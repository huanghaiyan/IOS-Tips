###iOS用户头像的圆形图片裁剪常用方法
####使用图层剪切
	//图层处理
    UIImage *image = [UIImage imageNamed:@"icon.png"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 100,100)];
    imageView.image = image;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    [self.view addSubview:imageView];
    
####通过Quartz2D将图形绘制出一张圆形图片
通常的解决的办法就是通过Quartz2D将图形绘制出一张圆形图片来进行显示。
		
	- (void)viewDidLoad {
	    [super viewDidLoad];
	    // Do any additional setup after loading the view, typically from a nib.
	    
	    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 250, 100, 100)];
	    imageView2.image = [self imageWithSourceImage:image];
	    [self.view addSubview:imageView2];
	}

	- (UIImage *)imageWithSourceImage:(UIImage *)sourceImage {
	    UIGraphicsBeginImageContext(sourceImage.size);
	    //bezierPathWithOvalInRect方法后面传的Rect,可以看作(x,y,width,height),前两个参数是裁剪的中心点,后面两个决定裁剪的区域是圆形还是椭圆.
	    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height)];
	    //把路径设置为裁剪区域(超出裁剪区域以外的内容会自动裁剪掉)
	    [path addClip];
	    //把图片绘制到上下文当中
	    [sourceImage drawAtPoint:CGPointZero];
	    //从上下文当中生成一张新的图片
	    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	    //结束上下文
	    UIGraphicsEndImageContext();
	    //返回新的图片
	    return newImage;
	}
