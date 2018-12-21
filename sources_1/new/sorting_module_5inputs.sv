`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2018 01:58:54 PM
// Design Name: 
// Module Name: sorting_module_5inputs
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


module sorting_module_5inputs#(

  parameter DATA_WIDTH = 8

)(
  
  input  logic                  i_clk,
  input  logic                  i_aresetn,

  input  logic [DATA_WIDTH-1:0] i_num_0,
  input  logic [DATA_WIDTH-1:0] i_num_1,
  input  logic [DATA_WIDTH-1:0] i_num_2,
  input  logic [DATA_WIDTH-1:0] i_num_3,
  input  logic [DATA_WIDTH-1:0] i_num_4,


  output logic [DATA_WIDTH-1:0] o_num_0,
  output logic [DATA_WIDTH-1:0] o_num_1,
  output logic [DATA_WIDTH-1:0] o_num_2,
  output logic [DATA_WIDTH-1:0] o_num_3,
  output logic [DATA_WIDTH-1:0] o_num_4

);

////////////////
//STAGE1// START
//signals stage 1
logic [DATA_WIDTH-1:0] high_st1_3inputs, reg_high_st1_3inputs;
logic [DATA_WIDTH-1:0] med_st1_3inputs,  reg_med_st1_3inputs;
logic [DATA_WIDTH-1:0] low_st1_3inputs,  reg_low_st1_3inputs;

logic [DATA_WIDTH-1:0] high_st1_2inputs, reg_high_st1_2inputs;
logic [DATA_WIDTH-1:0] low_st1_2inputs,  reg_low_st1_2inputs;

logic [DATA_WIDTH-1:0] delay_high_st1_2inputs [0:3];
logic [DATA_WIDTH-1:0] delay_low_st1_2inputs  [0:3];


sorting_module_3inputs #(
  .DATA_WIDTH ( DATA_WIDTH       )
) stage_1_3in (

  .i_clk      ( i_clk      ),
  .i_aresetn  ( i_aresetn  ),

  .in_1       ( i_num_4          ),
  .in_2       ( i_num_3          ),
  .in_3       ( i_num_2          ),

  .high       ( high_st1_3inputs ),
  .med        ( med_st1_3inputs  ),
  .low        ( low_st1_3inputs  )   
);

sorting_module_2inputs #(
  .DATA_WIDTH ( DATA_WIDTH       )
) stage_1_2in (

  .i_clk      ( i_clk      ),
  .i_aresetn  ( i_aresetn  ),

  .in_1       ( i_num_1          ),
  .in_2       ( i_num_0          ),

  .high       ( high_st1_2inputs ),
  .low        ( low_st1_2inputs  )   
);

//module_2inputs has 1 clk delay, module_3inputs has 3 clk delay, we should sync them
always_ff @( posedge i_clk, negedge i_aresetn )
  begin
    if   ( ~i_aresetn ) begin
      delay_high_st1_2inputs <= '{default:'b0};
      delay_low_st1_2inputs  <= '{default:'b0};
    end else begin
      delay_high_st1_2inputs <= {high_st1_2inputs, delay_high_st1_2inputs[0:2]};
      delay_low_st1_2inputs  <= {low_st1_2inputs, delay_low_st1_2inputs[0:2]};
   end              
  end  


//registering
always_ff @(posedge i_clk, negedge i_aresetn)
  begin
  	if ( ~i_aresetn ) begin

      reg_high_st1_3inputs <= 0;
      reg_med_st1_3inputs  <= 0;
      reg_low_st1_3inputs  <= 0;

      reg_high_st1_2inputs <= 0;
      reg_low_st1_2inputs  <= 0;

  	end else begin

      reg_high_st1_3inputs <= high_st1_3inputs;
      reg_med_st1_3inputs  <= med_st1_3inputs;
      reg_low_st1_3inputs  <= low_st1_3inputs;

      reg_high_st1_2inputs <= delay_high_st1_2inputs[3];
      reg_low_st1_2inputs  <= delay_low_st1_2inputs[3];

  	end	
  end
//STAGE1// END
//////////////


////////////////
//STAGE2.1// START
//signals stage 2_1
logic [DATA_WIDTH-1:0] low_st2_1_2inputs_1;
logic [DATA_WIDTH-1:0] high_st2_1_2inputs_2, reg_high_st2_1_2inputs_2;


logic [DATA_WIDTH-1:0] o_num_4_st2_1;
logic [DATA_WIDTH-1:0] o_num_0_st2_1;

logic [DATA_WIDTH-1:0] reg_med_st1_3inputs_reg_st2_1[0:1];

sorting_module_2inputs #(
  .DATA_WIDTH ( DATA_WIDTH         )
) stage_2_2in_1 (

  .i_clk      ( i_clk      ),
  .i_aresetn  ( i_aresetn  ),

  .in_1       ( reg_high_st1_3inputs   ),
  .in_2       ( reg_high_st1_2inputs   ),

  .high       ( o_num_4_st2_1 ),         //to register
  .low        ( low_st2_1_2inputs_1  )   //to register
);

sorting_module_2inputs #(
  .DATA_WIDTH ( DATA_WIDTH          )
) stage_2_2in_2 (

  .i_clk      ( i_clk      ),
  .i_aresetn  ( i_aresetn  ),

  .in_1       ( reg_low_st1_3inputs ),
  .in_2       ( reg_low_st1_2inputs ),

  .high       ( high_st2_1_2inputs_2  ), //inner connection
  .low        ( o_num_0_st2_1         )  //to register 
);

always_ff @( posedge i_clk, negedge i_aresetn )
  begin
    if   ( ~i_aresetn ) begin
      reg_med_st1_3inputs_reg_st2_1 <= '{default:'b0};
    end else begin
      reg_med_st1_3inputs_reg_st2_1 <= {reg_med_st1_3inputs, reg_med_st1_3inputs_reg_st2_1[0]};
   end              
  end 


//STAGE2.2// START
//signals stage 2_2
logic [DATA_WIDTH-1:0] low_st2_2inputs_3, reg_low_st2_2inputs_3;
logic [DATA_WIDTH-1:0] high_st2_2inputs_3, reg_high_st2_2inputs_3;

logic [DATA_WIDTH-1:0] reg_low_st2_2inputs_1[0:1];
logic [DATA_WIDTH-1:0] reg_o_num_4_st2[0:1];
logic [DATA_WIDTH-1:0] reg_o_num_0_st2[0:1];

sorting_module_2inputs #(
  .DATA_WIDTH ( DATA_WIDTH          )
) stage_2_2in_3 (

  .i_clk      ( i_clk      ),
  .i_aresetn  ( i_aresetn  ),

  .in_1       ( reg_med_st1_3inputs_reg_st2_1[1] ),
  .in_2       ( high_st2_1_2inputs_2  ),

  .high       ( high_st2_2inputs_3  ), //to reg
  .low        ( low_st2_2inputs_3   )  //to reg 
);
//
always_ff @( posedge i_clk, negedge i_aresetn )
  begin
    if   ( ~i_aresetn ) begin
      reg_o_num_4_st2       <= '{default:'b0};
      reg_low_st2_2inputs_1 <= '{default:'b0};
      reg_o_num_0_st2       <= '{default:'b0};
    end else begin
      reg_o_num_4_st2       <= {o_num_4_st2_1, reg_o_num_4_st2[0]};
      reg_low_st2_2inputs_1 <= {low_st2_1_2inputs_1, reg_low_st2_2inputs_1[0]};
      reg_o_num_0_st2       <= {o_num_0_st2_1, reg_o_num_0_st2[0]};
   end              
  end 

//STAGE2.2// END
//
//STAGE2// END
////////////////


////////////////
//STAGE3// START
//signals stage 3
logic [DATA_WIDTH-1:0] o_num_1_st3;
logic [DATA_WIDTH-1:0] o_num_2_st3;
logic [DATA_WIDTH-1:0] o_num_3_st3;

logic [DATA_WIDTH-1:0] delay_reg_o_num_4_st2 [0:5];
logic [DATA_WIDTH-1:0] delay_reg_o_num_0_st2 [0:5];

sorting_module_3inputs #(
  .DATA_WIDTH ( DATA_WIDTH             )
) stage_3_3in (

  .i_clk      ( i_clk      ),
  .i_aresetn  ( i_aresetn  ),
  
  .in_1       ( reg_low_st2_2inputs_1[1]  ),
  .in_2       ( high_st2_2inputs_3 ),
  .in_3       ( low_st2_2inputs_3  ),

  .high       ( o_num_3_st3            ),
  .med        ( o_num_2_st3            ),
  .low        ( o_num_1_st3            )   
);

//delay reg_o_num_4_st2, reg_o_num_0_st2 to sync with module_3inputs with 3clk delay
always_ff @( posedge i_clk, negedge i_aresetn )
  begin
    if   ( ~i_aresetn ) begin
      delay_reg_o_num_4_st2 <= '{default:'b0};
      delay_reg_o_num_0_st2 <= '{default:'b0};
    end else begin
      delay_reg_o_num_4_st2 <= {reg_o_num_4_st2[1], delay_reg_o_num_4_st2[0:4]};
      delay_reg_o_num_0_st2 <= {reg_o_num_0_st2[1], delay_reg_o_num_0_st2[0:4]};
   end              
  end 
//
//


////////////////////////// 
//registering to outputs
always_ff @(posedge i_clk, negedge i_aresetn)
  begin
  	if ( ~i_aresetn ) begin

      o_num_0 <= 0;
      o_num_1 <= 0;
      o_num_2 <= 0;
      o_num_3 <= 0;
      o_num_4 <= 0;

  	end else begin

      o_num_0 <= delay_reg_o_num_0_st2[5];
      o_num_1 <= o_num_1_st3;
      o_num_2 <= o_num_2_st3;
      o_num_3 <= o_num_3_st3;
      o_num_4 <= delay_reg_o_num_4_st2[5];

  	end	
  end
//STAGE3// END
////////////////
endmodule
