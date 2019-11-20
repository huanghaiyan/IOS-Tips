
# Objective-C代码规范

## 前言
Apple公司提供了一些代码规范文档。如果有内容未在此文档中提及，请参考如下内容：

* [The Objective-C Programming Language](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjectiveC/Introduction/introObjectiveC.html)
* [Cocoa Fundamentals Guide](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/CocoaFundamentals/Introduction/Introduction.html)
* [Coding Guidelines for Cocoa](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html)
* [iOS App Programming Guide](http://developer.apple.com/library/ios/#documentation/iphone/conceptual/iphoneosprogrammingguide/Introduction/Introduction.html)

## 适用范围
所有适用Objective-C语言开发的项目。 在这里我们希望以类似断言的方式,大家逐条对比写出的代码和下列规范是否吻合,以达到预期的代码的可读性。

## 代码规范
### 命名

基于iOS objective-c项目对于命名，目前分为变量名和函数名两类

#### 变量名
在这里我们把描述一个事物或者抽象事物的描述符统称为变量名。变量名目前分为几类: 类名，协议名，组合名，oc类内部变量，全局变量，枚举类型，block类型，结构体类型。
以下分别例举了几种类型的例子。
##### 类名
1. 使用类前缀
2. 需要包含一个名词用来表示这个类是什么,比如 NSString, NSDate, NSScanner等。
```objc
@interface MKUserTrackingBarButtonItem : UIBarButtonItem
```
##### 协议名
1. 使用类前缀
2. 在这里我们需要考虑一个重要的问题,不要滥用关键字,。面列了两个协议，"delegate"通常用于实现委托功能,而第二个用于实现的重载。
3. 大部分协议实际是包括一组功能相关的函数，并且和具体用于实现的类没有特别紧密的联系。这时候命名要考虑和具体实现类区分开，比如起名为NSLocking而不是NSLock。
4. 还有一些协议实际上囊括了很多不相关的功能（或者说像是很多个子协议的组合），这时候就可以和具体的实现类保持一致的名字，比如NSObject。
```objc
@protocol MKMapViewDelegate <NSObject>
@protocol MKAnnotation <NSObject>
```
##### 组合名
1. 需要类前缀
```objc
@interface NSString (NSStringExtensionMethods)
```
##### oc类内部变量
1. 无需类前缀
2. 尽可能使用property定义变量
3. .对于一些BOOL型变量表示状态的一般是动词+时态来表示一个名词,比如loading和selected。有趣的是,他们的getter方法都写成了 is+变量名,这样用起来的时候就更加接近自然语言。
```objc
@property (nonatomic, copy) NSString *title;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, getter=isSelected) BOOL selected;
```
##### 全局变量
1. 必须添加类前缀
2. 对于全局通知,我们需要遵守一个标准结构：“[Name of associated class] + [Did | Will] + [UniquePartOfName] + Notification”
```objc
NSString * const NSSystemClockDidChangeNotification
```
##### 枚举
1. 类型名及枚举值均需要添加类前缀
2. 枚举的具体值的名字为 枚举名+名词 
3. 使用`enum`枚举，因为它支持强类型检查及自动完成。SDK现在也支持枚举定义宏`NS_ENUm()`和`NS_OPTION()`，前者的各个选项是互斥的，而后者可以通过按位或`|`来组合使用。
```objc
typedef NS_OPTIONS(NSUInteger, MKDirectionsTransportType) {
  MKDirectionsTransportTypeAutomobile     = 1 << 0,
  MKDirectionsTransportTypeWalking        = 1 << 1,
  MKDirectionsTransportTypeAny            = 0x0FFFFFFF
}
```
##### block
1. 形参名无需前缀，类型名需要添加前缀
2. 苹果的习惯是以handler结尾表示他的功能
```objc
typedef void (^MKDirectionsHandler)(MKDirectionsResponse *response, NSError *error);
```
##### 结构体
1. 形参名无需前缀，类型名需要添加前缀
```objc
typedef struct {
	CLLocationDegrees latitude;
	CLLocationDegrees longitude;
} CLLocationCoordinate2D;
```

##### 通用规则
1. 禁止使用小写下划线形式（snake_case）
2. 关于类前缀这件事情，对于全局可见的变量需要添加，而对于类的内部变量和结构体内部变量则不需要添加。我们归纳一个原则，即变量的从属关系。对于可以全局可见的类型(类名，协议名，组合名，全局变量，枚举类型，block类型，结构体名)从属于项目名下,由于项目本身无法添加命名空间,即所有属于他名下的变量名需要添加前缀。而类的内部变量从属于他的所属类，结构体内部变量从属于结构体本身。
3. 这个原则是讨论在考虑层级的原则下如何给变量名起一个合适的名字。上面我们讨论了从属规则,为了统一原则，我们将有从属的变量和他的从属合并。比如MKUserTrackingBarButtonItem类内部有个NSString变量叫title，我们就合并为MKUserTrackingBarButtonItemTitle。对于绝大部分事物我们都可以认为他是名词或者形容词加名词,在这里诸如userTracking,barButtonItem,title，在一个项目中为了准确的标示一个变量是什么就需要从他的前缀开始逐层向下看他的每个层级是否能准确的标示这个层级是什么。就像上述例子，userTracking是全局唯一的事物，这里的barButtonItem只属于userTracking，而这里的headline又只属于UserTrackingBarButtonItem，这样我们可以很明显的看出这个title准确的标示着什么。
4. 这里讨论一下关于单个层级的命名原则，上面论述过可以把变量拆分为几个层级。对于每个层级来说我们倾向于为一个名词或者名词词组，在使用词组时不添加介词，比如写成nameLabel而不是labelForName。在描述一个层级的时候需要考虑几个问题，是什么，实现什么功能，在什么情况下实现这个功能。然后反序写出来 会变成：限定词+功能+类型 这样一种组合方式。当然这三部分在某些情况下都可以缺省，这个放到后面论述。
5. 这里讨论在选择用来命名的单词的问题。其实到这里才到了真正的关键点，命名用词的选择！依据apple官方的要求，这里总结了几点。
######清晰
	1.官方对于清晰的要求是不要滥用缩写 比如destinationSelection 不要写成destSel。至于何时能用缩写我们下面讨论。
	2.注意用词是否有一个明确的含义,当诸如object,data,flag单独作为变量出现的时候，肯定让人无所适从。
######一致
	当很多个类有同样作用的变量时，应该保证他们使用同一个变量名。比如tag用于NSView, NSCell, NSControl中。
######使用缩写
	在前面的“清晰”的要求中提出了不要滥用缩写，那什么时候推荐用缩写呢？这里有一个准则是使用大家默认的缩写，在apple的官方文档中有一个例子（见下方链接【apple使用的缩写】）。 当然这里不要求所有非一下词汇不可使用缩写，我们这里希望达成几个准则为：
	1.缩写不会和别的词汇产生混淆和冲突, 假设我们把Matrix简写成mtx就很容易和其他词(比如max,mix)产生混淆。
	2.在项目中要足够常用
	3.如果使用就保持全局统一使用,不要同时出现全称和缩写
	4.和团队成员达成统一

[apple使用的缩写](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/APIAbbreviations.html#//apple_ref/doc/uid/20001285-BCIHCGAE)
 
######一些习惯
	1.上述我们说一个层级变量起名为 限定词+功能+类型。这里我们有个例外的地方，对于NSString, NSArray, NSNumber, BOOL类型我们无需指定类型。

	2.对于命名一个复数形式的变量,如果它不是NSArray或者NSSet最好指定类型。
	
	3.对于其他类型,比如Image, Indicator这样的特殊类型或UI组件在变量命名的后半部分指定它的类型是有必要的。 尤其对于XXXManager类型的变量写成比如fontManager是必须的,否则无法理解它的含义。

[一些习惯的例子](http://static.oschina.net/uploads/space/2015/0129/165430_PlEG_1386081.png)


#### 函数名

oc语言实际上很贴近自然语言。先抛开通常作为全局函数用的c/cpp函数，oc的类内部函数通常看起来就像是一个句子。在这个命名规范里不去结合语法分析这个了，一下会根据函数常有的功能去做个分类。

#####以动词开头方法
```objc
- (void)insertOverlay:(id <MKOverlay>)overlay atIndex:(NSUInteger)index level:(MKOverlayLevel)level;

- (BOOL)createSymbolicLinkAtURL:(NSURL *)url withDestinationURL:(NSURL *)destURL error:(NSError **)error;
```

	1.对于以动词开头的函数,表示去执行某一个任务。
	2.我们一般定义他的返回值为void, 当需要得到他是否执行成功的状态时可以以BOOL作为返回值
	3.有一个例外是init开头一般是用于构造，返回一个构造的实例。

#####以名词开头方法
```objc
- (MKAnnotationView *)viewForAnnotation:(id <MKAnnotation>)annotation;

+ (instancetype)circleWithCenterCoordinate:(CLLocationCoordinate2D)coord
                                  radius:(CLLocationDistance)radius;
          
```

	1.对于以动词开头的函数,表示返回某一个具体事物。
	2.当函数作为回调函数存在时，它是例外的

#####回调函数
```objc
- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(int)row;
- (BOOL)applicationOpenUntitledFile:(NSApplication *)sender;

- (void)browserDidScroll:(NSBrowser *)sender;
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window;

- (BOOL)windowShouldClose:(id)sender;
          
- (void)windowDidChangeScreen:(NSNotification *)notification;
```
	1.消息发送者必须作为参数。如果函数参数只有消息发送者本身，将他放到函数最后。如果有2个及以上参数则放到第一位。
	2.did和will经常用在回调函数当做标记'已经发生'或者'将要发生'。
	3.'should'应用场景通常是询问代理行为是否应该发生,通常返回BOOL。
	4.通过通知的回调一般来说所有数据都放在notification内部，所以不需要返回值以及其他参数
	5.所有回调函数均以名词开头,标示是什么引发的回调。我们可以认为去掉开头的名词和调用者参数，基本和我们之前定的规范一致。

#####一些通用规则和建议
1.参数冒号之前用名词指代明确的参数类型
2.多个参数不需要用and连接
3.一些介词有助于提升函数名的可读性，比如：for，with，from，in，on，at等。

####处理魔术变量
使用常量而非内联的字串literal或魔术数，因为这样能更方便地修改它们。  
使用`static const`常量，禁止使用`#define`宏来定义变量，使用宏没有类型检查，并易被覆盖定义而很难检测。

**For example:**

```objc
static NSString * const ZDAboutViewControllerCompanyName = @"The New York Times Company";
static const CGFloat ZDAboutViewThumbImageHeight = 50.0;
```
**Not:**
```objc
#define CompanyName @"The ZDWorks Company"
#define thumbnailHeight 2
```

#### Dot-notation

使用dot-notation(.表示法)来获取/更改property。 Bracket notation([]表示法)适用于其他领域。  
**For example:**
```objc
view.backgroundColor = [UIColor orangeColor];
[UIApplication sharedApplication].delegate;
```

**Not:**
```objc
[view setBackgroundColor:[UIColor orangeColor]];
UIApplication.sharedApplication.delegate;
```

#### @property && ivar
只能在初始化方法、析构方法和自定义getter/setter里面，直接访问实例变量(ivar)，其他情况只能通过dot-notation访问property。更多内容参见 [here](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmPractical.html#//apple_ref/doc/uid/TP40004447-SW6).
不要直接声明实例变量，声明property即可。

### 格式
#### 工具
使用[BBUncrustify](https://github.com/benoitsan/BBUncrustifyPlugin-Xcode)来格式化代码，formatter使用Clang，配置文件见[.clang-format](.clang-format)

#### Spacing

* 使用4个空格而非tab符缩进，并检查其是否为Xcode预设值。
* 方法的大括号另起一行打开(`{`)，另起一行关闭(`}`)
* 其他大括号 (`if`/`else`/`switch`/`while`/`block` etc.)在当前行打开，另起一行关闭

**For example:**
```objc
- (void)foo:(User *)user
{
    if (user.isHappy) {
    //Do something
    }
    else {
    //Do something else
    }
}
```
* 方法之间隔一个空行。方法内依据功能的不同，用空行隔开，或者将其提取到新方法内。
* 每个`@dynamic`或`@synthesize`占据一行，Xcode4.4以后省略`@synthesize`。

#### 条件语句

条件语句的body必须被括号包含，即使只有一行。这样便于在body内新增操作而不会出错，同时可读性更强。

**For example:**
```objc
if (!error) {
    return success;
}
```

**Not:**
```objc
if (!error)
    return success;
```

or

```objc
if (!error) return success;
```

#### 方法

OC的方法，需要在符号+/-后添加一个空格。前一个参数和后一个中缀之间有且仅有一个空格，比如下方示例的text参数和image中缀之间。

**For Example**:
```objc
- (void)setExampleText:(NSString *)text image:(UIImage *)image;
```

#### 变量

指针变量的*与指针类型中间隔一个空格，与变量名中间无空格，e.g., `NSString *text` not `NSString* text` or `NSString * text`。

### 注释
#### 原则
对外接口必须写注释

#### 注释的类型
注释可以采用`/* */`和`//`两种注释符号，涉及到多行注释时，尽量使用`/* */`。方法里的注释只能使用`//`，因为嵌套`/**/`很可能带来无法预知的问题。

#### 类
Xcode会生成一段默认注释，我们需要在此基础上扩充，加入功能描述和修改记录部分。虽然svn/git能够看到完整的修改记录以及通过blame查找责任人，但是commit太多的时候很难定位。  
**For example:**
```objc
//
//  ClockTricksController.m
//  ZDClock
//
//  Created by John_Ma on 13-11-26.
//  Copyright (c) 2013年 ZDworks Co., Ltd. All rights reserved.
//  功能描述：
//  修改记录：(仅记录功能修改)
//       张三   2012-02-02  创建该单元 
//       小明   2010-03-02  增加本地点单功能。
//
```

#### 方法
方法注释一般出现在.h文件里，.m文件里尽量保持简洁，使用方法名完整描述功能和参数。方法注释使用[VVDocument]( https://github.com/onevcat/VVDocumenter-Xcode)插件生成，并在每次修改后及时更新。  
**For example:**
```objc
/**
 *  <#Description#>
 *
 *  @param application   <#application description#>
 *  @param launchOptions <#launchOptions description#>
 *
 *  @return <#return value description#>
 */
```

#### 其他
尽量不要出现方法内注释，如有可能将相关代码Extract到新方法里，使用方法名描述其功能。如果必须要要使用方法内注释，使用`//`注释在所要描述的代码前一行或者同一行末尾。

### 最佳实践
#### @interface

.h文件中只暴露目前被其他类使用的接口、属性。内部使用的接口、属性在extension（匿名category）中定义，比如IBOutlet等。  
在.h实现protocol亦是如此，会暴露该protocol包含的接口。如果外部无需使用相关接口，则移到extesion中。

**For example:**
```objc
// .m file
@interface Test ()<UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UIButton *refreshButton;
- (void)privateDoSth;
@end
```

**Not:**
```objc
// .m file
@interface Test : NSObject<UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UIButton *refreshButton;
- (void)privateDoSth;
@end
```

#### 三目运算符

只有当能够提高代码的可读性时，才应该使用三目运算符?:，比如单一判断条件。如果有多个判断条件，使用if会更好些。

**For example:**
```objc
result = a > b ? x : y;
```

**Not:**
```objc
result = a > b ? x = c > d ? c : d : y;
```

#### 错误处理

当方法使用引用返回表示错误的参数时，使用返回值判断，而非该错误变量。

**For example:**
```objc
NSError *error;
if (![self trySomethingWithError:&error]) {
    // Handle Error
}
```

**Not:**
```objc
NSError *error;
[self trySomethingWithError:&error];
if (error) {
    // Handle Error
}
```
在成功的情况下，Apple的一些API会将奇怪的值而非nil写入错误参数，所以不要使用该错误变量来判断。

#### Literals

`NSString`, `NSDictionary`, `NSArray`和`NSNumber`的immutable实例应该使用literal来创建，mutable实例也建议通过这种方式及mutableCopy方法来创建。需要注意的是需要做nil检测。

**For example:**

```objc
NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
NSDictionary *productManagers = @{@"iPhone" : @"Kate", @"iPad" : @"Kamal", @"Mobile Web" : @"Bill"};
NSNumber *shouldUseLiterals = @YES;
NSNumber *buildingZIPCode = @10018;
```

**Not:**

```objc
NSArray *names = [NSArray arrayWithObjects:@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul", nil];
NSDictionary *productManagers = [NSDictionary dictionaryWithObjectsAndKeys: @"Kate", @"iPhone", @"Kamal", @"iPad", @"Bill", @"Mobile Web", nil];
NSNumber *shouldUseLiterals = [NSNumber numberWithBool:YES];
NSNumber *buildingZIPCode = [NSNumber numberWithInteger:10018];
```

#### CGRect Functions

使用[`CGGeometry` functions](http://developer.apple.com/library/ios/#documentation/graphicsimaging/reference/CGGeometry/Reference/reference.html)而非结构体的数据成员来获取`x`, `y`, `width`, or `height`的值。From Apple's `CGGeometry` reference:

> All functions described in this reference that take CGRect data structures as inputs implicitly standardize those rectangles before calculating their results. For this reason, your applications should avoid directly reading and writing the data stored in the CGRect data structure. Instead, use the functions described here to manipulate rectangles and to retrieve their characteristics.

> 所有在这里定义、使用CGRect结构体作为输入参数的方法，先对这些矩形做标准化操作，再计算它们的方绘制。所以我们应该直接通过这些方法，而非访问结构体的数据成员来获得这些矩形的属性。

**For example:**

```objc
CGRect frame = self.view.frame;

CGFloat x = CGRectGetMinX(frame);
CGFloat y = CGRectGetMinY(frame);
CGFloat width = CGRectGetWidth(frame);
CGFloat height = CGRectGetHeight(frame);
```

**Not:**

```objc
CGRect frame = self.view.frame;

CGFloat x = frame.origin.x;
CGFloat y = frame.origin.y;
CGFloat width = frame.size.width;
CGFloat height = frame.size.height;
```

#### 私有Properties

私有property应该定义在类扩展（匿名类别）中。这样有个好处是，当你需要将其暴露给外部，直接command+x、command+v到.h文件中即可。

**For example:**

```objc
@interface ZDAdvertisement ()

@property (nonatomic, strong) GADBannerView *googleAdView;
@property (nonatomic, strong) ADBannerView *iAdView;
@property (nonatomic, strong) UIWebView *adXWebView;

@end
```

#### 单例

在OC中，使用如下线程安全的方式来创建单例
```objc
+ (instancetype)sharedInstance {
   static id sharedInstance = nil;

   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      sharedInstance = [[self alloc] init];
   });

   return sharedInstance;
}
```
这种方式可以防止 [可能的崩溃](http://cocoasamurai.blogspot.com/2011/04/singletons-your-doing-them-wrong.html).

#### 代码组织
函数长度（行数）不应超过2/3屏幕，禁止超过70行。  
例外：对于顺序执行的初始化函数，如果其中的过程没有提取为独立方法的必要，则不必限制长度。  

* 单个文件方法数不应超过30个
* 不要按类别排序（如把IBAction放在一块），应按任务把相关的组合在一起
* 禁止出现超过两层循环的代码，用函数或block替代。

尽早返回错误：

**For example:**
```objc
- (Task *)creatTaskWithPath:(NSString *)path {
    if (![path isURL]) {
        return nil;
    }
    
    if (![fileManager isWritableFileAtPath:path]) {
        return nil;
    }
    
    if ([taskManager hasTaskWithPath:path]) {
        return nil;
    }
    
    Task *aTask = [[Task alloc] initWithPath:path];
    return aTask;
}
```
**Not:**
```objc
- (Task *)creatTaskWithPath:(NSString *)path {
    Task *aTask;
    if ([path isURL]) {
        if ([fileManager isWritableFileAtPath:path]) {
            if (![taskManager hasTaskWithPath:path]) {
                aTask = [[Task alloc] initWithPath:path];
            }
            else {
                return nil;
            }
        }
        else {
            return nil;
        }
    }
    else {
        return nil;
    }
    return aTask;
}
```

### 文件组织
#### 原则
1. 使用group而非folder
2. 每个文件按照其类型寻找对应的根group
3. 当根group里的文件数量逐渐变多，并出现两种或以上不同功能/类型的文件时，根据功能/类型新建不同的group  
例如：
```
/Resources/main_background@2x.png
=>/Resources/Main/main_background@2x.png
或者
/Library/Recommend/RecommendData.m
=>/Library/Recommend/Model/RecommendData.m
```
默认的group结构如下：  
```
├── Application//应用相关，包括AppDelegate、Info.plist、main.m、.pch
├── Library//纯逻辑代码
│   └── Categories//存放类别
├── Models//应用级别的model，模块级别的放在对应的逻辑代码抽离的group里面
├── Resources//资源，常见的如图片、字体、数据、DataModel
│   └── Images//图片
│       └── App//启动封面、icon
└── ViewControllers//存放ViewController及对应的xib或storyboard
```