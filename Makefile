# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2020 Lean <coolsnowwolf@gmail.com>
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=autocore
PKG_VERSION:=2
PKG_RELEASE:=$(COMMITCOUNT)

PKG_CONFIG_DEPENDS:= \
	CONFIG_TARGET_bcm27xx \
	CONFIG_TARGET_bcm53xx

include $(INCLUDE_DIR)/package.mk

define Package/autocore-arm
  TITLE:=ARM auto core script.
  MAINTAINER:=CN_SZTL
  DEPENDS:=@(arm||aarch64) \
    +TARGET_bcm27xx:bcm27xx-userland \
    +TARGET_bcm53xx:nvram
  VARIANT:=arm
endef

define Package/autocore-arm/description
  Display more details info about the devices in LuCI.
endef

define Build/Compile
endef

define Package/autocore-arm/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_BIN) ./files/rpcd_luci $(1)/etc/rpcd_luci
	$(INSTALL_DATA) ./files/rpcd_luci-mod-status.json $(1)/etc/rpcd_luci-mod-status.json
	$(INSTALL_DATA) ./files/rpcd_10_system.js $(1)/etc/rpcd_10_system.js
	$(INSTALL_DATA) ./files/rpcd_21_ethinfo.js $(1)/etc/rpcd_21_ethinfo.js

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/090-cover-index_files $(1)/etc/uci-defaults/090-cover-index_files

	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) ./files/cpuinfo $(1)/sbin/cpuinfo
	$(INSTALL_BIN) ./files/ethinfo $(1)/sbin/ethinfo
endef

$(eval $(call BuildPackage,autocore-arm))
