HDMI 直通ILA调试实验
======================

**实验VIvado工程为“hdmi_loop”。**

本实验在上面的HDMI输出的实验基础上修改为HDMI输入直通到HDMI输出的显示，完成一个简单的HDMI输入输出检测。本实验中我们使用Vivado的ILA来调试，查看一些信号波形，初步掌握调试技巧。

硬件介绍
--------

开发板HDMI输出接口芯片使用ADV7511，HDMI输入芯片采用SIL9011，HDMI输入输出接口芯片采用独立的I2C总线。

程序设计
--------

程序非常简单，首先使用I2C Master控制器配置ADV7511和SIL9011，然后把HDMI视频数据、同步信息经过3级触发器，然后到HDMI输出。

.. image:: images/19_media/image1.png
      
使用Vivado调试
--------------

在前面的实验中我们已经讲解了Vivado的基本使用流程，现在我们来使用Vivado进行debug

1) 编译完成以后（或者运行过“Run Synthesis”），可以在“SYNTHESIS”中找到Set Up Debug，点击可以进入Debug调试窗口。

.. image:: images/19_media/image2.png
      
2) Set Up Debug运行向导，提示我们可以如何设置debug，这里点击Next

.. image:: images/19_media/image3.png
      
3) 在Netlist窗口中可以找到一些网络名称，选择后点击“+”号可以添加到debug信号里，需要主要直接和FPGA管脚相连的信号不能加入调试，例如vin_data，vout_data，只能使用BUF代替，例如vin_data_IBUF。vout_data_OBUF输出BUF添加后也不能布局布线。

.. image:: images/19_media/image4.png
      
4) 添加完信号以后，vivado会自动推导信号所在的时钟域，不过时钟也可以自己选择。

.. image:: images/19_media/image5.png
      
5) 采样深度设置，设置越大，一次采样能看到的数据越多，采样使用FPGA内部block ram来实现，采样深度太大会导致消耗过多的内部RAM。

.. image:: images/19_media/image6.png
      
6) 完成向导时提示有一个debug内核被创建，如果信号有多个时钟域，会创建多个debug内核。

.. image:: images/19_media/image7.png
      
7) 点击保存，vivado软件会把当前debug配置写入到xdc文件里

.. image:: images/19_media/image8.png
      
8) 在xdc文件下，可以看到多出一段代码，如果不再需要调试，可以删除这段代码

.. image:: images/19_media/image9.png
      
9) 生成bit文件

下载调试
--------

1) 连接HDMI输入到HDMI视频源，HDMI输出到HDMI显示器

2) 下载bit文件，和前面的实验不同，可以看到vivado自动添加了一个ltx文件

.. image:: images/19_media/image10.png
      
3) 如果HDMI输入没有，不会弹出调试窗口，提示找不到debug内核

.. image:: images/19_media/image11.png
      
4) 如果有HDMI输入，刷新硬件，一般会弹出一个调试窗口

.. image:: images/19_media/image12.png
      
5) 点击三角图标采集信号

.. image:: images/19_media/image13.png
      
6) 在触发设置窗口可以设置某个信号触发采集

.. image:: images/19_media/image14.png
      
7) 可以选择触发类型

.. image:: images/19_media/image15.png
      
8) 设置vs上升沿触发后采集到的波形

.. image:: images/19_media/image16.png
      
实验总结
--------

本实验在进行HDMI直通显示时，使用了Vivado的Debug功能，Vivado提供了非常丰富的调试选择，本实验仅仅是一个小小功能的展示，不过这也是使用最广泛的调试方式。

常见问题
--------

网络被综合以后找不到
~~~~~~~~~~~~~~~~~~~~

可以在Verilog代码中插入(\* mark_debug="true" \*)属性，这样在Set Up
Debug的时候可以快速找到这个信号。

.. image:: images/19_media/image17.png
      
找不到Debug内核
~~~~~~~~~~~~~~~

.. image:: images/19_media/image11.png
      
大部分原因是debug内核时钟输入有问题，或者时钟输入频率低于30Mhz，如果有多个调试内核，有一个内核没有时钟就会导致其他调试内核无法工作。
