///*
// * ECE385-HelperTools/PNG-To-Txt
// * Author: Rishi Thakkar
// *
// */
//
//module  frameRAM
//(
//		input [18:0] read_address,
//		input Clk,
//
//		output logic [23:0] data_Out
//);
//// mem has width of 24 bits and a total of 400 addresses
//logic [23:0] mem [0:63];
//initial
//begin
//	 $readmemh("1111.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
// if(read_address>=19'd0 && read_address<=19'd63) begin
//	data_Out<= mem[read_address]; end
//	else begin   data_Out<=24'b000;  end
//end
//
//endmodule
//
//module  frameRAMa
//(
//		input [18:0] read_address,
//		input Clk,
//
//		output logic [23:0] data_Out
//);
//
//// mem has width of 24 bits and a total of 400 addresses
//logic [23:0] mem [0:63];
//
//initial
//begin
//	 $readmemh("2222.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
// if(read_address>=19'd0 && read_address<=19'd63) begin
//	data_Out<= mem[read_address]; end
//	else begin   data_Out<=24'b000;  end
//end
//
//endmodule
//
//module  frameRAMb
//(
//		input [18:0] read_address,
//		input Clk,
//
//		output logic [23:0] data_Out
//);
//
//// mem has width of 24 bits and a total of 400 addresses
//logic [23:0] mem [0:63];
//
//initial
//begin
//	 $readmemh("3333.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
// if(read_address>=19'd0 && read_address<=19'd63) begin
//	data_Out<= mem[read_address]; end
//	else begin   data_Out<=24'b000;  end
//end
//
//endmodule
//
//module  frameRAMc
//(
//		input [18:0] read_address,
//		input Clk,
//
//		output logic [23:0] data_Out
//);
//
//// mem has width of 24 bits and a total of 400 addresses
//logic [23:0] mem [0:63];
//
//initial
//begin
//	 $readmemh("4444.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
// if(read_address>=19'd0 && read_address<=19'd63) begin
//	data_Out<= mem[read_address]; end
//	else begin   data_Out<=24'b000;  end
//end
//
//endmodule
//
//module  frameRAMd
//(
//		input [18:0] read_address,
//		input Clk,
//
//		output logic [23:0] data_Out
//);
//
//// mem has width of 24 bits and a total of 400 addresses
//logic [23:0] mem [0:63];
//
//initial
//begin
//	 $readmemh("5555.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
// if(read_address>=19'd0 && read_address<=19'd63) begin
//	data_Out<= mem[read_address]; end
//	else begin   data_Out<=24'b000;  end
//end
//
//endmodule
//
//module  frameRAMghost
//(
//		input [18:0] read_address,
//		input Clk,
//
//		output logic [23:0] data_Out
//);
//
//// mem has width of 24 bits and a total of 400 addresses
//logic [23:0] mem [0:63];
//
//initial
//begin
//	 $readmemh("redghost.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
// if(read_address>=19'd0 && read_address<=19'd63) begin
//	data_Out<= mem[read_address]; end
//	else begin   data_Out<=24'b000;  end
//end
//
//endmodule