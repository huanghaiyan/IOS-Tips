面试题

1-12VIVAT面试题

1. 在Object-C中 Category和 Extension的属性有什么区别
	
		类扩展（class extension）
		1.作用
		能为某个类增加额外的属性、成员变量、方法声明
		一般将类扩展写到.m文件中
		一般将一些私有的属性写到类扩展 		
		使用格式:  		 
		@interface 类名()
		  /* 属性、成员变量、方法声明 */
		  @end
		  
		2. 与分类的区别
		a) 分类的小括号必须有名字
		@interface 类名(分类名字)
		 /* 方法声明 
		@end
		 @implementation 类名(分类名字)
	     /* 方法实现 
	    @end
	     		  b) 分类只能扩充方法
	     		  c) 如果在分类中声明了一个属性，分类只会生成这个属性的get\set方法声明

2. OC宏定义问题
	
		1>.#define SECONDS_PER_YEAR 60*60*24*365UL   //用预处理指令#define声明一个常数，用以表明1年中有多少秒（忽略闰年问题）#define 语法的基本知识（例如：不能以分号结束，括号的使用，等等）懂得预处理器将为你计算常数表达式的值，因此，直接写出你是如何计算一年中有多少秒而不是计算出实际的值，是更清晰而没有代价的,意识到这个表达式将使一个16位机的整型数溢出-因此要用到长整型符号L,告诉编译器这个常数是的长整型数,如果你在你的表达式中用到UL（表示无符号长整型），那么你有了一个好的起点
		2>. #define MINx(A,B) ((A) <= (B) ? (A) : (B)) //写一个"标准"宏MIN ，这个宏输入两个参数并返回较小的一个。  #define MIN(A,B) （（A） <= (B) ? (A) : (B))。我也用这个问题开始讨论宏的副作用，例如：当你写下面的代码时会发生什么事？    least = MIN(*p++, b);    结果是：((*p++) <= (b) ? (*p++) : (*p++))这个表达式会产生副作用，指针p会作三次++自增操作。
		3>. #define APPVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] //定义一个宏获取当前应用的版本号
		4>.#define JudgeIsNull(value) (([value isEqual:[NSNull null]]|| (value == nil))?@"":value)    //处理返回值为nil,NULL问题

3. @property有哪些属性修饰符，区别是什么？(重点)
		
		readwrite：同时生成get方法和set方法的声明和实现
		readonly：只生成get方法的声明和实现
		assign：set方法的实现是直接赋值，用于基本数据类型
		retain：set方法的实现是release旧值，retain新值，用于OC对象类型
		copy：set方法的实现是release旧值，copy新值，用于NSString、block等类型
		nonatomic：非原子性，set方法的实现不加锁（比atomic性能高）

4. 实现一个半径为10px的图片圆形UIView
	
		**这是离屏渲染（off-screen-rendering），消耗性能的**
		最直接的方法就是使用如下属性设置：

		imgView.layer.cornerRadius = 10;
		// 这一行代码是很消耗性能的
		imgView.clipsToBounds = YES;
		

		给UIImage添加生成圆角图片的扩展API：这是on-screen-rendering
		- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
		CGRect rect = (CGRect){0.f, 0.f, self.size};

			UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
			CGContextAddPath(UIGraphicsGetCurrentContext(),[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
			CGContextClip(UIGraphicsGetCurrentContext());
			[self drawInRect:rect];
			UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

			UIGraphicsEndImageContext();
			return image;
		}
	

5. 如何判断当前设备应该适配@1x,@2x,@3x图片


6. 如何添加一个自定义字体到项目中

		ttf文件加入到项目中，然后在info.plist文件中加入相应信息，这一步实际上是在项目的Info页里面增加Fonts provided by application项，并设置相应的ttf文件进去
	如图：
	![20150606100334772.png](http://upload-images.jianshu.io/upload_images/726092-e57bb190d0ecc4d1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
		
7. UIButton和UILabel的向上继承类都有哪些


8. 通知的使用场景是什么，同步还是异步

9. GCD里面有哪几种Queue?


10. 如何用GCD同步若干个异步调用（如多个网络请求同时返回后进行UI操作）


11. 常用的第三方开源框架(重点)
	
		AFNetWorking、SDWebImage、FMDB、Masory、MJRefresh


12. 如何看待使用Storyboard和代码开发
	
		对于复杂的、动态生成的界面，建议使用手工编写界面。
		对于需要统一风格的按钮或UI控件，建议使用手工用代码来构造。方便之后的修改和复用。
		对于需要有继承或组合关系的 UIView 类或 UIViewController 类，建议用代码手工编写界面。
		对于那些简单的、静态的、非核心功能界面，可以考虑使用 xib 或 storyboard 来完成。
		团队开发时，大家同时修改一个storyboard,会导致大量冲突，解决起来比较麻烦

13. 怎么给类别添加属性？
		
		使用runtime添加属性
		头文件

		@interface NSObject (test)

		@property (nonatomic, copy) NSString *name;

		@end
		.m文件

		@implementation NSObject (test)
		// 定义关联的key
		static const char *key = "name";
		- (NSString *)name
		{
    		// 根据关联的key，获取关联的值。
    		return objc_getAssociatedObject(self, key);
		}
		- (void)setName:(NSString *)name
		{
    		// 第一个参数：给哪个对象添加关联
    		// 第二个参数：关联的key，通过这个key获取
    		// 第三个参数：关联的value
    		// 第四个参数:关联的策略
    		objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		}
		
14. UITableView卡顿如何处理？(重点)
	

15. 常见的设计模式有哪些？（重点）
		
		单例模式

		1.定义：确保一个类只有一个实例，而且自行实例化并向整个系统提供这个实例。
		
		什么是单例
		其实就是C中得全局变量
		在整个程序生命周期内，该对象只有一份存在内存中
		可以在多个对象之间共享数据
		
		单例模式的优点：
		* 在内存中只有一个对象，节省内存空间。
		* 避免频繁的创建销毁对象，可以提高性能。
		* 避免对共享资源的多重占用
		* 可以全局访问

		2.适用场景：
		* 需要频繁实例化然后销毁的对象。
		* 创建对象时耗时过多或者耗资源过多，但又经常用到的对象。
		* 有状态的工具类对象。
		* 频繁访问数据库或文件的对象。
		* 以及其他我没用过的所有要求只有一个对象的场景。

		3.注意事项：
		* 只能使用单例类提供的方法得到单例对象，不要使用反射，否则将会实		例化一个新对象。
		* 不要做断开单例类对象与类中静态引用的危险操作。
		* 多线程使用单例使用共享资源时，注意线程问题。

		4.代码实现：
		//  NHLocationManager.h

		#import <Foundation/Foundation.h>
		@interface NHLocationManager : NSObject
		+ (instancetype)sharedManager;
		@end


		//  NHLocationManager.m
		#import "NHLocationManager.h"
		static NHLocationManager *_singleton = nil;

		+ (instancetype)sharedManager {
    		static dispatch_once_t onceToken;
    		dispatch_once(&onceToken, ^{
        		_singleton = [[NHLocationManager alloc] init];
    		});
    		return _singleton;
		}

		观察者模式

		1.定义:定义对象间一种一对多的依赖关系，使得当每一个对象改变状态，则所有依赖于它的对象都会得到通知并自动更新。
		2.类型：行为类模式
		3.观察者模式的优缺点

		* 优点

			观察者与被观察者之间是属于轻度的关联关系，并且是抽象耦合的，这样，对于两者来说都比较容易进行扩展。
	
			观察者模式是一种常用的触发机制，它形成一条触发链，依次对各个观察者的方法进行处理。
	
		*  缺点
   
    		由于是链式触发，当观察者比较多的时候，由于是链式触发，当观察者比较多的时候，性能问题是比较令人担忧的。并且，在链式结构中，比较容易出现循环引用的错误，造成系统假死。



16. 推送原理？

		推送原理
		1、首先是应用程序注册消息推送。
		2、 iOS跟APNS Server要deviceToken。应用程序接受deviceToken。
		3、应用程序将deviceToken发送给PUSH服务端程序。
		4、 服务端程序向APNS服务发送消息。
    	5、APNS服务将消息发送给iPhone应用程序。
	参考文章： [ios推送消息的基本原理](http://blog.csdn.net/dongdongdongjl/article/details/8452211)
17. SDWebImage内部如何实现的，图片如何存储的？（重点）
	
	![图片缓存原理](https://github.com/huanghaiyan/IOS-Tips/blob/master/images/图片缓存原理.jpg)

	其他文章[一行行看SDWebImage源码（一）](http://www.jianshu.com/p/82c7f2865c92)

	[一行行看SDWebImage源码 （二）](http://www.jianshu.com/p/67f8daa47a10)
	
18. 内存问题（重点）
		
		NSString *name = [[NSString alloc]initWithString:@"张三"];
		NSLog(@"%d",[name retainCount]);
		上述代码打印结果是：-1
19. 对于语句NSString*obj = [[NSData alloc] init]; ，编译时和运行时obj分别是什么类型？（重点）
		
		编译时是NSString类型,运行时是NSData类型
		
20. \#import 跟#include、@class有什么区别？＃import<> 跟 #import”"又什么区别？（重点）
		
		#import和#include都能完整地包含某个文件的内容，#import能防止同一个文件被包含多次
		@class仅仅是声明一个类名，并不会包含类的完整声明;@class还能解决循环包含的问题
		#import <> 用来包含系统自带的文件，#import “”用来包含自定义的文件

21. Objective-C如何对内存管理的,说说你的看法和解决方法?（重点）
	
		1.每个对象都有一个引用计数器，每个新对象的计数器是1，当对象的计数器减为0时，就会被销毁
		2.通过retain可以让对象的计数器+1、release可以让对象的计数器-1
		3.还可以通过autorelease pool管理内存
		4.如果用ARC，编译器会自动生成管理内存的代码
		5.及时关闭不用的资源，使用缓存机制，尽量复用
	
22. OC中创建线程的方法是什么？如果指定在主线程中执行代码？如何延时执行代码？（重点）
	
		1.创建线程的方法
		> NSThread
		
		> NSOperationQueue和NSOperation
		
		> GCD
		2.主线程中执行代码
		> [self performSelectorOnMainThread: withObject: waitUntilDone:];
		
		> [self performSelector: onThread:[NSThread mainThread] withObject: waitUntilDone:];
		> dispatch_async(dispatch_get_main_queue(), ^{
		});
		3.延时执行
		> double delayInSeconds = 2.0;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 
		(int64_t)(delayInSeconds * NSEC_PER_SEC));
		
		dispatch_after(popTime, dispatch_get_main_queue(), 		^(void){        
		});
		
		> [self performSelector: withObject: afterDelay:];
		
		> [NSTimer scheduledTimerWithTimeInterval: target: selector: userInfo: repeats:];
		
		GCD
		
		main dispatch queue
		全局性的serial queue，所有和UI操作相关的任务都应该放到这个queue里面，在主线程中执行
		宏dispatch_get_main_queue()，同一时间只能执行一个任务
		global dispatch queue
		可以并发的执行多个任务，但是执行完成的顺序是随机的。一般后台执行的任务放到这个queue里面。
		函数dispatch_get_global_queue(0，0)//0默认优先级

		提交任务到dispatch queue
		1.同步提交
		void dispatch_sync(dispatch_queue_t queue,dispatch_block_t block);
		2.异步提交
		void dispatch_async(dispatch_queue_t queue,dispatch_block_t block);
		我们最常用的是异步提交

		典型应用线程处理
		为了避免界面在处理耗时的操作时卡死，比如读取网络数据，I/O,数据库读写等，我们会在另一个线程中处理这些操作，然后通知主线程更新界面。
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
		//耗时的操作
				dispatch_async(dispatch_get_main_queue(),^{
        		//更新界面
        		});
        });

		GCD的应用场合
		1.主要应用在本地的多线程处理上，比如解析从网络传输过来的数据
		2.对于网络方面的多线程控制，更多使用NSOperation,因为NSOperation的控制粒度更加精细

	 之前面试问题

		NSLog(@"1");//主线程中
    	__block NSString *str = nil;
    	// __block NSString *str = @"nn";

    	dispatch_sync(dispatch_get_main_queue(),^{
       		 NSLog(@"2");//放到主线程中，出现了线程死锁
        	str = @"mm";
        	NSLog(@"str=%@",str);
        });
    	NSLog(@"str=%@",str);
		打印结果：1

		NSLog(@"1");//主线程中
		__block NSString *str = nil;
		// __block NSString *str = @"nn";
    	
    	dispatch_async(dispatch_get_main_queue(),^{
        NSLog(@"2");//放到主线程中，出现了线程死锁
        str = @"mm";
        NSLog(@"str=%@",str);
    	});
    	NSLog(@"str=%@",str);
    	
		2016-05-12 23:53:01.288 死锁[64929:7993992] 1
		2016-05-12 23:53:01.289 死锁[64929:7993992] str=(null)
		2016-05-12 23:53:01.294 死锁[64929:7993992] 2
		2016-05-12 23:53:01.295 死锁[64929:7993992] str=mm

		线程死锁的原因：
		dispatch_sync的当前执行队列与提交block执行的目标队列相同时将造成死锁。 
   [iOS多线程编程技术之NSThread、Cocoa NSOperation、GCD](http://www.cocoachina.com/industry/20140520/8485.html)
      
23. 消息机制 （重点）
	
		Objective-C是基于C加入了面向对象特性和消息转发机制的动态语言，除编译器之外，还需用Runtime系统来动态创建类和对象，进行消息发送和转发。
[深入理解Objective-C的Runtime机制](http://www.csdn.net/article/2015-07-06/2825133-objective-c-runtime/2)


24. initialize和load的区别
		
		initialize和load的区别在于：load是只要类所在文件被引用就会被调用，而initialize是在类或者其子类的第一个方法被调用前调用。所以如果类没有被引用进项目，就不会有load调用；但即使类文件被引用进来，但是没有使用，那么initialize也不会被调用。
25. 分享，传什么参数，怎么实现？

26. APP上线的流程 

		1.配置发布环境。选择证书，打包环境是release环境。
		2.选择发布方式，选择发布到appStore，企业版。
		3.导出ipa文件。
		4.上传ipa文件到appStore发布。

27. block的内存泄露 （重点）
		
		 block默认情况下,任何block都是在栈,随时可能会被回收.
		 对block做一次copy操作,block的内存就会放到堆里面,能长期拥有		[myblcok copy];
    	 Block_copy(myBlock);//在ARC下会报错
28. 线程间是如何通信的


29. NSString *name = [[NSString alloc]initWithString:@"张三"];
NSLog(@"%d",[name retainCount]); 
	
		上述代码打印结果是：-1
		原理：字符串常量，类似于C语言形式，静态区存储，系统不会对其采用引用计数方式回收，所以不会对其做引用计数，即使我们如何对它retain或release，其值保持不变，对象也保持不变。
		
30. assign、retain、copy分别起什么作用？重写下面的属性的getter/setter方法 （重点）
	
		@property (nonatomic, retain) NSNumber *num;
		从题目可知这问的是MRC下的问题。在MRC下：

		1.assign用于非对象类型，对于对象类型的只用于弱引用。
		2.retain用于对象类型，强引用对象
		3.copy用于对象类型，强引用对象。
		重写setter/getter（如何重写getter和setter，是不会自动登录_num成员变量的，需要自己手动声明）：

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

31. 如何声明一个delegate属性，为什么？ （重点）
	
		声明属性时要，在ARC下使用weak，在MRC下使用assign。比如：
		
		@property (nonatomic, weak) id<HYBTestDelegate> delegate;
		
		在MRC下，使用assign是因为没有weak关键字，只能使用assign来防止循环引用。在ARC下，使用weak来防止循环引用。

32. autorelease的对象何时被释放 （重点）

		如果了解一点点Run Loop的知道，应该了解到：Run Loop在每个事件循环结束后会去自动释放池将所有自动释放对象的引用计数减一，若引用计数变成了0，则会将对象真正销毁掉，回收内存。

		所以，autorelease的对象是在每个事件循环结束后，自动释放池才会对所有自动释放的对象的引用计数减一，若引用计数变成了0，则释放对象，回收内存。因此，若想要早一点释放掉auto release对象，那么我们可以在对象外加一个自动释放池。比如，在循环处理数据时，临时变量要快速释放，就应该采用这种方式：
		for (int i = 0; i < 10000000; ++i) {
			@autoreleasepool {
			HYBTestModel *tempModel = [[HYBTestModel alloc] init];
			// 临时处理
			// ...
			} // 出了这里，就会去遍历该自动释放池了
		}
		 
33. 这段代码有问题吗？如何修改？ （重点）

		for (int i = 0; i < 10000; ++i) {
			NSString *str = @"Abc";
			str = [str lowercaseString];
			str = [str stringByAppendingString:@"xyz"];
			
			NSLog(@"%@", str);
		}
		这道题从语法上看没有任何问题的，当然，既然面试官出了这一道题，那肯定是有问题的。

		问题出在哪里呢？语法没有错啊？内存最后也可以得到释放啊！为什么会有问题呢？是的，问题是挺大的。这对于不了解iOS的自动释放池的原理的人或者说内存管理的人来说，这根本看不出来这有什么问题。

		问题就出在内存得不到及时地释放。为什么得不到及时地释放？因为Run Loop是在每个事件循环结束后才会自动释放池去使对象的引用计数减一，对于引用计数为0的对象才会真正被销毁、回收内存。

		因此，对于这里的问题，一个for循环执行10000次，会产生10000个临时自动释放对象，一直放到自动释放池中管理，而内存却得不到及时回收。

		然后，现象是内存暴涨。正确的写法：
		for (int i = 0; i < 10000; ++i) {
			@autoreleasepool {
				NSString *str = @"Abc";
				str = [str lowercaseString];
				str = [str stringByAppendingString:@"xyz"];
				
				NSLog(@"%@", str);
				}
		}
	
34. UIViewController的viewDidUnload、viewDidLoad和loadView分别什么时候调用？UIView的drawRect和layoutSubviews分别起什么作用？

		第一个问题：
		
		1.在控制器被销毁前会调用viewDidUnload（MRC下才会调用）
		2.在控制器没有任何view时，会调用loadView
		3.在view加载完成时，会调用viewDidLoad
		
		第二个问题：
		
		1.在调用setNeedsDisplay后，会调用drawRect方法，我们通过在此方法中可以获取到context（设置上下文），就可以实现绘图
		2.在调用setNeedsLayout后，会调用layoutSubviews方法，我们可以通过在此方法去调整UI。当然能引起layoutSubviews调用的方式有很多种的，比如添加子视图、滚动scrollview、修改视图的frame等。

35. 自定义NSOperation，需要实现哪些方法？
	
		1.对于自定义非并发NSOperation，只需要实现main方法就可以了。
		2.对于自定义并发NSOperation，需要重写main、start、isFinished、isExecuting，还要注意在相关地方加上kvo的代码，通知其它线程，否则当任务完成时，若没有设置isFinished=YES，isExecuting=NO，任务是不会退队的。
	更多内容看这里：[iOS NSOperation](http://www.huangyibiao.com/ios-nsoperation-queue/)
36. 用代码实现一个单例 （重点）
	
		+ (instancetype)sharedInstance {
			static id s_manager = nil;
			
			static dispatch_once_t onceToken;
			dispatch_once(&onceToken, ^{
				s_manager = [[HYBTestSingleton alloc] init];
			});
			return s_manager;
		}

37. 用代码实现一个冒泡算法 （重点）

		冒泡算法的核心算法思想是每趟两两比较，将小的往上浮，大的往下沉，就像气泡一样从水底往水面浮。
		void bubbleSort(int a[], int len) {
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
	
38. UITableView是如何重用cell的？（重点）

		UITableView提供了一个属性：visibleCells，它是记录当前在屏幕可见的cell，要想重用cell，我们需要明确指定重用标识（identifier）。

		当cell滚动出tableview可视范围之外时，就会被放到可重用数组中。当有一个cell滚动出tableview可视范围之外时，同样也会有新的cell要显示到tableview可视区，因此这个新显示出来的cell就会先从可重用数组中通过所指定的identifier来获取，如果能够获取到，则直接使用之，否则创建一个新的cell。

	
39. 如何更高效地显示列表 （重点）

		要更高效地显示列表（不考虑种种优化），可以通过以下方法处理（只是部分）：
		1.提前根据数据计算好高度并缓存起来
		2.提前将数据处理、I/O计算异步处理好，并保存结果，在需要时直接拿来使用
		
40. 描述KVC、KVO机制

		KVC即是指NSKeyValueCoding，是一个非正式的Protocol，提供一种机制来间接访问对象的属性。KVO 就是基于KVC实现的关键技术之一。

		KVO即Key-Value Observing，是建立在KVC之上，它能够观察一个对象的KVC key path值的变化。 当keypath对应的值发生变化时，会回调observeValueForKeyPath:ofObject:change:context:方法，我们可以在这里处理。
		
41. 使用或了解哪些设计模式？ （重点）

		在开发中真正常用到的设计模式（包括架构设计模式）：
		1.单例设计模式
		2.MVC构架设计模式
		3.工厂设计模式
		4.观察者设计模式（比如KVC/KVO/NSNotification，也有人说不是设计模式）
		5.代理设计模式
	更详细可以看这里：[23种设计模式目录](http://blog.csdn.net/damenhanter/article/details/50474449)
	
42. 在一个对象的方法里：self.name=@object;和name=@object有什么不同？（重点）

		这是老生常谈的话题了，实质上就是问setter方法赋值与成员变量赋值有什么不同。通过点语法self.name实质上就是[self setName:@object];。而name这里是成员变量，直接赋值。

		一般来说，在对象的方法里成员变量和方法都是可以访问的，我们通常会重写Setter方法来执行某些额外的工作。比如说，外部传一个模型过来，那么我会直接重写Setter方法，当模型传过来时，也就是意味着数据发生了变化，那么视图也需要更新显示，则在赋值新模型的同时也去刷新UI。这样也不用再额外提供其他方法了。
	
43. UITableViewCell上有个UILabel，显示NSTimer实现的秒表时间，手指滚动cell过程中，label是否刷新，为什么？（重点）

		这是否刷新取决于timer加入到Run Loop中的Mode是什么。Mode主要是用来指定事件在运行循环中的优先级的，分为：
		NSDefaultRunLoopMode（kCFRunLoopDefaultMode）：默认，空闲状态
		UITrackingRunLoopMode：ScrollView滑动时会切换到该Mode
		UIInitializationRunLoopMode：run loop启动时，会切换到该mode
		NSRunLoopCommonModes（kCFRunLoopCommonModes）：Mode集合
		
		苹果公开提供的Mode有两个，分别是NSDefaultRunLoopMode（kCFRunLoopDefaultMode）和NSRunLoopCommonModes（kCFRunLoopCommonModes）。

		如果我们把一个NSTimer对象以NSDefaultRunLoopMode（kCFRunLoopDefaultMode）添加到主运行循环中的时候, ScrollView滚动过程中会因为mode的切换，而导致NSTimer将不再被调度。当我们滚动的时候，也希望不调度，那就应该使用默认模式。但是，如果希望在滚动时，定时器也要回调，那就应该使用common mode。

		对于这道题，如果要cell滚动过程中定时器正常回调，UI正常刷新，那么要将timer放入到CommonModes下，因为是NSDefaultRunLoopMode，只有在空闲状态下才会回调。


44. 有a、b、c、d 4个异步请求，如何判断a、b、c、d都完成执行？如果需要a、b、c、d顺序执行，该如何实现？

		对于这四个异步请求，要判断都执行完成最简单的方式就是通过GCD的group来实现：
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		dispatch_group_t group = dispatch_group_create();
		dispatch_group_async(group, queue, ^{ /*任务a */ });
		dispatch_group_async(group, queue, ^{ /*任务b */ });
		dispatch_group_async(group, queue, ^{ /*任务c */ }); 
		dispatch_group_async(group, queue, ^{ /*任务d */ }); 
 
		dispatch_group_notify(group, dispatch_get_main_queue(), ^{
		// 在a、b、c、d异步执行完成后，会回调这里
		});
		当然，我们还可以使用非常老套的方法来处理，通过四个变量来标识a、b、c、d四个任务是否完成，然后在runloop中让其等待，当完成时才退出run loop。但是这样做会让后面的代码得不到执行，直到Run loop执行完毕。

		要求顺序执行，那么可以将任务放到串行队列中，自然就是按顺序来异步执行了。
 
	
45. 使用block有什么好处？使用NSTimer写出一个使用block显示（在UILabel上）秒表的代码。（重点）

		说到block的好处，最直接的就是代码紧凑，传值、回调都很方便，省去了写代理的很多代码。

		对于这里根本没有必要使用block来刷新UILabel显示，因为都是直接赋值。当然，笔者觉得这是在考验应聘者如何将NSTimer写成一个通用用的Block版本。

		代码放到了这里：NSTimer封装成Block版

		使用起来像这样：
		NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                    repeats:YES
                                   callback:^() {
                                   weakSelf.secondsLabel.text = ...
		}
		[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
	
46. 一个view已经初始化完毕，view上面添加了n个button（可能使用循环创建），除用view的tag之外，还可以采用什么办法来找到自己想要的button来修改Button的值

		这个问题有很多种方式，而且不同的使用场景也不一样的。比如说：

		第一种：如果是点击某个按钮后，才会刷新它的值，其它不用修改，那么不用引用任何按钮，直接在回调时，就已经将接收响应的按钮给传过来了，直接通过它修改即可。

		第二种：点击某个按钮后，所有与之同类型的按钮都要修改值，那么可以通过在创建按钮时将按钮存入到数组中，在需要的时候遍历查找。


47. tableview在滑动时，有时候会大量加载本地图片，这时候会很卡，如何解决加载耗时过长导致不流畅的问题？（重点）
		
		这是优化tableview的相关专题，如果只是处理图片加载问题，那可以通过异步读取图片然后刷新UI。当然，我们也可以在取数据时，在模型中提前准备好需要显示的图片资源，这样在cell只就不需要操作图片读取，而是直接显示。
		如果想要更深入地优化，学习以下知识点：
	[Offscreen-Rendered](http://www.huangyibiao.com/archives/649)
	
	[Color Misaligned Images](http://www.huangyibiao.com/archives/640)
	
	[Color Blended Layers](http://www.huangyibiao.com/color-blended-layers/)

48. 请写出以下代码输出

		int a[5] = {1, 2, 3, 4, 5};
		int *ptr = (int *)(&a + 1);
		printf("%d, %d", *(a + 1), *(ptr + 1));
		参考答案：2, 随机值

		这种类型题好像挺常见的。考的就是C语言上的指针的理解和数组的理解。

		分析：

		a代表有5个元素的数组的首地址，a[5]的元素分别是1，2，3，4，5。接下来，a + 1表示数据首地址加1，那么就是a[1]，也就是对应于值为2.但是，这里是&a + 1，因为a代表的是整个数组，它的空间大小为5 * sizeof(int)，因此&a + 1就是a+5。a是个常量指针，指向当前数组的首地址，指针+1就是移动sizeof(int)个字节。

		因此，ptr是指向int *类型的指针，而ptr指向的就是a + 5，那么ptr + 1也相当于a + 6，所以最后的*(ptr + 1)就是一个随机值了。而*(ptr – 1)就相当于a + 4，对应的值就是5。
		
49. 请写出以下代码输出
		
		main(){ 
		int a[5]={1,2,3,4,5}; 
		int *ptr=(int *)(&a+1);  
		printf("%d,%d",*(a+1),*(ptr-1));
		}
		答：2,5

		*(a+1)就是a[1]，*(ptr-1)就是a[4],执行结果是2.5 ，&a+1不是首地址+1，系统会认为加一个a数组的偏 移，是偏移了一个数组的大小（本例是5个int，int *ptr=(int *)(&a+1); 则ptr实际 是&(a[5]),也就是a+5 原因如下：

		&a是数组指针，其类型为 int (*)[5]; 而指针加1要根据指针类型加上一定的值，不同类型的指针+1之后增加的大小不同。a是长度为5的int数组指针，所以要加 5*sizeof(int)所以ptr实际是a[5]，但是prt与(&a+1)类型是不一样的(这点很重要)，所以prt-1只会减去sizeof(int*)，a,&a的地址是一样的，但意思不一样，a是数组首地址，也就是a[0]的地址，&a是对象（数组）首地址，a+1是数组下一元素的地址，即a[1],&a+1是下一个对象的地址，即a[5].
		
50. 怎样使用performSelector传入3个以上参数，其中一个为结构体

		- (id)performSelector:(SEL)aSelector;
		- (id)performSelector:(SEL)aSelector withObject:(id)object;
		- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;
		因为系统提供的performSelector的api中，并没有提供三个参数。因此，我们只能传数组或者字典，但是数组或者字典只有存入对象类型，而结构体并不是对象类型，那么怎么办呢？

		没有办法，我们只能通过对象放入结构作为属性来传过去了：
		typedef struct HYBStruct {
			int a;
			int b;
		} *my_struct;
 
		@interface HYBObject : NSObject
 
		@property (nonatomic, assign) my_struct arg3;
		@property (nonatomic, copy)  NSString *arg1;
		@property (nonatomic, copy) NSString *arg2;
 
		@end
 
		@implementation HYBObject
 
		// 在堆上分配的内存，我们要手动释放掉
		- (void)dealloc {
			free(self.arg3);
		}
 
		@end
		
		测试：
		
		my_struct str = (my_struct)(malloc(sizeof(my_struct)));
		str->a = 1;
		str->b = 2;
		HYBObject *obj = [[HYBObject alloc] init];
		obj.arg1 = @"arg1";
		obj.arg2 = @"arg2";
		obj.arg3 = str;
 
		[self performSelector:@selector(call:) withObject:obj];
  
		// 在回调时得到正确的数据的
		- (void)call:(HYBObject *)obj {
    		NSLog(@"%d %d", obj.arg3->a, obj.arg3->b);
		}
	
51. tableview的执行顺序

		numberOfRowsInSection
		heightForRowAtIndexPath
		cellForRowAtIndexPath

52. 二叉树的遍历 （重点）
	
		遍历即将树的所有结点访问且仅访问一次。按照根节点位置的不同分为前序遍历，中序遍历，后序遍历。
		前序遍历：根节点->左子树->右子树
		中序遍历：左子树->根节点->右子树
		后序遍历：左子树->右子树->根节点
53. 排序算法 （重点）
		
		1.冒泡算法的核心算法思想是每趟两两比较，将小的往上浮，大的往下沉，就像气泡一样从水底往水面浮。
		void bubbleSort(int a[], int len) {
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
		2.选择排序
		#pragma - mark 选择排序  
		+ (void)selectSort:(NSMutableArray *)array  
		{  
    		if(array == nil || array.count == 0){  
    		return;  
    		}  
      
    		int min_index;  
    		for (int i = 0; i < array.count; i++) {  
        	min_index = i;  
        		for (int j = i + 1; j<array.count; j++) {  
            		if ([array[j] compare:array[min_index]] == NSOrderedAscending) {  
                		[array exchangeObjectAtIndex:j withObjectAtIndex:min_index];  
            		}  
              
            		printf("排序中:");  
            		[self printArray:array];  
        		}  
        	}
        }  
  
		3.插入排序
		#pragma - mark 插入排序  
		+ (void)inserSort:(NSMutableArray *)array  
		{  
    		if(array == nil || array.count == 0){  
        	return;  
    		}  
      
    		for (int i = 0; i < array.count; i++) {  
        		NSNumber *temp = array[i];  
        		int j = i-1;  
          
        		while (j >= 0 && [array[j] compare:temp] == NSOrderedDescending) {  
            		[array replaceObjectAtIndex:j+1 withObject:array[j]];  
            		j--;  
              
            		printf("排序中:");  
            		[self printArray:array];  
        		}  
          
        	[array replaceObjectAtIndex:j+1 withObject:temp];  
    		}  
		}  
  
	
54. array[]  = 12121222211112222，对array进行排序，使所有的1在前面，2在后面
	
	分析：

	我们要做的是调整数组中元素的顺序，所以显然函数中主要的操作是交换元素，也就是交换奇数和偶数，使奇数位于偶数前边。在前边各种数组的题目中，我们常用到使用两个指针的方法，一个从前向后移动，一个从后向前移动。当前边的指针指向一个偶数，而后边的指针指向一个奇数时，交换两个元素，直到两个指针相遇为止。

	void ReorderArray(int* pData, unsigned int length)
	{
		if (pData == NULL || length <= 0)
			return;

		unsigned int Begin = 0;
		unsigned int End = length - 1;
		while (Begin < End)
		{
			while (Begin < End && (pData[Begin] & 1) != 0)
				++Begin;

			while (Begin < End && (pData[End] & 1) == 0)
				--End;

			if (Begin < End)
			{
				int temp = pData[Begin];
				pData[Begin] = pData[End];
				pData[End] = temp;
			}
		}
	}
	
	值得注意的是： 在判断数字的奇偶时，往往使用位运算“&1”，得1说明是奇数，反之为偶数；原因在于，只有当一个数的二进制表示中的最低位为1时这个数才是奇数。而使用取余%计算远远不如位运算效率高。
	另附一个小技巧：在求余运算中，如果被求余数是2的整数次幂，可以用位运算来进行转换，从而得到比较高的效率。
	n % m => n & (m - 1)
	例如：求 n % 32 ，可以将其转换为 n & (32-1)


	
55. 用oc写一个单例 （重点）
	
		//  NHLocationManager.h

		#import <Foundation/Foundation.h>
		@interface NHLocationManager : NSObject
		+ (instancetype)sharedManager;
		@end


		//  NHLocationManager.m
		#import "NHLocationManager.h"
		static NHLocationManager *_singleton = nil;

		+ (instancetype)sharedManager {
    		static dispatch_once_t onceToken;
    		dispatch_once(&onceToken, ^{
        		_singleton = [[NHLocationManager alloc] init];
    		});
    		return _singleton;
		}

56. 多线程方面（重点）
	
	
	
57. 简析浅拷贝和深拷贝 （重点）
	
		浅拷贝仅仅是拷贝了指针， 就是新的指针指向的还是同一块内存空间。深拷贝是重新向操作系统申请了相同的内存，并把原来的所有数据复制一份。浅拷贝相当于对于原指针的引用计数加了1.深拷贝的主要区别， 重新分配了内存空间。
	
58. 简述进程和线程的区别 （重点）
		
		进程是操作系统动态执行的基本单元，在传统的操作系统设计中，进程即是基本的分配单元，也是基本的执行单元。
		进程就是程序的一次执行过程。
		线程是由进程派生出来的一组代码的执行过程。
		线程是由进程派生出来的，一个进程可以产生多个线程，线程的特点是共享进程的内存空间，他们可以并发、异步地执行。
59. viewcontroller的生命周期 （重点）
	
	
	
60. TCP的三次握手
		
		第一次握手:客户端发送syn包(syn=j)到服务器,并进入SYN_SEND状态等待服务器确认;
		第二次握手:服务器端收到syn包,必须确认客户的SYN(ack = j + 1),同时自己也发送一个SYN包(syn=k)即SYN+ ACK包,此时服务器进入SYN_RECV状态;
		第三次握手:客户端收到服务器的SYN+ACK包,向服务器发送确认包ACK(ACK = k+1),此包发送完毕,客户端和服务器端进入进入ESTABLISHED状态,完成三次握手.
61. 数据解析
	
		XML与JSON数据解析，常用json。使用MJExtation进行json转模型。
