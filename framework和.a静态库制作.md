###FrameWork和.a静态库制作

[iOS-制作Framework（最新)](http://qingmang.me/articles/5162103427194116731) 

[iOS开发Xcode7 Framework制作流程简介](http://www.jianshu.com/p/bc89f3e5b58c) 


[.a静态库制作](http://www.jianshu.com/p/a1dc024a8a15)



###类别制成FrameWork在调用方法无法引用

######  Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[ViewController setTagName:]: unrecognized selector sent to instance 0x7f8723c02590'

	苹果官方Q&A上有这么一段话：
	The "selector not recognized" runtime exception occurs due to an issue between the implementation of standard UNIX static libraries, the linker and the dynamic nature of Objective-C. Objective-C does not define linker symbols for each function (or method, in Objective-C) - instead, linker symbols are only generated for each class. If you extend a pre-existing class with categories, the linker does not know to associate the object code of the core class implementation and the category implementation. This prevents objects created in the resulting application from responding to a selector that is defined in the category.
	
	翻译过来，大概意思就是Objective-C的链接器并不会为每个方法建立符号表，而是仅仅为类建立了符号表。这样的话，如果静态库中定义了已存在的一个类的分类，链接器就会以为这个类已经存在，不会把分类和核心类的代码合起来。这样的话，在最后的可执行文件中，就会缺少分类里的代码，这样函数调用就失败了。

####解决办法

	Important: For 64-bit and iPhone OS applications, there is a linker bug that prevents -ObjC from loading objects files from static libraries that contain only categories and no classes. The workaround is to use the -all_load or -force_load flags.
	
	重要的是：64位和iPhone OS的应用程序，有一个链接错误，防止从静态库只包含类和类加载文件objc对象。解决方法是使用- all_load或force_load旗帜。
	操作步骤：找到主工程的 target －－Build Setting－－Linking－－更改其 Other Linker Flags 为： -all_load或-force_load