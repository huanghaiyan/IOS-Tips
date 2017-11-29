1. 请写出一个单例

        + (instancetype)sharedInstance {
            static id s_manager = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                s_manager = [[HYBTestSingleton alloc] init]; });
            }
            return s_manager;
        }

2. 请写出程序计算结果,AB两地相距1000米，小明从A地点以30米/分钟的速度向B地点走，小白从B地点以20米/分钟的速度向A地点走，两人同时出发，用代码写出他们多少分钟后遇到？

        设x分钟后相遇，30*x+20*x = 1000；
        x=20;
3. 请写出程序输出结果,对数组 ["12-12","12-11", "12-11", "12-11", "12-13", "12-14"] 去重同时进行排序

        //4种方法对数组中的元素去重复
        NSArray *array = @[@"12-11", @"12-11", @"12-11", @"12-12", @"12-13", @"12-14"];
        //原来集合操作可以通过valueForKeyPath来实现的，去重可以一行代码实现：
        array = [array valueForKeyPath:@"@distinctUnionOfObjects.self"];
        NSLog(@"%@", array);
        
        //NSSet去重，利用集合NSSet的特性(确定性、无序性、互异性)，放入集合就自动去重了。但是它与字典拥有同样的无序性，所得结果顺序不再与原来一样。如果不要求有序，使用此方法与字典的效率应该是差不多的。效率分析：时间复杂度为O (n)：
        NSArray *arr = @[@"12-11", @"12-11", @"12-11", @"12-12", @"12-13", @"12-14"];
        NSSet *set = [NSSet setWithArray:arr];
        NSLog(@"set%@\n", set);
        
        //字典去重，利用NSDictionary去重，字典在设置key-value时，若已存在则更新值，若不存在则插入值，然后获取allValues。若不要求有序，则可以采用此种方法。若要求有序，还得进行排序。效率分析：只需要一个循环就可以完成放入字典，若不要求有序，时间复杂度为O(n)。若要求排序，则效率与排序算法有关：
    
        NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] initWithCapacity:array.count];
        for (NSString *item in array) {
        [resultDict setObject:item forKey:item];
        }
        NSArray *resultArray = resultDict.allValues;
        NSLog(@"%@", resultArray);
        
        //排序
        resultArray = [result ArraysortedArrayUsingComparator:^NSComparisonResult(id_Nonnullobj1,id_Nonnullobj2){
        NSString*item1=obj1;
        NSString*item2=obj2;
        return [item1compare:item2 options:NSLiteralSearch];
        }];
        
        //有序集合
        NSOrderedSet*set=[NSOrderedSet orderedSetWithArray:array];
        
4. 使用递归方法计算99到1相加的计算结果。

        #include<iostream>
        using namespace std;
        int sum(int max);
        int main()
        {
            cout<<sum(100)<<endl;
            return 0;
        }
        int sum(int max){
            if(max>1){
            return max+sum(max-1);
            }else{
            return 1;
            }
        }
  5. 请看下面一段代码
  
          - (void)viewDidLoad
          {
          [super viewDidLoad];
          dispatch_queue_t queue1 = dispatch_get_main_queue();
          dispatch_async(queue1, ^{NSLog(@"222 Hello?");});
          NSLog(@"aaaaaaa");
          }
  
          程序结果将输出
          A. 死锁
          B. 打印“aaaaaaa
          222 Hello?”
          C. 打印“222 Hello?
          aaaaaaa”
          D. 打印“”
          答案：A.死锁
    
6. 请说一说UITableView的重用机制。或者UITableView是如何重用cell的？

        UITableView提供了一个属性：visibleCells，它是记录当前在屏幕可见的cell，要想重用cell，我们需要明确指定重用标识（identifier）。
        当cell滚动出tableview可视范围之外时，就会被放到可重用数组中。当有一个cell滚动出tableview可视范围之外时，同样也会有新的cell要显示到tableview可视区，因此这个新显示出来的cell就会先从可重用数组中通过所指定的identifier来获取，如果能够获取到，则直接使用之，否则创建一个新的cell。

7. 如果更高效地显示列表

        要更高效地显示列表（不考虑种种优化），可以通过以下方法处理（只是部分）：
        提前根据数据计算好高度并缓存起来提前将数据处理、I/O计算异步处理好，并保存结果，在需要时直接拿来使用
8. 描述KVC、KVO机制

        KVC即是指NSKeyValueCoding，是一个非正式的Protocol，提供一种机制来间接访问对象的属性。KVO 就是基于KVC实现的关键技术之一。
        KVO即Key-Value Observing，是建立在KVC之上，它能够观察一个对象的KVC key path值的变化。 当keypath对应的值发生变化时，会回调observeValueForKeyPath:ofObject:change:context:方法，我们可以在这里处理
9. 用代码实现一个冒泡算法

        冒泡算法的核心算法思想是每趟两两比较，将小的往上浮，大的往下沉，就像气泡一样从水底往水面浮。
        -(void) bubbleSort(int a[], int len) {
            for (int i = 0; i < len - 1; ++i) {
                // 从水底往水面浮，所以从最后一个开始
                for (int j = len - 1; j > i; j--) {
                    // 后者比前者还小，将需要交换
                    if (a[j] < a[j - 1]) {
                        int temp = a[j];
                        a[j] = a[j - 1];
                        a[j - 1] = temp;
                    }
                }
            }
        }
        
10. UIViewController的viewDidUnload、viewDidLoad和loadView分别什么时候调用？UIView的drawRect和layoutSubviews分别起什么作用？

        第一个问题：
        在控制器被销毁前会调用viewDidUnload（MRC下才会调用）在控制器没有任何view时，会调用loadView在view加载完成时，会调用viewDidLoad
        第二个问题：
        在调用setNeedsDisplay后，会调用drawRect方法，我们通过在此方法中可以获取到context（设置上下文），就可以实现绘图在调用setNeedsLayout后，会调用layoutSubviews方法，我们可以通过在此方法去调整UI。当然能引起layoutSubviews调用的方式有很多种的，比如添加子视图、滚动scrollview、修改视图的frame等。

11. 如何声明一个delegate属性，为什么？

        声明属性时要，在ARC下使用weak，在MRC下使用assign。比如：
        @property (nonatomic, weak) id delegate;
        在MRC下，使用assign是因为没有weak关键字，只能使用assign来防止循环引用。在ARC下，使用weak来防止循环引用。
12. autorelease的对象何时被释放

        如果了解一点点Run Loop的知道，应该了解到：Run Loop在每个事件循环结束后会去自动释放池将所有自动释放对象的引用计数减一，若引用计数变成了0，则会将对象真正销毁掉，回收内存。
        所以，autorelease的对象是在每个事件循环结束后，自动释放池才会对所有自动释放的对象的引用计数减一，若引用计数变成了0，则释放对象，回收内存。因此，若想要早一点释放掉auto release对象，那么我们可以在对象外加一个自动释放池。比如，在循环处理数据时，临时变量要快速释放，就应该采用这种方式：
        for (int i = 0; i < 10000000; ++i) {
        @autoreleasepool {
        HYBTestModel *tempModel = [[HYBTestModel alloc] init];
        // 临时处理 // ...
        } // 出了这里，就会去遍历该自动释放池了
        }
        
13. assign、retain、copy分别起什么作用？重写下面的属性的getter/setter方法

            @property (nonatomic, retain) NSNumber *num;
            
            参考答案：从题目可知这问的是MRC下的问题。在MRC下：
            assign用于非对象类型，对于对象类型的只用于弱引用。retain用于对象类型，强引用对象copy用于对象类型，强引用对象。重写setter/getter（如何重写getter和setter，是不会自动登录_num成员变量的，需要自己手动声明）：
            - (NSNumber *)num {
                return _num;
            }
            - (void)setNum:(NSNumber *)aNum {
                if (_num != aNum) {
                [_num release];
                _num = nil;
                _num = [aNum retain];
                }
            }
            
14. 给定一个如下的字符串(1,(2,3),(4,(5,6)7))括号内的元素可以是数字，也可以是括号，请实现一个算法清除嵌套的括号，比如把上面的表达式的变成：(1,2,3,4,5,6,7)，表达式有误时请报错。

        如果只是判断整个表达式是否有错误，然后去掉里面的圆括号，那么一个循环就可以了。不过我们只需要加两个变量分别来记录左圆括号和右圆括号的个数。这里假设逗号总是正确的情况下，伪代码如下：
        left = 0;
        rigt = 0;
        for i = 0; i < str.length; ++i {
        if 是左括号 {
        left++;
        continue;
        }
        if 是右括号 {
        right++;
        // 处理(1,)这样的结构
        if 前一个是逗号 {
        error;
        }
        continue;
        }
        [newStr append:str[i]];
        }
        if left != right { error; }
    
15. 一个view已经初始化完毕，view上面添加了n个button（可能使用循环创建），除用view的tag之外，还可以采用什么办法来找到自己想要的button来修改Button的值

        这个问题有很多种方式，而且不同的使用场景也不一样的。比如说：
        第一种：如果是点击某个按钮后，才会刷新它的值，其它不用修改，那么不用引用任何按钮，直接在回调时，就已经将接收响应的按钮给传过来了，直接通过它修改即可。第二种：点击某个按钮后，所有与之同类型的按钮都要修改值，那么可以通过在创建按钮时将按钮存入到数组中，在需要的时候遍历查找。
16. 使用block有什么好处？使用NSTimer写出一个使用block显示（在UILabel上）秒表的代码。

        说到block的好处，最直接的就是代码紧凑，传值、回调都很方便，省去了写代理的很多代码。
        对于这里根本没有必要使用block来刷新UILabel显示，因为都是直接赋值。当然，笔者觉得这是在考验应聘者如何将NSTimer写成一个通用用的Block版本。
    
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES callback:^() {
        weakSelf.secondsLabel.text = ...
        }
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

17. 有a、b、c、d 4个异步请求，如何判断a、b、c、d都完成执行？如果需要a、b、c、d顺序执行，该如何实现？

        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
        NSLog(@"----任务a");
        });
        dispatch_group_async(group, queue, ^{
        NSLog(@"----任务b");
        });
        dispatch_group_async(group, queue, ^{
        NSLog(@"----任务c");
        });
        dispatch_group_async(group, queue, ^{
        NSLog(@"----任务d");
        });
        dispatch_group_notify(group, queue, ^{
        // 在a、b、c、d异步执行完成后，会回调这里
        NSLog(@"a,b,c,d执行完毕");
        });

        // 创建一个串行队列
        dispatch_queue_t queue =  dispatch_queue_create("zy", DISPATCH_QUEUE_SERIAL);
        // 将任务添加到队列中
        dispatch_async(queue, ^{
        NSLog(@"任务a");
        });
        dispatch_async(queue, ^{
        NSLog(@"任务b");
        });
        dispatch_async(queue, ^{
        NSLog(@"任务c");
        });
        dispatch_async(queue, ^{
        NSLog(@"任务d");
        });

18. UITableViewCell上有个UILabel，显示NSTimer实现的秒表时间，手指滚动cell过程中，label是否刷新，为什么？

19. 请说一说你对iOS中内存管理的了解。ARC底层时如何实现的？

20. 如何进行网络层的封装的？

21. 如何学习iOS开发的？

22. 为什么要用Alamofire而不用原生的NSURLSession，Alamofire的优势是什么？

23. 如果让你来封装一个网络库，类似于Alamofire或者SDWebImage，你会如何实现？

24. 在网络库中，如何针对TableView快速滚动过程中的图片额外渲染进行优化(网络库不能持有TableView)？

25. iOS的系统架构是怎么样的？常用SDK有哪些？

26. 了解HTTP协议吗？GET和POST的区别是什么？

27. 对安全方面有何了解？如何应对web页面被劫持？了解HTTPS加密解密的过程吗

28. 讲一讲你对iOS内存分配的理解？值类型和引用类型？

29. 函数中的闭包，如果要求闭包执行完后立刻改变函数中某个变量的值，应该如何实现？

30. 如何实现一个类似于微信聊天界面的布局？

31. 说一说 MVC 和 MVVM 的区别，以及各自的优缺点。

        MVC:
        MVC是将Model, View和Controller分离。
        M对应于Model（数据层）、V对应于View（视图层）、C对应于Controller（控制器层）。
        controller是Model和View之间的协调者(coordinator)，View和Model不能直接沟通，以确保责任的分离。
        用户在V上操作，需要通过C更新M，然后将新的M交到C，C让M更新。
        缺点：逻辑都是在vc里面写的,controller就会变得很大。

        MVVM
        Model-View-ViewModel
        帮忙分担一下controller里面的部分业务逻辑。
        MVVM的架构一样是M, V分离，但中间是以VM (ViewModel)来串接；
        View必须要透过ViewModel才可以取得Model，而ViewModel又必须要处理来自View的通知讯息；
        采用双向绑定：View的变动，自动反映在 ViewModel，反之亦然。
        低耦合 ：视图（View）可以独立于Model变化和修改，一个ViewModel可以绑定到不同的"View"上，当View变化的时候Model可以不变，当Model变化的时候View也可以不变。
        可重用性 ：你可以把一些视图逻辑放在一个ViewModel里面，让很多view重用这段视图逻辑。
        缺点：类会增多(每个VC都附带一个viewModel，类的数量*2)


32. 如何将 MVC 改造成 MVVM ？在MVVM中，网络请求、缓存处理的部分应该放在哪个模块？

33. 为什么说Swift是面向协议的语言？使用 Protocol 有什么好处？

34. 比较一下 Swift 和 Objective-C 在语言层面上的安全性？

35. 当点击一个View时，发生了什么？如何扩大点击区域？

36. 如何对TableView进行优化？

37. 能对Swift中的可选类型谈下你的理解吗？

38. 说一下快速排序的伪代码和时间复杂度？

39. 怎么判断两个链表是否相交？

40. 怎么反转二叉树？

41. 现在有ABC三个任务，如何实现AB完成后再执行C？

42. HTTP 和 HTTPS 有什么区别？

        HTTP 缺省工作在TCP协议80端口，用户访问网站http:// 打头的都是标准HTTP服务，HTTP所封装的信息是明文的，通过抓包工具可以分析其信息内容。
        HTTPS缺省工作在TCP协议443端口，它的工作流程一般如以下方式：
        1） 完成TCP三次同步握手
        2） 客户端验证服务器数字证书，通过，进入步骤3
        3） DH算法协商对称加密算法的密钥、hash算法的密钥
        4） SSL安全加密隧道协商完成
        5）网页以加密的方式传输，用协商的对称加密算法和密钥加密，保证数据机密性；用协商的hash算法进行数据完整性保护，保证数据不被篡改

43. 知道 HTTPS 通信过程吗？

44. Struct 和 Class 有什么区别？

45. 为什么要设计Cache？Cache分级有什么好处？

46. 堆区和栈区有什么区别？为什么要这么设计？

47. 给栈增加一个Max函数接口，返回当前栈的最大值，应该如何设计？

48. 一个m*n的棋盘，有些格子不能走，如何找到左上角到右下角的最短路径？

49. 反转字符串


50. TCP三次握手？为什么两次不行？

        第一次握手:客户端发送syn包(syn=j)到服务器,并进入SYN_SEND状态等待服务器确认;
        第二次握手:服务器端收到syn包,必须确认客户的SYN(ack = j + 1),同时自己也发送一个SYN包(syn=k)即SYN+ ACK包,此时服务器进入SYN_RECV状态;
        第三次握手:客户端收到服务器的SYN+ACK包,向服务器发送确认包ACK(ACK = k+1),此包发送完毕,客户端和服务器端进入ESTABLISHED状态,完成三次握手.

51. 使用或了解哪些设计模式

        单例设计模式
        MVC构架设计模式
        工厂设计模式
        观察者设计模式（比如KVC/KVO/NSNotification)
        代理设计模式
52. 数据库事务特征：
        
        1.原子性安全 2.一致性（银行转账）3。隔离性，不受其他事物影响
        
53. 使用了第三方库, 有看他们是怎么实现的吗？

        例：SD、YY、AFN、MJ等！

        <1>.SD为例：

        1.入口 setImageWithURL:placeholderImage:options:

        会先把 placeholderImage 显示，然后 SDWebImageManager 根据 URL 开始处理图片。

        2.进入 SDWebImageManagerdownloadWithURL:delegate:options:userInfo:，

        交给 SDImageCache 从缓存查找图片是否已经下载 queryDiskCacheForKey:delegate:userInfo:.

        3.先从内存图片缓存查找是否有图片，

        如果内存中已经有图片缓存，SDImageCacheDelegate 回调 imageCache:didFindImage:forKey:userInfo: 到 SDWebImageManager。

        4.SDWebImageManagerDelegate 回调 webImageManager:didFinishWithImage:

        到 UIImageView+WebCache 等前端展示图片。

        5.如果内存缓存中没有，生成 NSInvocationOperation

        添加到队列开始从硬盘查找图片是否已经缓存。

        6.根据 URLKey 在硬盘缓存目录下尝试读取图片文件。

        这一步是在 NSOperation 进行的操作，所以回主线程进行结果回调 notifyDelegate:。

        7.如果上一操作从硬盘读取到了图片，将图片添加到内存缓存中

        （如果空闲内存过小，会先清空内存缓存）。

        SDImageCacheDelegate 回调 imageCache:didFindImage:forKey:userInfo:。

        进而回调展示图片。

        8.如果从硬盘缓存目录读取不到图片，

        说明所有缓存都不存在该图片，需要下载图片，

        回调 imageCache:didNotFindImageForKey:userInfo:。

        9.共享或重新生成一个下载器 SDWebImageDownloader 开始下载图片。

        10.图片下载由 NSURLConnection 来做，

        实现相关 delegate 来判断图片下载中、下载完成和下载失败。

        11.connection:didReceiveData: 中

        利用 ImageIO 做了按图片下载进度加载效果。

        12.connectionDidFinishLoading: 数据下载完成后交给 SDWebImageDecoder 做图片解码处理。

        13.图片解码处理在一个 NSOperationQueue 完成，

        不会拖慢主线程 UI。如果有需要对下载的图片进行二次处理，

        最好也在这里完成，效率会好很多。

        14.在主线程 notifyDelegateOnMainThreadWithInfo:

        宣告解码完成，

        imageDecoder:didFinishDecodingImage:userInfo:

        回调给 SDWebImageDownloader。

        15.imageDownloader:didFinishWithImage:

        回调给 SDWebImageManager 告知图片下载完成。

        16.通知所有的 downloadDelegates 下载完成，

        回调给需要的地方展示图片。

        17.将图片保存到 SDImageCache 中，

        内存缓存和硬盘缓存同时保存。

        写文件到硬盘也在以单独 NSInvocationOperation 完成，

        避免拖慢主线程。

        18.SDImageCache 在初始化的时候会注册一些消息通知，

        在内存警告或退到后台的时候清理内存图片缓存，

        应用结束的时候清理过期图片。

        19.SDWI 也提供了 UIButton+WebCache 和

        MKAnnotationView+WebCache，方便使用。

        20.SDWebImagePrefetcher 可以预先下载图片，

        方便后续使用。
    
54. 遇到tableView卡顿嘛？会造成卡顿的原因大致有哪些？

        可能造成tableView卡顿的原因有：

        1.最常用的就是cell的重用， 注册重用标识符

        如果不重用cell时，每当一个cell显示到屏幕上时，就会重新创建一个新的cell；

        如果有很多数据的时候，就会堆积很多cell。

        如果重用cell，为cell创建一个ID，每当需要显示cell 的时候，都会先去缓冲池中寻找可循环利用的cell，如果没有再重新创建cell

        2.避免cell的重新布局

        cell的布局填充等操作 比较耗时，一般创建时就布局好

        如可以将cell单独放到一个自定义类，初始化时就布局好

        3.提前计算并缓存cell的属性及内容

        当我们创建cell的数据源方法时，编译器并不是先创建cell 再定cell的高度

        而是先根据内容一次确定每一个cell的高度，高度确定后，再创建要显示的cell，滚动时，每当cell进入凭虚都会计算高度，提前估算高度告诉编译器，编译器知道高度后，紧接着就会创建cell，这时再调用高度的具体计算方法，这样可以方式浪费时间去计算显示以外的cell

        4.减少cell中控件的数量

        尽量使cell得布局大致相同，不同风格的cell可以使用不用的重用标识符，初始化时添加控件，

        不适用的可以先隐藏

        5.不要使用ClearColor，无背景色，透明度也不要设置为0

        渲染耗时比较长

        6.使用局部更新

        如果只是更新某组的话，使用reloadSection进行局部更新

        7.加载网络数据，下载图片，使用异步加载，并缓存

        8.少使用addView 给cell动态添加view

        9.按需加载cell，cell滚动很快时，只加载范围内的cell

        10.不要实现无用的代理方法，tableView只遵守两个协议

        11.缓存行高：estimatedHeightForRow不能和HeightForRow里面的layoutIfNeed同时存在，这两者同时存在才会出现“窜动”的bug。所以我的建议是：只要是固定行高就写预估行高来减少行高调用次数提升性能。如果是动态行高就不要写预估方法了，用一个行高的缓存字典来减少代码的调用次数即可

        12.不要做多余的绘制工作。在实现drawRect:的时候，它的rect参数就是需要绘制的区域，这个区域之外的不需要进行绘制。例如上例中，就可以用CGRectIntersectsRect、CGRectIntersection或CGRectContainsRect判断是否需要绘制image和text，然后再调用绘制方法。

        13.预渲染图像。当新的图像出现时，仍然会有短暂的停顿现象。解决的办法就是在bitmap context里先将其画一遍，导出成UIImage对象，然后再绘制到屏幕；

        14.使用正确的数据结构来存储数据。
    
55. M、V、C相互通讯规则你知道的有哪些？

        MVC 是一种设计思想，一种框架模式，是一种把应用中所有类组织起来的策略，它把你的程序分为三块，分别是：

        M（Model）：实际上考虑的是“什么”问题，你的程序本质上是什么，独立于 UI 工作。是程序中用于处理应用程序逻辑的部分，通常负责存取数据。

        C（Controller）：控制你 Model 如何呈现在屏幕上，当它需要数据的时候就告诉 Model，你帮我获取某某数据；当它需要 UI 展示和更新的时候就告诉 View，你帮我生成一个 UI 显示某某数据，是 Model 和 View 沟通的桥梁。

        V（View）：Controller 的手下，是 Controller 要使用的类，用于构建视图，通常是根据 Model 来创建视图的。

        要了解 MVC 如何工作，首先需要了解这三个模块间如何通信。

        MVC通信规则

56. Controller to Model

        可以直接单向通信。Controller 需要将 Model 呈现给用户，因此需要知道模型的一切，还需要有同 Model 完全通信的能力，并且能任意使用 Model 的公共 API。

        Controller to View

        可以直接单向通信。Controller 通过 View 来布局用户界面。

        Model to View

        永远不要直接通信。Model 是独立于 UI 的，并不需要和 View 直接通信，View 通过 Controller 获取 Model 数据。

        View to Controller

        View 不能对 Controller 知道的太多，因此要通过间接的方式通信。

        Target

        action。首先 Controller 会给自己留一个 target，再把配套的 action 交给 View 作为联系方式。那么 View

        接收到某些变化时，View 就会发送 action 给 target 从而达到通知的目的。这里 View 只需要发送

        action，并不需要知道 Controller 如何去执行方法。

        代理。有时候 View 没有足够的逻辑去判断用户操作是否符合规范，他会把判断这些问题的权力委托给其他对象，他只需获得答案就行了，并不会管是谁给的答案。

        DataSoure。View 没有拥有他们所显示数据的权力，View 只能向 Controller 请求数据进行显示，Controller 则获取 Model 的数据整理排版后提供给 View。

        Model 访问 Controller

        同样的 Model 是独立于 UI 存在的，因此无法直接与 Controller 通信，但是当 Model 本身信息发生了改变的时候，会通过下面的方式进行间接通信。

        Notification & KVO一种类似电台的方法，Model 信息改变时会广播消息给感兴趣的人 ，只要 Controller 接收到了这个广播的时候就会主动联系 Model，获取新的数据并提供给 View。

        从上面的简单介绍中我们来简单概括一下 MVC 模式的优点。

        1.低耦合性

        2.有利于开发分工

        3.有利于组件重用

        4.可维护性

57. .NStimer准吗？谈谈你的看法？如果不准该怎样实现一个精确的NSTimer?

        1.不准

        2.不准的原因如下：

        1、NSTimer加在main runloop中，模式是NSDefaultRunLoopMode，main负责所有主线程事件，例如UI界面的操作，复杂的运算，这样在同一个runloop中timer就会产生阻塞。

        2、模式的改变。主线程的 RunLoop 里有两个预置的 Mode：kCFRunLoopDefaultMode 和 UITrackingRunLoopMode。

        当你创建一个 Timer 并加到 DefaultMode 时，Timer 会得到重复回调，但此时滑动一个ScrollView时，RunLoop 会将 mode 切换为 TrackingRunLoopMode，这时 Timer 就不会被回调，并且也不会影响到滑动操作。所以就会影响到NSTimer不准的情况。

        PS:DefaultMode 是 App 平时所处的状态，rackingRunLoopMode 是追踪 ScrollView 滑动时的状态。

        方法一：

        1、在主线程中进行NSTimer操作，但是将NSTimer实例加到main runloop的特定mode（模式）中。避免被复杂运算操作或者UI界面刷新所干扰。

        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];

        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

        2、在子线程中进行NSTimer的操作，再在主线程中修改UI界面显示操作结果；

        - (void)timerMethod2 {

        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(newThread) object:nil];

        [thread start];

        }

        - (void)newThread

        {

        @autoreleasepool

        {

        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showTime) userInfo:nil repeats:YES];

        [[NSRunLoop currentRunLoop] run];

        }

        }

        总结：

        一开始的时候系统就为我们将主线程的main runloop隐式的启动了。

        在创建线程的时候，可以主动获取当前线程的runloop。每个子线程对应一个runloop

        方法二：

        使用示例

        使用mach内核级的函数可以使用mach_absolute_time()获取到CPU的tickcount的计数值，可以通过”mach_timebase_info”函数获取到纳秒级的精确度 。然后使用mach_wait_until(uint64_t deadline)函数，直到指定的时间之后，就可以执行指定任务了。

        关于数据结构mach_timebase_info的定义如下：

        struct mach_timebase_info {uint32_t numer;uint32_t denom;};

        #include

        #include

        static const uint64_t NANOS_PER_USEC = 1000ULL;

        static const uint64_t NANOS_PER_MILLISEC = 1000ULL * NANOS_PER_USEC;

        static const uint64_t NANOS_PER_SEC = 1000ULL * NANOS_PER_MILLISEC;

        static mach_timebase_info_data_t timebase_info;

        static uint64_t nanos_to_abs(uint64_t nanos) {

        return nanos * timebase_info.denom / timebase_info.numer;

        }

        void example_mach_wait_until(int seconds)

        {

        mach_timebase_info(&timebase_info);

        uint64_t time_to_wait = nanos_to_abs(seconds * NANOS_PER_SEC);

        uint64_t now = mach_absolute_time();

        mach_wait_until(now + time_to_wait);

        }

        方法三：直接使用GCD替代！
        
58. 编译过程做了哪些事情？

59. NSString *a = @"abcd", NSString *b = @"abcd",是同一地址吗？

        我们都知道NSString是一个Objective-C的类，但是我们有时发现它的对象在内存管理上貌似和其他的对象有一些区别。比如有时你会发现对一个NSString进行copy操作时，它还是原本的对象，实际上并未拷贝对象。
        1.2 NSString的创建
        
        1.2.1测试NSString
        
        在objc中，我们一般通过几种方法来创建NSString呢，一般有三种方法，现在我们就分别对这三种情况写段测试代码，如下：
        
        NSString *str1 = @"1234567890";    TLog(str1);
        
        //str1: __NSCFConstantString -> 0x715ec : 1234567890  -1
        
        NSString *str2 = [NSString stringWithString:@"1234567890"];        TLog(str2);
        
        //str2: __NSCFConstantString -> 0x715ec : 1234567890  -1
        
        NSString *str3 = [NSString stringWithFormat:@"1234567890"];        TLog(str3);
        
        //str3: __NSCFString -> 0x1557cb50 : 1234567890  1
        
        看到上面这段测试代码，我们可以发现几点同我们想象不同的地方：
        
        第一种方式和第二种方式创建出来的NSString时一模一样的，isa是__NSCFConstantString，内存地址一样，retainCount是-1.
        第三种方式创建的NSString和创建其他objc对象类似的，在堆上分配内存，初始retainCount为1.
        这里面有几个疑问：
        
        什么是__NSCFConstantString？
        为什么第一种和第二种NSString的内存地址是一样的？
        为什么他们的retainCount是-1？

