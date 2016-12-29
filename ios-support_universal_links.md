###iOS-Support Universal Links

When you support universal links, iOS 9 users can tap a link to your website and get seamlessly redirected to your installed app without going through Safari. If your app isn’t installed, tapping a link to your website opens your website in Safari.

当你支持通用链接，iOS 9的用户可以点击一个链接到你的网站并得到无缝地重定向到您安装的应用程序不需要通过Safari。如果你的应用程序没有安装，点击一个链接到你的网站打开你的网站在Safari。

Universal links give you several key benefits that you don’t get when you use custom URL schemes. Specifically, universal links are:

当您使用自定义URL schemes时，您不会得到通用链接为您提供了几个主要优点。具体来说，通用链接是：

* Unique. Unlike custom URL schemes, universal links can’t be claimed by other apps, because they use standard HTTP or HTTPS links to your website. 
* Secure. When users install your app, iOS checks a file that you’ve uploaded to your web server to make sure that your website allows your app to open URLs on its behalf. Only you can create and upload this file, so the association of your website with your app is secure. 
* Flexible. Universal links work even when your app is not installed. When your app isn’t installed, tapping a link to your website opens the content in Safari, as users expect. 
* Simple. One URL works for both your website and your app. 
* Private. Other apps can communicate with your app without needing to know whether your app is installed.

* 唯一性。与自定义URL schemes不同，Universal Links不能依靠其他应用声明，因为他们使用标准的HTTP或HTTPS链接到您的网站。//扩充：另外,Custom URL scheme 因为是自定义的协议，所以在没有安装 app 的情况下是无法直接打开的，而 universal links 本身是一个 HTTP/HTTPS 链接，所以有更好的兼容性
* 安全性。当用户安装您的应用时，iOS会检查您上传到web服务器的文件，以确保您的网站允许您的应用代表其打开网址。 只有您可以创建和上传此文件，因此您的网站与您的应用程序的关联是安全的。
* 灵活性。即使您的应用程序未安装，Universal Links也会正常工作。当您的应用未安装时，点击一个链接到您的网站会像用户期望的一样在Safari中打开你网站的内容。
* 简单性。一个URL链接适用于您的网站和您的应用程序。
* 私有性。其他应用程序可以与您的应用程序通信，而无需知道您的应用程序是否已安装。

####NOTE

In iOS 9 and later, universal links let users open your app when they tap links to your website within WKWebView and UIWebView views and Safari pages, in addition to links that result in a call to openURL:, such as those that occur in Mail, Messages, and other apps.
When a user is browsing your website in Safari and they tap a universal link to a URL in the same domain as the current webpage, iOS respects the user’s most likely intent and opens the link in Safari. If the user taps a universal link to a URL in a different domain, iOS opens the link in your app.
For users who are running versions of iOS earlier than 9.0, tapping a universal link to your website opens the link in Safari.

在iOS 9及更高版本中，通用链接允许用户在WKWebView和UIWebView视图和Safari页面中点击指向您网站的链接时打开您的应用程序，此外也可以在短信、邮件、其他应用程序中点击链接打开网页跳转到应用程序。
当用户在Safari中浏览您的网站时，他们点击到与当前网页相同域中的URL的通用链接，iOS尊重用户最可能的意图，并在Safari中打开链接。 如果用户点击通向其他域中的URL的链接，iOS会在您的应用中打开该链接。//注释：如果承载页和深度链接是同一个域名。Universal links失效，无法通过深度链接唤起app。
对于运行9.0之前的iOS版本的用户，点击指向您网站的通用链接将在Safari中打开链接。

Adding support for universal links is easy. There are three steps you need to take:

* Create an apple-app-site-association file that contains JSON data about the URLs that your app can handle. 
* Upload the apple-app-site-association file to your HTTPS web server. You can place the file at the root of your server or in the .well-known subdirectory. 
* Prepare your app to handle universal links. 
You can test universal links on a device.

添加对通用链接的支持很容易。 您需要采取以下三个步骤：

* 创建一个包含您的应用程序可以处理的URL的JSON数据的apple-app-site-association文件。
* 将apple-app-site-association文件上传到HTTPS Web服务器。 您可以将文件放在服务器的根目录或.well-known子目录中。
* 准备您的应用程序来处理通用链接。
您可以测试设备上的通用链接。

Creating and Uploading the Association File
To create a secure connection between your website and your app, you establish a trust relationship between them. You establish this relationship in two parts:
* An apple-app-site-association file that you add to your website 
* A com.apple.developer.associated-domains entitlement that you add to your app (this part is described in Preparing Your App to Handle Universal Links) 
You can learn more about how your app and website can share credentials in Shared Web Credentials Reference.

在您的网站和应用程序之间建立一个安全连接，您需要在它们之间建立信任关系。 你建立这种关系分为两部分：
* 添加apple-app-site-association文件到您的网站
* 您添加到应用程序的com.apple.developer.associated-domains entitlement（此部分在准备应用程序以处理通用链接中进行了说明）//
￼
![屏幕快照 2016-12-28 下午4.25.31.png](http://upload-images.jianshu.io/upload_images/726092-12008fa06de86292.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

您可以在“共享网络凭据参考”中详细了解您的应用和网站如何共享凭据。

####NOTE

If your app runs in iOS 9 or later and you use HTTPS to serve the apple-app-site-association file, you can create a plain text file that uses the application/json MIME type and you don’t need to sign it. If you support Handoff and Shared Web Credentials in iOS 8, you still need to sign the file as described in Shared Web Credentials Reference.

如果您的应用程序在iOS 9或更高版本中运行，并且您使用HTTPS来提供apple-app-site-association文件，您可以创建一个使用application / json MIME类型的纯文本文件，而不需要对其进行签名。如果您在iOS 8中支持Handoff和Shared Web Credentials，您仍然需要按照共享Web凭据参考中所述签名文件。

You need to supply a separate apple-app-site-association file for each domain with unique content that your app supports. For example, apple.com and developer.apple.com need separate apple-app-site-association files, because these domains serve different content. In contrast, apple.com and www.apple.com don’t need separate site association files—because both domains serve the same content—but both domains must make the file available. For apps that run in iOS 9.3.1 and later, the uncompressed size of the apple-app-site-association file must be no greater than 128 KB, regardless of whether the file is signed.

您需要为每个域提供一个单独的apple-app-site-association文件，其中包含您应用支持的唯一内容。 例如，apple.com和developer.apple.com需要单独的apple-app-site-association文件，因为这些域提供不同的内容。相比之下，apple.com和www.apple.com不需要单独的站点关联文件 - 因为两个域提供相同的内容，但两个域必须使文件可用。 对于在iOS 9.3.1及更高版本中运行的应用程序，apple-app-site-association文件的未压缩大小不得大于128 KB，无论文件是否已签名。

In your apple-app-site-association file, you specify the paths from your website that should be handled as universal links along with those that should not be handled as universal links. Keep the list of paths fairly short and rely on wildcard matching to match larger sets of paths. Listing 6-1 shows an example of an apple-app-site-association file that identifies three paths that should be handled as universal links.

在您的apple-app-site-association文件中，指定您的网站中应作为通用链接处理的路径以及不应作为通用链接处理的路径。保持路径列表相当短，并依靠通配符匹配来匹配更大的路径集。 清单6-1显示了一个apple-app-site-association文件的示例，它标识了应该作为通用链接处理的三个路径。

￼
![屏幕快照 2016-12-28 下午4.27.04.png](http://upload-images.jianshu.io/upload_images/726092-6b6f995e7fa34ecc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####NOTE

Don’t append .json to the apple-app-site-association filename.

不要将.json追加到apple-app-site-association文件名。（在构建应用程序后，appID值与应用程序权限中的“application-identifier”键相关联。）

The apps key in an apple-app-site-association file must be present and its value must be an empty array, as shown in Listing 6-1. The value of the details key is an array of dictionaries, one dictionary per app that your website supports. The order of the dictionaries in the array determines the order the system follows when looking for a match, so you can specify an app to handle a particular part of your website.

apple-app-site-association文件中的apps键必须存在，其值必须为空数组，如清单6-1所示。 details键的值是一个字典数组，您的网站支持的每个应用程序一个字典。 数组中字典的顺序决定了系统在查找匹配时所遵循的顺序，因此您可以指定一个应用程序来处理网站的特定部分。

Each app-specific dictionary contains an appID key and a paths key. The value of the appID key is the team ID or app ID prefix, followed by the bundle ID. (The appID value is the same value that’s associated with the “application-identifier” key in your app’s entitlements after you build it.) The value of the paths key is an array of strings that specify the parts of your website that are supported by the app and the parts of your website that you don’t want to associate with the app. To specify an area that should not be handled as a universal link, add “NOT ” (including a space after the T) to the beginning of the path string. For example, the apple-app-site-association file shown in Listing 6-1 could prevent the /videos/wwdc/2010/* area of the website from being handled as a universal link by updating the paths array as shown here:

每个应用程序特定的字典包含一个appID键和一个paths键。 appID键的值是team ID 或app ID前缀，后跟bundleID。paths键的值是一个字符串数组，指定您的网站的应用程序和您不想与应用程序关联的网站部分支持的部分。 要指定不应作为通用链接处理的区域，请将“NOT”（包括T后的空格）添加到路径字符串的开头。 例如，如清单6-1所示的apple-app-site-association文件可以通过更新paths数组来阻止网站的/ videos / wwdc / 2010 / *区域被作为通用链接处理，如下所示：
￼
![屏幕快照 2016-12-28 下午4.27.30.png](http://upload-images.jianshu.io/upload_images/726092-2c64eeb62b323c53.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Because the system evaluates each path in the paths array in the order it is specified—and stops evaluating when a positive or negative match is found—you should specify high priority paths before low priority paths. Note that only the path component of the URL is used for comparison. Other components, such as the query string or fragment identifier, are ignored.

因为系统按照它指定的顺序评估paths数组中的每个路径，并在找到正或负匹配时停止计算，因此您应在低优先级路径之前指定高优先级路径。 请注意，只有URL的路径组件用于比较。 忽略其他组件，例如查询字符串或片段标识符。

There are various ways to specify website paths in the apple-app-site-association file. For example, you can:

* Use * to specify your entire website 
* Include a specific URL, such as /wwdc/news/, to specify a particular link 
* Append * to a specific URL, such as /videos/wwdc/2015/*, to specify a section of your website. In addition to using * to match any substring, you can also use ? to match any single character. You can combine both wildcards in a single path, such as /foo/*/bar/201?/mypage.

有多种方法在apple-app-site-association文件中指定网站路径。 例如，您可以：

* 使用*指定整个网站
* 包括特定URL,例如/ wwdc / news /,以指定特定链接
* 将*附加到特定网址,例如/ videos / wwdc / 2015 / *,以指定您网站的某个部分。除了使用*匹配任何子字符串，还可以使用？ 匹配任何单个字符。 您可以在单个路径中组合这两个通配符，例如/ foo / * / bar / 201？/ mypage
NOTE
The strings you use to specify website paths in the paths array are case sensitive.
用于在paths数组中指定网站路径的字符串对大小写是敏感的。//即：区分大小写。

After you create the apple-app-site-association file, upload it to the root of your HTTPS web server or to the .well-known subdirectory. The file needs to be accessible via HTTPS—without any redirects—at https://<domain>/apple-app-site-association or https://<domain>/.well-known/apple-app-site-association. Next, you need to handle universal links in your app.

创建apple-app-site-association文件后，将其上传到HTTPS Web服务器的根目录或.well-known子目录。 该文件需要通过HTTPS访问（无需任何重定向），网址为https：// <domain> / apple-app-site-association或https：// <domain> /.well-known/apple-app-site-association 。 接下来，您需要处理应用程序中的通用链接。

Preparing Your App to Handle Universal Links

Universal links use two technologies: The first is the same mechanism that powers Handoff between a web browser and a native app, and the second is Shared Web Credentials (for more information about these technologies, see Web Browser–to–Native App Handoff and Shared Web Credentials Reference). When a user taps a universal link, iOS launches your app and sends it an NSUserActivity object that you can query to find out how your app was launched.

Universal links使用两种技术：第一种是在Web浏览器和原生应用程序之间切换的相同机制，第二种是共享Web凭据（有关这些技术的更多信息，请参阅Web浏览器到本机应用程序切换和共享 Web凭据参考）。 当用户点击universal link时，iOS会启动您的应用程序，并向其发送一个NSUserActivity对象，您可以查询该对象以了解您的应用程序是如何启动的。

To support universal links in your app, take the following steps:

* Add an entitlement that specifies the domains your app supports. 
* Update your app delegate to respond appropriately when it receives the NSUserActivity object.

要在您的应用中支持universal links，请执行以下步骤：

* 添加指定您的应用支持的域的权利。
* 更新应用程序委派以在接收到NSUserActivity对象时进行适当响应。

In your com.apple.developer.associated-domains entitlement, include a list of the domains that your app wants to handle as universal links. To do this in Xcode, open the Associated Domains section in the Capabilities tab and add an entry for each domain that your app supports, prefixed with applinks:, such as applinks:www.mywebsite.com. Limit this list to no more than about 20 to 30 domains.

在com.apple.developer.associated-domains entitlement中，包含您的应用程序要作为通用链接处理的域的列表。 要在Xcode中执行此操作，请打开“ Capabilities”选项卡中的“Associated Domains”部分，并为应用程序支持的每个域添加一个条目，并以applinks：为前缀，如applinks：www.mywebsite.com。 将此列表限制为不超过大约20到30个域。

To match all subdomains of an associated domain, you can specify a wildcard by prefixing *. before the beginning of a specific domain (the period is required). Domain matching is based on the longest substring in the applinks entries. For example, if you specify the entries applinks:*.mywebsite.com and applinks:*.users.mywebsite.com, matching for the domain emily.users.mywebsite.com is performed against the longer *.users.mywebsite.com entry. Note that an entry for *.mywebsite.com does not match mywebsite.com because of the period after the asterisk. To enable matching for both *.mywebsite.com and mywebsite.com, you need to provide a separate applinks entry for each.

要匹配associated domain的所有子域，您可以通过使用前缀*指定通配符。 在特定域的开始之前（该期间是必需的）。 域匹配基于applinks条目中的最长子字符串。 例如，如果指定条目applinks：*。mywebsite.com和applinks：*。users.mywebsite.com，则对域emily.users.mywebsite.com的匹配将针对较长的* .users.mywebsite.com条目执行 。 请注意，* .mywebsite.com的条目与mywebsite.com不匹配，因为星号后的时间段。 要为* .mywebsite.com和mywebsite.com启用匹配，您需要为每个都提供单独的applinks条目。

After you specify your associated domains, adopt the UIApplicationDelegate methods for Handoff (specifically application:continueUserActivity:restorationHandler:) so that your app can receive a link and handle it appropriately.

指定关联的域后，为Handoff采用UIApplicationDelegate方法（具体应用程序：continueUserActivity：restorationHandler :)，以便应用程序可以接收链接并适当处理。

When iOS launches your app after a user taps a universal link, you receive an NSUserActivity object with an activityType value of NSUserActivityTypeBrowsingWeb. The activity object’s webpageURL property contains the URL that the user is accessing. The webpage URL property always contains an HTTP or HTTPS URL, and you can use NSURLComponents APIs to manipulate the components of the URL.

当iOS在用户点击universal link后启动应用程序时，您将收到一个activityType值为NSUserActivityTypeBrowsingWeb的NSUserActivity对象。 活动对象的webpageURL属性包含用户正在访问的网址。 这个webpage URL属性始终包含HTTP或HTTPS URL，您可以使用NSURLComponents API来处理URL的组件。

When a user taps a universal link that you handle, iOS also examines the user’s recent choices to determine whether to open your app or your website. For example, a user who has tapped a universal link to open your app can later choose to open your website in Safari by tapping a breadcrumb button in the status bar. After the user makes this choice, iOS continues to open your website in Safari until the user chooses to open your app by tapping OPEN in the Smart App Banner on the webpage.

当用户点按您处理的universal link时，iOS还会检查用户最近的选择，以确定是打开您的应用还是您的网站。 例如，点击universal link以打开应用的用户可以稍后通过点击状态栏中的导航栏按钮在Safari中选择打开您的网站。 在用户做出此选择之后，iOS会继续在Safari中打开您的网站，直到用户通过在网页上的智能应用横幅中点击打开来选择打开您的应用。

####NOTE

If you instantiate a SFSafariViewController, WKWebView, or UIWebView object to handle a universal link, iOS opens your website in Safari instead of opening your app. However, if the user taps a universal link from within an embedded SFSafariViewController, WKWebView, or UIWebView object, iOS opens your app.

如果您实例化SFSafariViewController，WKWebView或UIWebView对象来处理通用链接，iOS会在Safari中打开您的网站，而不是打开您的应用程序。 但是，如果用户从嵌入式SFSafariViewController，WKWebView或UIWebView对象中轻击通用链接，iOS会打开您的APP。

It’s important to understand that if your app uses openURL: to open a universal link to your website, the link always opens in Safari instead of getting redirected to your app. In this scenario, iOS recognizes that the call originates from your app and therefore should not be handled as a universal link.

请务必了解，如果您的应用使用openURL：打开指向您网站的通用链接，该链接将始终在Safari中打开，而不是重定向到您的应用。 在这种情况下，iOS会识别呼叫来自您的应用程序，因此不应作为通用链接处理。

If you receive an invalid URL in an activity object, it’s important to fail gracefully. To handle an unsupported URL, you can call openURL: on the shared application object to open the link in Safari. If you can’t make this call, display an error message to the user that explains what went wrong.

如果您在活动对象中收到无效的网址，请务必妥善处理失败。 要处理不受支持的URL，可以在共享应用程序对象上调用openURL：以在Safari中打开链接。 如果您无法进行此调用，请向用户显示一条错误消息，说明发生了什么问题。

####IMPORTANT

To protect users’ privacy and security, you should not use HTTP when you need to transport data; instead, use a secure transport protocol such as HTTPS.

为了保护用户的隐私和安全，当您需要传输数据时，不应使用HTTP; 而是使用安全传输协议（如HTTPS）。

####关于universal link相关的文章

[Breaking down iOS 9 Universal Links](http://blog.hokolinks.com/how-to-implement-apple-universal-links-on-ios-9/)

[Android M App Links: implementation, drawbacks and solutions](http://blog.hokolinks.com/android-m-app-links-implementation-drawbacks/)

[iOS Universal Links(通用链接)](https://yohunl.com/ios-universal-links-tong-yong-lian-jie/)

[Universal Links](http://www.jianshu.com/p/3c6415e98812)

[iOS 9学习系列：打通 iOS 9 的通用链接（Universal Links)](http://www.cocoachina.com/ios/20150902/13321.html)

[iOS 9 通用链接（Universal Links)](http://www.jianshu.com/p/c2ca5b5f391f)
