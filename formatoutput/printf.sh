#!/bin/bash
# 使用 printf 命令进行格式化输出
# 实现类似制表符式的输出方式
# 占位替换 % %s 输出一个字符串，%d 整型输出，%c 输出一个字符，%f 输出实数，以小数形式输出
# 左右对齐 - 为左对齐 不加是右对齐
# 字符宽度 30

printf "%-30s %-30s %-10.1f\n" AppName Status 8
printf "\e[1;33m%-30s %-30s %-10s\e[m\n" We Are Colorful
printf "%-30s \e[1;32m%-30s\e[m %-30s\n %-10s\n" "somthing string" "something colorful" "somenumber string"
printf "%-30c %-30s %-30s\n" "i am a so loooooooooooooooog string" "something uncolor" "somenumber string"