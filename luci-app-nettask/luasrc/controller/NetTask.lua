module("luci.controller.NetTask", package.seeall)

function index()
	entry({"admin", "system", "NetTask"},alias("admin", "system", "NetTask","commonly"), _("自定义脚本"))
	entry({"admin", "system", "NetTask", "commonly"},cbi("nettask"), _("基本功能"), 10).leaf = true
	entry({"admin", "system", "NetTask", "trontabs"}, cbi("trontabs"), _("高级功能"), 20).leaf = true
end
