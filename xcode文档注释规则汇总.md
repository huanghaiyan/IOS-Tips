xcode文档注释规则简要汇总

[参考源](http://www.cnblogs.com/zyl910/archive/2013/06/07/objcdoc.html)

#### 类与协议

```
/** 文档B.
 *
 * 文档B的详细描述.
 */
@interface DocB : NSObject
```
```
/// 文档A.
@interface DocA : NSObject
```

#### 文本链接

```
/**
 * - [文档B](DocB) : 类的链接文本.（仅appledoc）
 */
```



#### 单行注释

```
///# 标题1
///## 标题2
///hello oc，下面的空行是为了换行
///
///hello swift
/// - 这里使用了无序列表
/// - 使用加粗 **this**， 使用斜体 _this_
/// - 添加一个链接: [百度](http://www.baidu.com)
/// - 添加一个图片:![swift picture](http://img0.imgtn.bdimg.com/it/u=14209024,814391630&fm=21&gp=0.jpg )
```

#### 多行注释文档

```
/**
    多行注释文档相比于普通多行注释多了一个星号。
    在这里可以使用markDown语法，书写各种提示信息
    如：显示一个有序列表
    1. 有序列表
    2. 有序列表
    3. 有序列表
*/
```

####  方法/函数的注释

方法的注释包括传入参数、返回值、和异常等说明

```
/**
 初始化 数据和颜色值

 @param frame      frame
 @param dataItems  数据集
 @param colorItems 色值集

 @return self
 */
 - (id)initWithFrame:(CGRect)frame dataItems:(NSArray*)dataItems colorItems:(NSArray*)colorItems;
```





