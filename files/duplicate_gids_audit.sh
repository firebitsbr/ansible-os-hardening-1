#!/bin/bash

LOGLEVEL=INFO
log_debug() { if [ "$LOGLEVEL" == "DEBUG" ]; then echo "$@"; fi }
log_info()  { if [ "$LOGLEVEL" == "INFO" ]; then echo "$@"; fi }

cat /etc/group | cut -f3 -d":" | sort -n | uniq -c | while read x ; do
    [ -z "${x}" ] && break
    set - $x
    if [ $1 -gt 1 ]; then
        groups=`awk -F: '($3 == n) { print $1 }' n=$2 /etc/group | xargs`
        log_debug "Duplicate GID ($2): ${groups}"
        log_info "${groups}"
    fi
done
