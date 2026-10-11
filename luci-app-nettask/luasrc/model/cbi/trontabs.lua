local n = require "luci.fs"
local t = luci.http
local wa = require "luci.tools.webadmin"
local fs = require "nixio.fs"

m = Map("nettask",
	translate("多自定义任务管理"),
	translate("<span style='color: yellow;'>支持上传多个脚本以及多个计划任务，在本地编辑后直接上传即可运行，使用此功能时应该避免脚本进入死循环，否则可能引起严重问题</span>"))

sul =m:section(TypedSection, "upload", "上传脚本")
sul.addremove = false
sul.anonymous = true

fu = sul:option(FileUpload, "")
fu.template = "cbi/other_uploads"

um = sul:option(DummyValue, "", nil)
um.template = "cbi/other_dvalues"

local a, e

a = "/etc/nettask/filetab/"
nixio.fs.mkdir(a)

t.setfilehandler(function(t, o, i)
    if not e then
        if not t then
            return
        end
        if t and o then
            e = nixio.open(a .. t.file, "w")
        end
        if not e then
            um.value = "上传文件出错。"
            return
        end
    end
    if o and e then
        e:write(o)
    end
    if i and e then
        e:close()
        e = nil
        um.value = "脚本文件已上传到" .. '"/etc/nettask/filetab/' .. t.file .. '"'
	luci.sys.exec('chmod +x "/etc/nettask/filetab/' .. t.file .. '"')
	luci.sys.exec("find /etc/nettask/filetab -type f -name ' .. t.file .. ' -exec sed -i 's/\r$//' {} +")
    end
end)

if luci.http.formvalue("upload") then
    local e = luci.http.formvalue("ulfile")
    if #e <= 0 then
        um.value = "好像没有选择要上传的文件？？？"
    end
end


s = m:section(TypedSection, "crontab", translate("计划任务列表"))
s.addremove = true
s.anonymous = true
s.template  = "cbi/tblsection"

iface = s:option(ListValue, "shellname", "脚本名称")
iface.rmempty = true
iface:value("default", translate("-- 请选择 --"))

local nettask_dir = "/etc/nettask/filetab/"
local files = nixio.fs.dir(nettask_dir)
if files then
    for filename in files do
        iface:value(filename)
    end
end

t = s:option(Value, "minute", translate("分<abbr title=\"有效值\">（0-59）</abbr>"))
t.default = "0"

n = s:option(Value, "shi", translate("时<abbr title=\"有效值\">（0-23）</abbr>"))
n.default = "6"

g = s:option(Value, "day", translate("日<abbr title=\"有效值\">（1-31）</abbr>"))
g.default = "*"

metric = s:option(Value, "month", translate("月<abbr title=\"有效值\">（1-12）</abbr>"))
metric.default = "*"

mtu = s:option(Value, "week", translate("周<abbr title=\"有效值\">（1-7）</abbr>"))
mtu.default = "*"

routetype = s:option(Value, "type", translate("启用/停用"))
routetype:value("0", "停用")
routetype:value("1", "启用")
routetype.default = "0"
routetype.rmempty = true

local a, e

local n = require "luci.fs"
a = "/etc/nettask/filetab/"
nixio.fs.mkdir(a)

local function i(e)
    local t = 0
    local a = {' kB', ' MB', ' GB', ' TB'}
    repeat
        e = e / 1024
        t = t + 1
    until (e <= 1024)
    return string.format("%.1f", e) .. a[t]
end

local e, a = {}
for t, o in ipairs(n.glob("/etc/nettask/filetab/*")) do
    a = n.stat(o)
    if a then
        e[t] = {}
        e[t].name = n.basename(o)
        e[t].mtime = os.date("%Y-%m-%d %H:%M:%S", a.mtime)
        e[t].modestr = a.modestr
        e[t].size = i(a.size)
        e[t].remove = 0
        e[t].install = false
    end
end

tb = m:section(Table, e, "脚本列表")
nm = tb:option(DummyValue, "name", translate("文件名"))
mt = tb:option(DummyValue, "mtime", translate("修改时间"))
ms = tb:option(DummyValue, "modestr", translate("权限"))
sz = tb:option(DummyValue, "size", translate("大小"))
btnrm = tb:option(Button, "remove", translate("移除"))
btnrm.render = function(e, a, t)
    e.inputstyle = "remove"
    Button.render(e, a, t)
end

btnrm.write = function(a, t)
    local a = luci.fs.unlink("/etc/nettask/filetab/" .. luci.fs.basename(e[t].name))
    if a then
        table.remove(e, t)
    end
    return a
end

function IsIpkFile(e)
    e = e or ""
    e = string.lower(e)
    return string.find(e, ".sh", 1, true) ~= nil
end
btnis = tb:option(Button, "install", translate("试运行"))
btnis.template = "cbi/other_buttons"
btnis.render = function(o, a, t)
    if not e[a] then
        return false
    end
    if IsIpkFile(e[a].name) then
        t.display = ""
    else
        t.display = "none"
    end
    o.inputstyle = "apply"
    Button.render(o, a, t)
end

btnis.write = function(a, t)
    luci.sys.exec('pgrep -f /etc/nettask/%s | xargs kill -9 >/dev/null 2>&1', e[t].name)
    local e = luci.sys.exec(string.format('sh /etc/nettask/filetab/%s', e[t].name))
    tb.description = string.format('<span style="color: red">%s</span>', e)
end

m.on_commit = function(self)
    luci.sys.exec("/etc/nettask/cron.sh")
end

return m

