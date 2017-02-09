//: Playground - noun: a place where people can play

import UIKit

/*
 解决OOP 面临的这几个问题：
 动态派发安全性
 横切关注点
 菱形缺陷
 */
protocol Greetable{
    //定义
    var name: String { get }
    var legs: Int { get }//没有默认实现，遵守协议的类就必须实现
    func greet()
    func describe()
}

extension Greetable {
    //实现 optional
    var name: String {return "default name"}
    func greet() {
        print("Hello \(name)")
    }

    func Run() {// 使用已定义的方法和属性 扩展
        print("\(name) is running")
    }

    func describe() {
        print("I'm \(name)")
        greet()
        Run()
        print("I have \(legs) legs")
    }
}

//###############################
struct Cat: Greetable {
    internal var legs: Int = 2
}
let cat = Cat()
cat.describe()

struct Dog: Greetable {
    let name = "dog"
    let legs = 4
}
let dog = Dog()
dog.describe()
dog.legs
/*
 所以 协议方法实现之后，遵守协议的数据可以直接使用这些方法，而不用自己实现。
 这样就可以方便的实现代码的组装合成
 */