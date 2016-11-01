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


10. 如何用GCD同步若干个异步调用（如多个网络请求同事返回后进行UI操作）


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
		
14. UITableView卡顿如何处理？

15. 分享，传什么参数，怎么实现？

16. 推送原理？

17. SDWebImage内部如何实现的，图片如何存储的？

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

23. 







