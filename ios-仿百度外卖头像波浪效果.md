##iOS-仿百度外卖头像波浪效果

####CADisplayLink

简单的说就是一定时器,其根本利用刷帧和屏幕频率一样来重绘渲染页面.

其创建方式:

	CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];

	[timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

具体详细介绍请看：http://huanghaiyan.96.lt/ios/%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3cadisplaylink%E5%92%8Cnstimer/

####CAShapeLayer

CALayer的子类,通常结合CGPath来绘制图形.

其创建方式:

	CAShapeLayer *layer = [CAShapeLayer layer];

	layer.frame =  self.bounds;

	layer.fillColor = self.realWaveColor.CGColor;

	layer...等属性

	[self.view.layer addSublayer:layer];

其优点

- 渲染效率高渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
- 高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
- 不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。你的图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉。
- 不会出现像素化。当你给CAShapeLayer做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。

####三角函数

sin a = y/r

cos a = x/r

####思路实现

UIView –> 2个CAShapeLayer –> imageView.frame.orgin.y调整

####效果图：
![wave.gif](http://upload-images.jianshu.io/upload_images/726092-489278db427cf484.gif?imageMogr2/auto-orient/strip)

demo地址：https://github.com/huanghaiyan/BDWaveView-master