module CheckWall (input [9:0]  DrawX, DrawY,	
						output wall_on
						);
	logic [9:0] wall_addr;
	logic [639:0] wall_data;
	wall_rom wall(.addr(wall_addr),.data(wall_data));
	always_comb 
	begin
	wall_addr = DrawY;
	wall_on = wall_data[DrawX];
	end
endmodule
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						