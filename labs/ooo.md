
# Out-of-Order

In this lab, you will be asked several questions to verify your understanding of Out-of-Order.

## Prelab

Read through the [CVA6 Execute Stage Documentation](https://docs.openhwgroup.org/projects/cva6-user-manual/03_cva6_design/ex_stage.html) and the [CVA6 Issue Stage Documentation](https://docs.openhwgroup.org/projects/cva6-user-manual/03_cva6_design/issue_stage.html), and use them to answer the following questions.

1. What is the purpose of Out-of-Order?
2. Give a brief explanation of Scoreboarding and Tomasulo's Algorithm. What are the pros and cons of each? Which OoO strategy does CVA6 use? (Extra: [Tomasulo's original paper](https://ieeexplore.ieee.org/document/5392028))
3. CVA6's rename unit will not be enabled for this lab. However, provide pseudocode that would run faster assuming the rename unit was enabled.
4. For each of the 7 functional units, provide:
    1. A brief explanation of its function.
    2. Which instructions it handles.
    3. How many cycles it takes to execute.
       (Link to [decoder.sv](https://github.com/openhwgroup/cva6/blob/master/core/decoder.sv), [ex_stage.sv](https://github.com/openhwgroup/cva6/blob/master/core/ex_stage.sv), and [ariane_pkg.sv](https://github.com/openhwgroup/cva6/blob/b9fa25a200ec69623c23cd7c5015a8482c43d794/core/include/ariane_pkg.sv#L382-L393))
5. Briefly describe when the following hazards can occur:
    1. Read-Write (RAW)
    2. Write-Write (WAW)
    3. Write-Read (WAR)
6. Using the following diagram of the CVA6 backend, explain the path that an instruction must take through the issue and execute stage. Be sure to include the issue queue, transaction IDs, source operands, the destination register, `rd_clobber`, the scoreboard, and any other important logic in your explanation.

    [![Scoreboard](./ooo/figures/scoreboard.svg)](https://docs.openhwgroup.org/projects/cva6-user-manual/03_cva6_design/issue_stage.html)

7. Provide a GitHub permalink to the following in CVA6:
    1. The issue queue instantiation
    2. The logic that specifies if a functional unit is ready to execute a new instruction
    3. The logic that stalls the pipeline due to the execute stage being too full for the next instruction
    4. The logic that determines which instruction(s) will be committed on the next cycle

## Part 1

Write a program that demonstrates the following situations:

* Out-of-Order Execution
* Read-Write hazard
* Write-Write hazard
* Write-Read hazard
* A branch miss
* The issue queue full

First, you will need to enable OoO in CVA6 by increasing the number of commit ports to `4` in the [configuration file](https://github.com/openhwgroup/cva6/blob/ed56df/core/include/cv64a6_imafdc_sv39_config_pkg.sv#L35).

## Part 1 Questions

When providing screenshots of waveforms, please include all signals you decide are relevant to demonstrate the event. Improper justification will result in a lower score.

1. Share your program. Be sure each situation is clearly commented.
2. Provide a waveform screenshot and a brief explanation of how the issue queue is affected for each of the following situations:
    1. Out-of-Order Execution
    2. Read-Write hazard
    3. Write-Write hazard
    4. Write-Read hazard
    5. A branch miss
    6. The issue queue full

## Part 2

In this part, you will implement a synchronous FIFO.

FIFOs (first-in-first-out queues) are incredibly popular in pipelined architecture designs. If two hardware units operate at different rates, the faster unit must stall whenever they communicate. However, a FIFO can be added to buffer the requests so that the faster unit will stall only when the FIFO is full. This strategy usually provides incredible speedup in a design. (CVA6 implements several FIFOs in its design.)

You should implement your FIFO with a cyclical buffer. You should have one block ram, with pointers to your FIFO `head` and `tail`. Here are some specifics:

* When you pop an element, you should increment the `head` pointer.
* When you push an element, you should increment the `tail` pointer.
* If the `head` or `tail` pointer reach `NR_ENTRIES`, they should reset to `0`.
* If the FIFO is empty, you should never pop.
* If the FIFO is full, you should only push if you are also popping.

The module you need to finish is [`"ucsbece154b_fifo.sv"`](https://github.com/sifferman/labs-with-cva6/blob/main/labs/ooo/part2/starter/ucsbece154b_fifo.sv), found in [`"labs/ooo/part2/starter"`](https://github.com/sifferman/labs-with-cva6/tree/main/labs/ooo/part2/starter). You can simulate your changes with ModelSim using `make sim TOOL=modelsim` (or Verilator 5 using `make sim TOOL=verilator` assuming that you have it set up). A [sample testbench](https://github.com/sifferman/labs-with-cva6/blob/main/labs/ooo/part2/starter/tb/fifo_tb.sv) is provided that you may edit as desired. You will also be graded on whether your design is synthesizable. You can run `make synth` to verify that it synthesizes with Yosys+Surelog correctly.

Now that you have seen a lot of CVA6's code, **you must mimic the coding practices/styles of CVA6**. This means using `_d` and `_q` nets for all your flip-flops, and using `always_comb` to set your `_d` nets, and using `always_ff` to set your `_q` nets, (though you do not need to create separate `_d` and `_q` nets for your block ram).
