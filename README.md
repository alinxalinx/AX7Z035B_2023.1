# Xilinx Zynq 7000 series development boards AX7Z035, AX7Z035B
## Development board introduction
### Development board introduction
This core board uses 4 Micron 512MB DDR3 chips MT41J256M16HA-125.
Capacity reaches 2GB. Among them, the PS and PL terminals each mount two pieces, each forming a 32-bit bus width. DDR3 SDRAM on PS side
The maximum operating speed can reach 533MHz (data rate 1066Mbps), and the maximum operating speed of DDR3 SDRAM on the PL side is
The speed can reach 800MHz (data rate 1600Mbps). In addition, the core board also integrates 2 pieces of QSPI with a size of 256MBit.
FLASH and 8GB size eMMC FLASH chip for boot storage configuration and system files.
In order to connect to the backplane, the four board-to-board connectors of this core board extend the USB interface on the PS side, Gigabit and above.
Ethernet interface, SD card interface and other remaining MIO ports; it also extends ZYNQ's 8 pairs of high-speed transceiver GTX interfaces;
And almost all IO ports (144) on the PL side, among which the IO levels of BANK12 and BANK13 can be changed by changing
Replace the LDO chip on the core board to modify it to meet the user's requirement of not using a level interface. For users who require a lot of IO,
This core board will be a good choice. In addition, in the IO connection part, the traces between the ZYNQ chip and the interface are of equal length and differential.
management, and the core board size is only 80*60 (mm), which is very suitable for secondary development.
### Key Features
1. The development board uses Xilinx’s Zynq7000 series chip, model XC7Z035-2FFG676. The chip's PS system integrates two ARM Cortex™-A9 processors
2. Four Micron 512MB DDR3 chips, model MT41J256M16HA-125 (compatible with MT41K256M16HA-125), of which two are mounted on the PS and PL sides.
3. The development board is equipped with two 256MBit Quad-SPI FLASH chips to form an 8-bit bandwidth data bus. The FLASH model is W25Q256FVEI, which uses the 3.3V CMOS voltage standard.
4. The development board is equipped with a large-capacity 8GB eMMC FLASH chip, model THGBMFG6C1LBAIL, which supports the JEDEC e-MMC V5.0 standard HS-MMC interface, and the level supports 1.8V or 3.3V.
5. There are 3 red LED lights on the AC7Z035B core board, 1 of which is the power indicator light (PWR), 1 is the configuration LED light (DONE), and 1 is the user LED light. When the core board is powered on, the power indicator light will light up; when the FPGA configures the program, the configuration LED light will light up.
6. The HDMI output interface is implemented using the ADV7511 HDMI (DVI) encoding chip of ANALOG DEVICE, which supports up to 1080P@60Hz output and 3D output.
7. 2 Gigabit Ethernet interfaces, of which 1 Ethernet interface is connected to the PS system side, and the other 1 Ethernet interface is connected to the logical IO port of the PL.
8. A Uart to USB interface for system debugging. The conversion chip uses the USB-UAR chip of SiliconLabs CP2102GM, and the USB interface uses the MINI USB interface.
9. 4 USB2.0 HOST interfaces
10. For the HDMI input interface, we use Silion Image's SIL9011/SIL9013 HDMI decoding chip, which supports up to 1080P@60Hz input and supports data output in different formats. ;
11. 4-way optical fiber interfaces, users can purchase SFP optical modules (1.25G, 2.5G, 10G optical modules on the market) and insert them into these 4 optical fiber interfaces for optical fiber data communication.
12. A PCIe x4 interface
13. A Micro SD card interface
14. 1 2.54mm standard pitch 40-pin expansion port
15. 7 light-emitting diode LEDs, 1 power indicator light; 2 serial communication indicator lights, 4 PL control indicator lights.
16. 1 reset button RESET and 4 user buttons
17. The power input voltage of the development board is DC12V

# AX7Z035, AX7Z035B document tutorial link

 Note: You can switch between Chinese and English languages at the footer at the end of the document

# AX7Z035,AX7Z035B routine
## Routine description
This project is the factory routine of the development board and supports most peripherals on the board.
## Development environment and requirements
* Vivado 2023.1
* AX7Z035/AX7Z035B development board
## Create Vivado project
* Download the latest ZIP package.
* Create a new project folder.
* Unzip the downloaded ZIP package into this project folder.


There are two ways to create a Vivado project, as follows:
### Use Vivado tcl console to create a Vivado project
1. Open the Vivado software and use the **cd** command to enter the "**auto_create_project**" directory and press Enter
```
cd \<archive extracted location\>/vivado/auto_create_project
```
2. Enter **source ./create_project.tcl** and press Enter
```
source ./create_project.tcl
```

### Use bat to create a Vivado project
1. In the "**auto_create_project**" folder, there is a "**create_project.bat**" file, right-click to open it in edit mode, and modify the vivado path to the vivado installation path of this host, save and close.
```
CALL E:\XilinxVitis\Vivado\2023.1\bin\vivado.bat -mode batch -source create_project.tcl
PAUSE
```
2. Double-click the bat file under Windows.


For more information, please visit [ALINX website](https://www.alinx.com)