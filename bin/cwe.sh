#! /bin/bash

# Color warnings yellow and errors red
sed -E -e "s/error/$(echo -e "\033[31mERROR\033[0m"/gI)"   -e "s/warning/$(echo -e "\\033[0;33m"WARNING"\\033[0m"/gI)"
