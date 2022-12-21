#!/bin/bash

###
### app.sh — Count the number of duplicate lines of code in both directories and generate a report.
###
### Usage:
###   app.sh <Dir1> <Dir2>
###

src_dir=$1
dest_dir=$2
# 以下配置可以被进一步细化为参数传递
# 定义出不被统计的子目录，用 | 分割
# 定义出不被统计的文件类型，用扩展名来定义，用 | 分割
except_dir="somedir/|otherdir/"
except_fmt=".png|.jpg|.svg|.gif|.ico|.odp|.ods|.odt|.pdf|.tgz|.otp|.ots|.odg|.doc|.docx|.xls|.xlsx|.cur|.strings"


function showHelp() {
    sed -rn -e "s/^### ?//p" $0 | sed "s#app.sh#${0}#g"
}

if [ $1 == "--help" ] || [ $1 == "-h" ]; then
    showHelp && exit 0
fi

function code_diff() {
    local src_file=$1
    local dest_file=$2
    # 有的时候代码里的文件不讲武德，命名时中间有空格，这样不负责任的文件我不处理
    if [ ! -f ${src_file} ]; then
        continue
    fi
    src_file_num=$(cat ${src_file} | wc -l)
    if [ ! -f ${dest_file} ]; then
        dest_file_num=0
        dup_line_num=0
    else
        dest_file_num=$(cat ${dest_file} | wc -l)
        dup_line_num=$(cat ${src_file} ${dest_file} | sort | uniq -d | wc -l)
    fi

    printf "%s,%d,%d,%d\n" $(echo $src_file | awk -F "$src_dir/" '{print $2}') $src_file_num $dest_file_num $dup_line_num

}

printf "src,srcline_num,destline_num,dup_line_num\n"
src_line_total=0
dest_line_total=0
tdup_line_total=0
for i in $(find $src_dir -type f | awk -F "$src_dir/" '{print $2}' | egrep -v $except_dir | egrep -v $except_fmt); do
    code_diff $src_dir/$i $dest_dir/$i
    let src_line_total+=src_file_num
    let dest_line_total+=dest_file_num
    let tdup_line_total+=dup_line_num
done

echo "==============================="
printf "src_total,dest_total,tdup_total\n"
printf "%d,%d,%d\n" $src_line_total $dest_line_total $tdup_line_total
