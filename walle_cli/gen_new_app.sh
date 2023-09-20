#!/bin/bash
echo "start create keystore.jks !"
curTime=$(date "+%Y%m%d%H%M%S")
java -jar walle-cli-all.jar put -c meituan  -e buildtime="${curTime}",hash=2235wz app-release.apk app-release_new.apk
echo "${curTime}生成新app成功"
