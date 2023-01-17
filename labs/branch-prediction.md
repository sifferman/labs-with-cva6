
# Branch Prediction

In this lab, you will need to modify the existing [branch predictor](https://github.com/openhwgroup/cva6/blob/6deffb27d7f031341e33e84c422a19e39095aa6c/core/frontend/bht.sv). See the [Your Own Repository Guide](../guides/your-own-repo.md) for our recommended way to organize and collaborate on labs.

## Pre-Lab Questions

1. Define, compare, and contrast the following:
  * Static branch prediction
  * Dynamic branch prediction
  * One-level branch prediction
  * Two-level predictor
  * Local branch prediction
  * Global branch prediction
2. What kind of branch predictor does CVA6 use by default?
3. Define BHT and BTB. What are they used for? Explain the path that an instruction takes before a branch-taken can be predicted.
4. When can more than 1 instruction be fetched per cycle?

## Part 1

Add a counter to [bht.sv](https://github.com/openhwgroup/cva6/blob/6deffb27d7f031341e33e84c422a19e39095aa6c/core/frontend/bht.sv) that records the number of predictions and mispredictions and writes the branch predictor hit rate to a file on every instruction.

### Part 1 Questions

1. Share your modified `"bht.sv"` that records the hit rate.
2. What are the final hit rate percentages of each of the [bp benchmarks](https://github.com/sifferman/labs-with-cva6/tree/main/programs/bp)?
3. Provide a GitHub permalink to where the bht saturation counter initial value is set. Rerun all the [bp benchmarks](https://github.com/sifferman/labs-with-cva6/tree/main/programs/bp) and find the final hit rate for after setting the initial condition to strongly-taken, weakly-taken, weakly-not-taken, and strongly-taken. Display the hit rates in a table. Explain your findings.

## Part 2

Modify the [bht.sv](https://github.com/openhwgroup/cva6/blob/6deffb27d7f031341e33e84c422a19e39095aa6c/core/frontend/bht.sv) and turn it into a [Gshare Branch Predictor](https://en.wikipedia.org/wiki/Branch_predictor#Global_branch_prediction).

### Part 2 Questions

1. Share your modified `"bht.sv"` that implements a Gshare Branch Predictor.
2. What are your hit percentages for each of the [bp benchmarks](https://github.com/sifferman/labs-with-cva6/tree/main/programs/bp)? Explain the hit rate percentages you see for each file.

## Gshare Branch Predictor Specifications

**TODO**

## Code Submission

Submit your modified `"bht.sv"` that implements a Gshare Branch Predictor to the Gradescope autograder.
