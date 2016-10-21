
##svn“Previous operation has not finished; run 'cleanup' if it was interrupted

今天碰到了个郁闷的问题，svn执行clean up命令时报错“Previous operation has not finished; run 'cleanup' if it was interrupted”。无论你到那个父层次的目录执行“clean up “，都是报一样的错。执行cleanup时候，提示要cleanup。看来是进入死循环了。

可能是频繁做了一些改名，文件打开的时候更新或者提交操作，导致svn罢工了。这个也该算是svn的bug吧。类似的情况，其实之前也碰到过。之前都是图省事，把整个svn checkout的主目录都删掉，重新checkout来解决的。但是随着项目的深入开展，要更新的文件越来越多。这个问题迟早要解决的，试试看吧。问题的关键看来需要找到死锁的地方，解锁才行。网上查了下资料。Svn的operation是存放在“work queue’“里的。而“work queue’是在内嵌数据库wc.db的work_queue表中的。看看work_queue表中放了些什么，再做处理。

1. 内嵌数据库一般是用sqlite进行轻量级管理的。sqlite-shell-win32-x86-3081101.zip

2. 为了方便命令行执行，将sqlite3.exe放到svn 项目的主目录下，和.svn目录同级下。

3. 执行  sqlite3 .svn/wc.db "select * from work_queue".看到有4条记录。就是刚才我执行的一些操作。

	226539|(sync-file-flags 93目录名 文件名)

	226540|(file-remove 21 .svn/tmp/svn-7B43C232)

	226541|(sync-file-flags 目录名 文件名)

	226542|(file-remove 21 .svn/tmp/svn-7B48224E)

4. 执行  sqlite3 .svn/wc.db "delete from work_queue". 把队列清空。

5. 执行 sqlite3 .svn/wc.db "select * from work_queue". 确认一下是否已经清空队列，发现已经没有记录显示，说明已经清空了。

6. 最后再试一下，看是否可以  clean up了。果然成功了。

如果你是Mac电脑，你就看这里吧！

1. 第一步找到你的wc.db文件

![屏幕快照 2016-10-21 下午2.31.50.png](http://upload-images.jianshu.io/upload_images/726092-c17240015940402d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2. 使用数据库软件打开wc.db。

3. 找到字段work_queue数据表，可以看到你之前的下载操作记录。

4. 清楚该记录，你可能删除不了，因为文件是只读的，修改文件权限的命令：chmod 755 wc.db。

5. 现在可以放心的删除了，这样操作就完成了，你可以重新进入管理svn的工具打开目录，进行clean了，问题解决了，是不是很方便呢？

