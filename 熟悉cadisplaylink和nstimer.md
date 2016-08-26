
###熟悉CADisplayLink和NSTimer
####一、什么是CADisplayLink
> 简单地说，它就是一个定时器，每隔几毫秒刷新一次屏幕。
CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。我们在应用中创建一个新的 CADisplayLink 对象，把它添加到一个runloop中，并给它提供一个 target 和 selector 在屏幕刷新的时候调用。
一但 CADisplayLink 以特定的模式注册到runloop之后，每当屏幕需要刷新的时候，runloop就会调用CADisplayLink绑定的target上的selector，这时target可以读到 CADisplayLink 的每次调用的时间戳，用来准备下一帧显示需要的数据。例如一个视频应用使用时间戳来计算下一帧要显示的视频数据。在UI做动画的过程中，需要通过时间戳来计算UI对象在动画的下一帧要更新的大小等等。
在添加进runloop的时候我们应该选用高一些的优先级，来保证动画的平滑。可以设想一下，我们在动画的过程中，runloop被添加进来了一个高优先级的任务，那么，下一次的调用就会被暂停转而先去执行高优先级的任务，然后在接着执行CADisplayLink的调用，从而造成动画过程的卡顿，使动画不流畅。

CADisplayLink的属性介绍：
> 1.duration属性:提供了每帧之间的时间，也就是屏幕每次刷新之间的的时间。该属性在target的selector被首次调用以后才会被赋值。selector的调用间隔时间计算方式是：时间=duration×frameInterval。 我们可以使用这个时间来计算出下一帧要显示的UI的数值。但是 duration只是个大概的时间，如果CPU忙于其它计算，就没法保证以相同的频率执行屏幕的绘制操作，这样会跳过几次调用回调方法的机会。
2.frameInterval属性:是可读可写的NSInteger型值，标识间隔多少帧调用一次selector 方法，默认值是1，即每帧都调用一次。如果每帧都调用一次的话，对于iOS设备来说那刷新频率就是60HZ也就是每秒60次，如果将 frameInterval 设为2 那么就会两帧调用一次，也就是变成了每秒刷新30次。
3.pause属性:控制CADisplayLink的运行。当我们想结束一个CADisplayLink的时候，应该调用-(void)invalidate 从runloop中删除并删除之前绑定的 target 跟 selector
4.timestamp属性: 只读的CFTimeInterval值，表示屏幕显示的上一帧的时间戳，这个属性通常被target用来计算下一帧中应该显示的内容。 打印timestamp值，其样式类似于：179699.631584。

另外 CADisplayLink 不能被继承。

给非UI对象添加动画效果
我们知道动画效果就是一个属性的线性变化，比如 UIView 动画的 EasyIn EasyOut 。通过数值按照不同速率的变化我们能生成更接近真实世界的动画效果。我们也可以利用这个特性来使一些其他属性按照我们期望的曲线变化。比如当播放视频时关掉视频的声音我可以通过 CADisplayLink 来实现一个 EasyOut 的渐出效果：先快速的降低音量，在慢慢的渐变到静音。
注意：通常来讲：iOS设备的刷新频率事60HZ也就是每秒60次。那么每一次刷新的时间就是1/60秒 大概16.7毫秒。当我们的frameInterval 值为1的时候我们需要保证的是 CADisplayLink调用的target的函数计算时间不应该大于 16.7否则就会出现严重的丢帧现象。 在mac应用中我们使用的不是CADisplayLink而是 CVDisplayLink它是基于C接口的用起来配置有些麻烦但是用起来还是很简单的。

####二、CADisplayLink 与 NSTimer 有什么不同?

1.原理不同

CADisplayLink是一个能让我们以和屏幕刷新率同步的频率将特定的内容画到屏幕上的定时器类。 CADisplayLink以特定模式注册到runloop后， 每当屏幕显示内容刷新结束的时候，runloop就会向 CADisplayLink指定的target发送一次指定的selector消息，  CADisplayLink类对应的selector就会被调用一次。 
NSTimer以指定的模式注册到runloop后，每当设定的周期时间到达后，runloop会向指定的target发送一次指定的selector消息。

2.周期设置方式不同

iOS设备的屏幕刷新频率(FPS)是60Hz，因此CADisplayLink的selector 默认调用周期是每秒60次，这个周期可以通过frameInterval属性设置， CADisplayLink的selector每秒调用次数=60/ frameInterval。比如当 frameInterval设为2，每秒调用就变成30次。因此， CADisplayLink 周期的设置方式略显不便。
NSTimer的selector调用周期可以在初始化时直接设定，相对就灵活的多。

3、精确度不同

iOS设备的屏幕刷新频率是固定的，CADisplayLink在正常情况下会在每次刷新结束都被调用，精确度相当高。
NSTimer的精确度就显得低了点，比如NSTimer的触发时间到的时候，runloop如果在阻塞状态，触发时间就会推迟到下一个runloop周期。并且 NSTimer新增了tolerance属性，让用户可以设置可以容忍的触发的时间的延迟范围。

4、使用场景

CADisplayLink使用场合相对专一，适合做UI的不停重绘，比如自定义动画引擎或者视频播放的渲染。
NSTimer的使用范围要广泛的多，各种需要单次或者循环定时处理的任务都可以使用。

####三、CADisplayLink和NSTimer的使用方法

* CADisplayLink的使用
  
  1.创建方法
      	
      self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
      [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
 
 	2.停止方法
      
      [self.displayLink invalidate];
      self.displayLink = nil;
      
      当把CADisplayLink对象add到runloop中后，selector就能被周期性调用，类似于重复的NSTimer被启动了；执行invalidate操作时，CADisplayLink对象就会从runloop中移除，selector调用也随即停止，类似于NSTimer的invalidate方法。

* NSTimer的使用
  		
  	 1.创建方法
        
      		NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(action:) userInfo:nil repeats:NO];
      
	  		TimerInterval : 执行之前等待的时间。比如设置成1.0，就代表1秒后执行方法
	  		target : 需要执行方法的对象。
	  		selector : 需要执行的方法
	  		repeats : 是否需要循环

   2.释放方法
 
      		[timer invalidate];
      		
	 		 注意 :调用创建方法后，target对象的计数器会加1，直到执行完毕，自动减1。如果是循环执行的话，就必须手动关闭，否则可以不执行释放方法。

   3.特性

	存在延迟 ，不管是一次性的还是周期性的timer的实际触发事件的时间，都会与所加入的RunLoop和RunLoop Mode有关，如果此RunLoop正在执行一个连续性的运算，timer就会被延时出发。重复性的timer遇到这种情况，如果延迟超过了一个周期，则会在延时结束后立刻执行，并按照之前指定的周期继续执行。
	
	注意：必须加入Runloop
	
	使用上面的创建方式，会自动把timer加入MainRunloop的NSDefaultRunLoopMode中。如果使用以下方式创建定时器，就必须手动加入Runloop:
	
         NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
         [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];