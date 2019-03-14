// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu Mar 14 16:44:21 2019
// Host        : Michiel-Toshiba running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/michi/OneDrive/Documenten/Gitkraken
//               directory/PROGH_Eindopdracht/Eindopdracht/Eindopdracht.srcs/sources_1/ip/clk_148/clk_148_stub.v}
// Design      : clk_148
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_148(clk_out1, reset, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,reset,clk_in1" */;
  output clk_out1;
  input reset;
  input clk_in1;
endmodule