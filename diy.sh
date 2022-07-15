#########################################################################
# File Name: diy.sh
# Author: ecras_y@163.com
# Description: ecras_y@163.com
# Created Time: Fri 15 Jul 2022 02:22:58 AM UTC
# Modified Time: Fri 15 Jul 2022 02:22:58 AM UTC
#########################################################################


#!/bin/bash

# 修改默认IP为192.168.2.1
[ -e package/base-files/files/bin/config_generate ] && sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate 


# 替换默认theme
rm -rf package/lean/luci-theme-argon
[ -d package/lean ] && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/lean/luci-theme-argon
[ -e feeds/luci/collections/luci/Makefile ] && sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile

# 删掉重复theme
rm -rf feeds/kenzo/luci-theme-argon feeds/kenzo/luci-theme-argonne
[ -e package/feeds/kenzo/luci-app-mosdns/Makefile ] && sed -ri  's#mosdns[-_]neo#mosdns#g' package/feeds/kenzo/luci-app-mosdns/Makefile

# 去掉重复的ssl库
sed -i 's/CONFIG_PACKAGE_libustream-mbedtls/# CONFIG_PACKAGE_libustream-mbedtls/g' .config
sed -i 's/CONFIG_PACKAGE_libmbedtls/# CONFIG_PACKAGE_libmbedtls/g' .config
sed -i 's/CONFIG_LIBMBEDTLS_HAVE_SSE2/# CONFIG_LIBMBEDTLS_HAVE_SSE2/g' .config

# 替换CPU TYPE
if grep 'CONFIG_TARGET_BOARD="x86"' .config
then
    if grep 'CONFIG_TARGET_SUBTARGET="64"' .config
    then
        sed -ri 's/CONFIG_CPU_TYPE.*/CONFIG_CPU_TYPE="AMD64"/g' .config
    fi
fi
