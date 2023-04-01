/*
 * File: ucsbece154b_fifo.sv
 * Description: Starter file for fifo.
 */

module ucsbece154b_fifo #(
    parameter int unsigned DATA_WIDTH = 32,
    parameter int unsigned NR_ENTRIES = 4
) (
    input   logic                   clk_i,
    input   logic                   rst_i,

    output  logic [DATA_WIDTH-1:0]  data_o,
    input   logic                   pop_i,

    input   logic [DATA_WIDTH-1:0]  data_i,
    input   logic                   push_i,

    output  logic                   full_o,
    output  logic                   valid_o
);

// TODO

endmodule
