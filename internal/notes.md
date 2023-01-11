
# Changes in Setup

* `"cva6/ci/build-riscv-gcc.sh"`: riscv-gnu-toolchain now uses latest version
* `"cva6/ci/install-spike.sh"`: no longer re-clones riscv/riscv-isa-sim
* `"cva6/Makefile"`: change to `$(if $(DEBUG), --trace --trace-structs,)`
* `"cva6/core/cva6.sv"`: add `initial begin $dumpfile( "cva6.vcd" ); $dumpvars; end`

```bash
../scripts/mk-install-dirs.sh /home/ethan/GitHub/cva6_wrapper/tools/include
for dir in fesvr       ; \
  do \
        ../scripts/mk-install-dirs.sh /home/ethan/GitHub/cva6_wrapper/tools/include/$dir; \
    /bin/install -c -m 644 config.h /home/ethan/GitHub/cva6_wrapper/tools/include/$dir; \
  done
mkdir /home/ethan/GitHub/cva6_wrapper/tools/include/fesvr
../scripts/mk-install-dirs.sh /home/ethan/GitHub/cva6_wrapper/tools/include
for file in fesvr/byteorder.h fesvr/elf.h fesvr/elfloader.h fesvr/htif.h fesvr/dtm.h fesvr/memif.h fesvr/syscall.h fesvr/context.h fesvr/htif_pthread.h fesvr/htif_hexwriter.h fesvr/option_parser.h fesvr/term.h fesvr/device.h fesvr/rfb.h fesvr/tsi.h riscv/mmio_plugin.h; \
  do \
        ../scripts/mk-install-dirs.sh /home/ethan/GitHub/cva6_wrapper/tools/include/`dirname $file`; \
    /bin/install -c -m 644 ../$file /home/ethan/GitHub/cva6_wrapper/tools/include/`dirname $file`; \
  done
```
