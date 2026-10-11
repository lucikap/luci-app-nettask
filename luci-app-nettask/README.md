# luci-app-nettask

OpenWrt LuCI 自定义脚本管理工具，支持在 Web 界面编写和运行 Shell 脚本。

## 功能特点

- 在 LuCI 界面直接编辑和运行 Shell 脚本
- 支持多种执行方式：立即运行、开机运行、定时任务、按钮触发、断网触发
- 灵活的配置选项，可自定义任务执行时间和频率

## 目录结构

```
luci-app-nettask/
├── Makefile
├── luasrc/
│   ├── controller/
│   │   └── NetTask.lua          # 路由控制器
│   ├── model/cbi/
│   │   ├── nettask.lua          # 基本功能页面
│   │   └── trontabs.lua         # 高级功能页面
│   └── view/cbi/
│       ├── other_buttons.htm    # 按钮模板
│       ├── other_dvalues.htm    # 值显示模板
│       └── other_uploads.htm    # 上传模板
└── root/etc/
    ├── config/nettask           # UCI 配置文件
    ├── init.d/nettask           # 启动脚本
    └── nettask/                 # 功能脚本目录
        ├── button.sh
        ├── cron.sh
        ├── duan.sh
        ├── network.sh
        ├── ping.sh
        ├── timing.sh
        └── word.sh
```

## 依赖

- `luci-lib-fs`
- `luci-compat`（旧式 LuCI 架构需要）

## 安装

### 方式一：编译到固件

```bash
# 克隆到 package 目录
git clone https://github.com/lucikap/luci-app-nettask.git package/luci-app-nettask

# 在 menuconfig 中选择
make menuconfig
# LuCI -> Applications -> luci-app-nettask

# 编译
make package/luci-app-nettask/compile V=s
```

### 方式二：直接安装 ipk/apk

```bash
# 上传到设备后安装
opkg install luci-app-nettask_*.ipk
# 或
apk add --allow-untrusted luci-app-nettask_*.apk
```

## 访问

- **菜单入口**：系统 → 自定义脚本
- **直接访问**：`http://<router-ip>/cgi-bin/luci/admin/system/NetTask`

## 修复记录

### 2026-01-21

**问题**：安装后菜单不显示，访问返回 404

**原因**：
1. 目录结构不符合 luci.mk 规范（controller/model/view 应在 luasrc/ 下）
2. Makefile 自定义 install 未正确安装 LuCI 文件
3. view 模板路径错误（应在 `luasrc/view/cbi/` 而非 `luasrc/view/`）

**修复**：
- 将 `controller/` → `luasrc/controller/`
- 将 `model/` → `luasrc/model/cbi/`
- 将 `view/` → `luasrc/view/cbi/`
- 将 `etc/` → `root/etc/`
- 简化 Makefile，移除自定义 install，让 luci.mk 自动处理
- 添加 `luci-compat` 依赖

## 致谢

- 原作者：brukamen
- 联系邮箱：169296793@qq.com
- QQ 群：555201601

## 许可证

GPL-2.0
