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

  ####2.Swift访问权限修饰符

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

  #### 5.map、filter、reduce 的作用

  map : 映射 ，将一个元素根据某个函数 映射 成另一个元素（可以是同类型，也可以是不同类型）

  filter : 过滤 ， 将一个元素传入闭包中，如果返回的是false ， 就过滤掉

  reduce ：先映射后融合 ， 将数组中的所有元素映射融合在一起。

  ####6.String 与 NSString 的关系与区别

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

  
