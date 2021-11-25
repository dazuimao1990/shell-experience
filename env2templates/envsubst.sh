#!/bin/bash

# 这个用例是通过 envsubst 实现在 shell 中利用环境变量渲染模版，从 nginx 镜像学习而来
# 基本语法如下：
# 安装命令，以 ubuntu 为例
# apt-get update 
# apt-get install -y gettext-base


auto_envsubst() {
  # 定义模版文件路径
  local template_dir="${NGINX_ENVSUBST_TEMPLATE_DIR:-/etc/nginx/templates}"
  # 定义模版后缀名
  local suffix="${NGINX_ENVSUBST_TEMPLATE_SUFFIX:-.template}"
  # 定义配置文件输出路径
  local output_dir="${NGINX_ENVSUBST_OUTPUT_DIR:-/etc/nginx/conf.d}"
  # 声明一系列局部变量
  local template defined_envs relative_path output_path subdir
  # 抽取系统中所有环境变量，赋值给 envsubst
  defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
  # 如果不存在模版目录，则直接函数返回退出
  [ -d "$template_dir" ] || return 0
  if [ ! -w "$output_dir" ]; then
    echo >&3 "$ME: ERROR: $template_dir exists, but $output_dir is not writable"
    return 0
  fi
  # 在模版目录中抽取所有的以指定后缀名结尾的模版文件，作为输入，传递给 while 循环的 read 输入，赋值给变量  template
  find "$template_dir" -follow -type f -name "*$suffix" -print | while read -r template; do
    # 利用 # 截去变量值左侧匹配到的模版路径
    relative_path="${template#$template_dir/}"
    # 利用 % 截去变量值右侧的模版后缀名，并拼接起配置文件输出路径
    output_path="$output_dir/${relative_path%$suffix}"
    subdir=$(dirname "$relative_path")
    # create a subdirectory where the template file exists
    mkdir -p "$output_dir/$subdir"
    echo >&3 "$ME: Running envsubst on $template to $output_path"
    # 统一替换
    envsubst "$defined_envs" < "$template" > "$output_path"
  done
}

# 简要示例：
# 抽取一些标准环境变量，替换同目录下的一个模版文件
auto_envsubst_test(){
    defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
    template=source.txt
    output_path=distnation.txt
    envsubst "$defined_envs" < "$template" > "$output_path"
}
auto_envsubst_test