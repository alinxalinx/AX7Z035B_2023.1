//camera中寄存器的配置程序
 module reg_config(     
		  input clk_25M,
		  input camera_rstn,
		  input initial_en,
		  output reg strobe_flash,
		  output reg_conf_done,
		  output i2c_sclk,
		  inout i2c_sdat,
		  output reg clock_20k,
		  output reg [8:0]reg_index,
		  input key1
	  );

    
     
     reg [15:0]clock_20k_cnt;
     reg [1:0]config_step;
	  
     reg [31:0]i2c_data;
     reg [23:0]reg_data;
     reg start;
	  reg reg_conf_done_reg;
     reg [15:0] on_counter;
	  reg [15:0] off_counter;
	  reg key_on, key_off;
	  
     i2c_com u1(.clock_i2c(clock_20k),
               .camera_rstn(camera_rstn),
               .ack(ack),
               .i2c_data(i2c_data),
               .start(start),
               .tr_end(tr_end),
               .i2c_sclk(i2c_sclk),
               .i2c_sdat(i2c_sdat));

assign reg_conf_done=reg_conf_done_reg;
//产生i2c控制时钟-20khz   
always@(posedge clk_25M or negedge camera_rstn)   
begin
   if(!camera_rstn) begin
        clock_20k<=0;
        clock_20k_cnt<=0;
   end
   else if(clock_20k_cnt<1249)
      clock_20k_cnt<=clock_20k_cnt+1'b1;
   else begin
         clock_20k<=!clock_20k;
         clock_20k_cnt<=0;
   end
end

//按钮处理程序	
always @(posedge clock_20k or negedge camera_rstn)
   if (!camera_rstn) begin
	    on_counter<=0;
       off_counter<=0;	
		 key_on<=1'b0;
		 key_off<=1'b0;
	  end
	else begin
	    if (key1==1'b1)                               //如果按钮没有按下，寄存器为0
	       on_counter<=0;
	    else if ((key1==1'b0)& (on_counter<=16'h00c8))        //如果按钮按下并按下时间少于10ms,计数      
          on_counter<=on_counter+1'b1;
  	  
       if (on_counter==16'h00c7)                 //一次按钮有效，改变显示模式 
			   key_on<=1'b1;
		 else
			   key_on<=1'b0;
				
	    if (key1==1'b0)                               //如果按钮没有释放，寄存器为0
	       off_counter<=0;
	    else if ((key1==1'b1)& (off_counter<=16'h00c8))        //如果按钮释放并时间少于10ms,计数      
          off_counter<=off_counter+1'b1;
  	  
       if (off_counter==16'h00c7)                 //一次按钮有效，改变显示模式 
			   key_off<=1'b1;
		 else
			   key_off<=1'b0;				
				
     end 


////iic寄存器配置过程控制    
always@(posedge clock_20k or negedge camera_rstn)    
begin
   if(!camera_rstn) begin
       config_step<=0;
       start<=0;
       reg_index<=0;
		 reg_conf_done_reg<=0;
		 strobe_flash<=1'b0;
   end
   else if(!initial_en)begin
       config_step<=0;
       start<=0;
       reg_index<=0;
		 reg_conf_done_reg<=0;
		 strobe_flash<=1'b0;
   end
   
   else begin
      if(reg_conf_done_reg==1'b0) begin          //如果camera初始化未完成
			  if(reg_index<250) begin
					 case(config_step)
					 0:begin
						i2c_data<={8'h78,reg_data};       //IIC Device address is 0x78   
						start<=1;
						config_step<=1;
					 end
					 1:begin
						if(tr_end) begin                       //IIC发送结束               					
							 start<=0;
							 config_step<=2;
						end
					 end
					 2:begin
						  reg_index<=reg_index+1'b1;
						  config_step<=0;
					 end
					 endcase
				end
			 else 
				reg_conf_done_reg<=1'b1;
      end
      else begin                                    //如果camera初始化已完成
	       case(config_step)
             0:begin
				 	if(key_on==1'b1) begin                //按键按下,配置寄存器使得闪光灯亮
						config_step<=1;
						reg_index<=302;                    //从第300开始写寄存器
						strobe_flash<=1'b1;
					end
					else if (key_off==1'b1) begin         //按键松开,配置寄存器使得闪光灯灭
						config_step<=1;
						reg_index<=303;                    //从第304开始写寄存器
						strobe_flash<=1'b0;
					end
             end					
             1:begin			
						i2c_data<={8'h78,reg_data};       //IIC Device address is 0x78   
						start<=1;						
						config_step<=2;
             end
             2:begin
               if(tr_end) begin                       //IIC发送结束               					
					    start<=0;
                   config_step<=3;
               end
             end
             3:begin
                config_step<=0;
					 reg_index<=300;	  
             end
             endcase
		 end
   end
 end
			
////iic需要配置的寄存器值  			
always@(reg_index)   
 begin
    case(reg_index)
	 //15fps VGA YUV output  // 24MHz input clock, 24MHz PCLK
	// 0:reg_data<=24'h310311;// system clock from pad, bit[1]
	// 1:reg_data<=24'h300882;// software reset, bit[7]// delay 5ms 
	// 2:reg_data<=24'h300842;// software power down, bit[6]
	 0:reg_data<=24'h310303;// system clock from pad, bit[1]
	 1:reg_data<=24'h3017ff;// FREX, Vsync, HREF, PCLK, D[9:6] output enable
	 2:reg_data<=24'h3018ff;// D[5:0], GPIO[1:0] output enable
	 3:reg_data<=24'h30341A;// MIPI 10-bit
	 4:reg_data<=24'h303511;//
	 5:reg_data<=24'h303669;//  
	 6:reg_data<=24'h303713;// PLL root divider, bit[4], PLL pre-divider, bit[3:0]
	 7:reg_data<=24'h310801;// PCLK root divider, bit[5:4], SCLK2x root divider, bit[3:2] // SCLK root divider, bit[1:0] 
	 8:reg_data<=24'h363036;
	 9:reg_data<=24'h36310e;
	 10:reg_data<=24'h3632e2;
	 11:reg_data<=24'h363312;
	 12:reg_data<=24'h3621e0;
	 13:reg_data<=24'h3704a0;
	 14:reg_data<=24'h37035a;
	 15:reg_data<=24'h371578;
	 16:reg_data<=24'h371701;
	 17:reg_data<=24'h370b60;
	 18:reg_data<=24'h37051a;
	 19:reg_data<=24'h390502;
	 20:reg_data<=24'h390610;
	 21:reg_data<=24'h39010a;
	 22:reg_data<=24'h373112;
	 23:reg_data<=24'h360008;// VCM control
	 24:reg_data<=24'h360133;// VCM control
	 25:reg_data<=24'h302d60;// system control
	 26:reg_data<=24'h362052;
	 27:reg_data<=24'h371b20;
	 28:reg_data<=24'h471c50;
	 29:reg_data<=24'h3a1343;// pre-gain = 1.047x
	 30:reg_data<=24'h3a1800;// gain ceiling
	 31:reg_data<=24'h3a19f8;// gain ceiling = 15.5x
	 32:reg_data<=24'h363513;
	 33:reg_data<=24'h363603;
	 34:reg_data<=24'h363440;
	 35:reg_data<=24'h362201; // 50/60Hz detection     50/60Hz 灯光条纹过滤
	 36:reg_data<=24'h3c0134;// Band auto, bit[7]
	 37:reg_data<=24'h3c0428;// threshold low sum	 
	 38:reg_data<=24'h3c0598;// threshold high sum
	 39:reg_data<=24'h3c0600;// light meter 1 threshold[15:8]
	 40:reg_data<=24'h3c0707;// light meter 1 threshold[7:0]
	 41:reg_data<=24'h3c0800;// light meter 2 threshold[15:8]
	 42:reg_data<=24'h3c091c;// light meter 2 threshold[7:0]
	 43:reg_data<=24'h3c0a9c;// sample number[15:8]
	 44:reg_data<=24'h3c0b40;// sample number[7:0]
	 45:reg_data<=24'h382043;// Sensor flip off, ISP flip on
	 46:reg_data<=24'h382101;// Sensor mirror on, ISP mirror on, H binning on
	 47:reg_data<=24'h381411;// X INC 
	 48:reg_data<=24'h381511;// Y INC
	 49:reg_data<=24'h380001;// HS: X address start high byte
	 50:reg_data<=24'h380150;// HS: X address start low byte
	 51:reg_data<=24'h380201;// VS: Y address start high byte
	 52:reg_data<=24'h3803b2;// VS: Y address start high byte 
	 53:reg_data<=24'h380408;// HW (HE)         
	 54:reg_data<=24'h3805ef;// HW (HE)
	 55:reg_data<=24'h380605;// VH (VE)         
	 56:reg_data<=24'h3807f2;// VH (VE)      
	 57:reg_data<=24'h380807;// DVPHO  
	 58:reg_data<=24'h380980;// DVPHO
	 59:reg_data<=24'h380a04;// DVPVO
	 60:reg_data<=24'h380b38;// DVPVO
	 61:reg_data<=24'h380c09;// HTS           
	 62:reg_data<=24'h380dc4;// HTS
	 63:reg_data<=24'h380e04;// VTS           
	 64:reg_data<=24'h380f60;// VTS 
	 65:reg_data<=24'h381000;// Timing Hoffset[11:8]
	 66:reg_data<=24'h381110;// Timing Hoffset[7:0]
	 67:reg_data<=24'h381200;// Timing Voffset[10:8] 
	 68:reg_data<=24'h381304;// Timing Voffset 	 
	 69:reg_data<=24'h361804;
	 70:reg_data<=24'h36122b;
	 71:reg_data<=24'h370862;	 
	 72:reg_data<=24'h370912;
	 73:reg_data<=24'h370c00; 
	 74:reg_data<=24'h3a0204;// 60Hz max exposure, night mode 5fps
	 75:reg_data<=24'h3a0360;// 60Hz max exposure // banding filters are calculated automatically in camera driver
	 76:reg_data<=24'h3a0801; // B50 step
	 77:reg_data<=24'h3a0950; // B50 step
	 78:reg_data<=24'h3a0a01; // B60 step
	 79:reg_data<=24'h3a0b18; // B60 step
	 80:reg_data<=24'h3a0e03; // 50Hz max band
	 81:reg_data<=24'h3a0d04; // 60Hz max band
	 82:reg_data<=24'h3a1404; // 50Hz max exposure
	 83:reg_data<=24'h3a1560; // 50Hz max exposure
	 84:reg_data<=24'h400102;// BLC start from line 2
	 85:reg_data<=24'h400406;// BLC 2 lines 
	 86:reg_data<=24'h300000;// enable blocks
	 87:reg_data<=24'h30021c;// reset JFIFO, SFIFO, JPEG
	 88:reg_data<=24'h3004ff;// enable clocks 	 
	 89:reg_data<=24'h3006c3;// disable clock of JPEG2x, JPEG	
	 90:reg_data<=24'h300e58;// MIPI power down, DVP enable
	 91:reg_data<=24'h302e00;
	 92:reg_data<=24'h430030;// YUV422
	 93:reg_data<=24'h501f00;// ISP YUV422 
	 94:reg_data<=24'h471302;// JPEG mode 3
	 95:reg_data<=24'h440704;// Quantization scale 
	 96:reg_data<=24'h440e00;
	 97:reg_data<=24'h460b37;
	 98:reg_data<=24'h460c20;
	 99:reg_data<=24'h382404; // DVP CLK divider 
	 100:reg_data<=24'h5000a7; // Lenc on, raw gamma on, BPC on, WPC on, CIP on // AEC target    自动曝光控制
	 101:reg_data<=24'h5001a3; // SDE on, scale on, UV average off, color matrix on, AWB on	
	 102:reg_data<=24'h5180ff;// AWB B block
	 103:reg_data<=24'h5181f2;// AWB control 
	 104:reg_data<=24'h518200;// [7:4] max local counter, [3:0] max fast counter
	 105:reg_data<=24'h518314;// AWB advanced 
	 106:reg_data<=24'h518425;
	 107:reg_data<=24'h518524;
	 108:reg_data<=24'h518609;
	 109:reg_data<=24'h518709;
	 110:reg_data<=24'h518809;
	 111:reg_data<=24'h518975;
	 112:reg_data<=24'h518a54;
	 113:reg_data<=24'h518be0;
	 114:reg_data<=24'h518cb2;
	 115:reg_data<=24'h518d42;
	 116:reg_data<=24'h518e3d;
	 117:reg_data<=24'h518f56;
	 118:reg_data<=24'h519046;
	 119:reg_data<=24'h5191f8;// AWB top limit
	 120:reg_data<=24'h519204;// AWB bottom limit
	 121:reg_data<=24'h519370;// red limit
	 122:reg_data<=24'h5194f0;// green limit
	 123:reg_data<=24'h5195f0;// blue limit
	 124:reg_data<=24'h519603;// AWB control
	 125:reg_data<=24'h519701;// local limit 
	 126:reg_data<=24'h519804;
	 127:reg_data<=24'h519912;
	 128:reg_data<=24'h519a04;
	 129:reg_data<=24'h519b00;
	 130:reg_data<=24'h519c06;
	 131:reg_data<=24'h519d82;
	 132:reg_data<=24'h519e38;// AWB control // Gamma    伽玛曲线
	 133:reg_data<=24'h53811e;// CMX1 for Y
	 134:reg_data<=24'h53825b;// CMX2 for Y
	 135:reg_data<=24'h538308;// CMX3 for Y
	 136:reg_data<=24'h53840a;// CMX4 for U
	 137:reg_data<=24'h53857e;// CMX5 for U
	 138:reg_data<=24'h538688;// CMX6 for U
	 139:reg_data<=24'h53877c;// CMX7 for V
	 140:reg_data<=24'h53886c;// CMX8 for V
	 141:reg_data<=24'h538910;// CMX9 for V
	 142:reg_data<=24'h538a01;// sign[9]
	 143:reg_data<=24'h538b98; // sign[8:1] // UV adjust   UV色彩饱和度调整
	 144:reg_data<=24'h530008;// CIP sharpen MT threshold 1
	 145:reg_data<=24'h530130;// CIP sharpen MT threshold 2
	 146:reg_data<=24'h530210;// CIP sharpen MT offset 1
	 147:reg_data<=24'h530300;// CIP sharpen MT offset 2
	 148:reg_data<=24'h530408;// CIP DNS threshold 1
	 149:reg_data<=24'h530530;// CIP DNS threshold 2
	 150:reg_data<=24'h530608;// CIP DNS offset 1
	 151:reg_data<=24'h530716;// CIP DNS offset 2 
	 152:reg_data<=24'h530908;// CIP sharpen TH threshold 1
	 153:reg_data<=24'h530a30;// CIP sharpen TH threshold 2
	 154:reg_data<=24'h530b04;// CIP sharpen TH offset 1
	 155:reg_data<=24'h530c06;// CIP sharpen TH offset 2
	 156:reg_data<=24'h548001;// Gamma bias plus on, bit[0] 
	 157:reg_data<=24'h548108;
	 158:reg_data<=24'h548214;
	 159:reg_data<=24'h548328;
	 160:reg_data<=24'h548451;
	 161:reg_data<=24'h548565;
	 162:reg_data<=24'h548671;
	 163:reg_data<=24'h54877d;
	 164:reg_data<=24'h548887;
	 165:reg_data<=24'h548991;
	 166:reg_data<=24'h548a9a;
	 167:reg_data<=24'h548baa;
	 168:reg_data<=24'h548cb8;
	 169:reg_data<=24'h548dcd;
	 170:reg_data<=24'h548edd;
	 171:reg_data<=24'h548fea;
	 172:reg_data<=24'h54901d;// color matrix   色彩矩阵
	 173:reg_data<=24'h558002;// saturation on, bit[1]
	 174:reg_data<=24'h558340;
	 175:reg_data<=24'h558410;
	 176:reg_data<=24'h558910;
	 177:reg_data<=24'h558a00;
	 178:reg_data<=24'h558bf8;
	 179:reg_data<=24'h580023;
	 180:reg_data<=24'h580114;
	 181:reg_data<=24'h58020f;
	 182:reg_data<=24'h58030f;
	 183:reg_data<=24'h580412;
	 184:reg_data<=24'h580526;
	 185:reg_data<=24'h58060c;
	 186:reg_data<=24'h580708;
	 187:reg_data<=24'h580805;
	 188:reg_data<=24'h580905;
	 189:reg_data<=24'h580a08;
	 190:reg_data<=24'h580b0d;
	 191:reg_data<=24'h580c08;
	 192:reg_data<=24'h580d03;
	 193:reg_data<=24'h580e00;
	 194:reg_data<=24'h580f00;
	 195:reg_data<=24'h581003;
	 196:reg_data<=24'h581109;
	 197:reg_data<=24'h581207;
	 198:reg_data<=24'h581303;
	 199:reg_data<=24'h581400;
	 200:reg_data<=24'h581501;
	 201:reg_data<=24'h581603;
	 202:reg_data<=24'h581708;
	 203:reg_data<=24'h58180d;
	 204:reg_data<=24'h581908;
	 205:reg_data<=24'h581a05;
	 206:reg_data<=24'h581b06;
	 207:reg_data<=24'h581c08;
	 208:reg_data<=24'h581d0e;
	 209:reg_data<=24'h581e29;
	 210:reg_data<=24'h581f17;
	 211:reg_data<=24'h582011;
	 212:reg_data<=24'h582111;
	 213:reg_data<=24'h582215;
	 214:reg_data<=24'h582328;
	 215:reg_data<=24'h582446;
	 216:reg_data<=24'h582526;
	 217:reg_data<=24'h582608;
	 218:reg_data<=24'h582726;
	 219:reg_data<=24'h582864;
	 220:reg_data<=24'h582926;
	 221:reg_data<=24'h582a24;
	 222:reg_data<=24'h582b22;
	 223:reg_data<=24'h582c24;
	 224:reg_data<=24'h582d24;
	 225:reg_data<=24'h582e06;
	 226:reg_data<=24'h582f22;
	 227:reg_data<=24'h583040;
	 228:reg_data<=24'h583142;
	 229:reg_data<=24'h583224;
	 230:reg_data<=24'h583326;
	 231:reg_data<=24'h583424;
	 232:reg_data<=24'h583522;
	 233:reg_data<=24'h583622;
	 234:reg_data<=24'h583726;
	 235:reg_data<=24'h583844;
	 236:reg_data<=24'h583924;
	 237:reg_data<=24'h583a26;
	 238:reg_data<=24'h583b28;
	 239:reg_data<=24'h583c42;
	 240:reg_data<=24'h583dce;// lenc BR offset // AWB   自动白平衡
	 241:reg_data<=24'h502500;
 	 242:reg_data<=24'h3a0f30;// stable range in high
	 243:reg_data<=24'h3a1028;// stable range in low
	 244:reg_data<=24'h3a1b30;// stable range out high
	 245:reg_data<=24'h3a1e26;// stable range out low
	 246:reg_data<=24'h3a1160;// fast zone high
	 247:reg_data<=24'h3a1f14;// fast zone low// Lens correction for ?   镜头补偿
	 248:reg_data<=24'h300802; // wake up from standby, bit[6]
	 249:reg_data<=24'h303521;// enable manual offset of contrast// CIP  锐化和降噪 


	 default:reg_data<=24'h000000;
    endcase      
end	 



endmodule

