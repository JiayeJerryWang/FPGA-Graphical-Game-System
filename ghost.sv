module ghost ( input Reset, frame_clk, Over,
					input [9:0]  Ghost_X_Start,Ghost_Y_Start,BallX, BallY,
					output [9:0]  GhostX, GhostY, GhostS);
	 logic Up, Right, Left, Down;
	 logic [9:0] Ghost_X_Pos, Ghost_X_Motion, Ghost_Y_Pos, Ghost_Y_Motion,Ghost_X_Pos_in,Ghost_Y_Pos_in,Ghost_X_Motion_in,Ghost_Y_Motion_in;
	 logic [3:0] Direction,valid;
    parameter [9:0] Ghost_X_Min=0;       
    parameter [9:0] Ghost_X_Max=639;     
    parameter [9:0] Ghost_Y_Min=0;       
    parameter [9:0] Ghost_Y_Max=479;     
    parameter [9:0] Ghost_X_Step=1;      
    parameter [9:0] Ghost_Y_Step=1;
	 assign GhostS = 16;
	 assign GhostX = Ghost_X_Pos;
    assign GhostY = Ghost_Y_Pos;
   always_ff @ (posedge Reset or posedge frame_clk )
   begin: Move_Ghost
        if (Reset)
			begin 
            Ghost_Y_Motion <= 10'd0;
				Ghost_X_Motion <= 10'd0;
				Ghost_Y_Pos <= Ghost_Y_Start;
				Ghost_X_Pos <= Ghost_X_Start;
			end  
        else 
			begin
				unique case (Direction)
				4'b0001 ://left
					begin
						Ghost_Y_Motion <=10'd0;
						Ghost_X_Motion <=~10'd1 +1'b1;
					end
				4'b0010 ://right
					begin
						Ghost_Y_Motion <=10'd0;
						Ghost_X_Motion <=10'd1;
					end
				4'b0100 ://up
					begin
						Ghost_Y_Motion <=~10'd1 + 1'b1;
						Ghost_X_Motion <=10'd0;
					end
				4'b1000 ://down
					begin
						Ghost_Y_Motion <=10'd1;
						Ghost_X_Motion <=10'd0;
					end
				default :
					begin
						Ghost_Y_Motion <=10'd0;
						Ghost_X_Motion <=10'd0;
					end
				endcase
				Ghost_Y_Pos <= (Ghost_Y_Pos + Ghost_Y_Motion);
				Ghost_X_Pos <= (Ghost_X_Pos + Ghost_X_Motion);				 
			end
	end
	GhostDirection ghostdirection(.Movement(Direction), .GhostY(Ghost_Y_Pos), .GhostX(Ghost_X_Pos),.PacmanX(BallX), .PacmanY(BallY));		 
endmodule