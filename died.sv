module died(input frame_clk,reset, PacmanX, PacmanY, GhostX, GhostY, Ghost1X, Ghost1Y,
				output died);
	always_ff @ (posedge frame_clk)
		begin	
		if((PacmanX == GhostX) && (PacmanY== GhostY))
			begin
			died <= 1'b1;
			end
		
		else if((PacmanX == Ghost1X) && (PacmanY== Ghost1Y))
			begin
			died <= 1'b1;
			end
		else if(reset)
			begin
			died <= 1'b0;
			end
		else 	
			died <= 1'b0;
	end
endmodule