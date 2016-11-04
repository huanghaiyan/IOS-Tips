#####iOS面试题选择
1. 关于KVC的描述正确的是：

	A.KVC是指"Key-Value Observing"
	
	B.是一种间接访问对象的属性的机制。
	
	C.只能访问对象的属性。
	
	D.当对象的属性值改变时，我们能收到一个通知。
	
	答案：B
	
	解析：
	
2. NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
   [formatter setAMSymbol:@"AM"];
   
   [formatter setPMSymbol:@"PM"];
   
   [formatter setDateFormat:@"YY-MM-dd hh:mm:ss:ss aaa"];
    
   NSString *currentDate = [formatter stringFromDate:[NSDate date]];
   
   NSLog(@"%@",currentDate); 
   
   A.2016-08-3 17:45:04 PM
   
   B.16-08-3 17:45:04
   
   C.2016-08-3 17:45:04
   
   D.16-08-3 03:38:38:38 PM

   答案：D
	
   解析：
   
3. 类何时调用dealloc方法：
	
   A.[property release]后
   
   B.[instance release]后
   
   C.[super dealloc]时;
   
   D.当引用计数为0时
   
   答案：D
   
   解析：

4.	关于类和对象的概念，下列属于对象的是：
	
	A、奥迪A6
	
	B、保龄球
	
	C、世界冠军刘翔
	
	D、西红柿

	答案：C
	
	解析：类是对象的抽象，对象是类的具体实例。类是抽象的，不占用内存，而对象是具体的，占有内存空间。
5. 下面哪些选项是属性的正确声明方式：
	
	A、@property(nonatomic,retain)NSString myString;
	
	B、@property(nonatomic,assign)NSString *myString;
	
	C、@property(nonatomic,assign)int mynumber;
	
	D、@property(nonatomic,retain)int mynumber;
	
	答案：C
	
	解析：
	
6. 下面程序段的输出结果是什么:

	NSArray *arr1 = [[NSArray alloc]initWithObjects:@"1",@"2",@"3", nil];
	
    NSString *str;
    
    str = [arr1 objectAtIndex:2];
    
    NSLog(@"%@",str);   // 3
   
    输出为：
    
    A、1
    
    B、2
    
    C、3
    
    D、程序崩溃
    
    答案：C
    
    解析：
    
7. 下面代码正确的输出结果是：
	
	NSString *urlStr = @"www.lanou3g.com";
	
    NSRange range = NSMakeRange(4, 7);
    
    NSString *prefix = [urlStr substringWithRange:range];
    
    NSLog(@"%@",prefix); 
    
    输出为：
    
    A、lan
    
    B、lanou3g
   
    C、www.lan
    
    D、ou3g
    
    答案：B
    
    解析：NSMakeRange是一个结构体类型，包含两个参数，位置和长度。表示字符串要传进来从哪里开始的位置和需要的长度。
    

8. 下面category描述不正确的是：
	
	A、category可以添加新的方法
	
	B、category可以删除修改之前的方法
	
	C、将类的实现分散到多个不同文件或多个不同框架中
	
	D、创建对私有方法的前向引用
	
	答案：B
	
	解析：
	
9. 在UIKit中，frame与bounds的区别是 
	
	A. frame 是 bounds 的别名 
    
    B. frame 是 bounds 的继承类 
	
	C. frame 的参考系是父视图坐标，bounds 的参考系是自身的坐标 
	
	D. frame 的参考系是自身坐标，bounds 的参考系是父视图的坐标
	
	答案：C
	
	解析：frame指的是：该view在父view坐标系统中的位置和大小。（参照点是父亲的坐标系统）
        
      bounds指的是：该view在本身坐标系统中 的位置和大小。（参照点是本身坐标系统）

10. Block作为属性在ARC下应该使用的语义设置为？

	A、copy
	
	B、weak
	
	C、strong
	
	D、retain
	
	答案：A
	
	解析：开发者使用 block 的时候苹果官方文档中说明推荐使用 copy，使用 copy 的原因就在于大家所熟知的把block从栈管理过渡到堆管理
	
11. 需要在手动管理内存分配和释放的Xcode项目中引用和编译用ARC风格编写的文件，需要在文件的Compiler Flags上添加参数：
	
	A、-shared
	
	B、-fno-objc-arc
	
	C、-fobjc-arc
	
	D、-dynamic
 
    答案：C
	
    解析：
   
12. 下面关于线程管理错误的是
	
	A、GCD所用的开销要比NSThread大 

    B、可以在子线程中修改UI元素 
	
	C、NSOperationQueue是比NSthread更高层的封装 
	
	D、GCD可以根据不同优先级分配线程
	
	答案：B
	
	解析：
	

13. 在没有navigationController的情况下，要从一个ViewController切换到另一个ViewController应该 
	
	A、[self.navigationController pushViewController:nextViewController animated:YES]; 
	
	B、[self.view addSubview:nextViewController.view]; 
	
	C、[self pushViewController:nextViewController animated:YES]; 
	
	D、[self presentModalViewController:nextViewController animated:YES];
	
	答案：D
	
	解析：
	
14. 下面的代码问题在哪？
	
	
	@implementation xxx
	
	…
	…	
	
	-(void) setVar:(int)i {
		
	   self.var = i;
	
	}
	
	A、应该将var synthesize 
	
	B、调用会出现死循环 
	
	C、正常 
	
	D、返回值错误
	
	答案：B
	
	解析：

15. 什么是key window？ 
	
	A、App中唯一的那个UIWindow对象 
	
	B、可以指定一个key的UIWindow 
    
    C、可接收到键盘输入等事件的UIWindow 
	
	D. 不可以隐藏的那个UIWindow对象
	
	答案：C
	
	解析：
	
	
16. 下面代码的作用是让doSomeThing函数每隔1秒被调用1次。请问哪里有问题

	NSTimer *myTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(doSomeThing:)  userInfo:nil repeats:YES]; 
	
	[myTimer fire]
	
	A、没有将timer加入runloop 
	
	B、doSomeThing缺少参数 
	
	C、忘记传递数据给userInfo 
	
	D、myTimer对象未通过[[myTimer alloc] init]方法初始化
	
	答案：A
	
	解析：
	
17. NSRunLoop的以下描述错误的是：
	
	A、RunLoop并不是由系统自动控制的
	
	B、有3类对象可以被run loop 监控：sources，timers,observers
	
	C、线程是默认启动run loop的
	
	D、NSTimer可手动添加到新建的NSRunLoop中
	
	答案：C
	
	解析： 只有主线程默认启动run loop，子线程等需要手动启动，且在特定的场景下需要启动：需要使用NSTimer等。
	
18. C和Objective-C的混合使用，以下描述错误的是：
	
	A、cpp文件只能使用C/C++代码
	
	B、cpp文件include的头文件中，可以出现objective-C的代码
	
	C、mm文件中混用cpp直接使用即可
	
	D、cpp使用objective-C的关键是使用接口，而不能直接使用代码
	
	答案：B
	
	解析：

19. 关于浅复制和深复制的说法，下列说法正确的是：（多选）

	A、浅复制：只复制指向对象的指针，而不复制引用对象本身。
	
	B、深复制：复制引用对象本身。
	
	C、如果是浅复制，若类中存在成员变量指针，修改一个对象一定会影响另外一个对象。
	
	D、如果是深拷贝，修改一个对象不会影响到另外一个对象。
	
	答案：
	
	解析：

20. ObjC声明一个类所要用到的编译指令是：

	A、@interface SomeClass
	
	B、@protocol SomeClass
	
	C、implementation SomeClass
	
	D、@autorelease SomeClass
	
	答案：A
	
	解析：
	
21. 断点续传需要在请求头中添加的控制续传最重要的关键字：
	
	A、range
	
	B、length
	
	C、type
	
	D、size
	
	答案：A
	
	解析：
	
	
22. 堆和栈的区别正确的是：

	A、对于栈来讲，我们需要手工控制，容易产生memoryleak
	
	B、对于堆来说，释放工作由编译器自动管理，无需我们手工控制
	
	C、在Windows下，栈是向高地址扩展的数据结构，是连续的内存区域，栈顶的地址和栈的最大容量是系统预先规定好的
	
	D、对于堆来讲，频繁的new/delete势必会造成内存空间的不连续，从而造成大量的碎片，使程序效率降低
	
	答案：
	
	解析：

23. 线程和进程的区别不正确的是 
	
	A、进程和线程都是由操作系统所体会的程序运行的基本单元
	
	B、线程之间有单独的地址空间
	
	C、进程和线程的主要差别在于它们是不同的操作系统资源管理方式
	
	D、线程有自己的堆栈和局部变量
	
	答案：B
	
	解析：

24. 即时聊天App不会采用的网络传输方式：

	A、UDP
	
	B、TCP
	
	C、HTTP
	
	D、FTP
	
	答案：D
	
	解析：FTP是文件传输协议
25. MVC优点不正确的是 

	A、低耦合性	
	B、高重用性和可适用性	
	C、较低的生命周期成本		D、代码高效率	
	答案：D
26. 下面哪个不属于对象数据序列化方法 
	A、 JSON 

	B、Property List 
	
	C、XML 
	
	D、HTTP
	
	答案：D
	
27. 使用imageNamed方法创建UIImage对象时，与普通的init方法有什么区别？

	A、没有区别，只是为了方便 		B、imageNamed方法只是创建了一个指针，没有分配其他内存 	C、imageNamed方法将图片加载到内存中后不再释放 	D、imageNamed方法将使用完图片后立即释放
	答案：C28. Objective-C有私有方法吗？有私有变量吗？ 
	
	A、有私有方法和私有变量 
	
	B、没有私有方法也没有私有变量 
	
	C、没有私有方法，有私有变量 
	
	D、有私有方法，没有私有变量
	答案：C
29. 下面关于Objective-C内存管理的描述错误的是 
	
	A、当使用ARC来管理内存时，代码中不可以出现autorelease 
	
	B、autoreleasepool 在 drain 的时候会释放在其中分配的对象 
	
	C、当使用ARC来管理内存时，在线程中大量分配对象而不用autoreleasepool则可能会造成内存泄露 
	
	D、在使用ARC的项目中不能使用NSZone

	答案：A
	
	
30. 多线程中栈与堆是公有的还是私有的  
	
	A、栈公有, 堆私有 	B、 栈公有，堆公有 	
	C、 栈私有, 堆公有 	D、 栈私有，堆私有 	
	答案：C
	
	解析：
