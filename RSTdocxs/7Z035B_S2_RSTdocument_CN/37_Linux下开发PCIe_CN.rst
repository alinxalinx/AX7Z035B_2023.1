Linux下开发PCIe 
==================

PCIe驱动和上位机测试文件都位于“PCIe”文件夹

虚拟机下无法开发PCIe，所以这里我们专门找一台电脑用于测试。本实验要求有Linux系统使用基础，如果不会使用Linux，可跳过本章。

电脑主板配置
------------

配置说明
~~~~~~~~

PCIE板卡，在Linux下需要安装驱动。不幸的是，支持uefi的电脑，开启secure boot后，内核将只允许加载带有公钥的合法签名模块。

这里我们自己编译的驱动（xdma.ko）,并没有签名，所以在安装系统之前，关闭该功能。

配置方法
~~~~~~~~

下面我们将以华硕主板为例，介绍如何关闭secure boot功能

1) 电脑重启后，F2进入BIOS设置界面

.. image:: images/37_media/image1.jpeg
         
2) 点击“Advanced Mode(F7)”，并点击”OK“按钮确定

.. image:: images/37_media/image2.png
         
3) 进入高级设置界面

.. image:: images/37_media/image3.png
         
4) 选择“Boot”标签

.. image:: images/37_media/image4.png
         
5) 下拉滚动条，可看到“Secure Boot”选项

.. image:: images/37_media/image5.png
         
6) 点击进入

.. image:: images/37_media/image6.png
         
7) 重新选择“OS Type”为“Other OS”

.. image:: images/37_media/image7.png
         
8) 退出保存即可

.. image:: images/37_media/image8.png
         
Linux系统安装
-------------

这里我们选择ubuntu 16.04 LTS进行安装，安装方法不再描述。

文件准备
--------

使用u盘将驱动源文件“Xilinx_Answer_65444_Linux_Files“、应用程序源文件、QT安装程序拷入系统

.. image:: images/37_media/image9.png
         
打开虚拟终端
------------

1) 按键盘上的Windows键，即可弹出应用程序搜索页面。输入”ter”即可看到虚拟终端的图标

.. image:: images/37_media/image10.png
         
2) 点击搜索出的第一个图标，打开终端

.. image:: images/37_media/image11.png
         
驱动安装
--------

驱动编译
~~~~~~~~

1) 输入“cd + 目录”并敲回车，进入驱动文件所在目录

.. image:: images/37_media/image12.png
         
2) 输入”make”并敲回车，等待编译完成

.. image:: images/37_media/image13.png
         
驱动加载
~~~~~~~~

1) 输入”cd ../tests”并敲回车

2) 输入”chmod +x load_driver.sh”并敲回车

3) 输入”sudo ./load_driver.sh”并敲回车,驱动加载成功后，提示如下

.. image:: images/37_media/image14.png
         
Qt软件安装
----------

库安装
~~~~~~

1) 保证ubuntu系统可以连接网络

2) 更新源列表

..

   sudo apt-get update

3) 安装必要的库

..

   sudo apt-get install mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev
   freeglut3-dev

.. _qt软件安装-1:

Qt软件安装
~~~~~~~~~~

1) 进入Qt安装程序所在目录

..

   cd ~/Download

2) 添加运行权限

..

   chmod +x qt-opensource-linux-x64-5.7.1.run

3) 运行安装程序

..

   ./ qt-opensource-linux-x64-5.7.1.run

4) 按照提示完成安装

应用程序运行
------------

1) 修改设备节点权限

..

   sudo chmod 777 /dev/ \*

2) 打开Qt，按键盘windows键，在弹出的搜索框中输入Qt。点击Qt图标即可

测速软件
--------

程序功能和Windows版本完全相同，不再复述。

.. image:: images/37_media/image15.png
         
读应用
------

程序功能和Windows版本完全相同，不再复述。

.. image:: images/37_media/image16.png
         
写应用
------

程序功能和Windows版本完全相同，不再复述。

.. image:: images/37_media/image17.png
         