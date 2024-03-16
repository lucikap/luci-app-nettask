include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-nettask
PKG_VERSION=2.0.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-nettask
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=file transfer tool
	PKGARCH:=all
endef

define Package/luci-app-nettask/description
	Edit the shell script in the web.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-nettask/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/cbi/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/etc/nettask/filetab/
	
	$(INSTALL_BIN) ./controller/* $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_BIN) ./model/* $(1)/usr/lib/lua/luci/model/cbi/
	$(INSTALL_BIN) ./view/* $(1)/usr/lib/lua/luci/view/cbi/
	$(INSTALL_CONF) ./etc/config/nettask $(1)/etc/config/nettask
	$(INSTALL_BIN) ./etc/init.d/nettask $(1)/etc/init.d/nettask
	$(INSTALL_DATA) ./etc/nettask/* $(1)/etc/nettask/
	chmod +x $(1)/etc/nettask/*
endef

$(eval $(call BuildPackage,luci-app-nettask))
