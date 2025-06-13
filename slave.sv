module axi_lite_slave #(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32)(
  input logic clk,
  input logic rst,
  axi_lite_if.slave axi
);

  logic [DATA_WIDTH-1:0] reg_file [0:255];

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      axi.AWREADY <= 0;
      axi.WREADY  <= 0;
      axi.BVALID  <= 0;
      axi.ARREADY <= 0;
      axi.RVALID  <= 0;
    end else begin
      // Write channel
      axi.AWREADY <= axi.AWVALID;
      axi.WREADY  <= axi.WVALID;
      if (axi.AWVALID && axi.AWREADY && axi.WVALID && axi.WREADY) begin
        reg_file[axi.AWADDR] <= axi.WDATA;
        axi.BVALID <= 1;
        axi.BRESP  <= 2'b00;
      end else if (axi.BVALID && axi.BREADY) begin
        axi.BVALID <= 0;
      end

      // Read channel
      axi.ARREADY <= axi.ARVALID;
      if (axi.ARVALID && axi.ARREADY) begin
        axi.RDATA  <= reg_file[axi.ARADDR];
        axi.RVALID <= 1;
        axi.RRESP  <= 2'b00;
      end else if (axi.RVALID && axi.RREADY) begin
        axi.RVALID <= 0;
      end
    end
  end

endmodule
