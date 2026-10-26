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
	# 手册：https://www.doubao.com/thread/xrEph3xeGjGh04En8
	# 当前目录=工作目录：你现在在哪个文件夹里干活！
	cd /usr/mysoft		# 切换到指定目录（绝对路径） 
	cd ../test			# 切换到上一级目录/usr目录下的test目录，该命令=cd /usr/test
	cd ~				# 切换到当前用户的用户目录（类似Windows的C盘-用户）+su+pwd
	cd ..				# 返回上一级目录

2、查看当前所在目录
	# 查看当前所在目录
	# 手册：https://www.doubao.com/thread/xfJKxew77cS4gRSic
	pwd

3.2.2  ls命令：list，列出目录内容
	# 语法：ls [option] [names]
	# 手册：https://www.doubao.com/thread/xBoKMeZqroMpwBvkI
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
	# 手册：https://www.doubao.com/thread/xXfDq8i1KnZRXNzLD
	mkdir testdir			# 创建单个目录
	mkdir dir1 dir2 dir3	# 创建多个同级目录，空格隔开
	mkdir -p a/b/c			# 递归创建多级目录，一次性创建 a/b/c 三层目录
	mkdir -p project/{src,doc,log}	# 同时创建多组多级目录，等价 mkdir -p project/src project/doc project/log
	mkdir -m 755 mydir		# 创建目录并设置权限755

2、删除目录（只删空目录，目录有内容直接报错，相对安全；rm -r dirname删除带文件的目录）
	# 语法：rmdir [option] [dirname]
	# 手册：https://www.doubao.com/thread/xugsCw2zOxaHg1qKY
	rmdir testdir			# 删除单个空目录
	rmdir dir1 dir2 dir3	# 一次性删除多个同级空目录，空格分隔
	rmdir -p a/b/c			# 递归删除一串空的父目录（从子往父删）；目录必须全部为空！删除 c → b → a
	rmdir -p project/{src,doc,log}	# 批量删除多级空目录，打印详情
	
3.2.4  文件操作命令
1、创建文件：文件不存在=创建空文件、文件存在=更新文件的访问时间、修改时间，不改文件内容
	# 语法：touch [option] filename
	# 手册：https://www.doubao.com/thread/x4F4X7myP4UePSDlY
	touch test.txt						# 创建单个空文件
	touch file1.txt file2.log file3.sh	# 一次性创建多个空文件，空格隔开
	touch demo_{01..05}.txt				# 大括号批量创建（shell 扩展）
	touch -a test.txt					# `-a` 只修改访问时间 (atime)，不改动修改时间
	touch -m test.txt					# `-m` 只修改修改时间 (mtime)（最常用）
	touch /tmp/run.log					# 在指定目录创建空文件

2、复制文件
	# 语法：cp [option] source dest
	# 手册：https://www.doubao.com/thread/xqLMrcg47ZWOwuMyE
	cp test.txt /tmp/						# 把test.txt复制到/tmp目录
	cp test.txt /tmp/newtest.txt			# 复制并重命名：test.txt → /tmp/newtest.txt
	cp -r dir1 /tmp/						# 递归复制dir1目录到/tmp目录下，必须加-r
	cp -i test.txt /tmp/					# 提示是否覆盖，输入y覆盖，n取消
	cp file1.txt file2.txt file3.txt /tmp/	# 一次性复制多个文件到目标目录
	cp *.log /tmp/							# 复制当前所有.log 文件到/tmp
3、移动文件
	# 语法：mv [option] source dest
	# 手册：https://www.doubao.com/thread/xILht1icZKdiwovX7
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
	# 手册：https://www.doubao.com/thread/xpL4U7eVtES5ZDIYh
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
	# 手册：https://www.doubao.com/thread/xISVNS9MixvJW5Joh
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
	# 手册：https://www.doubao.com/thread/xpGeXfujcfuaj4Dzk
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
	# 手册：https://www.doubao.com/thread/xrCvPPyPgfNhv0LSq
	more /etc/profile		# 直接分页查看文件
	more +10 /etc/profile	# 从第10行开始显示文件
	more -5 /etc/profile	# 每次只显示 5 行（指定一页行数）
	ps -ef | more			# 查看进程分页

4、info（略）：info和man一样，都是查看某个命令的官方手册
5、识别文件类型
	# 语法：file [option] filename
	# 手册：https://www.doubao.com/thread/xGEOonZKHJcDq8yZY
	file /etc/passwd		# 查看单个文件类型
	file /etc/*				# 批量检测多个文件
	file empty.txt			# 判断是否空文件
	file /home				# 判断是否为目录

3.3.1  文件内容查找命令
	# 语法：grep [选项] '匹配模式' [文件...]
	# 手册：https://www.doubao.com/thread/xGiDwoJfK3h3QHqSI
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
	# 手册：https://www.doubao.com/thread/xJdtjDKpulVDGCinh
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
	# 手册：https://www.doubao.com/thread/xccNDnLc5mruEAjV6
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
	# 手册：https://www.doubao.com/thread/xkzb4RqiAYreHIuLS
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

3.4.1  tar命令（目录、文件）：打包 & 解包（tar 原生功能），压缩 & 解压（配合 gzip/bzip2/xz）
	# 语法：tar [option] filename
	# 手册：https://www.doubao.com/thread/xXxfDiWYDCIxiYOiv
	# 术语：
		# 打包：将多个文本拼成一个文件，文件数量改变，总大小不变，如3个文件，拼成da.tar.gz
		# 压缩：将拼成的文件压缩，总文件大小变小，如100MB，压缩成50MB
	# tar命令中三个压缩工具说明：https://www.doubao.com/thread/xonXIXBqSU02cW9n7
		# `-z`		gzip		.tar.gz		速度快，压缩率一般，最常用
		# `-j`		bzip2		.tar.bz2	压缩更好，慢一点
		# `-J`		xz			.tar.xz		压缩率最高，最慢
	
	
1、`-z`gzip 压缩 / 解压，后缀 `.tar.gz`（最常用）
	# （1）打包&压缩
	tar zcvf data.tar.gz /data		# 将/data目录打包压缩成 data.tar.gz
		# - z：gzip压缩/解压
		# - c：创建包
		# - v：显示过程
		# - f：输出包名
		# - x：解包
	tar zcvf data.tar.gz /data --exclude=/data/logs	# 打包/data，排除 /data/logs 目录
	# （2）解包&解压
	tar zxvf data.tar.gz			# 解压到当前目录
	tar zxvf data.tar.gz -C /opt	# 解压到 /opt 目录（-C 指定目标路径）
	
	tar ztvf data.tar.gz			# 只查看压缩包里面内容，不解压

2、`-j`bzip2 压缩 / 解压，后缀 `.tar.bz2`
	# （1）打包&压缩
	tar jcvf data.tar.bz2 /data		# 将/data目录打包压缩成 data.tar.bz2
		# - j：bzip2压缩/解压
		# - c：创建包
		# - v：显示过程
		# - f：输出包名
		# - x：解包
	# （2）解包&解压
	tar jxvf data.tar.bz2			# 解压到当前目录
	
3、`-J`xz 压缩 / 解压，后缀 `.tar.xz`
	# （1）打包&压缩
	tar Jcvf data.tar.xz /data		# 将/data目录打包压缩成data.tar.xz
		# - J：xz压缩/解压
		# - c：创建包
		# - v：显示过程
		# - f：输出包名
		# - x：解包
	# （2）解包&解压
	tar Jxvf data.tar.xz			# 解压到当前目录

4、只打包不压缩（纯 tar 包，体积不变）
	tar cvf files.tar file1 file2 /data		# 把 file1、file2、/data 打包，生成 files.tar 归档文件（仅打包，不压缩）
	tar xvf files.tar						# 解包到当前目录

3.4.2  zip命令（目录、文件）：压缩（打包 + 压缩一步完成）、unzip命令：解压（解包 + 解压一步完成）
0、先用如下命令安装&更新zip（用root账户）
	yum install zip unzip	# yum命令安装zip和unzip
1、zip命令：压缩
	# 语法：zip [参数]    压缩包名.zip     源文件/目录
	# 手册：https://www.doubao.com/thread/xXPf3vQIkZqHo7LGr
	zip test.zip test.txt				# 压缩单个文件
	zip files.zip a.txt b.log c.csv		# 压缩多个文件
	zip -r web.zip /var/www/html		# 压缩整个目录（必须加 -r 递归，否则不会打包子目录）
	zip -r web.zip /var/www/html -x "*.log"		# 打包html目录，排除里面的 *.log 文件
	zip -r web.zip /var/www/html -x "/var/www/html/tmp/*"	# 排除某个子目录
	zip -u web.zip new.txt		# 更新压缩包内文件（只更新改动的文件）
	zip -d web.zip old.log		# 删除压缩包里某个文件
	
2、unzip命令：解压
	# 语法：unzip [参数]  压缩包.zip
	# 手册：https://www.doubao.com/thread/xXPf3vQIkZqHo7LGr
	unzip web.zip					# 直接解压到当前目录
	unzip web.zip -d /opt/backup	# 解压到指定目录-d
	unzip -l web.zip				# 只查看压缩包内容，不解压
	unzip -t web.zip				# 测试压缩包是否完好（校验）
	unzip -o web.zip				# 解压时覆盖已有文件（不提示）
	unzip -n web.zip				# 解压时**不覆盖**已有文件
	
3.4.3  常用压缩格式（只针对单个文件，不针对目录）
1、gzip 命令（快、兼容性好）：不能打包目录，只能处理单个文件（减小单个文件体积）
	# gzip：只能压缩文件，不能直接压缩目录；压缩后默认删除原文件，生成 .gz，解压默认删除压缩包
	# 手册：https://www.doubao.com/thread/xt3RB5c46ykBtcH4d
	# （1）压缩文件
	gzip test.txt					# 压缩 test.txt，生成 test.txt.gz，原文件消失
	gzip -c test.txt > test.txt.gz	# 压缩，保留原文件（-c 输出到标准输出，重定向保存）
	gzip file1.log file2.log		# 批量压缩多个文件，分别压缩，不会打包成一个压缩包
	
	# （2）解压文件
	gzip -d test.txt.gz				# 方式1：gzip -d 解压（decompress）
	gunzip test.txt.gz				# 方式2：gunzip 等价 gzip -d
	gzip -dc test.txt.gz > test.txt	# 解压并保留压缩包

2、bzip2 命令（压得更小，但更慢，兼容性差）：不能打包目录，只能处理单个文件（减小单个文件体积）
	# bzip2：只压缩文件，不能直接压缩目录；压缩后缀 .bz2；压缩率高于 gzip，但更耗 CPU
	# 手册：https://www.doubao.com/thread/xBacv5xROYffE27qk
	# （1）压缩文件
	bzip2 test.txt				# 压缩 test.txt → test.txt.bz2，默认删除原文件
	bzip2 -k test.txt			# 保留原文件（bzip2特色参数 -k，keep）
	bzip2 file1.log file2.log	# 批量压缩多个文件，每个单独生成bz2
	
	# （2）解压文件
	bzip2 -d test.txt.bz2		# 方式1：bzip2 -d 解压
	bunzip2 test.txt.bz2		# 方式2：bunzip2 等价 bzip2 -d
	bzip2 -dk test.txt.bz2		# 解压并保留bz2压缩包（-k）
	
3.5.1  硬链接
0、硬链接、软连接：核心区别
	#- 软链接：删源文件，软链接直接失效；删软链接，源文件不受任何影响
	#- 硬链接：没有主次，删任意一个只是减少计数，全部删除才释放数据
1、硬链接创建及说明（不加 `-s` 就是硬链接；加 `-s` 是软链接（符号链接））
	# 语法：ln 源文件 目标硬链接名
	# 新建一个文件，并且插入内容
	touch /usr/mytest/cc.txt					
	echo "test cross fs" > /usr/mytest/cc.txt
	# 创建硬链接cc_hard.txt
	ln cc.txt cc_hard.txt
	# 现在：有2个名字，指向磁盘上同一份内容：cc.txt 和 cc_hard.txt
	ls -li cc_hard.txt 
	# 查看硬链接内容
	cat cc_hard.txt

2、局限① 不能跨文件系统（跨分区）创建硬链接
	# 手册：https://www.doubao.com/thread/xtaHto1NikvxEWI85
	# （1）在 /tmp（属于根分区/）创建源文件
	touch /tmp/fileA					
	echo "test cross fs" > /tmp/fileA

	# （2）尝试跨分区，把硬链接建到 /boot 分区
	ln /tmp/fileA /boot/fileA_hardlink
	
	# 提示如下：
	# ln: 无法创建硬链接"/boot/fileA_hardlink" => "/tmp/fileA": 无效的跨设备连接


3、局限② 无法引用目录（不能给目录创建硬链接）
	# 手册：https://www.doubao.com/thread/xtaHto1NikvxEWI85
	# （1）创建测试目录
	mkdir /tmp/test_dir

	# （2）尝试给目录建立硬链接
	ln /tmp/test_dir /tmp/test_dir_hardlink
	
	# 提示如下：
	# ln: "/tmp/test_dir": 不允许将硬链接指向目录

3.5.2  符号链接（软链接）
	# 语法：ln -s 源文件/源目录  软链接名称
	# 手册：https://www.doubao.com/thread/xz4eUWJ3aTjxmLYfH
	# （1）给文件创建软链接
	ln -s /tmp/test.txt /tmp/test_soft.txt
	# （2）给目录创建软链接（硬链接做不到）
	mkdir /tmp/mydir
	ln -s /tmp/mydir /tmp/mydir_soft

3.6.4  磁盘挂载和卸载
1、挂载
	# 语法：mount -t type device dir
		#-t type：指定文件系统类型（xfs、ext4、iso9660、vfat、ntfs-3g）
		#device：设备路径，如 `/dev/sdb1`、`/dev/cdrom`
		#dir：挂载点（空目录）
	# 手册：https://www.doubao.com/thread/xn8y0ixlOqGBpAAMK
	
	# （1）插上U盘，先找到U盘设备名
	lsblk	# 一般 U 盘识别为 `/dev/sdb`，U 盘的分区是 `/dev/sdb1`
	# （2）创建空挂载点（挂载目录）
	mkdir -p /mnt/usb
	# （3）挂载 U 盘
	mount -t vfat /dev/sdb1 /mnt/usb	# U 盘是 FAT32（vfat）
	
2、卸载
	# 语法：umount [device | dir]
	# 手册：https://www.doubao.com/thread/xn8y0ixlOqGBpAAMK
	umount /dev/sdb1	# 方式1：写设备卸载
	umount /mnt/usb		# 方式2：按挂载点卸载（推荐）

------------------------------------------------------------------
说明：
1、磁盘挂载和卸载，在实战中并不常用，这里介绍一下"虚拟机"上传下载文件。
2、MobaXterm中新建一个对话，选择SFTP，演示一下上传&下载文件。


	
3.6.5  交换空间
0、交换空间的作用
	# 当Linux物理内存不足时，系统会将长时间未使用的内存数据临时存入Swap空间，
	# 待程序需要时再换回内存，Swap的调整对服务器性能很关键。
1、方法一：使用分区
	# 安装系统的时候，给/swap已经分配了具体的空间，当时设定的是2GB-4GB
2、方法二：使用 swapfile
	# 手册：https://www.doubao.com/thread/xQhrFYMhArntE1SkB
	# 原理：在磁盘上创建一个文件，把它当作 swap 交换空间使用，
	# 临时生效（重启后失效，需要自动挂载要改`/etc/fstab`）
	# 使用步骤：https://www.doubao.com/thread/xgwXgIcIeLgzTVJpH

-------------------------------------------------------------------------------
提示：Windows11下，配置"虚拟内存"步骤：
1. `Win+R`，输入 `sysdm.cpl` 回车，打开【系统属性】
2. 切换到【高级】选项卡 → 性能区域点【设置】
3. 【性能选项】→【高级】→ 虚拟内存，点【更改】

















	























