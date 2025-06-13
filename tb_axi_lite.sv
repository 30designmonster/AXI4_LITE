//testbench axi4_lite
//Author:Praveen Saravanan
`timescale 1ns/1ps

module tb_axi_lite;

  logic clk, rst;

  // Interface
  axi_lite_if axi();

  // DUT instantiations
  axi_lite_master master_inst(
    .clk(clk),
    .rst(rst),
    .axi(axi)
  );

  axi_lite_slave slave_inst(
    .clk(clk),
    .rst(rst),
    .axi(axi)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_axi_lite);

    clk = 0;
    rst = 1;

    #15 rst = 0;

    #200 $finish;
  end

endmodule
