PS端EMIO的使用
================

**实验Vivado工程为“ps_emio”。**

如果想用PS点亮PL的LED灯，该如何做呢？一是可以通过EMIO控制PL端LED灯，二是通过AXI
GPIO的IP实现控制。本章介绍如何使用EMIO控制PL端LED灯的亮灭。同时也介绍了，利用EMIO连接PL端按键控制PL端LED灯。

原理介绍
--------

先来了解GPIO的BANK分布，在UG585文档GPIO一章中可以看到GPIO是有4个BANK，注意与MIO的BANK区分。
BANK0控制32个信号，BANK1控制22个信号，总共是MIO的54个引脚，也就是诸如SPI,I2C,USB,SD等PS端外设接口；
BANK2和BANK3共能控制64个PL端引脚，注意每一组都有三个信号，输入EMIOGPIOI，输出EMIOGPIOO，输出使能EMIOGPIOTN，类似于三态门，共192个信号。可以连接到PL端引脚，通过PS控制信号。本章就是采用EMIO控制PL端LED。

.. image:: images/03_media/image1.png
      
FPGA工程师工作内容
------------------

以下为FPGA工程师负责内容。

Vivado工程建立
--------------

1. 以ps_hello工程为基础，另存为一个名为ps_emio的工程，打开ZYNQ配置，把GPIO EMIO勾选上。

.. image:: images/03_media/image2.png
      
2. 在MIO配置中选择EMIO的位宽为8位，因为PL端的LED有四个，使用PL端的一个按键。配置结束，点击OK。

.. image:: images/03_media/image3.png
      
3. 点击多出的GPIO_0端口右键选择Make External，将端口信号导出

.. image:: images/03_media/image4.png
      
4. 修改引脚名称为emio

.. image:: images/03_media/image5.png
      
修改结果，并保存设计

.. image:: images/03_media/image6.png
      
5. 点击xx.bd右键选择Generate Output Products，重新生成输出文件

.. image:: images/03_media/image7.png
      
6. 结束后，顶层文件会更新出新的管脚，下面需要对其进行引脚绑定

.. image:: images/03_media/image8.png
      
XDC文件约束PL管脚
-----------------

1. 新建XDC文件，绑定PL端引脚

.. image:: images/03_media/image9.png
      
设置文件名称为emio

.. image:: images/03_media/image10.png
      
2. emio.xdc添加一下内容，端口名称一定要和顶层文件端口一致

::

 set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
 set_property CONFIG_VOLTAGE 3.3 [current_design]
 set_property CFGBVS VCCO [current_design]
 
 set_property IOSTANDARD LVCMOS33 [get_ports {emio_tri_io[*]}]
 #pl led
 set_property PACKAGE_PIN AB15 [get_ports {emio_tri_io[0]}]
 set_property PACKAGE_PIN AB14 [get_ports {emio_tri_io[1]}]
 set_property PACKAGE_PIN AF13 [get_ports {emio_tri_io[2]}]
 set_property PACKAGE_PIN AE13 [get_ports {emio_tri_io[3]}]
 #pl key
 set_property PACKAGE_PIN AF15 [get_ports {emio_tri_io[4]}]

1. 生成bit文件

.. image:: images/03_media/image11.png
      
4. 导出硬件

.. image:: images/03_media/image12.png
         
5. 因为要用到PL，所以选择“Include bitstream”，点击“OK”

软件工程师工作内容
------------------

以下为软件工程师负责内容。

Vitis程序编写
-------------

EMIO点亮PL端LED灯
~~~~~~~~~~~~~~~~~

1. 进入Vitis软件，新建名为emio_led_test的工程

.. image:: images/03_media/image13.png
      
下图为GPIO的控制框图，实验中会用到输出部分的寄存器，数据寄存器DATA，数据掩码寄存器MASK_DATA_LSW，MASK_DATA_MSW，方向控制寄存器DIRM，输出使能控制器OEN。

.. image:: images/03_media/image14.png
      
2. 再来看GPIO的寄存器，可以打开UG585文档的最下面Register Details，找到General Purpose I/O部分。

.. image:: images/03_media/image15.png
      
3. 实验中可能会用到的寄存器：

数据掩码寄存器，例如MIO 9在GPIO的BANK0，可以屏蔽其他BANK0中的其他31位。

.. image:: images/03_media/image16.png
      
方向寄存器，控制数据的方向

.. image:: images/03_media/image17.png
      
输出使能寄存器

.. image:: images/03_media/image18.png
      
数据寄存器，有效的数据

.. image:: images/03_media/image19.png
      
具体的寄存器含义就不一一讲解了，大家自行研究。

4. 一开始编写代码可能会无从下手，我们可以导入Xilinx提供的example工程，点开BSP，找到ps7_gpio_0，点击Import Examples

.. image:: images/03_media/image20.png
      
在弹出窗口选择“xgpiops_polled_example”，点击OK

.. image:: images/03_media/image21.png
      
会出现一个新的APP工程

.. image:: images/03_media/image22.png
      
5. 这个example工程是测试PS端EMIO的输入输出的，由于开发板PL端的第一个LED是MIO54，需要在文件中修改Output_pin为54，测试MIO54的LED灯。

.. image:: images/03_media/image23.png
      
由于只测试LED灯，也就是输出，我们把输入功能注释掉。保存文件。

.. image:: images/03_media/image24.png
      
6. 选中example的工程，右键进入Run Configurations

.. image:: images/03_media/image25.png
            
7. 双击System Debug

8. 选中Reset entire system，复位整个系统，并选择Program FPGA,点击Run，即可看到LED1闪烁16次。

.. image:: images/03_media/image26.png
            
9. 虽然用官方的例子比较方便，但是它的代码看起来比较臃肿，我们可以通过学习它的方法，自己简化写一遍。在emio_led_test的helloworld.c中修改。其实程序步骤很简单，初始化GPIO设置方向输出使能控制GPIO输出值。

.. image:: images/03_media/image27.png
            
10. 下载配置

.. image:: images/03_media/image28.png
      
由于下载需要bitstream文件，勾选上Program FPGA，点击Run，即可看到PL端LED闪烁。

.. image:: images/03_media/image26.png
      
EMIO实现PL端按键中断
~~~~~~~~~~~~~~~~~~~~

前面介绍了EMIO作为输出控制LED灯，这里讲一下利用EMIO作为按键输入控制LED灯。

1. 通过UG585文档看下GPIO的结构图，中断的寄存器：

INT_MASK：中断掩码

INT_DIS: 中断关闭

INT_EN: 中断使能

INT_TYPE: 中断类型，设置电平敏感还是边沿敏感

INT_POLARITY: 中断极性，设置低电平或下降沿还是高电平或上升沿

INT_ANY: 边沿触发方式，需要INT_TYPE设置为边沿敏感才能使用

设置中断产生方式时需要INT_TYPE、INT_POLARITY、INT_ANY配合使用。具体寄存器含义请参考UG585 Register Details部分。

.. image:: images/03_media/image29.png
      
2. 本实验设计为接下按键LED灯亮，再按下LED灭。

主程序设计流程如下：

GPIO初始化设置按键和LED方向设置产生中断方式设置中断打开中断控制器打开中断异常打开GPIO中断判断KEY_FLAG值，是1，写LED

中断处理流程：

查询中断状态寄存器判断状态清除中断设置KEY_FLAG值

通过PL端的按键控制PL端LED灯的亮灭

1. 新建名为emio_key_test的工程，模板为hello world

.. image:: images/03_media/image30.png
      
2. 按键的编号为58，LED灯编号为54，保存重新生成elf。

.. image:: images/03_media/image31.png
      
3. 在main函数中，设置LED和按键，将按键中断类型设置为上升沿产生中断。在本实验中，即按键信号的上升沿产生中断。

.. image:: images/03_media/image32.png
      
4. 中断控制器设置函数IntrInitFuntions是参考PS定时器中断实验所做，而下面的语句是设置中断优先级和触发方式。即操作ICDIPR和ICDICFR寄存器。

.. image:: images/03_media/image33.png
      
5. 在中断服务程序GpioHandler中，判断中断状态寄存器，清除中断，并将按键标志置1。

.. image:: images/03_media/image34.png
      
6. 在main函数中，判断按键标志key_flag，向LED写入数据。

.. image:: images/03_media/image35.png
      
1. Run Configurations选择Program FPGA，点击Run

.. image:: images/03_media/image36.png
      
7. 观察实验现象，按下PL端按键，就可以控制PL端LED的亮灭。

按键为KEY1； LED灯为LED1;

固化程序
--------

前面介绍过没有FPGA加载文件情况下如何生成固化程序（详情参考“体验ARM，裸机输出”Hello World”一章）。本章内容生成了FPGA的加载文件，在这里演示一下如何生成固化程序。

与前面一样，新建fsbl工程，添加调试信息，之后选择APP，右键Create Boot Image

.. image:: images/03_media/image37.png
      
软件会自动添加三个文件，第一个引导程序fsbl.elf，第二个为FPGA的bitstream，第三个为应用程序xx.elf，点击Create Image即可，下载方法与前面一样，不再赘述。

.. image:: images/03_media/image38.png
      
引脚绑定常见错误
----------------

1. 在block design设计中，比如下图，GPIO模块的引脚名设置为了leds和keys，很多人想当然的在XDC里按照这样的名称绑定引脚。

.. image:: images/03_media/image39.png
            
如果打开顶层文件就会发现引脚名称是不一样的，一定要仔细检查，以顶层文件里的引脚名称为

.. image:: images/03_media/image40.png
            
否则就会出现以下引脚未绑定的

.. image:: images/03_media/image41.png
            
2. 如果是手写XDC文件，切记注意空格，这也是非常常见的错误

.. image:: images/03_media/image42.png
            
知识点分享
----------

1. 在bsp的include文件夹下包含了xilinx的各种头文件，如本章用到的GPIO，用到了xgpiops.h，在此文件中可以看到各种宏定义，在调用GPIO函数时可以使用这些宏定义，提高可读性。

.. image:: images/03_media/image43.png
      
同时也包含外设自带的函数声明

.. image:: images/03_media/image44.png
      
2. 在xparameters.h头文件中定义了各个外设的基地址，器件ID，中断等

.. image:: images/03_media/image45.png
      
比如程序中的DEVICE_ID宏定义就是在这个文件里找到的。

.. image:: images/03_media/image46.png
      
3. 在libsrc文件夹中，包含外设函数的定义，使用说明

.. image:: images/03_media/image47.png
      
4. 在src文件夹下的lscript.ld中，定义了可用memory空间，栈和堆空间大小等，可根据需要修改。

.. image:: images/03_media/image48.png
      
5. 把鼠标光标放到宏定义或函数上，按下F3即可看到在哪里定义的，也可以按Ctrl+鼠标左键进入。比如下面的DEVICE_ID即可进入xparameter.h中

.. image:: images/03_media/image49.png
      
.. image:: images/03_media/image50.png
      
本章小节
--------

本章进一步学习了PS端的EMIO的使用，虽然将EMIO连接到了PL端的引脚上，但Vitis中的用法还是一样的，从这个例子我们也可以看出，一旦与PL端发生了联系，就需要生成bitstream，虽然几乎没有产生逻辑。
