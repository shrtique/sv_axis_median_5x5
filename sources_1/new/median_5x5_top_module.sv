`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2018 13:24:05
// Design Name: 
// Module Name: median_5x5_top_module
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
//This is simplified module of median filtration with 5x5 window.
//It has 3 stages: sorting by lines -> sorting by columns -> sorting main diagonal*
//* main diagonal is one that has the smallest value of "biggest" column and..
//.. biggest value of "smallest" column
//
// EXAMPLE
//
//   [ 20,  10, 1,  6,   8  ]       [ 20,  10, 8,  6,  1  ]       [ 110, 72, 50, 48, 36 ]       [ * , * , *,  *,  36 ]
//   [ 32,  5,  40, 100, 60 ]       [ 100, 60, 40, 32, 5  ]       [ 100, 60, 40, 32, 7  ]       [ * , * , *,  32, *  ]
//   [ 14,  3,  22, 26,  68 ]  -->  [ 68,  26, 22, 14, 3  ]  -->  [ 80 , 30, 22, 14, 5  ]  -->  [ * , * , 26, * , *  ] 
//   [ 110, 12, 30, 7,   11 ]       [ 110, 30, 12, 11, 7  ]       [ 68 , 26, 12, 11, 3  ]       [ * , 22, * , * , *  ]
//   [ 72,  48, 36, 50,  80 ]       [ 80,  72, 50, 48, 36 ]       [ 20 , 10, 8 , 6 , 1  ]       [ 20, * , * , * , *  ] 
//    
//   median = 26
//
//
//IMORTANT NOTE:
//This algorithm could make a mistake in one discret (one position): so if we range all pixels in upwards direction..
//.. the median value will be on position 13 (from 1 up to 25), but sometimes algorithm takes neighbour value (e.g. 12).
//We decided that this mistake can't dramatically decrease efficiency of suppressing impulsive noise on image



module median_5x5_top_module #(

  parameter DATA_WIDTH  = 8,
  //parameter IMG_WIDTH   = 1280,
  //parameter IMG_HEIGHT  = 1024,
  parameter KERNEL_SIZE = 5

)(

  input  logic                    i_clk,
  input  logic                    i_aresetn,

  input  logic [12:0]             WIDTH,
  input  logic [12:0]             HEIGHT,

  input  logic [DATA_WIDTH-1:0]   s_axis_data,
  input  logic                    s_axis_tvalid,
  input  logic                    s_axis_tuser,
  input  logic                    s_axis_tlast,
  output logic                    s_axis_tready,

  output logic [DATA_WIDTH-1:0]   m_axis_tdata,
  output logic                    m_axis_tvalid,
  output logic                    m_axis_tuser,
  output logic                    m_axis_tlast

);


//
//show that we're ready to receive pixels
always_ff @( posedge i_clk, negedge i_aresetn )
  begin 
    if ( ~i_aresetn ) begin
      s_axis_tready <= 1'b0;
    end else begin
      s_axis_tready <= 1'b1;
    end
end
//
//

// ASSIGNES
//parameters signals
logic [12:0] img_width;
logic [12:0] img_height;

assign img_width  = WIDTH;
assign img_height = HEIGHT;


////INST////

//1. RECEIVER

//signals
logic [DATA_WIDTH-1:0] kernel_image_buffer_from_receiver [0:KERNEL_SIZE-1] [0:KERNEL_SIZE-1];
logic                  data_valid_from_receiver;
logic                  sof_from_receiver;

AXIS_pixel_receiver #(

  .DATA_WIDTH  ( DATA_WIDTH  ),
  .KERNEL_SIZE ( KERNEL_SIZE ),
  .IMAGE_WIDTH ( IMG_WIDTH  )

) data_receiver (

  .i_clk                 ( i_clk                             ),
  .i_aresetn             ( i_aresetn                         ),

  .i_data                ( s_axis_data                       ),
  .i_data_valid          ( s_axis_tvalid                     ),
  .i_start_of_frame      ( s_axis_tuser                      ),

  .o_image_kernel_buffer ( kernel_image_buffer_from_receiver ),
  .o_data_valid          ( data_valid_from_receiver          ),
  .o_start_of_frame      ( sof_from_receiver                 )
  
);
//
//

//2. PROCESSING

//signals

logic [DATA_WIDTH-1:0] data_from_processing;
logic                  data_valid_from_processing;
logic                  sof_from_processing;


median_processing #(

  .DATA_WIDTH  ( DATA_WIDTH  ),
  .KERNEL_SIZE ( KERNEL_SIZE )

) data_processing (

  .i_clk                  ( i_clk                             ),
  .i_aresetn              ( i_aresetn                         ),

  .i_image_kernel_buffer  ( kernel_image_buffer_from_receiver ),
  .i_image_data_valid     ( data_valid_from_receiver          ),
  .i_start_of_frame       ( sof_from_receiver                 ),

  .o_median_pixel         ( data_from_processing              ),
  .o_image_data_valid_reg ( data_valid_from_processing        ),
  .o_start_of_frame_reg   ( sof_from_processing               )  

);
//
//

//3. TRANSMITTER

//signals

median_M_AXIS_FSM #(
  .DATA_WIDTH  ( DATA_WIDTH  ),
  .IMG_WIDTH   ( IMG_WIDTH   ),
  .IMG_HEIGHT  ( IMG_HEIGHT  ),
  .KERNEL_SIZE ( KERNEL_SIZE )
) data_transmitter (	
  .i_clk              ( i_clk                      ),
  .i_aresetn          ( i_aresetn                  ),

  .i_median_pixel     ( data_from_processing       ),
  .i_image_data_valid ( data_valid_from_processing ),
  .i_start_of_frame   ( sof_from_processing        ),

  .m_axis_tdata       ( m_axis_tdata               ),
  .m_axis_tvalid      ( m_axis_tvalid              ),
  .m_axis_tuser       ( m_axis_tuser               ),
  .m_axis_tlast       ( m_axis_tlast               )

);

endmodule
