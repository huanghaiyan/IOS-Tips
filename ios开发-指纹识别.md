#iOS开发-指纹识别

1.添加LocalAuthentication.framework库 
2.导入头文件#import "LocalAuthentication/LAContext.h" 
3.代码示例 

```
//判断手机系统版本 
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) { 
        NSLog(@"不支持指纹识别"); 
        return; 
    } 
    //创建一个LAContext实例，用于执行认证策略 
    LAContext *myContext = [[LAContext alloc]init]; 
    NSError *authError = nil; 
    NSString *myLocalizedReasonString = @"请输入指纹"; 
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) { 
        // 输入指纹，异步 
        // 提示：指纹识别只是判断当前用户是否是手机的主人！程序原本的逻辑不会受到任何的干扰！ 
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:myLocalizedReasonString reply:^(BOOL success, NSError * _Nullable error) { 
            if (success) { 
            }else{
                // 错误 error.code = ? 
            } 
        }]; 

    }else{

    } 
```

[其他文章：http://www.jianshu.com/p/85689f7f183e](http://www.jianshu.com/p/85689f7f183e)


