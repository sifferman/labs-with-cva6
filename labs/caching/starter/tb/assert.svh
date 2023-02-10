/*
 * File: assert.svh
 * Description: Macro to help with handling errors in testbences.
 */

`ifndef __ASSERT_SVH
`define __ASSERT_SVH

`define ASSERT(CONDITION, MESSAGE) if ((CONDITION)==1'b1); else begin $display($sformatf("Error: %s", $sformatf MESSAGE)); ERROR = 1; end

`endif
