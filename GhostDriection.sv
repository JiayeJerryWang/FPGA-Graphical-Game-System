module GhostDirection(//input Reset, frame_clk, Over,
							input [9:0]  GhostX, GhostY, PacmanX, PacmanY,
							 //input left, right, up, down,
							output [3:0] Movement);

logic up, down,left, right;							 
logic [3:0] pass;
assign DistX = GhostX - PacmanX;
assign DistY = GhostY - PacmanY;
always@ (GhostX, GhostY, PacmanX, PacmanY)
	 begin
	 pass = {~down,~up,~right,~left};
		case(pass)
			
			4'b1111: // all direction
			begin 	
			
				//go up
				if(((PacmanX < GhostX) && (PacmanY < GhostY ) && ((DistX) > (DistY))) || ((PacmanX > GhostX) && (PacmanY < GhostY ) && ((DistY) < (~DistX))) || ((PacmanX==GhostX ) && (GhostY > PacmanY)))
					Movement <= 4'b0100;
				// PacMan at UpLeft and Up is closer, go Up
				// PacMan at Right Up, Up is closer, go Up
				// PacMan at above go up		
								
			   //go down		
				else if(((PacmanX < GhostX ) && (PacmanY > GhostY) &&  ((~DistY) < (DistX))) || ((PacmanX > GhostX) && (PacmanY > GhostY) &&  ((~DistY) < (~DistX))) || ((PacmanX==GhostX ) && (PacmanY > GhostY)))
					Movement <= 4'b1000;
				// PacMan at Left Down,Down is closer, go Down
				// PacMan at DownRight , Down is closer, go Down
				// PacMan at below go down
			
			   //go left	
				else if(((PacmanX < GhostX) && (PacmanY < GhostY ) && ((DistX) < (DistY))) || ((PacmanX < GhostX ) && (PacmanY > GhostY) &&  ((DistX) < (~DistY))) ||  ((PacmanX < GhostX) && (PacmanY==GhostY)))
					Movement <= 4'b0001;
				// PacMan at upLeft, Left is closer, go Left
				// PacMan at Left Down,Left is closer, go Left	
				// PacMan at Left go Left	

			   //go right
				else if(((PacmanX > GhostX) &&(PacmanY < GhostY ) && ((~DistX) < (DistY))) || ((PacmanX > GhostX) && (PacmanY > GhostY) &&  ((~DistX) < (~DistY))) || ((PacmanX > GhostX) && (PacmanY==GhostY)))
					Movement <= 4'b0010;
				// PacMan at UpRight, Right is closer, go Right
				// PacMan at DownRight, Right is closer, go Right	
				// PacMan at Right go Right

				else
					Movement <= Movement;	
			end
			
			
			4'b1110: // 3 direction: up, down, right
			begin
			
			// go up
				if(((PacmanY<GhostY) &&(PacmanX > GhostX) && ((DistY) < (~DistX))) || ((PacmanX==GhostX) && (PacmanY < GhostY )) || (( PacmanY < GhostY ) && (PacmanX < GhostX  )))
					Movement <= 4'b0100;
				//PacMan at Right Up, Up is closer go Up
				//PacMan above go Up
				//PacMan is up Left go Up	
			
			// go down
				else if(((PacmanY > GhostY) && (PacmanX > GhostX) &&((~DistY) < (~DistX))) || ((PacmanY > GhostY) && (PacmanX<GhostX)) || ((PacmanX==GhostX ) && (PacmanY > GhostY)) || ((PacmanY==GhostY ) && (PacmanX < GhostX)))
					Movement <= 4'b1000;
				//PacMan at Right Down,Down is closer go Down
				//PacMan at down Left go Down
				//PacMan at below go Down
				//PacMan at Left go Down				
				
			// go right
				else if(((PacmanY > GhostY) &&(PacmanX > GhostX) && ((~DistX) < (~DistY))) || ((PacmanY<GhostY) &&(PacmanX > GhostX) && ((~DistX) < (DistY))) || (( PacmanY==GhostY) && (PacmanX > GhostX))) 
					Movement <= 4'b0010;
				//PacMan at Right Down, Right is closer go Right
				//PacMan at Right Up, Right is closer go Right
				//PacMan at Right go Right
			
				else
					Movement <= Movement;			
			end
			
			
			4'b1101: // 3 direction: up, down, left	
			begin 		
				// go up
				if(((PacmanY<GhostY) && (PacmanX < GhostX) && ((DistY) < (DistX))) || ((PacmanY<GhostY) && (PacmanX > GhostX))	|| ((PacmanX==GhostX) && (PacmanY < GhostY )))
					Movement <= 4'b0100;				
				//PacMan at LeftUp, Up is closer go Up	
				//PacMan above and to the Right go Up
				//PacMan at above go Up
							
				// go down	
				else if(((PacmanY > GhostY) && (PacmanX < GhostX) && ((~DistY) < (DistX))) || ((PacmanY > GhostY) && (PacmanX > GhostX))	|| ((PacmanX==GhostX) && (PacmanY > GhostY)) || ((PacmanY==GhostY) && (PacmanX > GhostX)))  
					Movement <= 4'b1000;
				//PacMan at Left Down, Down is closer go Down
				//PacMan below and to the Right go Down
				//PacMan at below go Down		
				//PacMan at Right go Down	
				
				// go left		
				else if(((PacmanY > GhostY) && (PacmanX < GhostX) && ((DistX) < (~DistY))) || ((PacmanY<GhostY) && (PacmanX < GhostX ) && ((DistX) < (DistY))) || ((PacmanY==GhostY) && (PacmanX < GhostX)))					
					Movement <= 4'b0001;
				//PacMan at Left Down, Left is closer go Left				
				//PacMan at Left Up, Left is closer go Left
				//PacMan at Left go Left
					
				else
					Movement <= Movement;						
			end
						
			
			4'b1011: // 3 direction: Left, Right, Down
			begin 
			
			// go down 
				if(((PacmanY > GhostY) && (PacmanX > GhostX) && ((~DistY) < (~DistX))) || ((PacmanY > GhostY) && (GhostX > PacmanX) && ((~DistY) < (DistX))) || ((PacmanX==GhostX) && (PacmanY > GhostY)))
					Movement <= 4'b1000;
				// PacMan at Right and Down, Down is closer go Down
				// PacMan at Left  Down, Down is closer go Down
				// PacMan at below go Down

			//go right		
				else if(((PacmanY > GhostY) &&(PacmanX > GhostX) &&((~DistX) < (~DistY))) || ((PacmanY<GhostY)  && (PacmanX > GhostX)) || ((PacmanY==GhostY) && (PacmanX > GhostX)) || ((PacmanX==GhostX) && (PacmanY<GhostY))) 
					Movement <= 4'b0010;
				// PacMan at Right Down, Right is closer go Right
		      // PacMan at upRight go Right	
			   // PacMan at Right go Right
				// PacMan at above go Right
									
			//go left
				else if(((PacmanY > GhostY) &&(DistX) && ((DistX) < (~DistY))) || ((PacmanY==GhostY) && (PacmanX<GhostX)) || (PacmanY<GhostY) && ( PacmanX < GhostX))
					Movement <= 4'b0001;
				// PacMan at LeftDown, Left is closer go Left
				// PacMan at Left go Left
				// if PacMan at upLeft go Left
			
				else
					Movement <= Movement;				
			end
						
				
			4'b0111: // 3 direction Left, Right, Up
			begin 	

				// go up					
				if(((PacmanY < GhostY) && (PacmanX > GhostX) && ((DistY) < (~DistX))) || (( PacmanY<GhostY) && (PacmanX < GhostX) && ((DistY) < (DistX))) || ((PacmanX==GhostX) && (PacmanY<GhostY)))
					Movement <= 4'b0100;							
				//PacMan at above and to the Right, Up is closer go Up
				//PacMan at above and to the Left, Up is closer go Up
				//PacMan at above, go Up
	
				//go right
				else if(((PacmanY < GhostY) && (PacmanX > GhostX) && ((~DistX) < (DistY))) || ((PacmanY > GhostY) && (PacmanX > GhostX)) || ((PacmanY==GhostY) && (PacmanX > GhostX)) || ((PacmanX==GhostX) && (PacmanY > GhostY)))
					Movement <= 4'b0010;
				//PacMan at above and to the Right, Right is closer go Right
				//PacMan at below and to the Right, go Right
				//PacMan at Right, go Right
				//PacMan at below, go Right

				//go left		
				else if(((PacmanY < GhostY) && (PacmanX < GhostX) && ((DistX) < (DistY))) || ((PacmanY==GhostY) && (PacmanX < GhostX)) || ((PacmanY > GhostY) && (PacmanX < GhostX)))
					Movement <= 4'b0001;
				// PacMan at above and to the Left, Left is closer go Left
				// PacMan at Left go Left
				// PacMan at  below and to the Left, go Left
			
				else
					Movement <= Movement;														
			end
			
	
			4'b0101: //2 direction: up,left
			begin 
				//go up
				if(((PacmanY < GhostY) && (PacmanX < GhostX) &&((DistY) < (DistX))) || ((PacmanY > GhostY) &&(PacmanX > GhostX) && ((~DistX) < (~DistY))) || ((PacmanX==GhostX)  && (PacmanY < GhostY)) || ((PacmanX > GhostX) && (PacmanY==GhostY)) || ((PacmanX > GhostX)&&(PacmanY < GhostY)))
					Movement <= 4'b0100;
				// pacman at upleft, up is closer, go up
				// pacman at upright, right is closer, go up
				// pacman at above, go up
				// pacman at right, go up
				// pacman at upright, go up			
				
				//go left	
				else if(((PacmanY < GhostY) && (PacmanX < GhostX) && ((DistX) < (DistY))) || ((PacmanX > GhostX)&&(PacmanY > GhostY)&&((~DistY) < (~DistX))) || ((PacmanY==GhostY) && (PacmanX < GhostX)) || ((PacmanY > GhostY) && (PacmanX < GhostX)) || ((PacmanX==GhostX)  && (PacmanY > GhostY)))
					Movement <= 4'b0001;
				//pacman at upleft, left is closer, go left
	         //pacman at downright, down is closer, go left
            //pacman at left, go left
            //pacman at downleft go left
            //pacman at below, go left
		
				else
					Movement <= Movement;			
			end
						
						
			4'b0110: // 2 direction: Up Right
			begin 
				//go up
				if(((GhostY > PacmanY) &&(PacmanX > GhostX) &&((DistY) < (~DistX))) || ((PacmanY > GhostY) &&(GhostX > PacmanX) && ((DistX) < (~DistY))) || ((GhostY > PacmanY) && (GhostX > PacmanX)) || ((GhostX == PacmanX) && (GhostY > PacmanY)) || ((GhostY == PacmanY) && (GhostX > PacmanX)))				
					Movement <= 4'b0100;
				// PacMan at up right, Up is closer, go Up
            // PacMan at down left, Left is closer, go Up
				// PacMan at UpLeft, go Up
				// PacMan above, go Up
            // PacMan at Left, go Up
				
				//go right
				else if(((GhostY > PacmanY) && (PacmanX > GhostX) && ((~DistX) < (DistY))) || ((PacmanY > GhostY) &&(GhostX > PacmanX) && ((~DistY) < (DistX))) || ((PacmanY > GhostY) && (PacmanX > GhostX)) || ((GhostY == PacmanY) && (PacmanX > GhostX)) || ((GhostX == PacmanX)  && (PacmanY > GhostY)))
					Movement <= 4'b0010;						
				// PacMan at upright, Right is closer, go Right
				// PacMan at downleft, Down is closer, go Right
				// PacMan at DownRight, go Right
            // PacMan at Right, go Right
				// PacMan at below, go Right
									
				else
					Movement <= Movement;
			end
		

			4'b1001: // 2 direction: Down Left
			begin 		
				//go down
				if(((PacmanY > GhostY) && (GhostX > PacmanX) && ((~DistY) < (DistX))) || ((GhostY > PacmanY) && (PacmanX > GhostX) && ((~DistX) < (DistY))) || ((PacmanY > GhostY) && (PacmanX > GhostX)) || ((GhostX == PacmanX) && (PacmanY > GhostY)) || ((GhostY == PacmanY) && (PacmanX > GhostX)))
					Movement <= 4'b1000;
				// Pacman at DownLeft, Down is closer, go Down
				// PacMan at Right Up, Right is closer, go Down
				// PacMan at down right, go Down
				// PacMan at below,  go Down
				// PacMan at Right, go Down
				
				//go left							
				else if(((GhostY > PacmanY) && (PacmanX > GhostX) && ((DistY) < (~DistX))) || ((PacmanY > GhostY) && (GhostX > PacmanX) && ((DistX) < (~DistY))) || ((GhostY > PacmanY) && (GhostX > PacmanX)) || ((GhostY == PacmanY) && (GhostX > PacmanX)) || ((GhostX == PacmanX) && (GhostY > PacmanY)))
					Movement <= 4'b0001;	
				// pacman at upright, Up is closer, go Left	
				// PacMan at Left and Down, Left is closer, go Left
				// PacMan at upleft, go Left
				// PacMan at Left go Left
				// PacMan at above go Left
					
				else
					Movement <= Movement;					
						
			end
						
						
			4'b1010: begin // 2 direction: Down Right
			
				//go down
				if(((PacmanY > GhostY) && (PacmanX > GhostX) &&((~DistY) < (~DistX))) || ((GhostY > PacmanY) && (GhostX > PacmanX) && ((DistX) < (DistY))) || ((PacmanY > GhostY) && (GhostX > PacmanX)) || ((GhostX == PacmanX) && (PacmanY > GhostY)) || ((GhostY == PacmanY) && (GhostX > PacmanX))) 
					Movement <= 4'b1000;
				// PacMan at RightDown, Down is closer, go Down
				// PacMan at upLeft, Left is closer, go Down
				// PacMan Down and to the Left go Down
				// PacMan directly below go Down
				// PacMan directly to the Left go Down		
				
				//go right
				else if(((PacmanY > GhostY) && (PacmanX > GhostX) && ((~DistX) < (~DistY))) || ((GhostY > PacmanY) && (GhostX > PacmanX) && ((DistY) < (DistX))) || ((GhostY > PacmanY) && (PacmanX > GhostX)) || ((GhostY == PacmanY) && (PacmanX > GhostX)) || ((GhostX == PacmanX) && (GhostY > PacmanY))) 
					Movement <= 4'b0010;
				// PacMan at Right and Down, Right is closer, go Right
				// PacMan at upleft, Up is closer, go Right
            // Pacman at upRight, go Right
            // PacMan at right, go Right
            // Pacman is above, go Right

				else
					Movement <= Movement;
			end
			
			4'b0011: //2 direction: left,  right 
			begin 
				
				//go left
				if((((PacmanX==GhostX)) && ((PacmanY < GhostY))) || (PacmanX < GhostX))
					Movement <= 4'b0001;
				//pac man at above, go left
				//pac man at left, go left
							
				//go right	
				else if((((PacmanX==GhostX)) && ((PacmanY > GhostY))) || (PacmanX > GhostX))
					Movement <= 4'b0010; 
			  //pac man at below, go right
			  //pac man at right, go right
				
				else
					Movement <= Movement;									
			end
				
			4'b1100: // can go Down or Up
			begin 
				//go up			
				if(((GhostY == PacmanY) && (PacmanX > GhostX)) || (GhostY > PacmanY))
					Movement <= 4'b0100;
				// PacMan at Right, go Up
				// Pacman is above, go Up				
				
				//go down	
				else if(((GhostY == PacmanY) && (GhostX > PacmanX)) || (PacmanY > GhostY))
					Movement <= 4'b1000;
				// PacMan at Left, go Down
            //Pac man is below, go Down				
	
				else
					Movement <= Movement;
								
			end	
			4'b0001: Movement <= 4'b0001;
			
			4'b0010: Movement <= 4'b0010;
			
			4'b0100: Movement <= 4'b0100;
			
			4'b1000: Movement <= 4'b1000;
			
			4'b0000: Movement <= 4'b0000;	
		endcase
end
	ValidMoveUp validup(.BallX(GhostX),.BallY(GhostY),.Up(up));
	ValidMoveDown validdown(.BallX(GhostX),.BallY(GhostY),.Down(down));
	ValidMoveLeft validleft(.BallX(GhostX),.BallY(GhostY),.Left(left));
	ValidMoveRight validright(.BallX(GhostX),.BallY(GhostY),.Right(right));
endmodule