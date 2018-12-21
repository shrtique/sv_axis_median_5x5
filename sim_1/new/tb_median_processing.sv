`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2018 13:41:32
// Design Name: 
// Module Name: tb_median_processing
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


module tb_median_processing();

localparam DATA_WIDTH  = 8;
localparam KERNEL_SIZE = 5;
localparam IMAGE_WIDTH = 10;

logic                  clk;
logic                  aresetn;
logic [DATA_WIDTH-1:0] image_kernel [0:KERNEL_SIZE-1] [0:KERNEL_SIZE-1];
logic [DATA_WIDTH-1:0] image_kernel_reg [0:KERNEL_SIZE-1] [0:KERNEL_SIZE-1];

logic                  image_data_valid, image_data_valid_reg;
logic                  sof, sof_reg;

median_processing#(

  .DATA_WIDTH  ( DATA_WIDTH  ),
  .KERNEL_SIZE ( KERNEL_SIZE )

) UUT (

  .i_clk                  ( clk              ),
  .i_aresetn              ( aresetn          ),

  .i_image_kernel_buffer  ( image_kernel_reg ),
  .i_image_data_valid     ( image_data_valid_reg ),
  .i_start_of_frame       ( sof_reg              ),

  .o_median_pixel         (                  ),
  .o_image_data_valid_reg (                  ),
  .o_start_of_frame_reg   (                  )  

);


//simulation
always
  begin
    clk = 1; #5; clk = 0; #5;
  end

initial
  begin
  	aresetn          = 1'b0;
  	image_kernel     = '{default: 'b0};
  	image_data_valid = 1'b0;
  	sof              = 1'b0;
  	#7;
  	aresetn          = 1'b1;

    /*image_kernel     = '{ 
                         '{92, 99,  1,   8,  15},
                         '{98, 80,  7,   14, 16},
                         '{4,  81,  88,  20, 22},
                         '{85, 87,  19,  21, 3},
                         '{86, 93,  25,  2,  9}
                       };
    */
    /*
    image_kernel     = '{ 
                         '{9 , 2 , 25, 93, 86},
                         '{3 , 21, 19, 87, 85},
                         '{22, 20, 88, 81, 4},
                         '{16, 14, 7 , 80, 98},
                         '{15, 8 , 1 , 99, 92}
                       };
    */
    /*                   
    image_kernel     = '{ 
                         '{99, 1 , 8 , 15, 67},
                         '{80, 7 , 14, 16, 73},
                         '{81, 88, 20, 22, 54},
                         '{87, 19, 21, 3 , 60},
                         '{93, 25, 2 , 9 , 61}
                       };
    */               
            
  
    
    image_kernel     = '{ 
                         '{20, 10, 1, 6, 8},
                         '{32, 5, 40, 100, 60},
                         '{14, 3, 22, 26, 68},
                         '{110, 12, 30, 7, 11},
                         '{72, 48, 36, 50, 80}
                       };
                       

    image_data_valid = 1'b1;
    sof              = 1'b1;

    #7;
    image_data_valid = 1'b0;
    sof              = 1'b0;                   

  end	


  always_ff @( posedge clk, negedge aresetn )
  begin
   if   ( ~aresetn ) begin

     image_kernel_reg     <= '{default:'h00};
     image_data_valid_reg <= 1'b0;
     sof_reg              <= 1'b0;


   end else begin

     image_kernel_reg     <= image_kernel;
     image_data_valid_reg <= image_data_valid;
     sof_reg              <= sof;

   end              
  end

endmodule
