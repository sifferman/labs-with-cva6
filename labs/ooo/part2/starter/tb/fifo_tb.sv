/*
 * File: fifo_tb.sv
 * Description: Example testbench for fifo.
 */

`include "assert.svh"

module fifo_tb #(
    parameter int unsigned DATA_WIDTH = 32,
    parameter int unsigned NR_ENTRIES = 4
) ();

logic                   clk_i = 0;
logic                   rst_i;

logic [DATA_WIDTH-1:0]  data_o;
logic                   pop_i;

logic [DATA_WIDTH-1:0]  data_i;
logic                   push_i;

logic                   full_o;
logic                   valid_o;

always #10 clk_i = ~clk_i;
ucsbece154b_fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .NR_ENTRIES(NR_ENTRIES) // modify as needed
) fifo (.*);

int i;
logic ERROR = 0;
initial begin
$dumpfile( "dump.fst" );
$dumpvars;
$display( "Begin simulation." );
//\\ =========================== \\//



// reset/initialize
rst_i  = 1'b1;
data_i = '0;
pop_i = 1'b0;
push_i = 1'b0;

@(negedge clk_i);

`ASSERT(valid_o==1'b0, ("Not reporting as invalid after reset"));

rst_i = 1'b0;

push_i = 1'b1;

for (i = 1; i <= (NR_ENTRIES+1); i++) begin
    if (i==(NR_ENTRIES+1)) // if trying to push SIZE+1th item
        `ASSERT(full_o==1'b1, ("Not reporting as full after filling"));
    data_i = {DATA_WIDTH{4'(i)}};
    @(negedge clk_i);
    `ASSERT(valid_o==1'b1, ("Not reporting as valid after pushing"));
end



//\\ =========================== \\//
$display( "End simulation.");
if (ERROR) $fatal();
$stop;
end

endmodule
