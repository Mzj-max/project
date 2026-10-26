`timescale 1ns / 1ps
module led(
    input clk,
	 input rst,
	 output reg led
	 );
	//define the time counter
	reg [31:0]      timer;

	// cycle counter:from 0 to 4 sec
	always@(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
			timer <= 32'd0;                     //when the reset signal valid,time counter clearing
		else if (timer == 32'd39_999_999)      //4 seconds count(50M*4-1=199999999)
			timer <= 32'd0;                     //count done,clearing the time counter
		else
			timer <= timer + 32'd1;             //timer counter = timer counter + 1

	end

	// LED control
	always@(posedge clk or negedge rst)
	begin								
		if (rst == 1'b0)					
			led <= 1'b0;                        //when the reset signal active
		else if (timer == 32'd49_999_999)       //time counter count to 1st sec,LED1 lighten
			led <= 1'b1;
		else if(timer == 32'd99_999_999)
			led <= 1'b0;
	end
	
endmodule
