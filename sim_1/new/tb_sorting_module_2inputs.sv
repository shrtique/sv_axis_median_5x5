`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2018 01:17:33 PM
// Design Name: 
// Module Name: tb_sorting_module_2inputs
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


module tb_sorting_module_2inputs();

//signals
localparam N = 8;

logic [N-1:0] number_1;
logic [N-1:0] number_2;

logic [N-1:0] higher_value;
logic [N-1:0] lower_value;

logic                  clk;
logic                  aresetn;

sorting_module_2inputs #(
  .DATA_WIDTH ( N            )
) UUT (

  .i_clk      ( clk      ),
  .i_aresetn  ( aresetn  ),

  .in_1       ( number_1     ),
  .in_2       ( number_2     ),

  .high       ( higher_value ),
  .low        ( lower_value  )   
);

//simulation
always
  begin
    clk = 1; #5; clk = 0; #5;
  end

initial
  begin
    aresetn  = 1'b0;
    number_1 = 8'd0;  
    number_2 = 8'd0;
    #7;
    aresetn  = 1'b1;
    number_1 = 8'd10; 
    number_2 = 8'd5;
    #10;
    number_1 = 8'd100; 
    number_2 = 8'd255;
    #10;
    number_1 = 8'd180; 
    number_2 = 8'd180;

  end	

endmodule
