### 创建新仓库

创建新文件夹，在其目录下执行`git init` 以创建新的git仓库。

### 检出仓库

执行如下命令，把gitlab远端服务器上的仓库克隆到本地（HTTPS协议）:

`git clone https://git.gitlab.com/project.git`

如果是使用SSH协议，你的命令会是这个样子：

`git clone git@git.gitlab.com:username/project.git`

### 工作流

你的本地仓库有git维护的三棵"树"组成。

工作目录 它持有实际文件

暂存区 它像个缓存区域，临时保存你的改动

HEAD 它指向你最后一次提交的结果

![截屏2020-04-08下午12.42.28.png](https://i.loli.net/2020/04/08/gycNbFq5k2LtAsj.png)

### 添加和提交

你可以提出更改(把它们添加到暂存区)，使用如下命令：

`git add <filename>`

`git add -A`

这是git基本工作流程的第一步；使用如下命令以实际提交改动：

`git commit -m "代码提交信息"`

现在，你的改动已经提交到了HEAD,但是还没到你的远端仓库。

### 推送改动

你的改动现在已经在本地仓库的HEAD中了。执行如下命令以将这些改动提交到远端仓库。

`git push origin master`

可以把master换成你想要推送的任何分支。

如果你已有一个本地Git仓库，并想将你的仓库连接到Gitlab远程服务器，可以使用如下命令添加：

`git remote add origin git@git.gitlab.com:username/project.git`

如此你就能够将你的改动推送到所添加的服务器上去了。

### 分支

分支是用来将特性开发绝缘开来的。在你创建仓库的时候，master是"默认的"分支。在其他分支上进行开发，完成后再将它们合并到主分支上。

![branch.jpg](https://i.loli.net/2020/04/08/ET47oOPbjN3L9Wy.jpg)

创建一个叫做"feature_x"的分支，并切换过去：

`git checkout -b feature_x`

切换回主分支：

`git checkout master`

再把新建的分支删掉：

`git branch -d feature_x`

除非你将分支推送到远端仓库，不然该分支就是不为他人所见的：

`git push origin <branch>`

### 更新与合并

要更新你的本地仓库至最新改动，执行：

`git pull`

以在你的工作目录中获取fetch并合并远端的改动。

要合并其他分支到你的当前分支master，执行

`git merge <branch>`

在这两种情况下，git 都会尝试去自动合并改动。遗憾的是，这可能并非每次都成功，并可能出现冲突conficts。这时候就需要你修改这些文具来手动合并这些冲突conficts。改完之后，你需要执行入校命令以将它们标记为合并成功：

`git add <filename>`

在合并改动之前，你可以使用如下命令预览差异：

`git diff <source_branch> <target_branch>`
