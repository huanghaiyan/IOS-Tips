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

