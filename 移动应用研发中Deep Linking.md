##移动应用研发中 Deep linking 


###基本概念
####Deep linking
_________________________________

Deep linking,中文译作深度链接。
深度链接，即绕过被链接网站首页直接链接到分页的链接方式。当用胡点击链接时，计算机会自动绕过被链网站的首页，而跳到具体内容页。

####Mobile deep linking
_________________________________

Mobile deep linking,中文译作移动深度链接。
简单的从用户体验来讲，Mobile deep linking 就是可以让你在手机上点击一个链接，便能直接跳转到一个已安装应用中的具体内容页。

####Deferred deep linking
_________________________________

Deferred deep linking ,中文译作延迟深度链接。
上面说到的Mobile deep linking，只能针对已经安装的应用可以跳转到具体内容也，但是对于未安装应用的用户则无法跳转。Deferred deep linking弥补了Mobile deep linking的不足，在用户没有安装目标应用的情况下，用户在访问特定页面或点击特定链接的时候，服务端记录用户设备的特征，如IP,系统版本，手机型号，语言等信息；然后在用户下载应用后打开的时候，客户端发送这些特征到服务器，服务器查询一段时间内（如 1 小时内）是否有匹配的用户点击过链接，如果有就把该信息返回给客户端，这样客户端就可以跳转到一个具体内容页。这样做是有缺陷的，因为服务端是通过设备的特征模糊匹配，所以会有匹配不成功的情况出现；但是第三方服务商从不同来源收集多个维度的信息，匹配的准确率其实非常高。

###Deep linking的原理与实现

iOS有两种实现方式。

####iOS
_________________________________

##### 一、URL Schemes

1.苹果的沙盒机制

在iOS系统中，针对安全问题，苹果使用了[沙盒]机制：应用智能访问它声明可能访问的资源。所有提交到App Store上的应用都必须遵循这个机制。苹果选择沙盒来保障用户的隐私和安全，但沙盒也阻碍了应用间合理的信息共享，于是有了URL Schemes这个解决办法。

2.URL Schemes

简单来说，URL Schemes就是一个可以让App间相互跳转的协议，通过URL Schemes可以跳转到应用的一个具体内容页。例如：weixin://dl/moments,通过://前边的weixin就可以唤醒微信，而通过后边的dl/moments就可以进入微信的一个具体的功能页--朋友圈。类比PC上的URL，http://www.apple.com/mac/,通过http://www.apple.com可以进入Apple的官网，加上后边的/mac/就能进入介绍mac的子页面。

3.如何实现

如图所示，添加URL Schemes

![WechatIMG14.png](http://upload-images.jianshu.io/upload_images/726092-d6ac2634320ae368.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


##### 二、Universal links

1.实现原理

![icon tupian](http://cc.cocimg.com/api/uploads/20150902/1441174097574453.png)

2.实现步骤
	
	1.在deverloper.apple.com注册你的App;
	2.准备一个用户Universal link 的domain(域名)；
	3.在app identifier中启用Associated Domains;
	4.在Xcode中启用Associated Domains;
	5.将domain信息填入Xcode - app identifier中；
	6.为你的domain(域名)申请SSL证书；
	7.创建apple-app-site-association JSON文件；
	8.使用SSL证书签名你的JSON文件；
	9.配置你的服务器将JSON文件上传到你的服务器中；
	10.编写解析链接和跳转的相关代码。
	
####开发中遇到的问题
1.如果承载也和深度链接是同一个域名，universal links失效，无法通过深度链接唤醒App。

