`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2018 14:28:57
// Design Name: 
// Module Name: tb_AXIS_pixel_receiver
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


module tb_AXIS_pixel_receiver();

localparam DATA_WIDTH  = 8;
localparam KERNEL_SIZE = 5;
localparam IMAGE_WIDTH = 10;


//signals

logic                  clk;
logic                  aresetn;

logic [DATA_WIDTH-1:0] image_data;
logic                  image_data_valid;
logic [DATA_WIDTH-1:0] image_kernel [0:KERNEL_SIZE-1] [0:KERNEL_SIZE-1];
logic                  start_of_frame;


AXIS_pixel_receiver #(
  .DATA_WIDTH     ( DATA_WIDTH  ),
  .KERNEL_SIZE    ( KERNEL_SIZE ),
  .IMAGE_WIDTH    ( IMAGE_WIDTH )

) UUT (

  .i_clk                ( clk              ),
  .i_aresetn            ( aresetn          ),

  .i_data               ( image_data       ),
  .i_data_valid         ( image_data_valid ),
  .i_start_of_frame     ( start_of_frame   ),

  .o_image_kernel       ( image_kernel     ),
  .o_data_valid         (  ),
  .o_start_of_frame_reg (  )
);	



//simulation
always
  begin
    clk = 1; #5; clk = 0; #5;
  end

initial
  begin
  	aresetn          = 1'b0;
  	#7;
  	aresetn          = 1'b1;

    image_data       = 1'b1;
    image_data_valid = 1'b1;
    start_of_frame   = 1'b1;
    #7;
    image_data       = 1'b0;
    start_of_frame   = 1'b0;

  end	


endmodule
