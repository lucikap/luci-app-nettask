# Luci-app-nettask

项目描述：这个仓库是一个用于在 OpenWrt 的 LuCI 界面上编写和运行自定义 Shell 脚本的工具，支持多种执行方式。

<img src="https://github.com/lucikap/luci-app-nettask/blob/main/png/Overview.png" alt="效果图" width="800">

## 功能特点

- 在 LuCI 界面上直接编辑和运行 Shell 脚本
- 支持多种执行方式，包括立即运行、开机运行、定时任务、按钮触发和断网触发
- 灵活的配置选项，可以根据需要自定义任务执行的时间和频率

## 安装说明

1. 在你的 OpenWrt 设备上安装 LuCI 界面（如果尚未安装），安装后可以在“系统”菜单中找到“自定义脚本”。

2. 使用 Git 克隆本仓库到你的编译环境。

   ```shell
   git clone https://github.com/lucikap/luci-app-nettask.git
   
3. 可以在编译选项的luci-->Applications 菜单下找到luci-app-nettask选项，勾选为“*”状态即可编译到固件中。
   ```shell
   make -j12 V=99 #开始编译

## 关于本插件

1. 插件由brukamen开发，目的是方便大家在某些情况下需要执行shell脚本时不需要再进行繁琐的添加文件、修改文件等操作，可以直接在luci进行编辑并运行。
2. 插件非盈利为目的而开发，此仓库完全开源，如果你有好的建议可以在GitHub提出改进建议（或者发送至我的邮箱169296793@qq.com），我更希望你直接申请成为开发者。
3. 如果你对此感兴趣，可以加入讨论QQ群组：555201601<br>

<img src="https://github.com/lucikap/luci-app-nettask/blob/main/png/qrcode_1708176698643.jpg" alt="qq" width="300">

## 如果可以，不妨以打赏的方式支持Brukamen，相信以后能给大家带来更多好玩的插件！！

<img src="https://github.com/lucikap/luci-app-nettask/blob/main/png/eeda353f2bd3110abbe23dd362bc839.jpg" alt="qq" width="200">

