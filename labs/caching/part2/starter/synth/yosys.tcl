
set top ucsbece154b_victim_cache
set name ucsbece154b_caching_victim_cache_1.0.0

yosys -import
plugin -i systemverilog

yosys -import

read_systemverilog -noinfo -nonote {../../unread.sv}
read_systemverilog -PNR_ENTRIES=4 -PADDR_WIDTH=16 -PLINE_WIDTH=16 -noinfo -nonote {../../ucsbece154b_victim_cache.sv}

synth_ice40 -top $top
opt
write_json synth.json
