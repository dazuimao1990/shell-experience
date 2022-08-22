#!/bin/bash
# 使用 eval 命令进行环境变量的二次渲染，这个命令对 sh 不兼容，最好使用在 bash 环境中
# 这个命令有个缺点，就是如果文件中存在没有值的环境变量，会被渲染成空，有时候会引起问题
# 例如使用以下方式，将文件 Procfile 中的环境变量 $JAVA_OPTS 利用已有环境变量进行渲染
# 假设同目录下 Porcfile 文件内容： web: java $JAVA_OPTS -jar *.jar

JAVA_OPTS="-Xms180m -Xmx180m -Xss512k -XX:MaxDirectMemorySize=24M  -Dfile.encoding=UTF-8"

eval "cat <<EOF
$(<Procfile)
EOF
" >result.txt

# 得到结果为 web: java -Xms180m -Xmx180m -Xss512k -XX:MaxDirectMemorySize=24M  -Dfile.encoding=UTF-8 -jar *.jar
