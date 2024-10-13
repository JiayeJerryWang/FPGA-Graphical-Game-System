module  ghost1 ( input Reset, frame_clk, Over,
					input [7:0] keycode,
					input [9:0]   DrawX, DrawY,
					//output [9:0]  Xmotion,Ymotion,
					output ball_on, is_dot_eaten,
               output [9:0]  BallX, BallY, BallS );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
//	 logic [9:0] wall_addr1,  wall_addr2, wall_addr3,  wall_addr4, wall_addr5, wall_addr6;
//	 logic [639:0] wall_data1, wall_data2, wall_data3, wall_data4, wall_data5, wall_data6;
	 logic [7:0] prevkey;
	 logic Up, Right, Left, Down, RightUp, RightDown, LeftUp, LeftDown, RightUp1, RightDown1, LeftUp1, LeftDown1;
	 logic Xmove, Ymove;
    parameter [9:0] Ball_X_Center=17;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=39;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    assign Ball_Size = 16;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 //assign Xmotion= Ball_X_Motion;
	 //assign Ymotion= Ball_Y_Motion;
	 always_ff @ (posedge Reset, posedge frame_clk, posedge Over)
    begin
        if (Over)
        begin
            prevkey<= 8'h00;
        end
		  else if (Reset)
        begin
            prevkey<= 8'h00;
        end
        else 
        begin
            if((keycode==8'h1A)||(keycode==8'h16)||(keycode==8'h04)||(keycode==8'h07)) begin  prevkey <= keycode;  end  
        end
    end
    always_ff @ (posedge Reset, posedge Over, posedge frame_clk )
	 begin: Move_Ball
		if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
        end
		else if (Over)
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
        end		    
      else 
        begin 
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
		   end
		end
		
		
	 always_comb	  
	 begin
				Ball_X_Motion_in = Ball_X_Motion;
				Ball_Y_Motion_in = Ball_Y_Motion;
				unique case (keycode)
					8'h50 : //A
					begin
								if (Left)
									begin
										if (Ball_Y_Motion == Ball_Y_Step)
											begin
												if (Down)
													begin
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = 0;   
													end
												else
													begin								
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = Ball_Y_Step;
													end											
											end
										else if (Ball_Y_Motion == (~(Ball_Y_Step) + 1'b1))
											begin
												if (Up)
													begin
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = 0;   
													end
												else
													begin								
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
													end
											end
										else
											begin
												Ball_X_Motion_in = 0;
												Ball_Y_Motion_in = 0;
											end
									end
								else
									begin
										Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);//A
										Ball_Y_Motion_in = 0;
									end
							  end
					        
					8'h4F : //D 
						begin   
								if (Right)
									begin
										if (Ball_Y_Motion == Ball_Y_Step)
											begin
												if (Down)
													begin
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = 0;   
													end
												else
													begin								
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = Ball_Y_Step;
													end											
											end
										else if (Ball_Y_Motion == (~(Ball_Y_Step) + 1'b1))
											begin
												if (Up)
													begin
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = 0;   
													end
												else
													begin								
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
													end
											end
										else
											begin
												Ball_X_Motion_in = 0;
												Ball_Y_Motion_in = 0;
											end
									end
								else
									begin								
										Ball_X_Motion_in = Ball_X_Step;//D
										Ball_Y_Motion_in = 0;
									end
							  end

							  
					8'h51 : //S
						begin  
								if (Down)
									begin
										if (Ball_X_Motion == Ball_X_Step)
											begin
												if (Right)
													begin
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = 0;   
													end
												else
													begin								
														Ball_X_Motion_in = Ball_X_Step;
														Ball_Y_Motion_in = 0;
													end											
											end
										else if (Ball_X_Motion == (~(Ball_X_Step) + 1'b1))
											begin
												if (Left)
													begin
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = 0;   
													end
												else
													begin								
														Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
														Ball_Y_Motion_in = 0;
													end
											end
										else
											begin
												Ball_X_Motion_in = 0;
												Ball_Y_Motion_in = 0;
											end
									end
								else
									begin
										Ball_Y_Motion_in = Ball_Y_Step;//S
										Ball_X_Motion_in = 0;
									end
							 end
							  
					8'h52 :
						begin
								if (Up)
									begin
										if (Ball_X_Motion == Ball_X_Step)
											begin
												if (Right)
													begin
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = 0;   
													end
												else
													begin								
														Ball_X_Motion_in = Ball_X_Step;
														Ball_Y_Motion_in = 0;
													end											
											end
										else if (Ball_X_Motion == (~(Ball_X_Step) + 1'b1))
											begin
												if (Left)
													begin
														Ball_X_Motion_in = 0;
														Ball_Y_Motion_in = 0;   
													end
												else
													begin								
														Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
														Ball_Y_Motion_in = 0;
													end
											end
										else
											begin
												Ball_X_Motion_in = 0;
												Ball_Y_Motion_in = 0;
											end
									end
								else
									begin
										Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);//W
										Ball_X_Motion_in = 0;
									end
							 end	  
					default:
					begin
					
						if ((Ball_Y_Motion == (~(Ball_Y_Step) + 1'b1)) && Up)
							begin
										Ball_X_Motion_in = 0;
										Ball_Y_Motion_in = 0;
							end
						else if ((Ball_Y_Motion == Ball_Y_Step) && Down)
							begin
										Ball_X_Motion_in = 0;
										Ball_Y_Motion_in = 0;
							end
						else if ((Ball_X_Motion == (~(Ball_X_Step) + 1'b1)) && Left)
							begin
										Ball_X_Motion_in = 0;
										Ball_Y_Motion_in = 0;
							end
						else if ((Ball_X_Motion == Ball_X_Step) && Right)
							begin
										Ball_X_Motion_in = 0;
										Ball_Y_Motion_in = 0;
							end
						else
							begin
										Ball_X_Motion_in = Ball_X_Motion;
										Ball_Y_Motion_in = Ball_Y_Motion;
							end
					end
			   endcase
				 
				 Ball_Y_Pos_in = (Ball_Y_Pos + Ball_Y_Motion_in);  // Update ball position
				 Ball_X_Pos_in = (Ball_X_Pos + Ball_X_Motion_in);
      
			
		end         
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallS = Ball_Size;
	 
	 assign Xmotion= Ball_X_Motion;
	 
	 assign Ymotion= Ball_Y_Motion;

	 ValidMoveUp validup(.BallX(Ball_X_Pos),.BallY(Ball_Y_Pos),.Up(Up));
	 ValidMoveDown validdown(.BallX(Ball_X_Pos),.BallY(Ball_Y_Pos),.Down(Down));
	 ValidMoveLeft validleft(.BallX(Ball_X_Pos),.BallY(Ball_Y_Pos),.Left(Left));
	 ValidMoveRight validright(.BallX(Ball_X_Pos),.BallY(Ball_Y_Pos),.Right(Right));
always_comb
	begin
		if (DrawX >= BallX && DrawX < BallX + Ball_Size && DrawY >= BallY && DrawY < BallY + Ball_Size)
			begin
			ball_on = 1'b1;
			is_dot_eaten = 1'b1;
			end
		else 
			begin
			ball_on = 1'b0;
			is_dot_eaten = 1'b0;
			end
	end
endmodule



//module  ghost1 ( input Reset, frame_clk, Over,
//					input [7:0] keycode,
//					input [9:0]   DrawX, DrawY,
//					//input [9:0] Ghost_X_Start, Ghost_Y_Start,
//               output [9:0]  GhostX, GhostY, GhostS,
//					output ghost_on);
//    
//    logic [9:0] Ghost_X_Pos, Ghost_X_Motion, Ghost_Y_Pos, Ghost_Y_Motion, GhostSize;
//    logic [9:0] Ghost_X_Pos_in, Ghost_X_Motion_in, Ghost_Y_Pos_in, Ghost_Y_Motion_in;
//	 logic [7:0] prevkey;
//	 logic Up, Right, Left, Down, RightUp, RightDown, LeftUp, LeftDown, RightUp1, RightDown1, LeftUp1, LeftDown1;
//	 logic Xmove, Ymove;
//    parameter [9:0] Ghost_X_Start=17;  // Center position on the X axis
//    parameter [9:0] Ghost_Y_Start=39;  // Center position on the Y axis
//    parameter [9:0] Ghost_X_Min=0;       // Leftmost point on the X axis
//    parameter [9:0] Ghost_X_Max=639;     // Rightmost point on the X axis
//    parameter [9:0] Ghost_Y_Min=0;       // Topmost point on the Y axis
//    parameter [9:0] Ghost_Y_Max=479;     // Bottommost point on the Y axis
//    parameter [9:0] Ghost_X_Step=1;      // Step size on the X axis
//    parameter [9:0] Ghost_Y_Step=1;      // Step size on the Y axis
//
//    assign Ghost_Size = 16;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
//	 always_ff @ (posedge Reset, posedge frame_clk, posedge Over)
//    begin
//        if (Over)
//        begin
//            prevkey<= 8'h00;
//        end
//		  else if (Reset)
//        begin
//            prevkey<= 8'h00;
//        end
//        else 
//        begin
//            if((keycode==8'h4F)||(keycode==8'h50)||(keycode==8'h51)||(keycode==8'h52)) begin  prevkey <= keycode;  end  
//        end
//    end
//    always_ff @ (posedge Reset, posedge Over, posedge frame_clk )
//	 begin: Move_Ghost
//		if (Reset)  // Asynchronous Reset
//        begin 
//            Ghost_Y_Motion <= 10'd0; //Ghost_Y_Step;
//				Ghost_X_Motion <= 10'd0; //Ghost_X_Step;
//				Ghost_Y_Pos <= Ghost_Y_Start;
//				Ghost_X_Pos <= Ghost_X_Start;
//        end
//		else if (Over)
//        begin 
//            Ghost_Y_Motion <= 10'd0; //Ghost_Y_Step;
//				Ghost_X_Motion <= 10'd0; //Ghost_X_Step;
//				Ghost_Y_Pos <= Ghost_Y_Start;
//				Ghost_X_Pos <= Ghost_X_Start;
//        end		    
//      else 
//        begin 
//            Ghost_X_Pos <= Ghost_X_Pos_in;
//            Ghost_Y_Pos <= Ghost_Y_Pos_in;
//            Ghost_X_Motion <= Ghost_X_Motion_in;
//            Ghost_Y_Motion <= Ghost_Y_Motion_in;
//		   end
//		end
//		
//		
//	 always_comb	  
//	 begin
//				Ghost_X_Motion_in = Ghost_X_Motion;
//				Ghost_Y_Motion_in = Ghost_Y_Motion;
//				unique case (keycode)
//					8'h50 : //A
//					begin
//								if (Left)
//									begin
//										if (Ghost_Y_Motion == Ghost_Y_Step)
//											begin
//												if (Down)
//													begin
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = 0;   
//													end
//												else
//													begin								
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = Ghost_Y_Step;
//													end											
//											end
//										else if (Ghost_Y_Motion == (~(Ghost_Y_Step) + 1'b1))
//											begin
//												if (Up)
//													begin
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = 0;   
//													end
//												else
//													begin								
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = (~(Ghost_Y_Step) + 1'b1);
//													end
//											end
//										else
//											begin
//												Ghost_X_Motion_in = 0;
//												Ghost_Y_Motion_in = 0;
//											end
//									end
//								else
//									begin
//										Ghost_X_Motion_in = (~(Ghost_X_Step) + 1'b1);//A
//										Ghost_Y_Motion_in = 0;
//									end
//							  end
//					        
//					8'h4F : //D 
//						begin   
//								if (Right)
//									begin
//										if (Ghost_Y_Motion == Ghost_Y_Step)
//											begin
//												if (Down)
//													begin
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = 0;   
//													end
//												else
//													begin								
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = Ghost_Y_Step;
//													end											
//											end
//										else if (Ghost_Y_Motion == (~(Ghost_Y_Step) + 1'b1))
//											begin
//												if (Up)
//													begin
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = 0;   
//													end
//												else
//													begin								
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = (~(Ghost_Y_Step) + 1'b1);
//													end
//											end
//										else
//											begin
//												Ghost_X_Motion_in = 0;
//												Ghost_Y_Motion_in = 0;
//											end
//									end
//								else
//									begin								
//										Ghost_X_Motion_in = Ghost_X_Step;//D
//										Ghost_Y_Motion_in = 0;
//									end
//							  end
//
//							  
//					8'h51 : //S
//						begin  
//								if (Down)
//									begin
//										if (Ghost_X_Motion == Ghost_X_Step)
//											begin
//												if (Right)
//													begin
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = 0;   
//													end
//												else
//													begin								
//														Ghost_X_Motion_in = Ghost_X_Step;
//														Ghost_Y_Motion_in = 0;
//													end											
//											end
//										else if (Ghost_X_Motion == (~(Ghost_X_Step) + 1'b1))
//											begin
//												if (Left)
//													begin
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = 0;   
//													end
//												else
//													begin								
//														Ghost_X_Motion_in = (~(Ghost_X_Step) + 1'b1);
//														Ghost_Y_Motion_in = 0;
//													end
//											end
//										else
//											begin
//												Ghost_X_Motion_in = 0;
//												Ghost_Y_Motion_in = 0;
//											end
//									end
//								else
//									begin
//										Ghost_Y_Motion_in = Ghost_Y_Step;//S
//										Ghost_X_Motion_in = 0;
//									end
//							 end
//							  
//					8'h52 :
//						begin
//								if (Up)
//									begin
//										if (Ghost_X_Motion == Ghost_X_Step)
//											begin
//												if (Right)
//													begin
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = 0;   
//													end
//												else
//													begin								
//														Ghost_X_Motion_in = Ghost_X_Step;
//														Ghost_Y_Motion_in = 0;
//													end											
//											end
//										else if (Ghost_X_Motion == (~(Ghost_X_Step) + 1'b1))
//											begin
//												if (Left)
//													begin
//														Ghost_X_Motion_in = 0;
//														Ghost_Y_Motion_in = 0;   
//													end
//												else
//													begin								
//														Ghost_X_Motion_in = (~(Ghost_X_Step) + 1'b1);
//														Ghost_Y_Motion_in = 0;
//													end
//											end
//										else
//											begin
//												Ghost_X_Motion_in = 0;
//												Ghost_Y_Motion_in = 0;
//											end
//									end
//								else
//									begin
//										Ghost_Y_Motion_in = (~(Ghost_Y_Step) + 1'b1);//W
//										Ghost_X_Motion_in = 0;
//									end
//							 end	  
//					default:
//					begin
//					
//						if ((Ghost_Y_Motion == (~(Ghost_Y_Step) + 1'b1)) && Up)
//							begin
//										Ghost_X_Motion_in = 0;
//										Ghost_Y_Motion_in = 0;
//							end
//						else if ((Ghost_Y_Motion == Ghost_Y_Step) && Down)
//							begin
//										Ghost_X_Motion_in = 0;
//										Ghost_Y_Motion_in = 0;
//							end
//						else if ((Ghost_X_Motion == (~(Ghost_X_Step) + 1'b1)) && Left)
//							begin
//										Ghost_X_Motion_in = 0;
//										Ghost_Y_Motion_in = 0;
//							end
//						else if ((Ghost_X_Motion == Ghost_X_Step) && Right)
//							begin
//										Ghost_X_Motion_in = 0;
//										Ghost_Y_Motion_in = 0;
//							end
//						else
//							begin
//										Ghost_X_Motion_in = Ghost_X_Motion;
//										Ghost_Y_Motion_in = Ghost_Y_Motion;
//							end
//					end
//			   endcase
//				 
//				 Ghost_Y_Pos_in = (Ghost_Y_Pos + Ghost_Y_Motion_in);  // Update Ghost position
//				 Ghost_X_Pos_in = (Ghost_X_Pos + Ghost_X_Motion_in);
//      
//			
//		end         
//    assign GhostX = Ghost_X_Pos;
//    assign GhostY = Ghost_Y_Pos;
//    assign GhostS = Ghost_Size;
//	 ValidMoveUp validup(.BallX(Ghost_X_Pos),.BallY(Ghost_Y_Pos),.Up(Up));
//	 ValidMoveDown validdown(.BallX(Ghost_X_Pos),.BallY(Ghost_Y_Pos),.Down(Down));
//	 ValidMoveLeft validleft(.BallX(Ghost_X_Pos),.BallY(Ghost_Y_Pos),.Left(Left));
//	 ValidMoveRight validright(.BallX(Ghost_X_Pos),.BallY(Ghost_Y_Pos),.Right(Right));
//endmodule