### GCD缺点

    1. 在GCD中有两种队列，分别是串行队列和并发队列。在串行队列中，同一时间只有一个任务在执行，不能充分利用多核 CPU 的资源，效率较低。
    2. 并发队列可以分配多个线程，同时处理不同的任务；效率虽然提升了，但是多线程的并发是用时间片轮转方法实现的，线程创建、销毁、上下文切换等会消耗CPU 资源。
    3. 目前iPhone的处理器是多核（2个、4个），适当的并发可以提高效率，但是无节制地并发，如将大量任务不加思索就用并发队列来执行，这只会大量增加线程数，抢占CPU资源，甚至会挤占掉主线程的 CPU 资源（极端情况）。
    4. 此外，提交给并发队列的任务中，有些任务内部会有全局的锁（如 CoreText 绘制时的 CGFont 内部锁），会导致线程休眠、阻塞；一旦这类任务多，并发队列还需要创建新的线程来执行其他任务；这种情况下，线程数大量增加是避免不了的。

###     NSOperation

    1. NSOperationQueue是iOS提供的工作队列，开发者只需要将任务封装在NSOperation的子类（NSBlockOperation、NSInvocationOperation或自定义NSOperation子类）中，然后添加进NSOperationQueue队列，队列就会按照优先顺序及工作的从属依赖关系(如果有的话)组织执行。
    2. NSOperationQueue中，已经考虑到了最大并发数的问题，并提供了maxConcurrentOperationCount属性设置最大并发数(该属性需要在任务添加到队列中之前进行设置)。maxConcurrentOperationCount默认值是-1；如果值设为0，那么不会执行任何任务；如果值设为1，那么该队列是串行的；如果大于1，那么是并行的。
    NSOperationQueue *queue = [[NSOperationQueue alloc]init]；queue.maxConcurrentOperationCount = 2;//添加Operation任务...
    3. 第三方库如SDWebImage库和AFNetworking 中就是采用NSOperationQueue来控制最大并发数的。
    说明：NSOperationQueue使用详见多线程编程3 - NSOperationQueue 和 NSOperation
