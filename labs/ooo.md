
# Out-of-Order

In this lab, you will be asked several questions to verify your understanding of Out-of-Order.

## Prelab

Read through the [CVA6 Execute Stage Documentation](https://docs.openhwgroup.org/projects/cva6-user-manual/03_cva6_design/ex_stage.html) and the [CVA6 Issue Stage Documentation](https://docs.openhwgroup.org/projects/cva6-user-manual/03_cva6_design/issue_stage.html).

1. What is the purpose of Out-of-Order?
2. Give a brief explanation of Scoreboarding and Tomasulo's Algorithm. What are the pros and cons of each? Which OoO strategy does CVA6 use? (Extra: [Tomasulo's original paper](https://ieeexplore.ieee.org/document/5392028))
3. Although they are not included in CVA6, briefly describe the purposes of the following, and give a short pseudocode example where they would be used.
    1. Reorder Buffer
    2. Rename Unit
4. For each of the 7 functional units, provide:
    1. A brief explanation of its function.
    2. Which instructions it handles.
    3. How many cycles it takes to execute.
    (Link to [decoder.sv](https://github.com/openhwgroup/cva6/blob/master/core/decoder.sv) and [ex_stage.sv](https://github.com/openhwgroup/cva6/blob/master/core/ex_stage.sv))
5. Breifly describe when the following hazards can occur:
    1. Read-Write (RAW)
    2. Write-Write (WAW)
    3. Write-Read (WAR)
6. Provide a GitHub permalink to the following in CVA6:
    1. The issue queue instantiation
    2. The logic that specifies if a functional unit is ready to execute a new instruction
    3. The logic that stalls the pipeline due to the execute stage being too full for the next instruction
    4. The logic that determines which instruction(s) will be commited on the next cycle

## Part 1

Write a program that demonstrates the following situations:

* Out-of-Order Execution
* Read-Write hazard
* Write-Write hazard
* Write-Read hazard
* A branch miss after a `div` instruction
* An issue queue full of non-compressed instructions
* An issue queue full of compressed instructions

## Part 1 Questions

When providing screenshots of waveforms, please include all signals you decide are relevant to demonstrate the event. Improper justification will result in a lower score.

1. Share your program. Be sure each situation is clearly commented.
2. Provide screenshots of the following situations:
    1. Out-of-Order Execution
    2. Read-Write hazard
    3. Write-Write hazard
    4. Write-Read hazard
    5. A branch miss after a `div` instruction
    6. An issue queue full of non-compressed instructions
    7. An issue queue full of compressed instructions

## Part 2

*Coming soon...*
