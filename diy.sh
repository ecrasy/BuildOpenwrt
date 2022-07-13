#!/bin/bash

# 修改默认IP为192.168.2.1
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate 


# 替换默认主题
rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/lean/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile

#删掉重复
rm -rf feeds/kenzo/luci-theme-argon feeds/kenzo/luci-theme-argonne
[ -e package/feeds/kenzo/luci-app-mosdns/Makefile ] && sed -ri  's#mosdns[-_]neo#mosdns#g' package/feeds/kenzo/luci-app-mosdns/Makefile