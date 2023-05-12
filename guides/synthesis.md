
# Writing Synthesizable SystemVerilog

This guide gives a brief overview of how to write synthesizable SystemVerilog. (When this guide fails, please move on to this guide: ["Busting the Myth that SystemVerilog is only for Verification"](https://sutherland-hdl.com/papers/2013-SNUG-SV_Synthesizable-SystemVerilog_paper.pdf).)

SystemVerilog and Verilog are overwhelmingly popular in digital design, but are partnered with extremely underdeveloped and unreliable software. This leads to extremely frequent instances of Verilog software not warning on bad code, and instances of software not understanding good code. For example, here is an example of a Verilog-2005 design that works with some tools, but not with others: <https://github.com/ucsb-ece154a/verilog_best_practices_example>.

By following this guide, you will learn how to overcome the shortcomings of Verilog/SystemVerilog tools and write synthesizable code that meets your desired specifications.

All code examples follow the [lowRISC Verilog Coding Style Specifications](https://github.com/lowRISC/style-guides/blob/master/VerilogCodingStyle.md).

## Table of Contents

* [Table of Contents](#table-of-contents)
* [DigitalJS Online](#digitaljs-online)
* [Inference](#inference)
* [Combinational Logic](#combinational-logic)
* [Latches](#latches)
* [Flip-Flops](#flip-flops)
* [Memory](#memory)
* [Clock and Reset](#clock-and-reset)
* [Simulation Tools](#simulation-tools)
* [Synthesis Tools](#synthesis-tools)
* [OSS CAD Suite](#oss-cad-suite)

## DigitalJS Online

[DigitalJS Online](https://digitaljs.tilk.eu/) is an incredible website that uses Verilator, Yosys, and ElkJS to lint, synthesize, and visualize any valid Verilog design. Playing around with this website for more than an hour will teach you more about Verilog than reading 90% of all the available online Verilog resources.

## Inference

Verilog and SystemVerilog are behavioral, which means that these languages describe the intended behavior of a circuit, and not the logic required to implement the design using physical hardware.

Inference in Verilog and SystemVerilog refers to the process by which logic cells or hardware components are automatically generated from the behavioral code. Synthesis tools will automatically infer which logic gates and other hardware components are necessary to implement the specified behavior.

Additionally, when mapping a synthesized design to a specified target (FPGA/ASIC), the synthesis tool will need to adjust its netlist to ensure that it only uses what logic cells are available. For example, an FPGA without any dedicated adder cells must use the gates it has available to implement an adder if one was described behaviorally.

The exception to this is that Verilog and SystemVerilog allow explicit instantiation of synthesis primitives to force logic cells to be added to the netlist. For example, [`$_DFF_N_`](https://github.com/YosysHQ/yosys/blob/master/techlibs/ice40/ff_map.v), [`SB_MAC16`](https://www.latticesemi.com/-/media/LatticeSemi/Documents/ApplicationNotes/AD/DSPFunctionUsageGuideforICE40Devices.ashx?document_id=50669), [`DSP48E1`](https://docs.xilinx.com/v/u/en-US/ug479_7Series_DSP48E1), etc.

## Combinational Logic

Combinational logic can be generated either by using `assign` or `always_comb`. The rule of thumb is, if you can do it cleanly in 1 line of code, use `assign`. Otherwise, use `always_comb`.

```systemVerilog
logic [WIDTH-1:0] data_i, data_plus1, data_plus2, data_o;

assign data_plus1   = data_i        + WIDTH'(1);
assign data_plus2   = data_plus1    + WIDTH'(1);
assign data_o       = data_plus2    + WIDTH'(1);
```

`always_comb` blocks allow for procedural assignment, which enables greater design flexibility.

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

An unwanted latch is generated in an `always_comb` block when a net is not updated for a possible input condition. A common good practice to avoid unwanted latches is to set default values for all combinational nets at the top of the `always_comb` block.

```systemVerilog
always_comb begin : y_latch
    y1_o = 0; // default value
    if (en_i) begin
        y0_o = x0_i; // latch (gives error)
        y1_o = x1_i; // no latch
    end
end
```

## Flip-Flops

A common practice is to split your flip-flops into `_d` and `_q` nets. This way, your code is organized better because all your combinational logic is clearly done to your `_d` net in an `always_comb` block, and your `_q` nets are assigned in a `always_ff` block using reset and the `_d` nets. Plus, `always_ff` blocks do not allow for procedural assignment, so `always_comb` blocks are always better for combinational logic.

Another popular naming strategy is to use `<NAME>_next` and `<NAME>_reg` instead of `<NAME>_d` and `<NAME>_q`. This is a personal preference, but it is crucial to match the coding style already introduced by the developers of the project. If it's your project, pick your favorite, and stick to it!

Note: the following are infamously buggy in synthesis tools:

* FF initial values (`initial data = 0;` or `logic data = 0;`). Instead, use a reset value for all FFs.
* Non-clock/reset logic in `always_ff`. If you are following the lowRISC naming style with `_d` and `_q`, this should never happen.

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

## Memory

Memories in designs are common, so FPGAs often have built-in block RAMs (BRAMs) that you can use. Unfortunately, synthesis tools are usually really bad at inferring memories from a design, and will often incorrectly infer an array of DFFs. If you want a BRAM, then you should either use target-specific BRAM primitives ([SB_RAM40_4K](https://www.latticesemi.com/-/media/LatticeSemi/Documents/ApplicationNotes/MO/MemoryUsageGuideforiCE40Devices.ashx?document_id=47775), [RAMB36E1](https://docs.xilinx.com/r/en-US/ug953-vivado-7series-libraries/RAMB36E1), etc.) or write clear behavioral code that the tool developers allow for memory inference.

For a tool to have the greatest success of inferring a memory, you should structure your code like this:

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

## Clock and Reset

Clock and reset nets hold highly sensitive global signals, and are better optimized when they are only used in `always_ff` blocks and not `always_comb` blocks.

When synthesizing your design, you often want to manually tell your synthesis software which nets are clocks. (Vivado example: [ucsbieee/mapache64 `"clk_constraints.xdc"`](https://github.com/ucsbieee/mapache64/blob/6ab8816c592a68c5168a956eed243ba345927583/hardware-level/rtl/top/synth/boards/cmod_a7/clk_constraints.xdc).)

## Simulation Tools

There are several Verilog Simulators to choose from, and each have pros and cons. Here is a quick summary of a few important ones:

### Open Source Simulation Tools

* Icarus Verilog
    * Pros: Easy to use, good Verilog-2005 support
    * Cons: Poor SystemVerilog support, slow for large designs, minimal error messages
* Verilator
    * Pros: Fast, gives incredibly detailed warnings, great SystemVerilog/Verilog support
    * Cons: [Does not support unknown (X) values](https://github.com/verilator/verilator/issues/3645)

### Proprietary Simulation Tools

(All good, but all expensive)

* Siemens ModelSim
* Synopsys VCS
* Cadence NCSim

## Synthesis Tools

### Open Source Synthesis Tools

The only good open-source synthesis software is Yosys. Yosys is a buggy mess that has laughable SystemVerilog support, and is infamous for absolutely scrambling designs without giving any warnings. Therefore, it is CRUCIAL that you ensure your code is well-linted and follows all best-practices before using Yosys.

### Proprietary Synthesis Tools

The proprietary tool will depend on what your FPGA supports. Though [Vivado](https://www.xilinx.com/products/design-tools/vivado.html) is well-liked and offers free synthesis for most Xilinx FPGAs.

## OSS CAD Suite

If you want a fully open-source design flow, you will need to install nearly a dozen tools that each do different things. You will need [Icarus](https://github.com/steveicarus/iverilog), [Verilator](https://github.com/verilator/verilator), [GTKWave](https://github.com/gtkwave/gtkwave), [Yosys](https://github.com/YosysHQ/yosys), [Surelog](https://github.com/chipsalliance/Surelog), [sv2v](https://github.com/zachjs/sv2v), [nextpnr](https://github.com/YosysHQ/nextpnr), [IceStorm](https://github.com/YosysHQ/icestorm), [openFPGALoader](https://github.com/trabucayre/openFPGALoader), and more. Most of these tools do not provide updated binaries and expect you to compile them yourself. However, as of 2021 this overwhelming scavenger hunt has been made exponentially easier!

[OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build) is a project that releases updated binaries of all common open-source digital design tools in one TAR file.

This is how to curl a release from OSS:

*Note: check the [latest release](https://github.com/YosysHQ/oss-cad-suite-build/releases/tag/latest) and edit the filenames in the script accordingly.*

```bash
cd ~/Downloads
curl -JOL https://github.com/YosysHQ/oss-cad-suite-build/releases/download/YYYY-MM-DD/oss-cad-suite-linux-x64-YYYYMMDD.tgz
tar -xzvf oss-cad-suite-linux-x64-YYYYMMDD.tgz -C ~/Utils/
```

Be sure to add the OSS CAD Suite `"bin"` directory to `PATH`.
