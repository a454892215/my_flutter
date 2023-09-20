#!/bin/bash
echo "start create keystore.jks !"
curTime=$(date "+%Y%m%d%H%M%S")
 java -jar walle-cli-all.jar show app-release_new.apk
echo "${curTime} 显示新app信息完毕"
