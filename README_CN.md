# Xilinx Zynq 7000 系列开发板AX7Z035、AX7Z035B  
## 开发板介绍
### 开发板简介
这款核心板使用了 4 片 Micron 的 512MB 的 DDR3 芯片 MT41J256M16HA-125,总的
容量达2GB。其中 PS和 PL 端各挂载两片，分别组成 32bit 的总线宽度。PS端的 DDR3 SDRAM
的最高运行速度可达 533MHz(数据速率 1066Mbps)，PL 端的 DDR3 SDRAM 的最高运行速
度可达 800MHz(数据速率 1600Mbps)。另外核心板上也集成了 2 片 256MBit 大小的 QSPI
FLASH 和 8GB 大小的 eMMC FLASH 芯片，用于启动存储配置和系统文件。
为了和底板连接，这款核心板的 4 个板对板连接器扩展出了 PS 端的 USB 接口，千兆以
太网接口，SD 卡接口及其它剩余的 MIO 口；也扩展出了 ZYNQ 的 8 对高速收发器 GTX 接口；
以及 PL 端的几乎所有 IO 口（144 个），其中 BANK12 和 BANK13 的 IO 的电平可以通过更
换核心板上的 LDO 芯片来修改，满足用户不用电平接口的要求。对于需要大量 IO 的用户，
此核心板将是不错的选择。而且 IO 连接部分，ZYNQ 芯片到接口之间走线做了等长和差分处
理，并且核心板尺寸仅为 80*60（mm），对于二次开发来说，非常适合。
### 关键特性
  1. 开发板使用的是 Xilinx 公司的 Zynq7000 系列的芯片，型号为 XC7Z035-2FFG676。芯片的 PS 系统集成了两个 ARM Cortex™-A9 处理器 
  2. 四片Micron(美光）的512MB的DDR3芯片,型号为 MT41J256M16HA-125(兼容MT41K256M16HA-125)，其中PS和PL端各挂载两片。   
  3. 开发板配有 2 片 256MBit 大小的 Quad-SPI FLASH 芯片组成 8 位带宽数据总线，FLASH型号为 W25Q256FVEI，它使用 3.3V CMOS 电压标准。 
  4. 开 发 板 配 有 一 片 大 容 量 的 8GB 大 小 的 eMMC FLASH 芯 片 ， 型 号 为 THGBMFG6C1LBAIL，它支持 JEDEC e-MMC V5.0 标准的 HS-MMC 接口，电平支持 1.8V 或者 3.3V。   
  5. AC7Z035B 核心板上有 3 个红色 LED 灯，其中 1 个是电源指示灯(PWR)，1 个是配置 LED灯(DONE)，1 个是用户 LED 灯。当核心板供电后，电源指示灯会亮起；当 FPGA 配置程序后，配置 LED 灯会亮起。
  6. HDMI 输出接口的实现，是选用 ANALOG DEVICE 公司的 ADV7511 HDMI（DVI）编码芯片，最高支持 1080P@60Hz 输出，支持 3D 输出。 
  7. 2 路千兆以太网接口，其中 1 路以太网接口是连接的 PS 系统端，另外 1 路以太网接口是连接到 PL 的逻辑 IO 口上。  
  8. 一个 Uart 转 USB 接口，用于系统调试。转换芯片采用 SiliconLabs CP2102GM 的 USB-UAR 芯片, USB 接口采用 MINI USB 接口 
  9. 4个USB2.0 HOST接口 
  10. HDMI 输入接口我们采用了 Silion Image 公司的 SIL9011/ SIL9013HDMI 解码芯片，最高支持 1080P@60Hz 输入，支持不同格式的数据输出。； 
  11. 4 路光纤接口，用户可以购买 SFP 光模块(市场上 1.25G，2.5G，10G 光模块）插入到这 4 个光纤接口中进行光纤数据通信。
  12. 一个 PCIe x4 的接口
  13. 一个Micro型的SD卡接口 
  14.  1 个 2.54mm 标准间距的 40 针的扩展口  
  15. 7 个发光二极管 LED, 1 个电源指示灯； 2 个串口通信指示灯， 4个 PL 控制指示灯。   
  16. 1 个复位按键 RESET 和 4 个用户按键
  17. 开发板的电源输入电压为 DC12V

# AX7Z035、AX7Z035B 文档教程链接
https://ax7z035b-20231-v101.readthedocs.io/zh-cn/latest/7Z035B_S1_RSTdocument_CN/00_%E5%85%B3%E4%BA%8EALINX_CN.html

 注意：文档的末尾页脚处可以切换中英文语言

## 运行环境
* Vivado/Vitis 2023.1 软件安装[下载页面](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vitis/2023-1.html)
* Petalinux 2023.1 软件安装 [下载页面](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools/2023-1.html)

# AX7Z035,AX7Z035B 例程
## 例程描述
此项目为开发板出厂例程，支持板卡上的大部分外设。
## 开发环境及需求
* Vivado 2023.1
* AX7Z035/AX7Z035B开发板
## 创建Vivado工程
* 下载最新的ZIP包。
* 创建新的工程文件夹.
* 解压下载的ZIP包到此工程文件夹中。


有两种方法创建Vivado工程，如下所示：
### 利用Vivado tcl console创建Vivado工程
1. 打开Vivado软件并且利用**cd**命令进入"**auto_create_project**"目录，并回车
```
cd \<archive extracted location\>/vivado/auto_create_project
```
2. 输入 **source ./create_project.tcl** 并且回车
```
source ./create_project.tcl
```

### 利用bat创建Vivado工程
1. 在 "**auto_create_project**" 文件夹, 有个 "**create_project.bat**"文件, 右键以编辑模式打开，并且修改vivado路径为本主机vivado安装路径，保存并关闭。
```
CALL E:\XilinxVitis\Vivado\2023.1\bin\vivado.bat -mode batch -source create_project.tcl
PAUSE
```
2. 在Windows下双击bat文件即可。


更多信息, 请访问[ALINX网站](https://www.alinx.com)