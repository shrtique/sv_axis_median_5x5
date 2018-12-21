`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2018 12:33:42
// Design Name: 
// Module Name: ranging_kernel
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


module ranging_kernel#(

  parameter DATA_WIDTH  = 8,
  KERNEL_SIZE           = 5,
  SORT_BY_COLUMN        = 0

)(

  input  logic                  i_clk,
  input  logic                  i_aresetn,

  input  logic [DATA_WIDTH-1:0] i_image_kernel_buffer [0:KERNEL_SIZE-1] [0:KERNEL_SIZE-1],

  output logic [DATA_WIDTH-1:0] o_image_kernel_sorted [0:KERNEL_SIZE-1] [0:KERNEL_SIZE-1]

);


//SIGNALS

//

//instantiate sorting_module_5inputs for each line/column of image_kernel_buffer 
//if sort_by_column == 1 - generate sort_col instantiation, else - generate sort_line instantiation

generate
  if ( SORT_BY_COLUMN ) begin
 
///////COLUMN_SORTING///////  
    sorting_module_5inputs#(
      .DATA_WIDTH ( DATA_WIDTH       )

    ) sort_col_0 (
      
      .i_clk     ( i_clk ),
      .i_aresetn ( i_aresetn ),

      .i_num_0   ( i_image_kernel_buffer[0][0] ),
      .i_num_1   ( i_image_kernel_buffer[1][0] ),
      .i_num_2   ( i_image_kernel_buffer[2][0] ),
      .i_num_3   ( i_image_kernel_buffer[3][0] ),
      .i_num_4   ( i_image_kernel_buffer[4][0] ),

      .o_num_0   ( o_image_kernel_sorted[0][0] ),
      .o_num_1   ( o_image_kernel_sorted[1][0] ),
      .o_num_2   ( o_image_kernel_sorted[2][0] ),
      .o_num_3   ( o_image_kernel_sorted[3][0] ),
      .o_num_4   ( o_image_kernel_sorted[4][0] )

    );//sort_col_0
    //
    //
    sorting_module_5inputs#(
      .DATA_WIDTH ( DATA_WIDTH       )

    ) sort_col_1 (

      .i_clk     ( i_clk ),
      .i_aresetn ( i_aresetn ),

      .i_num_0   ( i_image_kernel_buffer[0][1] ),
      .i_num_1   ( i_image_kernel_buffer[1][1] ),
      .i_num_2   ( i_image_kernel_buffer[2][1] ),
      .i_num_3   ( i_image_kernel_buffer[3][1] ),
      .i_num_4   ( i_image_kernel_buffer[4][1] ),

      .o_num_0   ( o_image_kernel_sorted[0][1] ),
      .o_num_1   ( o_image_kernel_sorted[1][1] ),
      .o_num_2   ( o_image_kernel_sorted[2][1] ),
      .o_num_3   ( o_image_kernel_sorted[3][1] ),
      .o_num_4   ( o_image_kernel_sorted[4][1] )

    );//sort_col_1
    //
    //
    sorting_module_5inputs#(
      .DATA_WIDTH ( DATA_WIDTH       )

    ) sort_col_2 (

      .i_clk     ( i_clk ),
      .i_aresetn ( i_aresetn ),

      .i_num_0   ( i_image_kernel_buffer[0][2] ),
      .i_num_1   ( i_image_kernel_buffer[1][2] ),
      .i_num_2   ( i_image_kernel_buffer[2][2] ),
      .i_num_3   ( i_image_kernel_buffer[3][2] ),
      .i_num_4   ( i_image_kernel_buffer[4][2] ),

      .o_num_0   ( o_image_kernel_sorted[0][2] ),
      .o_num_1   ( o_image_kernel_sorted[1][2] ),
      .o_num_2   ( o_image_kernel_sorted[2][2] ),
      .o_num_3   ( o_image_kernel_sorted[3][2] ),
      .o_num_4   ( o_image_kernel_sorted[4][2] )

    );//sort_col_2
    //
    //
    sorting_module_5inputs#(
      .DATA_WIDTH ( DATA_WIDTH       )

    ) sort_col_3 (

      .i_clk     ( i_clk ),
      .i_aresetn ( i_aresetn ),

      .i_num_0   ( i_image_kernel_buffer[0][3] ),
      .i_num_1   ( i_image_kernel_buffer[1][3] ),
      .i_num_2   ( i_image_kernel_buffer[2][3] ),
      .i_num_3   ( i_image_kernel_buffer[3][3] ),
      .i_num_4   ( i_image_kernel_buffer[4][3] ),

      .o_num_0   ( o_image_kernel_sorted[0][3] ),
      .o_num_1   ( o_image_kernel_sorted[1][3] ),
      .o_num_2   ( o_image_kernel_sorted[2][3] ),
      .o_num_3   ( o_image_kernel_sorted[3][3] ),
      .o_num_4   ( o_image_kernel_sorted[4][3] )

    );//sort_col_3
    //
    //
    sorting_module_5inputs#(
      .DATA_WIDTH ( DATA_WIDTH       )

    ) sort_col_4 (

      .i_clk     ( i_clk ),
      .i_aresetn ( i_aresetn ),

      .i_num_0   ( i_image_kernel_buffer[0][4] ),
      .i_num_1   ( i_image_kernel_buffer[1][4] ),
      .i_num_2   ( i_image_kernel_buffer[2][4] ),
      .i_num_3   ( i_image_kernel_buffer[3][4] ),
      .i_num_4   ( i_image_kernel_buffer[4][4] ),

      .o_num_0   ( o_image_kernel_sorted[0][4] ),
      .o_num_1   ( o_image_kernel_sorted[1][4] ),
      .o_num_2   ( o_image_kernel_sorted[2][4] ),
      .o_num_3   ( o_image_kernel_sorted[3][4] ),
      .o_num_4   ( o_image_kernel_sorted[4][4] )

    );//sort_col_4
    //
    //
  end else begin

///////LINE_SORTING///////
    sorting_module_5inputs#(
      .DATA_WIDTH ( DATA_WIDTH       )

    ) sort_line_0 (

      .i_clk     ( i_clk ),
      .i_aresetn ( i_aresetn ),

      .i_num_0   ( i_image_kernel_buffer[0][0] ),
      .i_num_1   ( i_image_kernel_buffer[0][1] ),
      .i_num_2   ( i_image_kernel_buffer[0][2] ),
      .i_num_3   ( i_image_kernel_buffer[0][3] ),
      .i_num_4   ( i_image_kernel_buffer[0][4] ),

      .o_num_0   ( o_image_kernel_sorted[0][0] ),
      .o_num_1   ( o_image_kernel_sorted[0][1] ),
      .o_num_2   ( o_image_kernel_sorted[0][2] ),
      .o_num_3   ( o_image_kernel_sorted[0][3] ),
      .o_num_4   ( o_image_kernel_sorted[0][4] )

    );//sort_line_0
    //
    //
    sorting_module_5inputs#(
      .DATA_WIDTH ( DATA_WIDTH       )

    ) sort_line_1 (

      .i_clk     ( i_clk ),
      .i_aresetn ( i_aresetn ),

      .i_num_0   ( i_image_kernel_buffer[1][0] ),
      .i_num_1   ( i_image_kernel_buffer[1][1] ),
      .i_num_2   ( i_image_kernel_buffer[1][2] ),
      .i_num_3   ( i_image_kernel_buffer[1][3] ),
      .i_num_4   ( i_image_kernel_buffer[1][4] ),

      .o_num_0   ( o_image_kernel_sorted[1][0] ),
      .o_num_1   ( o_image_kernel_sorted[1][1] ),
      .o_num_2   ( o_image_kernel_sorted[1][2] ),
      .o_num_3   ( o_image_kernel_sorted[1][3] ),
      .o_num_4   ( o_image_kernel_sorted[1][4] )

    );//sort_line_1
    //
    //
    sorting_module_5inputs#(
      .DATA_WIDTH ( DATA_WIDTH       )

    ) sort_line_2 (

      .i_clk     ( i_clk ),
      .i_aresetn ( i_aresetn ),

      .i_num_0   ( i_image_kernel_buffer[2][0] ),
      .i_num_1   ( i_image_kernel_buffer[2][1] ),
      .i_num_2   ( i_image_kernel_buffer[2][2] ),
      .i_num_3   ( i_image_kernel_buffer[2][3] ),
      .i_num_4   ( i_image_kernel_buffer[2][4] ),

      .o_num_0   ( o_image_kernel_sorted[2][0] ),
      .o_num_1   ( o_image_kernel_sorted[2][1] ),
      .o_num_2   ( o_image_kernel_sorted[2][2] ),
      .o_num_3   ( o_image_kernel_sorted[2][3] ),
      .o_num_4   ( o_image_kernel_sorted[2][4] )

    );//sort_line_2
    //
    //
    sorting_module_5inputs#(
      .DATA_WIDTH ( DATA_WIDTH       )

    ) sort_line_3 (

      .i_clk     ( i_clk ),
      .i_aresetn ( i_aresetn ),

      .i_num_0   ( i_image_kernel_buffer[3][0] ),
      .i_num_1   ( i_image_kernel_buffer[3][1] ),
      .i_num_2   ( i_image_kernel_buffer[3][2] ),
      .i_num_3   ( i_image_kernel_buffer[3][3] ),
      .i_num_4   ( i_image_kernel_buffer[3][4] ),

      .o_num_0   ( o_image_kernel_sorted[3][0] ),
      .o_num_1   ( o_image_kernel_sorted[3][1] ),
      .o_num_2   ( o_image_kernel_sorted[3][2] ),
      .o_num_3   ( o_image_kernel_sorted[3][3] ),
      .o_num_4   ( o_image_kernel_sorted[3][4] )

    );//sort_line_3
    //
    //
    sorting_module_5inputs#(
      .DATA_WIDTH ( DATA_WIDTH       )

    ) sort_line_4 (

      .i_clk     ( i_clk ),
      .i_aresetn ( i_aresetn ),

      .i_num_0   ( i_image_kernel_buffer[4][0] ),
      .i_num_1   ( i_image_kernel_buffer[4][1] ),
      .i_num_2   ( i_image_kernel_buffer[4][2] ),
      .i_num_3   ( i_image_kernel_buffer[4][3] ),
      .i_num_4   ( i_image_kernel_buffer[4][4] ),

      .o_num_0   ( o_image_kernel_sorted[4][0] ),
      .o_num_1   ( o_image_kernel_sorted[4][1] ),
      .o_num_2   ( o_image_kernel_sorted[4][2] ),
      .o_num_3   ( o_image_kernel_sorted[4][3] ),
      .o_num_4   ( o_image_kernel_sorted[4][4] )

    );//sort_line_4
    //
    //
  end//if ( sort_by_column )	

endgenerate

endmodule
