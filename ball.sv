//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input Reset, frame_clk, Over,
					input [7:0] keycode,
					input [9:0]   DrawX, DrawY,
					output [9:0]  Xmotion,Ymotion,
					output ball_on, is_dot_eaten,
               output [9:0]  BallX, BallY, BallS );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
//	 logic [9:0] wall_addr1,  wall_addr2, wall_addr3,  wall_addr4, wall_addr5, wall_addr6;
//	 logic [639:0] wall_data1, wall_data2, wall_data3, wall_data4, wall_data5, wall_data6;
	 logic [7:0] prevkey;
	 logic Up, Right, Left, Down, RightUp, RightDown, LeftUp, LeftDown, RightUp1, RightDown1, LeftUp1, LeftDown1;
	 logic Xmove, Ymove;
    parameter [9:0] Ball_X_Center=314;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=209;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    assign Ball_Size = 16;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign Xmotion= Ball_X_Motion;
	 assign Ymotion= Ball_Y_Motion;
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
					8'h04 : //A
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
					        
					8'h07 : //D 
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

							  
					8'h16 : //S
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
							  
					8'h1A :
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
//				wall_addr1 = Ball_Y_Pos-1; 
//				
//				wall_addr2 = Ball_Y_Pos;
//				
//				wall_addr3 = Ball_Y_Pos;
//				
//				wall_addr4 = Ball_Y_Pos+16;
//				
//				
//				wall_addr5 = Ball_Y_Pos-1;
//				
//				wall_addr6 = Ball_Y_Pos+16;
				//Up = wall_data1[Ball_X_Pos];
				
				//Right = wall_data2[Ball_X_Pos+16];
				
				//Left = wall_data3[Ball_X_Pos-1];

				//Down = wall_data4[Ball_X_Pos];				
				//LeftDown = wall_data6[Ball_X_Pos+4];
				//LeftDown1 = wall_data6[Ball_X_Pos];	
				//LeftUp = wall_data5[Ball_X_Pos];
				//RightDown = wall_data6[Ball_X_Pos+12];
				//RightDown1 = wall_data6[Ball_X_Pos+16];
				//RightUp = wall_data5[Ball_X_Pos+12];
				//RightUp1 = wall_data5[Ball_X_Pos-1];