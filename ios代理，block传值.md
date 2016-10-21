##ios代理，block传值
#####需求：在ViewController中，点击Button，push到下一个页面NextViewController，在NextViewController的输入框TextField中输入一串字符，返回的时候，在ViewController的Label上面显示文字内容，

（1）第一种方法：首先看看通过“协议/代理”是怎么实现两个页面之间传值的吧，

```
//NextViewController是push进入的第二个页面
//NextViewController.h 文件
//定义一个协议，前一个页面ViewController要服从该协议，并且实现协议中的方法
@protocol NextViewControllerDelegate <NSObject>
- (void)passTextValue:(NSString *)tfText;
@end

@interface NextViewController : UIViewController
@property (nonatomic, assign) id<NextViewControllerDelegate> delegate;

@end

//NextViewController.m 文件
//点击Button返回前一个ViewController页面
- (IBAction)popBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(passTextValue:)]) {
        //self.inputTF是该页面中的TextField输入框
        [self.delegate passTextValue:self.inputTF.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
```
接下来我们在看看ViewController文件中的内容，

```
//ViewController.m 文件
@interface ViewController ()<NextViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nextVCInfoLabel;

@end
//点击Button进入下一个NextViewController页面
- (IBAction)btnClicked:(id)sender
{
    NextViewController *nextVC = [[NextViewController alloc] initWithNibName:@"NextViewController" bundle:nil];
    nextVC.delegate = self;//设置代理
    [self.navigationController pushViewController:nextVC animated:YES];
}

//实现协议NextViewControllerDelegate中的方法

 #pragma mark - NextViewControllerDelegate method
- (void)passTextValue:(NSString *)tfText
{
    //self.nextVCInfoLabel是显示NextViewController传递过来的字符串Label对象
    self.nextVCInfoLabel.text = tfText;
}
```
这是通过“协议/代理”来实现的两个页面之间传值的方式。

（2）第二种方法：使用Block作为property，实现两个页面之间传值，

先看看NextViewController文件中的内容，

```
//NextViewController.h 文件
@interface NextViewController : UIViewController
@property (nonatomic, copy) void (^NextViewControllerBlock)(NSString *tfText);

@end
//NextViewContorller.m 文件
- (IBAction)popBtnClicked:(id)sender {
    if (self.NextViewControllerBlock) {
        self.NextViewControllerBlock(self.inputTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
```
再来看看ViewController文件中的内容，

```
- (IBAction)btnClicked:(id)sender
{
    NextViewController *nextVC = [[NextViewController alloc] initWithNibName:@"NextViewController" bundle:nil];
    nextVC.NextViewControllerBlock = ^(NSString *tfText){
        [self resetLabel:tfText];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}
 #pragma mark - NextViewControllerBlock method
- (void)resetLabel:(NSString *)textStr
{
    self.nextVCInfoLabel.text = textStr;
}

```