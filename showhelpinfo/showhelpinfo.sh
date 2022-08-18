#!/bin/bash
# 用写注释一样的方式，来实现帮助信息的输出

###
### app.sh — Controls app startup and stop.
###
### Usage:
###   app.sh <Options>
###
### Options:
###   start   Start your app.
###   stop    Stop your app.
###   status  Show app status.
###   -h      Show this message.

function showHelp() {
    sed -rn -e "s/^### ?//p" $0 | sed "s#app.sh#${0}#g"
}

case $1 in
start)
    appStart
    ;;
stop)
    appStop
    ;;
status)
    appStatus
    ;;
*)
    showHelp
    exit 1
    ;;
esac