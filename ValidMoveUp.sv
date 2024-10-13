module ValidMoveUp (input [9:0]  BallX, BallY,
						output Up);
	 logic [9:0] wall_addr;
	 logic [639:0] wall_data;
	 logic Up1,Up2,Up3,Up4,Up5,Up6,Up7,Up8,Up9,Up10,Up11,Up12,Up13,Up14,Up15,Up16;
always_comb
	begin	 
	 wall_addr = BallY-1;
	 Up1 = wall_data[BallX];
	 Up2 = wall_data[BallX+1];
	 Up3 = wall_data[BallX+2];
	 Up4 = wall_data[BallX+3];
	 Up5 = wall_data[BallX+4];
	 Up6 = wall_data[BallX+5];
	 Up7 = wall_data[BallX+6];
	 Up8 = wall_data[BallX+7];
	 Up9 = wall_data[BallX+8];
	 Up10 = wall_data[BallX+9];
	 Up11 = wall_data[BallX+10];
	 Up12 = wall_data[BallX+11];
	 Up13 = wall_data[BallX+12];
	 Up14 = wall_data[BallX+13];
	 Up15 = wall_data[BallX+14];
	 Up16 = wall_data[BallX+15];
	 if ( Up1 || Up2 || Up3 || Up4 || Up5|| Up6 || Up7 || Up8 || Up9 || Up10 || Up11|| Up12 || Up13 || Up14 || Up15 ||Up16) 
		begin
			Up = 1;
		end
	else
		begin
			Up = 0;
		end
	end
	 wall_rom wall(.addr(wall_addr), .data(wall_data));
endmodule