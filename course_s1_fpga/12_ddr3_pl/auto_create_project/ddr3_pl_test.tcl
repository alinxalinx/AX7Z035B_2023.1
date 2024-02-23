#////////////////////////////////////////////////////////////////////////////////
#  project：ddr3_pl_test                                                       //
#                                                                              //
#  Author: JunFN                                                               //
#          853808728@qq.com                                                    //
#          ALINX(shanghai) Technology Co.,Ltd                                  //
#          黑金                                                                //
#     WEB: http://www.alinx.cn/                                                //
#                                                                              //
#////////////////////////////////////////////////////////////////////////////////
#                                                                              //
# Copyright (c) 2017,ALINX(shanghai) Technology Co.,Ltd                        //
#                    All rights reserved                                       //
#                                                                              //
# This source file may be used and distributed without restriction provided    //
# that this copyright statement is not removed from the file and that any      //
# derivative work contains the original copyright notice and the associated    //
# disclaimer.                                                                  //
#                                                                              // 
#////////////////////////////////////////////////////////////////////////////////

#================================================================================
#  Revision History:
#  Date          By            Revision    Change Description
# --------------------------------------------------------------------------------
#  2023/8/22                   1.0          Original
#=================================================================================

#设置项目名称和工作目录
set projname "ddr3_pl_test"
set Topname "top"
set tclpath [pwd]
cd ..
set projpath [pwd]
#创建工程
#**********************************************************************************************************
create_project -force $projname $projpath/$projname -part xc7z035ffg676-2
# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}
file mkdir $projpath/$projname/$projname.srcs/sources_1/ip
file mkdir $projpath/$projname/$projname.srcs/sources_1/new
file mkdir $projpath/$projname/$projname.srcs/sources_1/bd
# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}
file mkdir $projpath/$projname/$projname.srcs/constrs_1/new
# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}
file mkdir $projpath/$projname/$projname.srcs/sim_1/new
#添加IP
#以下CONFIG.XML_INPUT_FILE添加你的mig.prj配置文件路径。
create_ip -name mig_7series -vendor xilinx.com -library ip -version 4.2 -module_name ddr3
set_property -dict [list \
  CONFIG.ARESETN.INSERT_VIP {0} \
  CONFIG.BOARD_MIG_PARAM {Custom} \
  CONFIG.C0_ARESETN.INSERT_VIP {0} \
  CONFIG.C0_CLOCK.INSERT_VIP {0} \
  CONFIG.C0_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C0_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C0_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C0_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C0_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C0_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C0_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C0_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C0_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C0_RESET.INSERT_VIP {0} \
  CONFIG.C0_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C0_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C0_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C1_ARESETN.INSERT_VIP {0} \
  CONFIG.C1_CLOCK.INSERT_VIP {0} \
  CONFIG.C1_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C1_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C1_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C1_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C1_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C1_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C1_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C1_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C1_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C1_RESET.INSERT_VIP {0} \
  CONFIG.C1_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C1_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C1_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C2_ARESETN.INSERT_VIP {0} \
  CONFIG.C2_CLOCK.INSERT_VIP {0} \
  CONFIG.C2_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C2_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C2_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C2_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C2_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C2_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C2_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C2_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C2_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C2_RESET.INSERT_VIP {0} \
  CONFIG.C2_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C2_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C2_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C3_ARESETN.INSERT_VIP {0} \
  CONFIG.C3_CLOCK.INSERT_VIP {0} \
  CONFIG.C3_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C3_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C3_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C3_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C3_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C3_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C3_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C3_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C3_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C3_RESET.INSERT_VIP {0} \
  CONFIG.C3_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C3_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C3_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C4_ARESETN.INSERT_VIP {0} \
  CONFIG.C4_CLOCK.INSERT_VIP {0} \
  CONFIG.C4_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C4_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C4_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C4_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C4_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C4_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C4_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C4_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C4_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C4_RESET.INSERT_VIP {0} \
  CONFIG.C4_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C4_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C4_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C5_ARESETN.INSERT_VIP {0} \
  CONFIG.C5_CLOCK.INSERT_VIP {0} \
  CONFIG.C5_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C5_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C5_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C5_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C5_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C5_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C5_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C5_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C5_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C5_RESET.INSERT_VIP {0} \
  CONFIG.C5_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C5_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C5_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C6_ARESETN.INSERT_VIP {0} \
  CONFIG.C6_CLOCK.INSERT_VIP {0} \
  CONFIG.C6_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C6_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C6_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C6_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C6_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C6_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C6_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C6_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C6_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C6_RESET.INSERT_VIP {0} \
  CONFIG.C6_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C6_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C6_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C7_ARESETN.INSERT_VIP {0} \
  CONFIG.C7_CLOCK.INSERT_VIP {0} \
  CONFIG.C7_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C7_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C7_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C7_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C7_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C7_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C7_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C7_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C7_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C7_RESET.INSERT_VIP {0} \
  CONFIG.C7_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C7_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C7_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.CLK_REF_I.INSERT_VIP {0} \
  CONFIG.CLOCK.INSERT_VIP {0} \
  CONFIG.DDR2_RESET.INSERT_VIP {0} \
  CONFIG.DDR3_RESET.INSERT_VIP {0} \
  CONFIG.LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.MIG_DONT_TOUCH_PARAM {Custom} \
  CONFIG.MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.RESET.INSERT_VIP {0} \
  CONFIG.RESET_BOARD_INTERFACE {Custom} \
  CONFIG.RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.RLDII_RESET.INSERT_VIP {0} \
  CONFIG.S0_AXI.INSERT_VIP {0} \
  CONFIG.S0_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S1_AXI.INSERT_VIP {0} \
  CONFIG.S1_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S2_AXI.INSERT_VIP {0} \
  CONFIG.S2_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S3_AXI.INSERT_VIP {0} \
  CONFIG.S3_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S4_AXI.INSERT_VIP {0} \
  CONFIG.S4_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S5_AXI.INSERT_VIP {0} \
  CONFIG.S5_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S6_AXI.INSERT_VIP {0} \
  CONFIG.S6_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S7_AXI.INSERT_VIP {0} \
  CONFIG.S7_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.SYSTEM_RESET.INSERT_VIP {0} \
  CONFIG.SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.S_AXI.INSERT_VIP {0} \
  CONFIG.S_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.XML_INPUT_FILE $projpath/mig.prj \
] [get_ips ddr3]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/ddr3/ddr3.xci]
#C:/Users/Administrator/Desktop/vivado_2023.1/AX7035B_2023.1/course_s1_fpga/12_ddr3_pl/auto_create_project
#*********************************************************************************************************
#添加源文件
add_files -fileset sources_1  -copy_to $projpath/$projname/$projname.srcs/sources_1/new -force -quiet [glob -nocomplain $tclpath/src/design/*.v]
#添加约束文件
add_files -fileset constrs_1  -copy_to $projpath/$projname/$projname.srcs/constrs_1/new -force -quiet [glob -nocomplain $tclpath/src/constraints/*.xdc]
#**********************************************************************************************************
set_property top_file "/$projpath/$projname/$projname.srcs/sources_1/new/$Topname.v" [current_fileset]
launch_runs synth_1 impl_1 -jobs 5
wait_on_run synth_1
wait_on_run impl_1
synth_design -top $Topname
opt_design
place_design
route_design
write_bitstream -force $projpath/$projname/$projname.runs/impl_1/$projname.bit
write_debug_probes -file $projpath/$projname/$projname.runs/impl_1/$projname.ltx
add_files -fileset sources_1  -copy_to $projpath -force -quiet [glob -nocomplain $projpath/$projname/$projname.runs/impl_1/*.bit]
add_files -fileset sources_1  -copy_to $projpath -force -quiet [glob -nocomplain $projpath/$projname/$projname.runs/impl_1/*.ltx]
