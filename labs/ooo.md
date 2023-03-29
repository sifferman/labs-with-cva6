
# Out-of-Order

In this lab, you will be asked several questions to verify your understanding of Out-of-Order.

## Prelab

Read through the [CVA6 Execute Stage Documentation](https://docs.openhwgroup.org/projects/cva6-user-manual/03_cva6_design/ex_stage.html) and the [CVA6 Issue Stage Documentation](https://docs.openhwgroup.org/projects/cva6-user-manual/03_cva6_design/issue_stage.html), and use them to answer the following questions.

1. What is the purpose of Out-of-Order?
2. Give a brief explanation of Scoreboarding and Tomasulo's Algorithm. What are the pros and cons of each? Which OoO strategy does CVA6 use? (Extra: [Tomasulo's original paper](https://ieeexplore.ieee.org/document/5392028))
3. CVA6's rename unit will not be enabled for this lab. However, provide pseudocode that would run faster assuming the rename unit was enabled.
4. CVA6 has 7 functional units in [`"ex_stage.sv"`](https://github.com/openhwgroup/cva6/blob/master/core/ex_stage.sv): ALU, Branch Unit, LSU, Multiplier, CSR Buffer, [FPU](https://github.com/openhwgroup/cvfpu), and [CVXIF](https://github.com/openhwgroup/core-v-xif). For each of the 7 functional units, provide:
    1. A brief explanation of its function.
    2. Which instructions it handles.
    3. How many cycles it takes to execute. (You don't have to do this question for the FPU and CVXIF).
5. Briefly describe when the following hazards can occur:
    1. Read after Write (RAW)
    2. Write after Write (WAW)
    3. Write after Read (WAR)
6. Using the following diagram of the CVA6 backend, explain the path that an instruction must take through the issue and execute stage. Be sure to include the issue queue, transaction IDs, source operands, the destination register, `rd_clobber`, the scoreboard, and any other important logic in your explanation.

    [![Scoreboard](./ooo/figures/scoreboard.svg)](https://docs.openhwgroup.org/projects/cva6-user-manual/03_cva6_design/issue_stage.html)

7. After looking through the issue stage and scoreboard RTL, Provide a GitHub permalink to the following in CVA6:
    1. The issue queue instantiation
    2. The logic that specifies if a functional unit is ready to execute a new instruction
    3. The logic that stalls the pipeline due to the execute stage being too full for the next instruction
    4. The logic that determines which instruction(s) will be committed on the next cycle

## Lab

Write a program that demonstrates the following situations:

* Out-of-Order Execution
* Read after Write hazard
* Write after Write hazard
* Write after Read hazard
* A branch miss
* The issue queue full

Note:

* A dependency hazard exists only if the instructions are run out-of-order when the dependency is removed. Verify this when writing your RAW, WAW, and WAR hazards.
* To enable out-of-order execution, your program must use a mix of instructions from the 3 functional unit types:
    * No more than 1 fixed latency unit operation (`ALU`, `CTRL_FLOW`, `CSR`, `MULT`) can be run simultaneously.
    * No more than 1 floating point unit operation (`FPU`, `FPU_VEC`) can be run simultaneously.
    * No more than 1 load-store unit operation (`LOAD`, `STORE`) can be run simultaneously.

An example of how to run RISC-V floating point instructions (RVF) is provided here: [`"fpu_example.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/rvf/fpu_example.S)

## Lab Questions

When providing screenshots of waveforms, please include all signals you decide are relevant to demonstrate the event. Improper justification will result in a lower score.

1. Share your program. Be sure each situation is clearly commented.
2. Provide a waveform screenshot and a brief explanation of **how the issue queue is affected** for each of the following situations:
    1. Out-of-Order Execution
    2. Read after Write hazard
    3. Write after Write hazard
    4. Write after Read hazard
    5. A branch miss
    6. The issue queue full
