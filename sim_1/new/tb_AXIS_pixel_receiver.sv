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
localparam IMAGE_WIDTH = 4096;


//signals

logic                  clk;
logic                  aresetn;

logic [DATA_WIDTH-1:0] image_data, image_data_r;
logic                  image_data_valid, image_data_valid_r;
logic [DATA_WIDTH-1:0] image_kernel [0:KERNEL_SIZE-1] [0:KERNEL_SIZE-1];
logic                  start_of_frame, start_of_frame_r;
logic [31:0]           pixel_counter; 



AXIS_pixel_receiver #(
  .DATA_WIDTH     ( DATA_WIDTH  ),
  //.IMAGE_WIDTH    ( IMAGE_WIDTH ),
  .KERNEL_SIZE    ( KERNEL_SIZE )
  

) UUT (

  .i_clk                ( clk              ),
  .i_aresetn            ( aresetn          ),

  .IMAGE_WIDTH          ( IMAGE_WIDTH      ),

  .i_data               ( image_data_r       ),
  .i_data_valid         ( image_data_valid_r ),
  .i_start_of_frame     ( start_of_frame_r   ),

  .o_image_kernel_buffer       ( image_kernel     ),
  .o_data_valid         (  ),
  .o_start_of_frame     (  )
);  



//simulation
always
  begin
    clk = 1; #5; clk = 0; #5;
  end

initial
  begin

    aresetn          = 1'b0;
    image_data_valid = 1'b0;
    start_of_frame   = 1'b0;
    #7;
    aresetn          = 1'b1;

    image_data_valid = 1'b1;
    start_of_frame   = 1'b1;

    #7;
    start_of_frame   = 1'b0;
    #50
    //image_data_valid = 1'b0;
    #7;
    image_data_valid = 1'b1;

  end 

always_ff @( posedge clk, negedge aresetn )
  begin

    if ( ~aresetn ) begin
      image_data <= '0;
    end else begin  

      if ( image_data_valid ) begin      
        image_data++;
      end  
    end        
  end


always_ff @( posedge clk, negedge aresetn )
  begin

    if ( ~aresetn ) begin
      image_data_r       <= '0;
      image_data_valid_r <= 1'b0;
      start_of_frame_r   <= 1'b0;
      pixel_counter      <= '0;
    end else begin  
      image_data_valid_r <= image_data_valid;
      start_of_frame_r   <= start_of_frame;
      if ( image_data_valid_r ) begin      
        image_data_r       <= image_data_r + 1;
        pixel_counter      <= pixel_counter + 1;
      end  
    end        
  end


endmodule
