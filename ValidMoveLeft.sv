module ValidMoveLeft (input [9:0]  BallX, BallY,
						output Left);
	 logic [9:0] wall_addr1,wall_addr2,wall_addr3,wall_addr4,wall_addr5,wall_addr6,wall_addr7,wall_addr8,wall_addr9,
	 wall_addr10,wall_addr11,wall_addr12,wall_addr13,wall_addr14,wall_addr15,wall_addr16;
	 logic [639:0] wall_data1,wall_data2,wall_data3,wall_data4,wall_data5,wall_data6,wall_data7,wall_data8,wall_data9,
	 wall_data10,wall_data11,wall_data12,wall_data13,wall_data14,wall_data15,wall_data16;
	 logic Left1,Left2,Left3,Left4,Left5,Left6,Left7,Left8,Left9,Left10,Left11,Left12,Left13,Left14,Left15,Left16;
always_comb
	begin	 
	 wall_addr1 = BallY;
	 wall_addr2 = BallY+1;
	 wall_addr3 = BallY+2;
	 wall_addr4 = BallY+3;
	 wall_addr5 = BallY+4;
	 wall_addr6 = BallY+5;
	 wall_addr7 = BallY+6;
	 wall_addr8 = BallY+7;
	 wall_addr9 = BallY+8;
	 wall_addr10 = BallY+9;
	 wall_addr11 = BallY+10;
	 wall_addr12 = BallY+11;
	 wall_addr13 = BallY+12;
	 wall_addr14 = BallY+13;
	 wall_addr15 = BallY+14;
	 wall_addr16 = BallY+15;
	 Left1 = wall_data1[BallX-1];
	 Left2 = wall_data2[BallX-1];
	 Left3 = wall_data3[BallX-1];
	 Left4 = wall_data4[BallX-1];
	 Left5 = wall_data5[BallX-1];
	 Left6 = wall_data6[BallX-1];
	 Left7 = wall_data7[BallX-1];
	 Left8 = wall_data8[BallX-1];
	 Left9 = wall_data9[BallX-1];
	 Left10 = wall_data10[BallX-1];
	 Left11 = wall_data11[BallX-1];
	 Left12 = wall_data12[BallX-1];
	 Left13 = wall_data13[BallX-1];
	 Left14 = wall_data14[BallX-1];
	 Left15 = wall_data15[BallX-1];
	 Left16 = wall_data16[BallX-1];

	 if ( Left1 || Left2 || Left3 || Left4 || Left5 || Left6 || Left7 || Left8 || Left9 || Left10 || Left11 || Left12 || Left13 || Left14 || Left15 || Left16) 
		begin
			Left = 1;
		end
	else
		begin
			Left = 0;
		end
	end
	 wall_rom wall1(.addr(wall_addr1), .data(wall_data1));
	 wall_rom wall2(.addr(wall_addr2), .data(wall_data2));
	 wall_rom wall3(.addr(wall_addr3), .data(wall_data3));
	 wall_rom wall4(.addr(wall_addr4), .data(wall_data4));
	 wall_rom wall5(.addr(wall_addr5), .data(wall_data5));
	 wall_rom wall6(.addr(wall_addr6), .data(wall_data6));
	 wall_rom wall7(.addr(wall_addr7), .data(wall_data7));
	 wall_rom wall8(.addr(wall_addr8), .data(wall_data8));
	 wall_rom wall9(.addr(wall_addr9), .data(wall_data9));
	 wall_rom wall10(.addr(wall_addr10), .data(wall_data10));
	 wall_rom wall11(.addr(wall_addr11), .data(wall_data11));
	 wall_rom wall12(.addr(wall_addr12), .data(wall_data12));
	 wall_rom wall13(.addr(wall_addr13), .data(wall_data13));
	 wall_rom wall14(.addr(wall_addr14), .data(wall_data14));
	 wall_rom wall15(.addr(wall_addr15), .data(wall_data15));
	 wall_rom wall16(.addr(wall_addr16), .data(wall_data16));
endmodule