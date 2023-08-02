
all: clean stats timing

build/synth.json:
	@mkdir -p build
	cd build && yosys -l yosys.log -p 'tcl ../yosys.tcl'

build/synth.asc: build/synth.json
	@mkdir -p build
	cd build && nextpnr-ice40 -l next.log --hx8k --package ct256 --pcf-allow-unconstrained --json synth.json --asc synth.asc

build/synth.stat: build/synth.asc
	@mkdir -p build
	cd build && icebox_stat synth.asc > synth.stat

build/synth.tim: build/synth.asc
	@mkdir -p build
	cd build && icetime -r synth.tim synth.asc

stats: build/synth.stat

timing: build/synth.tim

clean:
	rm -rf build
