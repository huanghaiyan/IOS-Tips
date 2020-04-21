### App包Size优化

#### 1.优化包大小原因

​     Android/iOS应用的安装包大小也是一个重要的影响用户体验的点。如果安装包的大小太大，用户下载等待的时间就会长，从而影响App的下载转化率。

#### 2.优化方案

- 资源优化

  - 删除无用资源

    - 删除未使用的图片，使用脚本或者Unused、LSUnusedResources等界面化工具。一个通用的脚本如下：

      ```
      #!/bin/sh
      PROJ=`find . -name '*.xib' -o -name '*.[mh]'`
      for png in `find . -name '*.png'`
      do
      	name=`basename $png`
      	if ! GREP -qhs "$name" "$PROJ"; then
      		echo "$png is not referenced"
      	fi
      done	
      ```

    - 删除重复图片

  - 资源压缩,

    - 使用 [ImageOptim](https://links.jianshu.com/go?to=https%3A%2F%2Fimageoptim.com%2F) 无损压缩图片。
    - 使用 [TinyPNG](https://links.jianshu.com/go?to=https%3A%2F%2Ftinypng.com%2F) 有损压缩图片。使用的时候直接执行 `tinypng *.png -k token` 脚本即可。

  - 资源云端化，不常用资源放在云端，动态下载资源(如字体等)。

  - 使用iconfont替换icon和logo

  - 用 LaunchScreen.storyboard 替换启动图片。

  - 本地大图片都使用 webp。

- 可执行文件优化
  - 代码优化。代码复用，禁止拷贝代码，共用代码下沉为底层组件；少用多行宏，多用函数封装；删除无用代码。
  - 第三方库优化。删除未使用的库，合理选择第三方库。
  - 代码混淆。通过混淆类、方法名可以减小其长度，从而减小可执行文件大小。

- 编译选项
  - Optimization Level 在 release 状态设置为 Fastest/Smallest。
  - Strip Debug Symbols During Copy 在 release 状态设置为 YES。
  - Debug版本代码不要提交到Release版本中

- 苹果官方的策略
  - App Thinning ，使用 xcasset 管理图片。
  - 开启 BitCode
