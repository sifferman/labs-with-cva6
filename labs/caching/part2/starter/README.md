# Victim Cache Starter

## To-Do

Finish `"ucsbece154b_victim_cache.sv"` and `"tb/victim_cache_tb.sv"`.

## Usage

```bash
make sim TOOL=modelsim
gtkwave build/ucsbece154b_caching_victim_cache_1.0.0/tb-verilator/dump.fst
make lint_1way
make lint_2way
make lint_4way
make lint_16way
make synth
```
