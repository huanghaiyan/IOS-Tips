私有Pod仓库创建流程

​	1. 新建pod spec仓库：此仓库存放私有仓库源码的地址及迭代版本等。

​	在公司服务器上新建pod spec项目，将项目地址及仓库命名提交给pod。

​	pod repo add podSpecRepositoryName podSpecRepositoryURL

​	2. 通过Cocoapods模板创建项目：pod lib create PodLibName

​	3. 在新建的模板项目中对应的Class文件夹下，添加相应的组件类及文件夹

​	4. 编写项目根目录下对应的pod spec文件，填写项目名称、版本、简介、项目源码地址、源文件地址、依赖库及subspec等

​	5. 本地检查pod spec合法性：pod lib lint --allow-warnings

​	6. 在公司服务器创建组件项目存放源码：git 提交源码并打标签到远端服务器，标签命名需与pod spec 文件中版本号一致

​	7. 远程检查pod spec文件合法性：pod spec lint --allow-warnings

​	8. 提交pod sepc文件到私有pod spec仓库：

pod repo push PodSpecRepositoryName Pod.podspec

​	9. 搜索项目是否能被pod索引到：pod search PodLibName

如果搜索不到课 删除cocoapods的索引，然后重新search，

​	rm ~/Library/Caches/CocoaPods/search_index.json

​	pod search PodLibName

​	10. 主项目引入私有项目：podfile文件添加私有pod sepc仓库url，pod添加私有库名称，之后 pod update。

五. 实施

目前只是思路调整具体实施中应该会遇到一些想不到的问题，因此会逐步尝试。由于联银普惠目前是纯H5引入原生较少可以在先此项目尝试



cocoapods编译私有库坑集：

* tag 不可以删除，重新添加，pod repo lint 会默认使用第一次的tag编译情况

* 头文件引入第三方依赖库，验证需要添加参数 --sources='git@gitee.com:IelpmWallet/LSpec.git,https://github.com/CocoaPods/Specs.git'

* 添加文件：将文件添加到class下，有文件夹的话需要配置podspec，再在xcode中add file

* --use-libraries 让静态库可以编译通过

* --allow-warnings 允许警告

* ```ruby
  引用自己或第三方的framework或.a文件时,检查是否需要手动引入文件和其依赖的库
  在podsepc中应该这样写:

  s.ios.vendored_frameworks = "xxx/**/*.framework"
  s.ios.vendored_libraries = "xxx/**/*.a”
  s.library = 'resolv.9' #libresolv.9.tbd依赖动态库
  # s.libraries = "iconv", "xml2"

  如果找不到路径的话，配置下.a的路径 s.source_files = 'LTDRiskCloud/Classes/**/*.{h,a}'
  如果这样还是报编译架构问题，需要修改下cocoapods的源码：
  gem which cocoapods 找到cocoapods的目录路径
  validator.rb 文件找到并打开
  def xcodebuild(action ...)
    ...
    when :ios
      command += %w(--help)#此处修改，注释掉模拟器校验，改为这个
      #command += %w(CODE_SIGN_IDENTITY=- -sdk iphonesimulator)
    ...
    end
  ```

  ​

* `use_frameworks`告诉CocoaPods你想使用Frameworks而不是Static Libraries。由于Swift不支持静态库，你必须使用框架。从Xcode 9 beta 4和CocoaPods 1.5.0开始，现在支持swift静态库。主要优势在于更快的应用启动时间，特别是如果您有很多Pod时 - 当您有很多dylib时，iOS 10和11不是最快的。[CocoaPods 1.5.0于2018年4月初发布](http://blog.cocoapods.org/CocoaPods-1.5.0/)，因此您可能需要升级以获取它： `sudo gem install cocoapods`。

pod repo push LSpec LBasicTools.podspec --sources='git@gitee.com:IelpmWallet/LSpec.git,https://github.com/CocoaPods/Specs.git' --allow-warnings
