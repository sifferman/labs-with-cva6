
set top ucsbece154b_fifo
set name ucsbece154b_ooo_fifo_1.0.0

yosys -import
plugin -i systemverilog

yosys -import

read_systemverilog -PDATA_WIDTH=64 -PNR_ENTRIES=1024 -noinfo -nonote {../../ucsbece154b_fifo.sv}

synth_ice40 -top $top
write_json synth.json
