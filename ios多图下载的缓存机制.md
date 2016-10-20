## iOS多图下载的缓存机制

1. 需求点是什么？

	这里所说的多图下载，就是要在tableview的每一个cell里显示一张图片，而且这些图片都需要从网上下载。

2. 容易遇到的问题

	如果不知道或不使用异步操作和缓存机制，那么写出来的代码很可能会是这样：

		cell.textLabel.text = app.name;

		cell.detailTextLabel.text = app.download;

		NSData *imageData = [NSData dataWithContentsOfURL:app.url];

		cell.imageView.image = [UIImage imageWithData:imageData];

	这样写有什么后果呢？

	后果1：不可避免的卡顿（因为没有异步下载操作）

	dataWithContentsOfURL：是耗时操作，将其放在主线程会造成卡顿。如果图片很多，图片很大，而且网络情况不好的话肯定会卡出翔！

	后果2：同一图片重复下载，耗费流量和系统开销（因为没有建立缓存机制）

	由于没有缓存机制，即使下载完成并显示了当前cell的图片，但是当该cell再一次需要显示的时候还是会下载它所对应的图片：耗费了下载流量，而且还导致重复操作。

	很显然，要达到Tableview滚动的如丝滑般的享受必须二者兼得才可以，具体怎么做呢？

3. 解决方案

	1.先看一下解决方案的流程图

	640

	要想快速看懂此图，需要先了解该流程所需的所有数据源：

	1. 图片的URL：因为每张图片对应的URL都是唯一的，所以我们可以通过它来建立图片缓存和下载操作的缓存的键，以及拼接沙盒缓存的路径字符串。

	2. 图片缓存（字典）：存放于内存中；键为图片的URL，值为UIImage对象。作用：读取速度快，直接使用UIImage对象。

	3. 下载操作缓存（字典）：存放与内存中，键为图片的URL，值为NSBlockOperation对象。作用：用来避免对于同一张图片还要开启多个下载线程。

	4. 沙盒缓存(文件路径对应NSData)：存放于磁盘中，位于Cache文件夹内，路径为“Cache/图片URL的最后的部分”，值为NSData对象（将UIImage转化为NSData才能写入磁盘里）。作用：程序断网，再次启动也可以直接在磁盘中拿到图片。

2. 再看一下解决方案的代码
	
		//缓存路径，拼接Cache文件夹的路径与url最后的部分
		#define CachedImageFile(url)[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:[url lastPathComponent]]

		/*

		*图片缓存，下载操作缓存，沙盒缓存路径

		*/

		//存放所有下载完的图片

		@property (nonatomic,strong) NSMutableDictionary *images;

		//存放所有的下载操作（key是url,value是operation对象）

		@property (nonatomic,strong) NSMutableDictionary *operations;

		//存放所有下载操作的队列

		@property (nonatomic,strong) NSOperationQueue* queue;

2.1.图片下载之前的查询缓存部分：

	//先从images缓存中取出图片url对应的UIImage

    UIImage *image = self.images[app.icon];

    if (image) {

        //存在，说明图片已经下载成功

        cell.imageView.image = image;

    }else{

        //不存在，说明图片并未下载成功过，或者成功下载但是images里缓存失败，需要在沙盒里寻找对应的图片

        //获得url对应的沙盒缓存路径

        NSString *filePath = CachedImageFile(app.icon);

        //先从沙盒中取出图片

        NSData *imageData = [NSData dataWithContentsOfFile:filePath];

        if (imageData) {

            //data不为空，说明沙盒中存在这个文件

            cell.imageView.image = [UIImage imageWithData:imageData];

        }else{

            //沙盒中图片文件不存在

            //在下载之前显示转为图片

            cell.imageView.image = [UIImage imageNamed:@"2"];

            //下载图片

            [self download:app.icon indexPath:indexPath];

        }

    }

2.2图片的下载部分

	#pragma mark -图片下载 ，imageUrl图片的url

	- (void)download:(NSString *)imageUrl indexPath:(NSIndexPath *)indexPath{

    	//取出当前图片url对应的下载操作（operation对象）
		NSBlockOperation *operation = self.operations[imageUrl];
		if (operation == nil) {

        	//创建操作，下载图片

        	__weak typeof(self) vc = self;

        	operation = [NSBlockOperation blockOperationWithBlock:^{

            	NSURL *url = [NSURL URLWithString:imageUrl];

            	NSData *data = [NSData dataWithContentsOfURL:url];//下载

            	UIImage *image = [UIImage imageWithData:data];

            	if (image) {

                	//如果图片存在（下载完成），存放图片到图片缓存字典中

                	vc.images[imageUrl] = image;

                	//将图片存入沙盒中

                	//1.先将图片转化为NSData

                	NSData *imageData = UIImagePNGRepresentation(image);

                	//2.再生成缓存路径

                	[imageData writeToFile:CachedImageFile(imageUrl) atomically:YES];

            	}

            	//回到主线程

            	[[NSOperationQueue mainQueue] addOperationWithBlock:^{

              	//从字典中移除下载操作（保证下载失败后，能重新下载）

                	[vc.operations removeObjectForKey:imageUrl];

                	//刷新表格，减少系统开销

                	[vc.mTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];

            	}];

        	}];

        	//添加下载操作到队列中

        	[self.queue addOperation:operation];

        	//添加到字典中

        	self.operations[imageUrl] = operation;

    	}

	}

demo地址:[https://github.com/huanghaiyan/CellImageDownload](https://github.com/huanghaiyan/CellImageDownload)

