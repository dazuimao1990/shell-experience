## 简介
该脚本用于在两个文件夹之间批量进行文件对比，并形成简易的报告。遍历首个文件夹中的所有非二进制文件，在被比对的文件夹中找到同名文件，分别计算代码行数以及重复行数，输出为结果。

## 用法

```bash
$ ./diffcount.sh -h             

./diffcount.sh — Count the number of duplicate lines of code in both directories and generate a report.

Usage:
  ./diffcount.sh <Dir1> <Dir2>
```

## 示例

### 打印结果到标准输出

```bash
$ ./diffcount.sh srcdir destdir 
src,srcline_num,destline_num,dup_line_num
test/codefileindir.txt,4,0,0  # 这个文件只在 src 目录中存在，源文件中代码行数得到统计，被比对的文件中代码行数为0，重复行数也为0。
codefile.txt,5,5,3            # 这个文件在 src 和被比对的文件中有差异，重复代码行数为 4.
===============================
src_total,dest_total,tdup_total
9,5,3                         # src 文件夹中代码总行数,被比对文件夹中代码总行数,重复代码总行数.
```

### 输出Excel兼容格式

```bash
$ ./diffcount.sh srcdir destdir > result.csv
```

得到的文件可以被 Excel 直接打开。