今天在处理按钮连续点击重复请求的问题，进行延迟处理时，[self performSelector:@selector(setFjl_ignoreEvent:) withObject:@(NO) afterDelay:self.fjl_acceptEventInterval];。发现在执行到这行代码的时候，并没有调用 SEL 的方法。


    //解决按钮连续点击问题
    - (void)_fjl_sendAction:(SEL)selector to:(id)target forEvent:(UIEvent*)event{
        if (self.fjl_ignoreEvent) return;
        if (self.fjl_acceptEventInterval > 0) {
            self.fjl_ignoreEvent = YES;
            [self performSelector:@selector(setFjl_ignoreEvent:) withObject:@(NO) afterDelay:self.fjl_acceptEventInterval];
        }
        [self _fjl_sendAction:selector to:target forEvent:event];
    }
    
此延迟方法没走，测试人员又着急测试，我变换了一种延迟方法，使用了dispatch_after，运行了一下，没有问题了。

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.fjl_acceptEventInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setFjl_ignoreEvent:NO];
    });
    
着实纳了闷，这两个方法到底有什么区别呢，经过我的一番努力，终于找到了答案。
原来performSelector withObject afterDelay这个方法在子线程中，并不会调用SEL方法，而performSelect withObject 方法会直接调用。原因是：

    1. afterDelay 方式是使用当前线程的定时器在一定时间后调用SEL，NO AfterDelay方式是直接调用SEL.
    2. 子线程中默认是没有定时器的。

原因我们知道了，那么解决这个问题你是不是有了思路呢？

1. 开启线程的定时器
    
        [[NSRunLoop currentRunLoop] run];

2. 使用dispatch_after来执行定时任务
       
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, self.fjl_acceptEventInterval*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            [self setFjl_ignoreEvent:NO];
        });

        或者
        
        //延时调用
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.fjl_acceptEventInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setFjl_ignoreEvent:NO];
        });