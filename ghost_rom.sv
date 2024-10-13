module ghost_rom ( input [5:0]	addr,
						output [15:0]	data
					 );

	parameter ADDR_WIDTH = 7;
   parameter DATA_WIDTH =  16;
	logic [ADDR_WIDTH-1:0] addr_reg;
				
	// ROM definition				
	parameter [0:15][15:0] ROM = {
	16'b0000000000000000,
	16'b0000111111110000,
	16'b0111111111111110,
	16'b1111111111111111,
	16'b1111111111111111,
	16'b1111000111100011,
	16'b1111000111100011,
	16'b1111111111111111,
	16'b1111111111111111,
	16'b1111111111111111,
	16'b1111111111111111,
	16'b1111111111111111,
	16'b1111111111111111,
	16'b1111111111111111,
	16'b1101111001111011,
	16'b1000110000110001 
   };
	assign data = ROM[addr];

endmodule 