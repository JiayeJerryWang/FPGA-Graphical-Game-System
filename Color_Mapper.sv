//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input frame_clk,Reset,
							  input [9:0] GhostX, GhostY, Ghost1X, Ghost1Y,GhostS,Ghost1S,
							  input [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
							  input [9:0] ymotion, xmotion,
							  input start,drawwall, endgame, drawpacman,drawghost, drawghost1,drawdot,
							  input ball_on, ghost1_on,
							  output died,
                       output logic [7:0]  Red, Green, Blue );
    
    logic dot_on,wall_on, ghost_on;//,ghost1_on;
	 logic [6:0] address_pac;
	 logic [5:0] address_ghost,address_ghost1, address_dot, address_died,address_start;
	 logic [8:0] address_score;
	 logic [15:0] pac_color,ghost_color,ghost1_color, dot_color,score_color;
	 logic [39:0] died_on,start_on;
	 logic [7:0] dotRed, dotGreen, dotBlue;  
    int DistX, DistY, Size, GhostSize;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
	 assign GhostSize = GhostS;
	 assign Ghost1Size = Ghost1S;
	 logic position[30][40];
	 initial
	 begin
			for(int i = 0; i < 30; i++) 
				for (int j = 0; j < 40; j++)
					position[i][j] <= rom[i][j];
	 end
	 always_ff @ (posedge frame_clk or posedge Reset) 
	 begin
		if(Reset) begin
			for(int i = 0; i < 30; i++) 
				for (int j = 0; j < 40; j++)
					position[i][j] <= rom[i][j];
		end
		else begin
			position[BallY[9:4]][BallX[9:4]] <= 1'b1;
		end
	 end
	 always_ff @ (posedge frame_clk)
	begin	
		if((BallX >= Ghost1X - 8) && (BallX <= Ghost1X + 8) && (BallY >= Ghost1Y - 8) && (BallY <= Ghost1Y + 8))
			begin
			died <= 1'b1;
			end
		
		else if((BallX >= GhostX - 8) && (BallX <= GhostX + 8) && (BallY >= GhostY - 8) && (BallY <= GhostY + 8))
			begin
			died <= 1'b1;
			end
		else if(Reset)
			begin
			died <= 1'b0;
			end
		else
			begin
			died <= 1'b0;
			end
		
	 end
	 always_comb
	 begin
				address_ghost = (DrawY -GhostY);
				address_ghost1 = (DrawY -Ghost1Y);
				address_dot = DrawY % 16 ;
				address_died = DrawY[9:4];
				address_start = DrawY[9:4];
				if(ymotion > 10'd10) begin //up
					address_pac = (DrawY - BallY + 48);
				end	
				else if (ymotion == 10'b1)   begin //down
					address_pac = (DrawY - BallY + 64);
				end	
				else if (xmotion > 10'd10 )   begin //left
					address_pac = (DrawY - BallY);
				end	
				else if (xmotion== 10'b1)   begin //right
					address_pac =	(DrawY - BallY + 80);
				end	
				else begin
					address_pac =  (DrawY - BallY+16);
				end
	 end
	 always_comb
	 begin:Ghost_on_proc
        if (DrawX >= GhostX && DrawX <  GhostX + GhostSize && DrawY >= GhostY && DrawY < GhostY + GhostSize)
            ghost_on = 1'b1;
        else 
            ghost_on = 1'b0;
    end
      
    always_comb
    begin:RGB_Display	
		  if ((ball_on == 1'b1) && pac_color[DrawX - BallX] == 1'b1 && drawpacman)  
		  begin
				Red = 8'hff;
				Green = 8'hee;
				Blue = 8'h00;
		  end
		  else if ((ghost1_on == 1'b1) && ghost1_color[DrawX - Ghost1X] == 1'b1 && drawghost1)
		  begin 
				Red = 8'hee; 
				Green = 8'hee;
				Blue = 8'hee;
		  end		  
		  else if ((wall_on == 1'b1) && drawwall)
		  begin 
				Red = 8'h00; 
				Green = 8'h00;
				Blue = 8'h7f;
		  end
		  else if ((position[DrawY[9:4]][DrawX[9:4]] == 1'b0) && dot_color[DrawX % 16] && drawdot)
		  begin
				Red = 8'hff; 
				Green = 8'hff;
				Blue = 8'hff;
		  end
		  else if ((ghost_on == 1'b1) && ghost_color[DrawX - GhostX] == 1'b1 && drawghost)
		  begin 
				Red = 8'hff; 
				Green = 8'h00;
				Blue = 8'h00;
		  end
		  
		  else if ((died_on[40 - DrawX[9:4]] == 1'b1) && endgame)
		  begin 
				Red = 8'hff; 
				Green = 8'h00;
				Blue = 8'h00;
		  end 
		  else if ((start_on[40 - DrawX[9:4]] == 1'b1) && start)
		  begin 
				Red = 8'hff; 
				Green = 8'hff;
				Blue = 8'hff;
		  end 
		  else
		  begin 
				Red = 8'h00; 
				Green = 8'h00;
				Blue = 8'h00;
		  end
				
    end
	 CheckWall check(.DrawX(DrawX),.DrawY(DrawY),.wall_on(wall_on));
	 pac_rom pac(.addr(address_pac), .data(pac_color));	
	 ghost_rom ghost(.addr(address_ghost), .data(ghost_color));
	 ghost_rom ghost1(.addr(address_ghost1), .data(ghost1_color));
	 dot_rom dots(.addr(address_dot), .data(dot_color));
	 died_rom endview(.addr(address_died), .data(died_on));
	 start_rom startview(.addr(address_start), .data(start_on));
	 
	 score_rom score(.addr(address_score), .data(score_color));
		parameter [0:29][39:0] rom = {
		  40'b1111111111111111111111111111111111111111,         
		  40'b1000000000000000000110000000000000000001, 
		  40'b1011111110111111110110111111110111111101,
		  40'b1011111110111111110110111111110111111101,  
		  40'b1011111110111111110110111111110111111101,
		  40'b1000000000000000000000000000000000000001,
		  40'b1011111110110111111111111110110111111101,
		  40'b1000000000110111111111111110110000000001,
		  40'b1111111110110000000110000000110111111111,
		  40'b1111111110111111110110111110110111111111,
		  40'b1111111110110000000000000000110111111111,
		  40'b1111111110110111111001111110110111111111,
		  40'b1000000000000100000000000010000000000001,
		  40'b1111111110110100000000000010110111111111,
		  40'b1111111110110111111111111110110111111111,
		  40'b1111111110110000000000000000110111111111,
		  40'b1111111110110111111111111110110111111111,
		  40'b1000000000000000000110000000000000000001,
		  40'b1011111110111111110110111111110111111101,
		  40'b1011111110111111110110111111110111111101,
		  40'b1000001110000000000000000000000111000001,
		  40'b1111101110111111111111111111110111011111,
		  40'b1111101110111111111111111111110111011111,
		  40'b1000000000000000000110000000000000000001,
		  40'b1011111111111111110110111111111111111101,
		  40'b1000000000000000000000000000000000000001,
		  40'b1111111111111111111111111111111111111111,
		  40'b1111111111111111111111111111111111111111,
		  40'b1111111111111111111111111111111111111111,
		  40'b1111111111111111111111111111111111111111,
		 };
endmodule

	//		  else if ((score_on == 1'b1) && (score_color == 1'b1))
	//		  begin
	//				Red = 8'hff; 
	//				Green = 8'hff;
	//				Blue = 8'hff;
	//		  end
//	 always_comb
//	 begin:Ghost1_on_proc
//        if (DrawX >= Ghost1X && DrawX <  Ghost1X + Ghost1Size && DrawY >= Ghost1Y && DrawY < Ghost1Y + Ghost1Size)
//            ghost1_on = 1'b1;
//        else 
//            ghost1_on = 1'b0;
//    end
	 
//	 always_comb
//	 begin:score_on_proc
//			if (DrawY >= 432 && DrawX >= 0 && DrawX <= 80)
//				address_score = (DrawX % 16 + )
//			else if ()
//			else if ()
//			else if ()
//			else if ()
//				
//	 end
