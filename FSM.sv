module FSM(input reset, clk, died, begingame,
				output start,drawwall, endgame, drawpacman,drawghost, drawghost1,drawdot);
   enum logic [3:0] {startgame,game,over,halt}   currentstate, nextstate; 
//	assign nextstate=currentstate;
	always_ff @ (posedge clk, posedge reset) 
	begin
		if (reset) 
		begin
			currentstate <= startgame;
		end 
		else 
		begin
			currentstate <= nextstate;
		end
	end	
	
	always_comb
	begin
		nextstate = currentstate;
			start = 1'b1;
			drawwall= 1'b0;
			endgame= 1'b0;
			drawpacman= 1'b0;
			drawghost= 1'b0;
			drawghost1= 1'b0;
			
		unique case(currentstate)
			
			startgame: if(begingame)
					nextstate = game;
			game: if(died)
						nextstate = over;
			over: nextstate = halt;
			halt: if(reset)
						nextstate = startgame;
					else
						nextstate = halt;
		endcase
		
		case(currentstate)
			startgame: 
			begin
				start = 1'b1;
				drawwall= 1'b0;
				endgame= 1'b0;
				drawpacman= 1'b0;
				drawghost= 1'b0;
				drawghost1= 1'b0;
				drawdot = 1'b0;
			end
			game:
			begin
				start = 1'b0;
				drawwall= 1'b1;
				endgame= 1'b0;
				drawpacman= 1'b1;
				drawghost= 1'b1;
				drawghost1= 1'b1;
				drawdot = 1'b1;
			end
			over: 
			begin
				start = 1'b0;
				drawwall= 1'b0;
				endgame= 1'b1;
				drawpacman= 1'b0;
				drawghost= 1'b0;
				drawghost1= 1'b0;
				drawdot = 1'b0;
			end
			halt:
			begin
				start = 1'b0;
				drawwall= 1'b0;
				endgame= 1'b1;
				drawpacman= 1'b0;
				drawghost= 1'b0;
				drawghost1= 1'b0;
				drawdot = 1'b0;
			end			
		endcase
	end
endmodule