
# Writing Synthesizable SystemVerilog

This guide gives a brief overview of how to write Synthesizable SystemVerilog. (When this guide fails, please move on to this guide: ["Busting the Myth that SystemVerilog is only for Verification"](https://sutherland-hdl.com/papers/2013-SNUG-SV_Synthesizable-SystemVerilog_paper.pdf).)

SystemVerilog and Verilog are overwhelmingly popular in digital design, but are partnered with extremely underdeveloped and unreliable software. This leads to extremely frequent instances of Verilog software not warning on bad code, and instances of software not understanding good code. For example, this repository provides a Verilog-2005 design that works with some tools, but not with others: <https://github.com/ucsb-ece154a/verilog_best_practices_example>

## DigitalJS Online

[DigitalJS Online](https://digitaljs.tilk.eu/) is an incredible website that uses Verilator, Yosys, and ElkJS to lint, synthesize, and visualize any valid Verilog design. Playing around with this website for more than an hour will teach you more about Verilog than reading 90% of all the available online Verilog resources.

## Combinational Logic

Combinational logic can be generated either by using `assign` or `always_comb`. The rule of thumb is, if you can do it cleanly in 1 line of code, use `assign`. Otherwise, use `always_comb`.

```systemVerilog

logic [WIDTH-1:0] data_i, data_plus1, data_plus2, data_o;

assign data_plus1   = data_i        + WIDTH'(1);
assign data_plus2   = data_plus1    + WIDTH'(1);
assign data_o       = data_plus2    + WIDTH'(1);

```

```systemVerilog

always_comb begin : data_set
    data_o = data_i + WIDTH'(1);
    data_o = data_o + WIDTH'(1);
    data_o = data_o + WIDTH'(1);
end

```

## Latches

Latches are generally frowned-upon. Many FPGAs don't even have a latch cell you can use. Only use a latch if you REALLY know what you are doing.

To infer a latch, you should structure your code like this:

```systemVerilog

always_latch begin : y_latch
    if (en_i)
        y_o <= x_i;
end

```

## Flip-Flops

A common practice is to split your flip-flops into `_d` and `_q` nets. This way, your `always_ff` block is kept simple because all your combinational logic is done to your `_d` net. `always_ff` blocks are infamously buggy, so it is best to use them as little as possible.

To infer a flip-flop, you should structure your code like this:

```systemVerilog
logic [WIDTH-1:0] data_d, data_q;

always_comb begin : data_set
    data_d = input_i;
end

always_ff @(posedge clk_i) begin : data_ff
    if (rst_i) begin
        data_q <= '0;
    end else begin
        data_q <= data_d;
    end
end

```

## BRAM

To infer a BRAM, you should structure your code like this:

```systemVerilog
// instantiation
logic [DATA_WIDTH-1:0] MEM [0:NR_ENTRIES-1];

// read port
assign rdata_o = MEM[raddr_i];

// write port
always_ff @(posedge clk_i) begin : mem_write
    if (we_i)
        MEM[waddr_i] <= wdata_i;
end
```

## Clocks and Reset

Clocks and reset nets are highly sensitive, global nets, and are often optimized better when they are only used in `always_ff` blocks and not `always_comb` blocks.

When synthesizing your design, you often want to manually tell your synthesis software which nets are clocks and divided clocks. (Vivado example: [ucsbieee/mapache64 `"clk_constraints.xdc"`](https://github.com/ucsbieee/mapache64/blob/6ab8816c592a68c5168a956eed243ba345927583/hardware-level/rtl/top/synth/boards/cmod_a7/clk_constraints.xdc).)

## Simulation Tools

There are several Verilog Simulators to choose from, and each have pros and cons. Here is a quick summary of a few important ones.

### Open Source

* Icarus Verilog
    * Pros: Easy to use, good Verilog-2005 support
    * Cons: Poor SystemVerilog support, slow for large designs
* Verilator
    * Pros: Fast, gives incredibly detailed warnings, great SystemVerilog/Verilog support
    * Cons: [Does not support unknown values](https://github.com/verilator/verilator/issues/3645)

### Proprietary

(All good, but all expensive)

* Siemens ModelSim
* Synopsys VCS
* Cadence NCSim

## Synthesis Tools

The only good open-source synthesis software is Yosys. Yosys is a buggy mess that has laughable SystemVerilog support, and is infamous for absolutely scrambling designs without giving any warnings. Therefore, it is CRUCIAL that you ensure your code is well-linted and follows all best-practices.

The proprietary tool will depend on what your FPGA supports.
