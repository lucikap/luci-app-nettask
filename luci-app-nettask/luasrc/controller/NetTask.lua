module("luci.controller.NetTask", package.seeall)

function index()
	entry({"admin", "system", "NetTask"}, cbi("nettask"), _("自定义脚本"), 10).leaf = true
end