3.1.1  Linux目录结构
https://www.doubao.com/thread/x35GbdYgm1fEf5tZH
https://www.doubao.com/thread/x6MtuTAvbVhjlBS97
1、/dev、/mnt、/media:三者区别
	# /dev：设备文件目录，Linux 把硬件抽象成文件（硬盘、U 盘、终端、光驱等）
	# /mnt：临时手动挂载点，管理员手动挂载硬盘、ISO 常用
	# /media：可移动设备自动挂载点，图形界面下 U 盘、光盘自动挂载到此

2、查看磁盘设备信息相关命令
	# 启动好虚拟机➜插入U盘➜根据提示选择插入到虚拟机
	lsblk			# 列出块设备（磁盘、分区）树形信息
	fdisk -l		# 查看磁盘分区表信息
	blkid			# 查看设备 UUID、文件系统类型（写 fstab 用）
	
3、CenOS7软件安装一般涉及的目录
	# yum/rpm：分散在 `/usr源码解压` `/etc配置文件` `/var日志文件`
	# 源码默认：`/usr/local`
	# 第三方解压大包：常用 `/opt` 或 `/usr/local`



3.1.3  Linux文件系统结构
1、文件名称
	# 禁止文件名包含 `/`，`/` 是路径分隔符，不能作为文件名
	touch a/a.txt	# 提示：touch: 无法创建"a/a.txt": 没有那个文件或目录
	
	# 字母区分大小写
	touch aa.txt
	touch AA.txt
	ls -l
	
	# 以“.”开头的文件是隐藏文件
	touch .yincang.txt
	ls -l
	ls -a

2、绝对路径与相对路径
	mkdir /usr/mysoft	# 创建文件夹mysoft
	cd /usr/mysoft		# 切换到mysoft文件夹
	touch bb.txt		# 创建bb.txt文件
	cd ..				# 返回上一级目录
	
###########################################基础命令学习###########################################

3.2.1  工作目录与目录的切换
1、工作目录与目录的切换
	# 语法：cd [directory]		
		# "."当前目录
		# ".."上一级父目录
		# "~"当前用户家目录
		# "-"上一次所在目录
		# "/"根目录
	cd /usr/mysoft		# 切换到指定目录（绝对路径） 
	cd ../test			# 切换到上一级目录/usr目录下的test目录，该命令=cd /usr/test
	cd ~				# 切换到当前用户的用户目录（类似Windows的C盘-用户）+su+pwd
	cd ..				# 返回上一级目录

2、查看当前所在目录
	# 查看当前所在目录
	pwd

3.2.2  ls命令：list，列出目录内容
	# 语法：ls [option] [names]
	ls			# 列出当前目录下文件/文件夹（不显示隐藏文件）
	ls -l		# ls -l=ll；列出当前目录下文件/文件夹；long，长格式，信息=权限、所有者、大小、时间
	ls -a		# 显示所有文件，包括.隐藏文件
	ls -la		# 长格式 + 显示隐藏文件
	ls -lh		# human，文件大小人性化展示 KB/MB），常搭配 `-l`
	ls -lSh		# 按文件大小降序排序
	ls /etc		# 查看指定的其他目录
	ls *.txt	# 只看指定后缀文件（通配符 `*`）
	ll *.txt	# 只看指定后缀文件（通配符 `*`）

3.2.3  目录的创建和删除
1、创建目录
	# 语法：mkdir [option] [dirname]
	mkdir testdir			# 创建单个目录
	mkdir dir1 dir2 dir3	# 创建多个同级目录，空格隔开
	mkdir -p a/b/c			# 递归创建多级目录，一次性创建 a/b/c 三层目录
	mkdir -p project/{src,doc,log}	# 同时创建多组多级目录，等价 mkdir -p project/src project/doc project/log
	mkdir -m 755 mydir		# 创建目录并设置权限755

2、删除目录（只删空目录，目录有内容直接报错，相对安全；rm -r dirname删除带文件的目录）
	# 语法：rmdir [option] [dirname]
	rmdir testdir			# 删除单个空目录
	rmdir dir1 dir2 dir3	# 一次性删除多个同级空目录，空格分隔
	rmdir -p a/b/c			# 递归删除一串空的父目录（从子往父删）；目录必须全部为空！删除 c → b → a
	rmdir -p project/{src,doc,log}	# 批量删除多级空目录，打印详情
	
3.2.4  文件操作命令
1、创建文件：文件不存在=创建空文件、文件存在=更新文件的访问时间、修改时间，不改文件内容
	# 语法：touch [option] filename
	touch test.txt						# 创建单个空文件
	touch file1.txt file2.log file3.sh	# 一次性创建多个空文件，空格隔开
	touch demo_{01..05}.txt				# 大括号批量创建（shell 扩展）
	touch -a test.txt					# `-a` 只修改访问时间 (atime)，不改动修改时间
	touch -m test.txt					# `-m` 只修改修改时间 (mtime)（最常用）
	touch /tmp/run.log					# 在指定目录创建空文件

2、复制文件
	# 语法：cp [option] source dest
	cp test.txt /tmp/						# 把test.txt复制到/tmp目录
	cp test.txt /tmp/newtest.txt			# 复制并重命名：test.txt → /tmp/newtest.txt
	cp -r dir1 /tmp/						# 递归复制dir1目录到/tmp目录下，必须加-r
	cp -i test.txt /tmp/					# 提示是否覆盖，输入y覆盖，n取消
	cp file1.txt file2.txt file3.txt /tmp/	# 一次性复制多个文件到目标目录
	cp *.log /tmp/							# 复制当前所有.log 文件到/tmp
3、移动文件
	# 语法：mv [option] source dest
	mv old.txt new.txt				# 文件重命名：old.txt改名为new.txt
	mv test.txt /tmp/				# 将test.txt移动到/tmp
	mv test.txt /tmp/test_bak.txt	# 移动并重命名：移动到/tmp，同时改名
	mv dir1 /tmp/					# 把dir1整个目录移动到/tmp目录下
	mv dir_old dir_new				# 目录重命名
	mv file1.txt file2.log /tmp/	# 多个文件移动到目标目录
	mv *.log /tmp/					# 当前目录所有.log文件移动到/tmp
	mv -i test.txt /tmp/			# 提示是否覆盖，y确认，n取消
	mv -n test.txt /tmp/			# 如果/tmp里已有同名文件，则跳过，不会覆盖
4、删除文件
	# 语法：rm [option] filename
	rm test.txt				# 删除单个文件
	rm -f test.txt			# 强制删除文件，不弹窗询问
	rm -r dir1				# 删除dir1目录以及里面所有内容，会逐个确认
	rm -rf dir1				# 递归+强制删除目录，无提示（最常用，但危险）
	rm file1.txt file2.log	# 删除多个文件
	rm -f *.log				# 删除当前所有.log文件
	rm -f dir/*.txt			# 删除dir目录下全部txt文件
	
3.2.5  其他操作
1、文件内容（行）排序，默认按ASCII字符逐字符比较，默认升序；不改变文件内容，将排序结果输出
	# 语法：sort [option] filename
	# 把这些内容写入test.txt文件
cat > test.txt << 'EOF'
apple 20
banana 5
orange 15
Apple 8
grape 10
EOF
	sort test.txt				# 按每行首字符 ASCII 排序，大写字母排在小写前面。

2、显示文件内容：`cat`适合**小文件**，大文件建议用 `less` / `more`
	# 语法：cat [option] filename
	cat /etc/hosts			# 查看文件全部内容
	cat -n /etc/profile		# 带行号查看（空行也编号）
	cat -b /etc/profile		# 带行号，空行不编号（最常用）
	cat /etc/hosts > hosts.bak	# 把文件输出写入新文件（覆盖），`>` 覆盖目标文件，原有内容丢失
	cat /etc/hosts >> hosts.bak	# 追加内容到文件末尾（不覆盖），`>>` 追加，保留原有内容
	cat file1.txt file2.txt > all.txt	# 合并多个文件输出到新文件
	cat > test.txt				# 从键盘输入新建文件（按 `Ctrl+D` 结束输入）
	cat >> test.txt				# 从键盘追加输入到已有文件（按 `Ctrl+D` 结束输入）
	
3、分页查看文件，只能向下翻
	# 语法：more [option] filename
		# 空格：向下翻一页
		# Enter：向下翻一行
		# b：向上翻一页（部分版本支持，有限）
		# q：退出 more
		# / 关键词：搜索文本，n 下一个匹配
		# =：显示当前行号
	more /etc/profile		# 直接分页查看文件
	more +10 /etc/profile	# 从第10行开始显示文件
	more -5 /etc/profile	# 每次只显示 5 行（指定一页行数）
	ps -ef | more			# 查看进程分页

4、info（略）：info和man一样，都是查看某个命令的官方手册
5、识别文件类型
	# 语法：file [option] filename
	file /etc/passwd		# 查看单个文件类型
	file /etc/*				# 批量检测多个文件
	file empty.txt			# 判断是否空文件
	file /home				# 判断是否为目录

3.3.1  文件内容查找命令
	# 语法：grep [选项] '匹配模式' [文件...]
		# grep  = grep -G 	# BRE 基础正则（默认）
		# egrep = grep -E 	# ERE 扩展正则
		# fgrep = grep -F 	# Fixed string 固定字符串，不解析正则
	# 正则表达式-菜鸟教程
	https://www.runoob.com/regexp/regexp-tutorial.html
	# 测试文件
cat > test.txt <<EOF
apple
app
banana
cat dog
hello world
hello 123
Hello HELLO
# comment line
ip:192.168.1.100
ip:10.0.0.5
a1 b2 c3
EOF
	grep "hello" test.txt		# 查找包含hello的行
	grep -i "hello" test.txt	# 忽略大小写 `-i`
	grep -v "hello" test.txt	# 输出不包含hello的行
	grep -c "hello" test.txt	# 只输出匹配的数量 `-c`（匹配的行数）
	grep -n "hello" test.txt	# 显示行号 `-n`
	grep "app\(le\)\?" test.txt	# 匹配apple或app；?代表前面内容出现0次或者1次

3.3.2  find命令：查找文件或目录（实时遍历磁盘，慢）
	# 语法：find [搜索路径] [条件] [动作]
	# 一、按文件名查找
	find /home -name "test.txt"		# 在/home目录下查找名为test.txt的文件，精确匹配
	find /home -iname "test.txt"	# 忽略大小写查找
	find /var/log -name "*.log"		# 通配符，查找所有 .log 文件，引号不能省
	find /etc -name "*nginx*"		# 查找名字包含nginx的文件；”*“任意长度任意字符（0 到多个）
	# 二、按文件类型查找 `-type`
	find /tmp -type d				# 查找/tmp下所有目录；按文件类型查找，d=目录
	find /var -type d -name "*log*"	# 查找目录名包含 log 的目录
	find /tmp -type f				# 查找普通文件；按文件类型查找，f=普通文件
	find / -type l					# 查找软链接；按文件类型查找，l=软链接
	# 三、按文件大小查找 `-size`
	find /var -size +10M			# 查找大于10M的文件
	find . -size -1k				# 查找小于1k的文件
	find . -size 20M				# 查找大小正好是20M
	# 四、按时间查找（访问 / 修改 / 状态变更）
	find /var/log -mtime -7			# 查找7天内修改过的文件
	find /var/log -mtime +7			# 查找7天之前修改的文件
	find . -mmin -30				# 查找最近30分钟修改的文件
	# 五、组合条件：`-and` `-or` `-not`（可简写 `-a` `-o` `!`）
	find /var -size +10M -a -type f			# 查找大于10M 并且是普通文件
	find . -name "*.log" -o -name "*.txt"	# 查找 .log 或者 .txt 文件
	find . ! -name "*.tmp"					# 查找不是 .tmp 的文件
	# 七、找到后执行操作：
		# -exec：执行后面的 shell 命令
		# -ok：和 `-exec` 功能几乎一模一样，唯一区别：交互式询问确认
		# {}：占位符，代表 find 本次匹配到的文件（完整路径）
		# \：`\;` 反斜杠 + 分号（必须写结尾）
	find /tmp -name "*.tmp" -exec rm -f {} \;	# 找到所有 .tmp 文件，强制删除（慎用！）
	find /tmp -name "*.tmp" -ok rm {} \;		# -ok 交互式，删除前询问，更安全
	
3.3.3  locate命令：查找文件或目录（mlocate查询数据库速度极快，不实时扫描磁盘，数据库默认每天更新一次，时效性差）
	# 语法：locate [选项] 搜索关键词
	sudo updatedb					# 所以，尽量先更新一下数据库，再locate查找
	locate -S						# 查看数据库统计信息
	locate my.cnf					# 查找所有带 my.cnf 的文件
	locate -i readme				# 忽略大小写，能匹配 README、ReadMe、readme.txt
	locate -c nginx					# 只统计数量，不输出路径
	locate -b passwd				# 只匹配文件名，不匹配目录路径
	locate /etc/network				# 只搜索 /etc 下面包含 network 的文件

3.3.4  whereis命令：只检索系统预定义的二进制、源码、man 路径，不搜索任意普通文件，和 `locate/find` 不一样。
	# 语法：whereis [option] filename
	# 适合快速找：命令本体在哪、man 手册在哪。
	# 查看命令全部信息（二进制 + man 手册，最常用）
	whereis nginx
	whereis java
	whereis mysql
	whereis python
	whereis git
	# 只获取二进制可执行文件路径（开发高频）`-b`
	whereis -b nginx
	whereis -b java
	whereis -b python3
	# 只查 man 手册文件 `-m`
	whereis -m nginx
	whereis -m ls































