####iOS-UITextField设置
1. 初始化textfield并设置位置及大小
	
		//初始化textfield并设置位置及大小
		UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, 130, 30)];
	
	
2. 首字母是否大写

		//首字母是否大写
		textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
 
		typedef enum {
    		UITextAutocapitalizationTypeNone, 不自动大写
    		UITextAutocapitalizationTypeWords,  单词首字母大写
    		UITextAutocapitalizationTypeSentences,  句子的首字母大写
    		UITextAutocapitalizationTypeAllCharacters, 所有字母都大写
		} UITextAutocapitalizationType;

3. 设置边框样式  
	
		//设置边框样式，只有设置了才会显示边框样式  
		textField.borderStyle = UITextBorderStyleRoundedRect;
		
		typedef enum {
    		UITextBorderStyleNone,  //无边框
    		UITextBorderStyleLine,  //有边框
    		UITextBorderStyleBezel, //有边框和阴影
    		UITextBorderStyleRoundedRect   //圆角
    	} UITextBorderStyle;
    		
4. 背景颜色是文本内容部分的颜色

		textField.backgroundColor = [UIColor whiteColor];
		
5. 设置背景图片
	
		textField.background=[UIImage imageNamed:@"Icon.png"];
6. 提示文字
		
		textField.placeholder = @"请输入账号";
7. 设置和读取文字内容
	
		textField.text = @”我是文本框”;
		NSString * str = textField.text;
		
8. 设置字体格式

		[textField setFont:[UIFont fontWithName:@"Arial" size:30]];
9. 设置字体颜色
		textField.textColor = [UIColor redColor];
10. 密文输入

		textField.secureTextEntry = YES; 
11. 输入框中是否有个叉号显示

		text.clearButtonMode = UITextFieldViewModeAlways;
		typedef enum {
    		UITextFieldViewModeNever,  //从不出现
    		UITextFieldViewModeWhileEditing, //编辑时出现
    		UITextFieldViewModeUnlessEditing,  //除了编辑外都出现
    		UITextFieldViewModeAlways   //一直出现
		} UITextFieldViewMode;
		
12. 键盘类型

		textField.keyboardType = UIKeyboardTypeNumberPad;//数字键		typedef enum {
			UIKeyboardTypeDefault,                // 当前键盘（默认）
    		UIKeyboardTypeASCIICapable,           // 字母输入键
			UIKeyboardTypeNumbersAndPunctuation,  //数字和符号
    		UIKeyboardTypeURL,                    //URL键盘
    		UIKeyboardTypeNumberPad,          //数字键盘
    		UIKeyboardTypePhonePad,           //电话号码输入键盘   
    		UIKeyboardTypeNamePhonePad,  // 电话键盘，也支持输入人名
    		UIKeyboardTypeEmailAddress, //邮件地址输入键盘   
    		UIKeyboardTypeDecimalPad,     数字键盘 有数字和小数点
    		UIKeyboardTypeTwitter,        优化的键盘，方便输入@、#字符       

		} UIKeyboardType;
		
13. 键盘风格

		textField.keyboardAppearance = UIKeyboardAppearanceDefault；
		typedef enum {
			UIKeyboardAppearanceDefault， 默认外观，浅灰色
			UIKeyboardAppearanceAlert，     深灰 石墨色
		} UIReturnKeyType;
		
14. 再次编辑时是否清空之前内容；默认NO

		textField.clearsOnBeginEditing = YES;
15. 内容对齐方式

		textFied.textAlignment = UITextAlignmentLeft;
16. 内容的垂直对齐方式 
	
		//内容的垂直对齐方式  UITextField继承自UIControl,此类中有一个属性contentVerticalAlignment
		textFied.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

17. 设置为YES时文本会自动缩小以适应文本窗口大小.默认是保持原来大小,而让长文本滚动

		textFied.adjustsFontSizeToFitWidth = YES;
18. 设置自动缩小显示的最小字体大小
	
		textFied.minimumFontSize = 20;
		
19. 设置return键

		textFied.returnKeyType =UIReturnKeyDone;
		typedef enum {
    		UIReturnKeyDefault, //默认 灰色按钮，标有Return
    		UIReturnKeyGo,      //标有Go的蓝色按钮
    		UIReturnKeyGoogle, //标有Google的蓝色按钮，用语搜索
    		UIReturnKeyJoin,  //标有Join的蓝色按钮
    		UIReturnKeyNext,  //标有Next的蓝色按钮
    		UIReturnKeyRoute,  //标有Route的蓝色按钮
    		UIReturnKeySearch,  //标有Search的蓝色按钮
    		UIReturnKeySend,  //标有Send的蓝色按钮
    		UIReturnKeyYahoo, //标有Yahoo的蓝色按钮
    		UIReturnKeyYahoo,  //标有Yahoo的蓝色按钮
    		UIReturnKeyEmergencyCall, //紧急呼叫按钮
		} UIReturnKeyType;

20. 设置代理 用于实现协议

		textFied.delegate = self;
21. 点击键盘上Return按钮时候调用

		- (BOOL)textFieldShouldReturn:(UITextField *)textField{
			//官方 取消第一响应者（就是退出编辑模式收键盘）
    		[textField resignFirstResponder];
    		return YES;
		}
22. 当输入任何字符时，代理调用该方法
	
		-(BOOL)textField:(UITextField *)field shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

			//当输入任何字符时，代理调用该方法，如果返回YES则这次输入可以成功，如果返回NO，不能输入成功
		//range表示光标位置，只有location，length == 0；

		//string表示这次输入的字符串。
		{
			 NSLog(@"range = %@  string = %@",NSStringFromRange(range),string);

    		return str.length < 10;
    		//textField.text超过了10个字符，返回NO，不让输入成功。(最多输入10个)

    		//textField.text输入后不到10个字符，返回YES，使输入成功。

    		return YES;

		}