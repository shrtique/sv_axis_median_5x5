`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2018 13:34:13
// Design Name: 
// Module Name: AXIS_pixel_receiver
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

//DESCRIPTION:
//simple receiver of AXI Stream data for following image processing
//
//    DATA           KERNEL_BUFFER 5x5             LINE_BUFFER
// 47, 46, 45 -->  [ 44, 43, 42, 41, 40 ] --> [ 39, 38, 37, 36, 35 ] --> *
//          * -->  [ 34, 33, 32, 31, 30 ] --> [ 29, 28, 27, 26, 25 ] --> *
//          * -->  [ 24, 23, 22, 21, 20 ] --> [ 19, 18, 17, 16, 15 ] --> *
//          * -->  [ 14, 13, 12, 11, 10 ] --> [ 09, 08, 07, 06, 05 ] --> *
//          * -->  [ 04, 03, 02, 01, 00 ] --> ...  
//

module AXIS_pixel_receiver#(

  parameter DATA_WIDTH      = 8,
  //parameter MAX_IMAGE_WIDTH = 4096,
  //parameter IMAGE_WIDTH = 10,
  parameter KERNEL_SIZE     = 5

)(

  input  logic                  i_clk,
  input  logic                  i_aresetn,

  input  logic [12:0]           IMAGE_WIDTH,

  input  logic [DATA_WIDTH-1:0] i_data,
  input  logic                  i_data_valid,
  input  logic                  i_start_of_frame,

  output logic [DATA_WIDTH-1:0] o_image_kernel_buffer [0:KERNEL_SIZE-1] [0:KERNEL_SIZE-1],
  output logic                  o_data_valid,
  output logic                  o_start_of_frame
  

);



//////////////////////////////
//////////////////////////////

//signals


logic        rd_en_buf             [0:KERNEL_SIZE-1];
logic [7:0]  dout_line_buf         [0:KERNEL_SIZE-1];
logic [11:0] data_count_buf        [0:KERNEL_SIZE-1];

logic        prog_full_buf         [0:KERNEL_SIZE-1];
logic        full_buf              [0:KERNEL_SIZE-1];
logic        almost_full_buf       [0:KERNEL_SIZE-1];

logic        prog_empty_buf        [0:KERNEL_SIZE-1];
logic        empty_buf             [0:KERNEL_SIZE-1];
logic        almost_empty_buf      [0:KERNEL_SIZE-1];


logic [11:0] prog_full_thresh_buf;

//////////////////////////////
const logic [11:0] prog_empty_thresh_buf = 0;


assign prog_full_thresh_buf = IMAGE_WIDTH - 7; //this calculation is based on FIFO delay. 
                                               //FIFO outputs data after 7 clks from rising edgeof rd_en



//shifting through kernel_buffer when data is valid
always_ff @( posedge i_clk, negedge i_aresetn )
  begin
    if   ( ~i_aresetn ) begin
      o_image_kernel_buffer <= '{default: 'b0};
    end else begin  
     
      if ( i_data_valid ) begin

        o_image_kernel_buffer[0] <= {i_data, o_image_kernel_buffer[0][0:KERNEL_SIZE-2]};

        for ( int i = 1; i < KERNEL_SIZE-1; i++ ) begin
          o_image_kernel_buffer[i] <= {dout_line_buf[i-1], o_image_kernel_buffer[i][0:KERNEL_SIZE-2]};
        end

        o_image_kernel_buffer[KERNEL_SIZE-1] <= {dout_line_buf[KERNEL_SIZE-2], o_image_kernel_buffer[KERNEL_SIZE-1][0:KERNEL_SIZE-2]};

      end  
    end             
  end


genvar j;
generate
  for ( j = 0; j < KERNEL_SIZE-1; j++ ) begin

    assign rd_en_buf[j] = prog_full_buf[j] && i_data_valid; 

    fifo_generator_0 line_buffer_inst (
      .clk               ( i_clk                                   ),  // input wire clk
      .srst              ( ~i_aresetn                              ),  // input wire srst
      .din               ( o_image_kernel_buffer[j][KERNEL_SIZE-1] ),  // input wire [7 : 0] din
      .wr_en             ( i_data_valid                            ),  // input wire wr_en
      .rd_en             ( rd_en_buf[j]                            ),  // input wire rd_en

      .prog_empty_thresh ( prog_empty_thresh_buf                   ),  // input wire [11 : 0] prog_empty_thresh
      .prog_full_thresh  ( prog_full_thresh_buf                    ),  // input wire [11 : 0] prog_full_thresh

      .dout              ( dout_line_buf[j]                        ),  // output wire [7 : 0] dout

      .full              ( full_buf[j]                             ),  // output wire full
      .almost_full       ( almost_full_buf[j]                      ),  // output wire almost_full
      .empty             ( empty_buf[j]                            ),  // output wire empty
      .almost_empty      ( almost_empty_buf[j]                     ),  // output wire almost_empty
      .data_count        (                        ),  // output wire [11 : 0] data_count

      .prog_full         ( prog_full_buf[j]                       ),  // output wire prog_full
      .prog_empty        ( prog_empty_buf[j]                       )   // output wire prog_empty

    );

  end 
endgenerate 


//reg these signals to sync with next module
always_ff @( posedge i_clk, negedge i_aresetn )
  begin
    if ( ~i_aresetn ) begin
      o_data_valid     <= 1'b0;
      o_start_of_frame <= 1'b0;
    end else begin
      o_data_valid     <= i_data_valid;
      o_start_of_frame <= i_start_of_frame;
    end 
  end


//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////  
endmodule
