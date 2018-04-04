### appledoc使用说明

安装命令行：

*        git clone git://github.com/tomaz/appledoc.git

*         cd ./appledoc

*        sudo sh install-appledoc.sh
*        appledoc —version  //检查successed

#### 使用

##### 生成HTML

当需要html文档时，可以加上“--no-create-docset”——

```
appledoc --no-create-docset --output ~/doc --project-name "DrowRect" --company-id "com.jinyuyoulong" --project-company "jinyuyoulong" ./
```
注:

--output ./doc：设置输出目录为“./doc”。
--project-name objcdoc：设置项目名为“DrowRect”。
--project-company "jinyuyoulong"：设置公司名为“jinyuyoulong”。
--company-id "com.jinyuyoulong"：设置公司id为“com.jinyuyoulong”。
./：当前目录。

##### ~~生成docset 此路不通~~

```
appledoc --output ./doc --project-name "DrowRect" --project-company "jinyuyoulong" --company-id "com.jinyuyoulong" ./
```

---

##### Xcode脚本生成文档

###### Xcode 配置

1. add new target —>选择Other—Aggregate，命名为docText


2. Build Phases + run script
3. 编辑run script的内容
4. 设置target为docText，运行Xcode
5. 在脚本中标明的导出目录下查看生成的文档

script:

```
#appledoc Xcode script
# Start constants
company="abc";
companyID="com.abc";
companyURL="http://abc.com";
target="iphoneos";
#target="macosx";
outputPath="~/doc";#输出地址
# End constants
/usr/local/bin/appledoc \
--project-name "${PROJECT_NAME}" \
--project-company "${company}" \
--company-id "${companyID}" \
--docset-atom-filename "${company}.atom" \
--docset-feed-url "${companyURL}/${company}/%DOCSETATOMFILENAME" \
--docset-package-url "${companyURL}/${company}/%DOCSETPACKAGEFILENAME" \
--docset-fallback-url "${companyURL}/${company}" \
--output "${outputPath}" \
--publish-docset \
--docset-platform-family "${target}" \
--logformat xcode \
--keep-intermediate-files \
--no-repeat-first-par \
--no-warn-invalid-crossref \
--exit-threshold 2 \
"${PROJECT_DIR}"
```