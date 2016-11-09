#####iOS面试题选择
1. 关于KVC的描述正确的是：

	A.KVC是指"Key-Value Observing"
	
	B.是一种间接访问对象的属性的机制。
	
	C.只能访问对象的属性。
	
	D.当对象的属性值改变时，我们能收到一个通知。
	
	答案：B
	
	解析：kvc:键 - 值编码(Key-Value-Coding)是一种间接访问对象的属性使用字符串来标识属性，而不是通过调用存取方法，直接或通过实例变量访问的机制。
	kvo:键值观察（Key-Value Observing）机制，他提供了观察某一属性变化的方法。
	
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
	
   解析： yy 不包含纪元的年份。具有前导零。  
        yyyy 包括纪元的四位数的年份。  
   
3. 类何时调用dealloc方法：
	
   A.[property release]后
   
   B.[instance release]后
   
   C.[super dealloc]时;
   
   D.当引用计数为0时
   
   答案：D
   
   解析：当对象的引用计数为0，系统会自动调用dealloc方法，回收内存。
   -(void)dealloc{
    [super dealloc];}

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
	
	解析：readwrite 是可读可写特性；需要生成getter方法和setter方法时；

	readonly 是只读特性  只会生成getter方法 不会生成setter方法 ;不希望属性在类外改变；

	assign 是赋值特性，setter方法将传入参数赋值给实例变量；仅设置变量时；

	retain 表示持有特性，setter方法将传入参数先保留，再赋值，传入参数的retaincount会+1;

	copy 表示拷贝特性，setter方法将传入对象复制一份；需要完全一份新的变量时；

	nonatomic 非原子操作，决定编译器生成的setter getter是否是原子操作，atomic表示多线程安全，一般使用nonatomic；
	
	
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
    
    解析：数组的下标是从0开始的，arr1中共有三个元素，下标分别是0、1、2，取arr1中下标为2的元素值是3,并不会越界，造成程序崩溃。
    
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
    
    解析：NSRange 结构体用来表示相关事物的范围.比如:字符串里字符的位置信息或者数组里数组元素的范围.location表示范围的位置信息,从0开始计数,length表示范围所含元素的个数,length可以为0.如字符串@“Hello,Power Node”,单词”Power”,可以用location为6,length为5来表示.
    

8. 下面category描述不正确的是：
	
	A、category可以添加新的方法
	
	B、category可以删除修改之前的方法
	
	C、将类的实现分散到多个不同文件或多个不同框架中
	
	D、创建对私有方法的前向引用
	
	答案：B
	解析：category为现有的类添加新的方法；将类的实现代码分散到多个不同文件或框架中；创建对私有方法的前向引用；向对象添加非正式协议。
	
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
	
	解析：开发者使用 block 的时候苹果官方文档中说明推荐使用copy，使用 copy 的原因就在于大家所熟知的把block从栈管理过渡到堆管理。
	
11. 需要在手动管理内存分配和释放的Xcode项目中引用和编译用ARC风格编写的文件，需要在文件的Compiler Flags上添加参数：
	
	A、-shared
	
	B、-fno-objc-arc
	
	C、-fobjc-arc
	
	D、-dynamic
 
    答案：C
	
    解析：ARC与非ARC在一个项目中同时使用，需要选择项目中的Targets，选中你所要操作的Target，选Build Phases，在其中Complie Sources中选择需要ARC的文件双击，并在输入框中输入：-fobjc-arc。
 
12. 下面关于线程管理错误的是
	
	A、GCD所用的开销要比NSThread大 

    B、可以在子线程中修改UI元素 
	
	C、NSOperationQueue是比NSthread更高层的封装 
	
	D、GCD可以根据不同优先级分配线程
	
	答案：B
	
	解析：[NSThread](http://blog.csdn.net/totogo2010/article/details/8010231)、[Cocoa NSOperation](http://blog.csdn.net/totogo2010/article/details/8013316)、[GCD](http://blog.csdn.net/totogo2010/article/details/8016129) 
	。这三种编程方式从上到下，抽象度层次是从低到高的，抽象度越高的使用越简单。为了避免界面在处理耗时的操作时卡死，比如读取网络数据，IO,数据库读写等，我们会在另外一个线程中处理这些操作，然后通知主线程更新界面。系统给每一个应用程序提供了三个concurrent dispatch queues。这三个并发调度队列是全局的，它们只有优先级的不同。

13. 在没有navigationController的情况下，要从一个ViewController切换到另一个ViewController应该 
	
	A、[self.navigationController pushViewController:nextViewController animated:YES]; 
	
	B、[self.view addSubview:nextViewController.view]; 
	
	C、[self pushViewController:nextViewController animated:YES]; 
	
	D、[self presentModalViewController:nextViewController animated:YES];
	
	答案：D
	
	解析：页面跳转方式：1.模态跳转（Modal）：一个普通的视图控制器一般只有模态跳转的功能，这个方法是所有视图控制器对象都可以用的。
	2.通过导航控制器UINavigationController：工作原理：通过栈的方式的来实现的，NavigationController展示永远就是栈顶的控制器的view。当使用push方法的时候，就将需要跳转的控制器压入栈中，成为栈顶控制器；当使用pop方法的时候，就将控制器移出栈，原来跳转之前的控制器重新成为栈顶控制器，被展现；
	3.选项卡UITabBarController控制器：通过调用UITabBarController的addChildViewController方法添加子控制器
	4.Storyboard的segues方式

	
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
	
	解析：这是重写setter方法，然后在setter方法里调用setter方法，形成了死循环。

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
	
	解析：1）obj-c的编译器处理后缀为m的文件时，可以识别obj-c和c的代码， 处理mm文件可以识别obj-c,c,c++代码，但cpp文件必须只能用c/c++代码，而且cpp文件include的头文件中，也不能出现obj- c的代码，因为cpp只是cpp 	
	2) 在mm文件中混用cpp直接使用即可，所以obj-c混cpp不是问题
	
	3）在cpp中混用obj- c其实就是使用obj-c编写的模块是我们想要的。 如果模块以类实现，那么要按照cpp class的标准写类的定义，头文件中不能出现obj-c的东西，包括#import cocoa的。实现文件中，即类的实现代码中可以使用obj-c的东西，可以import,只是后缀是mm。 如果模块以函数实现，那么头文件要按 c的格式声明函数，实现文件中，c++函数内部可以用obj-c，但后缀还是mm或m。  总结：只要cpp文件和cpp include的文件中不包含obj-c的东西就可以用了，cpp混用obj-c的关键是使用接口，而不能直接使用实现代码，实际上cpp混用的是 obj-c编译后的o文件，这个东西其实是无差别的，所以可以用。obj-c的编译器支持cpp.

19. 关于浅复制和深复制的说法，下列说法正确的是：（多选）

	A、浅复制：只复制指向对象的指针，而不复制引用对象本身。
	
	B、深复制：复制引用对象本身。
	
	C、如果是浅复制，若类中存在成员变量指针，修改一个对象一定会影响另外一个对象。
	
	D、如果是深拷贝，修改一个对象不会影响到另外一个对象。
	
	答案：A 、B、C、D
	
	解析：浅层复制：只复制指向对象的指针，而不复制引用对象本身。
	
	深层复制：复制引用对象本身。
	
	对于浅复制来说，A和A_copy指向的是同一个内存资源，复制的只不过是是一个指针，对象本身资源 还是只有一份，那如果我们对A_copy执行了修改操作,那么发现A引用的对象同样被修改;深复制就好理解了,内存中存在了 两份独立对象本身

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
	
	答案：D
	
	解析：管理方式：对于栈来讲，是由编译器自动管理，无需我们手工控制；对于堆来讲，释放工作有程序员控制，容易产生memory Leak。
	
	申请大小：
	
	栈：在Windows下，栈是向低地址扩展的数据结构，是一块连续的内存区域。这句话的意思是栈顶上的地址和栈的最大容量是系统预先规定好的，在Windows下，栈的大小是2M（也有的说1M，总之是编译器确定的一个常数），如果申请的空间超过了栈的剩余空间时候，就overflow。因此，能获得栈的空间较小。
	
	堆：堆是向高地址扩展的数据结构，是不连续的内存区域。这是由于系统是用链表来存储的空闲内存地址的，自然是不连续的，而链表的遍历方向是由低地址向高地址。堆的大笑受限于计算机系统中有效的虚拟内存。由此可见，堆获得的空间比较灵活，也比较大。
	
	碎片的问题：
	
	对于堆来讲，频繁的new/delete势必会造成内存空间的不连续，从而造成大量的碎片，使程序效率降低。对于栈来讲，则不会存在这个问题，因为栈是先进后出的队列，他们是如此的一一对应，以至于永远都不可能有一个内存快从栈中弹出。
 
	分配方式：
	
	堆都是动态分配的，没有静态分配的堆。栈有两种分配方式：静态分配和动态分配。静态分配是编译器完成的，比如局部变量的分配。动态分配是有alloc函数进行分配的，但是栈的动态分配和堆是不同的，他的动态分配由编译器进行释放，无需我们手工实现。

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
	解析：HTTP是网络协议
	
27. 使用imageNamed方法创建UIImage对象时，与普通的init方法有什么区别？

	A、没有区别，只是为了方便 		B、imageNamed方法只是创建了一个指针，没有分配其他内存 	C、imageNamed方法将图片加载到内存中后不再释放 	D、imageNamed方法将使用完图片后立即释放
	答案：C
	解析：28. Objective-C有私有方法吗？有私有变量吗？ 
	
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

31. 请问下面的array对象的retainCount是多少？
	@property (nonatomic, retain) NSArray *array; 
 
	self.array = [[NSArray alloc] init]; 
	
	A、1
	
	B、2
	
	C、3
	
	D、4

	答案：A
	
	解析：如果没有上下文的话，只有self引用了array，其引用计数应该为1.
	
32. 请问下面的test对象的retainCount是多少

	NSString *string = [[NSString alloc] initWithString:@"abc"];
	
	NSString *test = string;
	A、1
	
	B、2
	
	C、3
	
	D、4
	
	答案：B
	
	解析：string指向了字符串@abc所在的内存区，而test指针指向了string指针，因此会对string所指向的内存区的引用计数加1，因此retainCount为2
	
33. NSInteger count=100,以下哪条语句没有错误

	A、 NSArray *array = [NSArray arrayWithObject:count];
	
	B、 NSString *str = [NSString stringWithFormat:@"%@", count];
	
	C、 NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
	
	D、 NSString *str = [count stringValue];
	
	答案：C
	
	解析：A中要求传对象；B中%@应该修改为%ld；D中count不是对象，没有方法！
34. @property(nonatomic) NSInterger age;以下代码有什么问题？

	-(void)setAge:(int)_age {
   
   	   self.age = _age;

     }
	
    A、没有问题
	
	B、 死循环
	
	C、 内存泄漏
	
	D、 不能用int类型做参数
	
	答案：B
	
	解析：重写setter方法，然后在setter方法里调用setter方法，形成了死循环。
	
35. 下面程序的输出是

		main() {
  
  			int a = -1, b = 4, k;
  
  			k = (a++<=0) && (!(b--<=0));
  			printf("%d%d%d\n", k, a, b);
		}
	A、003
	
	B、012
	
	C、103
	
	D、112
	
	答案：C
	
	解析：k = (a++ <= 0) && (!(b– <= 0)); => a++表达式的值为-1，它是后增，所以表达式的值是-1；

	由于a++ == -1，而-1 <= 0为真，因此继续看后面的表达式了：

	但是a++是执行了的，所以a变成了0。

	! (b– <= 0) => b == 3, 这个表达式的值为真，所以k的值为1

	所以，k == 1, a == 0, b == 3
	
36. 设有：int a=1, b=2, c=3, d=4, m=2, n=2;执行(m=a>b)&&(n=c>d)后n的值是多少

	A、1
	
	B、2
	
	C、3
	
	D、4
	答案：B
	
	解析：(m = a > b) 的结果是m = 1 > 2 =>m = 0，由于&&（逻辑与）在前面的条件为假时，就会短路了，不会再继续往下执行判断，所以后面的表达式（n=c>d）是不会执行的，所以n的值不变。

37.


