### Swift相关知识

#### 1.struct和class的区别是什么？

* struct是**值类型**，class是**引用类型**

* 内存分配方式不同：class在堆上，struct在栈上

* 二者的本质区别：**struct是深拷贝，拷贝的是内容；class是浅拷贝，拷贝的是指针**。

* **immutable变量**：swift的可变内容和不可变内容用var和let来甄别，如果初始为let的变量再去修改会发生编译错误。**struct遵循这一特性；class不存在这样的问题**。

* 变量赋值方式不同：struct是值拷贝；class是引用拷贝。

  class有这几个功能struct没有的：

  - class可以继承，这样子类可以使用父类的特性和方法
  - 类型转换可以在runtime的时候检查和解释一个实例的类型
  - 可以用deinit来释放资源
  - 一个类可以被多次引用

  struct也有这样几个优势：

  - 结构较小，适用于复制操作，相比于一个class的实例被多次引用更加安全。
  - 无须担心内存memory leak或者多线程冲突问题

  **C语言**中，struct与的class的区别：
  struct只是作为一种复杂数据类型定义，不能用于面向对象编程。

  **C++**中，struct和class的区别：
  对于成员访问权限以及继承方式，class中默认的是private的，而struct中则是public的。class还可以用于表示模板类型，struct则不行。
  
  总结:struct 是值类型，结构较小，内存存储在栈上，对struct进行copy属于深拷贝。
  class是引用类型，内存存储在堆上，对class进行copy属于浅拷贝，class可以继承，通过引用计数来管理。
  
 
  ##### 开发中怎么选择用哪一个？
  
  如果模型较小，并且无需继承、无需储存到 NSUserDefault 或者无需 Objective-C 使用时，建议使用 Struct。
  
  ##### oc中调用swift中的struct吗？
  在oc中是不能调用struct里面的内容的，你想在类似class前面加个@objc的方法加在struct前面，你是发现是不行的，那但是我们又想在oc中调用struct的属性，那怎么办呢？我们只能够再建一个类，在类里写个方法来返回struct中的值

  #### 2.Swift访问权限修饰符

  访问控制权限从高到低依次为Open，Public，Internal，File-private，Private。

  open 可以被任何人使用，包括override重写和继承。

  public 可以被任何人访问。但其他module中不可以被override和继承，而在module内可以被override和继承。

  internal 默认访问权限，整个App项目内都是可以访问的。

  fileprivate所修饰的属性或方法在当前的Swift源文件里可以访问。其他跟private一样。

  private所修饰的属性或方法只能在当前类里访问，包括extension。继承的话子类也不能访问。

  #### 3.Swift5.1新特性

  比如 `@propertyWrapper`、`@_functionBuilder`、`@dynamicMemberLookup`

  #### 4.swift把struct作为数据模型

  优点：

  1. **安全性**： 因为 Struct 是用值类型传递的，它们没有引用计数。
  2. **内存**： 由于他们没有引用数，他们不会因为循环引用导致内存泄漏。
  3. **速度**： 值类型通常来说是以栈的形式分配的，而不是用堆。因此他们比 Class 要快很多!
  4. **拷贝**：Objective-C 里拷贝一个对象,你必须选用正确的拷贝类型（深拷贝、浅拷贝）,而值类型的拷贝则非常轻松！
  5. **线程安全**： 值类型是自动线程安全的。无论你从哪个线程去访问你的 Struct ，都非常简单。

  缺点：

  1. **Objective-C与swift混合开发**：OC调用的swift代码必须继承于NSObject。
  2. **继承**：struct不能相互继承。
  3. **NSUserDefaults**：Struct 不能被序列化成 NSData 对象

  #### 5.map、flatMap 、filter、reduce 的作用

  map : 映射 ，将一个元素根据某个函数 映射 成另一个元素（可以是同类型，也可以是不同类型）

  flatMap 方法同 map 方法比较类似，只不过它返回后的数组中不存在 nil（自动把 nil 给剔除掉），同时它会把 Optional 解包。

  filter : 过滤 ， 将一个元素传入闭包中，如果返回的是false ， 就过滤掉

  reduce ：先映射后融合 ， 将数组中的所有元素映射融合在一起。

```
1、map 是Array类的一个方法，我们可以使用它来对数组的每个元素进行转换
let intArray = [1, 3, 5]
let stringArr = intArray.map {
            return "\($0)"
        }
// ["1", "3", "5"]

2、filter 用于选择数组元素中满足某种条件的元素
let filterArr = intArray.filter {
    return $0 > 1
}
//[3, 5]

3、reduce 把数组元素组合计算为一个值
let result = intArray.reduce(0) {
    return $0 + $1
}
//9
```
  #### 6.String 与 NSString 的关系与区别

  String为Swift的Struct结构，值类型；NSString为OC对象，引用类型，能够互相转换

  #### 7.try?和 try!

  这两个都用于处理可抛出异常的函数, 使用这两个关键字可以不用写 do catch.

  区别在于, try? 在用于处理可抛出异常函数时, 如果函数抛出异常, 则返回 nil, 否则返回函数返回值的可选值

  而 try! 则在函数抛出异常的时候崩溃, 否则则返会函数返回值, 相当于(try? xxx)!

  #### 8.根据如下代码回答问题

  ```
  struct Tutorial {
    var difficulty: Int = 1
  }
  
  var tutorial1 = Tutorial()
  var tutorial2 = tutorial1
  tutorial2.difficulty = 2
  ```

  tutorial1.difficulty 和 tutorial2.difficulty的值分别是多少？假如Tutorial是一个类，会有什么不同？并说明原因。

  答案：tutorial1.difficulty  的值是1，然而tutorial2.difficulty的值是2.

  在Swift中结构体是值类型，他们的值是复制的而不是引用的。下面的一行代码意思是复制了tutorial1的值并把它赋值给tutorial2：

  ```
  var tutorial2 = tutorial1
  ```

  从这一行开始，tutorial2值得改变并不影响tutorial1的值。

  假如Tutorial是一个类，tutorial1.difficulty和tutorial2.difficulty的值将都会是2.在Swift中类对象都是引用类型。tutorial1属性的任何改变将会反应到tutorial2上，反之亦然。

  #### 9.view1声明成var类型，view2声明let类型。这里有什么区别吗？下面的最后一行代码能编译吗？

  ```
  import UIKit
  
  var view1 = UIView()
  view1.alpha = 0.5
  
  let view2 = UIView()
  view2.alpha = 0.5 // Will this line compile?
  ```

  答案：view1是个变量可以重新赋值给一个新的实例化的UIView对象。使用let你只赋值一次，所以下面的代码是不能编译的：

  ```
  view2 = view1 // Error: view2 is immutable
  ```

  但是UIView是一个引用类型的类，所以你可以改变view2的属性，也就是说最后一行代码是可以编译的：

  ```
  let view2 = UIView()
  
  view2.alpha = 0.5 // Yes!
  ```

  #### 10.下面的代码创建了两个类Address和Person,并且创建了两个实例对象分别代表Ray和Brain.

  ```
  class Address {
    var fullAddress: String
    var city: String
  
    init(fullAddress: String, city: String) {
      self.fullAddress = fullAddress
      self.city = city
    }
  }
  
  class Person {
    var name: String
    var address: Address
  
    init(name: String, address: Address) {
      self.name = name
      self.address = address
    }
  }
  
  var headquarters = Address(fullAddress: "123 Tutorial Street", city: "Appletown")
  var ray = Person(name: "Ray", address: headquarters)
  var brian = Person(name: "Brian", address: headquarters)
  ```

  假设Brain搬家到街对面的建筑物里，那么你会这样更新他的地址：

  ```
  brian.address.fullAddress = "148 Tutorial Street"
  ```

  这样做将会发生什么？错误出在什么地方呢？

  答案：Ray同样会搬家到新的建筑物里面。Address是一个引用类型类，所以无论你是通过ray或者brain访问headquarters，访问都是同一个实例化对象。headquarters对象的变化也会引起ray和brain的变化。你能想象如果Brain收到Ray的邮件或者相反Ray收到Brain的邮件，将会发生什么？解决方案是创建一个新的Address对象赋值给Brain或者把Address声明成为结构体而不是一个类。

  #### 11.下面的代码输出是什么？并说明理由。

  ```
  var thing = "cars"
  
  let closure = { [thing] in
    print("I love \(thing)")
  }
  
  thing = "airplanes"
  closure()
  ```

  答案：输出的是：I love cars。当闭包被声明的时候，抓捕列表就复制一份thing变量，所以被捕捉的值并没有改变，即使你给thing赋了一个新值。

  如果你要忽视闭包中捕捉列表的值，那么编译器引用那个值而不是复制。这种情况下，被引用变量的值的变化将会反映到闭包中，正如下面的代码所示：

  ```
  var thing = "cars"
  
  let closure = {   
    print("I love \(thing)")
  }
  
  thing = "airplanes"
  closure() // Prints "I love airplanes"
  ```

  #### 12.在Objective-C中，一个常量可以这样定义：const int number = 0;类似的Swift是这样定义的：let number = 0 两者之间有什么不同吗？如果有，请说明原因。

  答案：const常量是一个在编译时或者编译解析时被初始化的变量。通过let创建的是一个运行时常量，是不可变得。它可以使用stattic 或者dynamic关键字来初始化。谨记它的的值只能被分配一次。
  
  #### 13.描述一种在Swift中出现循环引用的情况，并说明怎么解决，weak和unowned的区别。

    循环引用出现在当两个实例对象相互拥有强引用关系的时候，这会造成内存泄露，原因是这两个对象都不会被释放。只要一个对象被另一个对象强引用，
    
    那么该对象就不能被释放，由于强引用的存在，每个对象都会保持对方的存在。

    解决方式：用weak或者unowned引用代替其中一个的强引用，来打破循环引用。

    weak和unowned的区别？

    unowned要求被捕获的变量不能为nil，所以在closure中使用[unowned self] 必须保证self不能为空，所以当self被释放后再执行closure会导致程序崩溃。

    weak允许被捕获的值为可选型，即可以被捕获的值为nil，当使用[weak self]时需要进行对self进行解包。或者使用
  
  #### 14.什么是闭包，逃逸闭包和非逃逸闭包，为什么要分逃逸闭包和非逃逸闭包？ 
  
  逃逸闭包：一个接受闭包作为参数的函数，该闭包可能在函数返回后才被调用，也就是说这个闭包逃离了函数的作用域，这种闭包称为逃逸闭包。当你声明一个接受闭包作为形式参数的函数时，你可以在形式参数前写@escaping来明确闭包是允许逃逸。
  
  逃逸闭包的生命周期：

    1、闭包作为参数传递给函数；
    2、退出函数；
    3、闭包被调用，闭包生命周期结束。

    即逃逸闭包的生命周期长于函数，函数退出的时候，逃逸闭包的引用仍被其他对象持有，不会在函数结束时释放。
  
    非逃逸闭包：一个接受闭包作为参数的函数，闭包是在这个函数结束前内被调用。
    
    非逃逸闭包的生命周期：

    1、闭包作为参数传给函数；
    2、函数中运行该闭包；
    3、退出函数。
    
#### Swift中closure与OC中block的区别？
1. closure是匿名函数，block是一个结构体对象
2. 都能捕获变量
3. closure通过逃逸闭包来在block内部修改变量，block是通过__block修饰符修饰。
#### Swift的静态派发    
静态派发是一种更高效的方法，因为静态派发免去了查表操作。
不过静态派发是有条件的，方法内部的代码必须对编译器透明，并且在运行时不能被更改，这样编译器才能帮助我们。

Swift 中的值类型不能被继承，也就是说值类型的方法实现不能被修改或者被复写，因此值类型的方法满足静态派发的要求。

默认静态派发，如果需要满足动态派发，需要 dymanic修饰

#### swift相对于OC有哪些优点？
1、swift语法简单易读、代码更少，更加清晰、易于维护

2、更加安全，optional的使用更加考验程序员对代码安全的掌控

3、泛型、结构体、枚举都很强大

4、函数为一等公民，便捷的函数式编程

5、有命名空间 基于module

6、类型判断

oc的优点、运行时

#### defer、guard的作用？
defer 包体中的内容一定会在离开作用域的时候执行

guard 过滤器，拦截器

#### 实现一个 min 函数，返回两个元素较小的元素

```
func minNum<T: Comparable>(a: T, b: T) -> T {
    return a > b ? a : b
}
```
#### 什么是 copy on write

copy on write, 写时复制，简称COW，它通过浅拷贝(shallow copy)只复制引用而避免复制值；当的确需要进行写入操作时，首先进行值拷贝，在对拷贝后的值执行写入操作，这样减少了无谓的复制耗时。

#### 如何截取 String 的某段字符串?
substring 已废弃

let star = str.index(str.startIndex, offsetBy: 0)

let end = str.index(str.startIndex, offsetBy: 4)

let substr = str[star..<end]

#### Optional（可选型） 是用什么实现的?
枚举 一个 为nil，一个为属性值

#### inout 的作用
让输入参数可变 类似__block 的作用

#### 下面代码中 mutating 的作用是什么?
```
struct Person {

    var name: String {
        mutating get {
            return store
        }
    }
}

结构体中的 属性可能发生改变
```
