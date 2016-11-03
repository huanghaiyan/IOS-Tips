面试题

1-12ViVAT面试题

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

3. @property有哪些属性修饰符，区别是什么
		
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


11. 常用的第三方开源框架
	
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
		
14. UITableView卡顿如何处理？

15. 常见的设计模式有哪些？
		
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
17. SDWebImage内部如何实现的，图片如何存储的？
	
	
	其他文章[一行行看SDWebImage源码（一）](http://www.jianshu.com/p/82c7f2865c92)

	[一行行看SDWebImage源码 （二）](http://www.jianshu.com/p/67f8daa47a10)
	
18. 内存问题
		
		NSString *name = [[NSString alloc]initWithString:@"张三"];
		NSLog(@"%d",[name retainCount]);
		上述代码打印结果是：-1
19. 对于语句NSString*obj = [[NSData alloc] init]; ，编译时和运行时obj分别是什么类型？
		
		编译时是NSString类型,运行时是NSData类型
		
20. \#import 跟#include、@class有什么区别？＃import<> 跟 #import”"又什么区别？
		
		#import和#include都能完整地包含某个文件的内容，#import能防止同一个文件被包含多次
		@class仅仅是声明一个类名，并不会包含类的完整声明;@class还能解决循环包含的问题
		#import <> 用来包含系统自带的文件，#import “”用来包含自定义的文件

21. Objective-C如何对内存管理的,说说你的看法和解决方法?
	
		1.每个对象都有一个引用计数器，每个新对象的计数器是1，当对象的计数器减为0时，就会被销毁
		2.通过retain可以让对象的计数器+1、release可以让对象的计数器-1
		3.还可以通过autorelease pool管理内存
		4.如果用ARC，编译器会自动生成管理内存的代码
		5.及时关闭不用的资源，使用缓存机制，尽量复用
	
22. OC中创建线程的方法是什么？如果指定在主线程中执行代码？如何延时执行代码？
	
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
23. 消息机制
	
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

27. block的内存泄露
		
		 block默认情况下,任何block都是在栈,随时可能会被回收.
		 对block做一次copy操作,block的内存就会放到堆里面,能长期拥有		[myblcok copy];
    	 Block_copy(myBlock);//在ARC下会报错
28. 线程间是如何通信的
