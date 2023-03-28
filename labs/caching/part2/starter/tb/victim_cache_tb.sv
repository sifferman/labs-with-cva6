/*
 * File: victim_cache_tb.sv
 * Description: Example testbench to test a victim cache.
 */

`include "assert.svh"

module victim_cache_tb ();

parameter int unsigned ADDR_WIDTH = 56;
parameter int unsigned LINE_WIDTH = 128;

logic                   clk_i = 0;
logic                   rst_ni;
logic                   flush_i;
logic                   en_i;
logic [ADDR_WIDTH-1:0]  raddr_i;
logic [LINE_WIDTH-1:0]  rdata_o;
logic                   hit_o;
logic                   we_i;
logic [ADDR_WIDTH-1:0]  waddr_i;
logic [LINE_WIDTH-1:0]  wdata_i;

always #10 clk_i = ~clk_i;
ucsbece154b_victim_cache #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .LINE_WIDTH(LINE_WIDTH),
    .NR_ENTRIES(2) // modify as needed
) victim_cache (.*);

logic ERROR = 0;
initial begin
$dumpfile( "dump.fst" );
$dumpvars;
$display( "Begin simulation." );
//\\ =========================== \\//



// reset/initialize
rst_ni  = 1'b1;
flush_i = 1'b1;
en_i    = 1'b1;

raddr_i = '0;

we_i    = '0;
waddr_i = '0;
wdata_i = '0;

@(negedge clk_i);
@(negedge clk_i);

// write beef to 1000
rst_ni = 1'b1;
flush_i = 1'b0;

we_i = 1'b1;
waddr_i = (ADDR_WIDTH)'(32'h1000);
wdata_i = (LINE_WIDTH)'(32'hbeef);

@(negedge clk_i);

// assert read beef at 1000
raddr_i = (ADDR_WIDTH)'(32'h1000);

we_i = 1'b0;

#1;
`ASSERT(hit_o==1'b1, ("Write then read did not give hit"));
`ASSERT(rdata_o==(LINE_WIDTH)'(32'hbeef), ("Write then read gave wrong data"));

@(negedge clk_i);

// write bead to 2000
we_i = 1'b1;
waddr_i = (ADDR_WIDTH)'(32'h2000);
wdata_i = (LINE_WIDTH)'(32'hbead);

@(negedge clk_i);

we_i = 1'b0;

// assert read beef at 1000
raddr_i = (ADDR_WIDTH)'(32'h1000);

#1;
`ASSERT(hit_o==1'b1, ("2 writes then read did not give hit"));
`ASSERT(rdata_o==(LINE_WIDTH)'(32'hbeef), ("2 writes then read gave wrong data"));

// assert read bead at 2000
raddr_i = (ADDR_WIDTH)'(32'h2000);

#1;
`ASSERT(hit_o==1'b1, ("2 writes then read did not give hit"));
`ASSERT(rdata_o==(LINE_WIDTH)'(32'hbead), ("2 writes then write then read gave wrong data"));



//\\ =========================== \\//
$display("End simulation.");
if (ERROR) $fatal();
$stop;
end

endmodule
