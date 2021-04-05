## GCD多线程：信号量和条件锁
### 1.信号量 
dispatch_semaphore_t  

在NSOperation中，可以直接设置最大并发数来控制并发数量，在GCD中，控制并发数量由信号量来完成。

信号量是一个整形值并且具有一个初始计数值，并且支持两个操作：信号通知和等待。当一个信号量被信号通知，其计数会被增加。当一个线程在一个信号量上等待时，线程会被阻塞（如果有必要的话），直至计数器大于零，然后线程会减少这个计数。
	
	在GCD中有三个函数是semaphore的操作，分别是：
	
	dispatch_semaphore_create　　　创建一个semaphore
	
	dispatch_semaphore_signal　　　发送一个信号
	
	dispatch_semaphore_wait　　　　等待信号

　　简单的介绍一下这三个函数，第一个函数有一个整形的参数，我们可以理解为信号的总量，dispatch_semaphore_signal是发送一个信号，自然会让信号总量加1，dispatch_semaphore_wait等待信号，当信号总量少于0的时候就会一直等待，否则就可以正常的执行，并让信号总量-1，根据这样的原理，我们便可以快速的创建一个并发控制来同步任务和有限资源访问控制。
	            
    //信号量：整数值，最多有10个线程并发 
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);      
    
    for (int i = 0; i < 100; i++){
    	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //当前信号量-1           
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);                       
            NSLog(@"%d",i+1);                       
            //线程休眠            
            //C           
            //sleep(1);            
            //OC            
            [NSThread sleepForTimeInterval:1];                       
            //当前信号量+1            
            dispatch_semaphore_signal(semaphore);                   
            });
    }

阻塞线程：

	/**阻塞线程*/
	// 创建一个信号量，值为0    
	dispatch_semaphore_t sema = dispatch_semaphore_create(0);    
	// 在一个操作结束后发信号，这会使得信号量+1    
	ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){           
     dispatch_semaphore_signal(sema);           
     });    
	// 一开始执行到这里信号量为0，线程被阻塞，直到上述操作完成使信号量+1,线程解除阻塞
	dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
	
### 2.条件锁 
条件锁可以控制线程的执行次序，相当于NSOperation中的依赖关系
	
	/*     常见的锁：    
        1.@synchronized(对象) 对象锁     
        2.NSLock 互斥锁     
        3.NSConditionLock 条件锁         
        NSRecursiveLock 递归锁     
        */    
        //条件锁,条件是整数值    
        NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:3];       
        //不要在外面加锁，那样锁的是主线程    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
                 //加锁        
                 [lock lockWhenCondition:3];               
                 NSLog(@"111111111111");               
                 //解锁        
                 [lock unlockWithCondition:4];           
                 });       
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{               
                 //加锁        
                 [lock lockWhenCondition:4];               
                 NSLog(@"222222222222");               
                 //解锁        
                 [lock unlock];       
    });
