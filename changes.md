
# Changes in Setup

* `"cva6/ci/build-riscv-gcc.sh"`: riscv-gnu-toolchain now uses latest version
* `"cva6/ci/install-spike.sh"`: no longer re-clones riscv/riscv-isa-sim
* `"cva6/Makefile"`: change to `$(if $(DEBUG), --trace --trace-structs,)`
* `"cva6/core/cva6.sv"`: add `initial begin $dumpfile( "cva6.vcd" ); $dumpvars; end`
