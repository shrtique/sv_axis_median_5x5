`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2018 03:03:29 PM
// Design Name: 
// Module Name: tb_sorting_module_5inputs
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_sorting_module_5inputs();

localparam N = 8;

logic [N-1:0] number_0;
logic [N-1:0] number_1;
logic [N-1:0] number_2;
logic [N-1:0] number_3;
logic [N-1:0] number_4;



logic [N-1:0] sorted_0;
logic [N-1:0] sorted_1;
logic [N-1:0] sorted_2;
logic [N-1:0] sorted_3;
logic [N-1:0] sorted_4;

logic         clk;
logic         aresetn;


sorting_module_5inputs #(
  .DATA_WIDTH ( N            )
) UUT (

  .i_clk      ( clk      ),
  .i_aresetn  ( aresetn  ),

  .i_num_0    ( number_0 ),
  .i_num_1    ( number_1 ),
  .i_num_2    ( number_2 ),
  .i_num_3    ( number_3 ),
  .i_num_4    ( number_4 ),

  .o_num_0    ( sorted_0 ),
  .o_num_1    ( sorted_1 ),
  .o_num_2    ( sorted_2 ),
  .o_num_3    ( sorted_3 ),
  .o_num_4    ( sorted_4 )
);	


initial
  begin

  	aresetn  = 1'b0;
    number_0 = 8'd0;  
    number_1 = 8'd0;
    number_2 = 8'd0;
    number_3 = 8'd0;
    number_4 = 8'd0;
  	#7;
  	aresetn  = 1'b1;
    #2;
    number_0 = 8'd20;  
    number_1 = 8'd10;
    number_2 = 8'd1;
    number_3 = 8'd6;
    number_4 = 8'd8;
    #10;
    number_0 = 8'd32;  
    number_1 = 8'd5;
    number_2 = 8'd40;
    number_3 = 8'd100;
    number_4 = 8'd60;
    #10;
    number_0 = 8'd14;  
    number_1 = 8'd3;
    number_2 = 8'd22;
    number_3 = 8'd26;
    number_4 = 8'd68;
    #10;
    number_0 = 8'd110;  
    number_1 = 8'd12;
    number_2 = 8'd30;
    number_3 = 8'd7;
    number_4 = 8'd11;
    #10;
    number_0 = 8'd72;  
    number_1 = 8'd48;
    number_2 = 8'd36;
    number_3 = 8'd50;
    number_4 = 8'd80;
    #10;
    number_0 = 8'd0;  
    number_1 = 8'd0;
    number_2 = 8'd0;
    number_3 = 8'd0;
    number_4 = 8'd0;

  end	

always
  begin
    clk = 1; #5; clk = 0; #5;
  end

endmodule
