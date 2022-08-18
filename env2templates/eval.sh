#!/bin/bash
# 使用 eval 命令进行环境变量的二次渲染
# 例如使用以下方式，将文件 Procfile 中的环境变量 $JAVA_OPTS 利用已有环境变量进行渲染
# 假设同目录下 Porcfile 文件内容： web: java $JAVA_OPTS -jar *.jar

JAVA_OPTS="-Xms180m -Xmx180m -Xss512k -XX:MaxDirectMemorySize=24M  -Dfile.encoding=UTF-8"

eval "cat <<EOF
$(<Procfile)
EOF
" >result.txt

# 得到结果为 web: java -Xms180m -Xmx180m -Xss512k -XX:MaxDirectMemorySize=24M  -Dfile.encoding=UTF-8 -jar *.jar