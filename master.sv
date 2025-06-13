//Master AXI4_LITE
//Author:Praveen Saravanan
module axi_lite_master #(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32)(
  input logic clk,
  input logic rst,
  axi_lite_if.master axi
);

  typedef enum logic [1:0] {IDLE, WRITE_ADDR, WRITE_DATA, READ_ADDR, READ_WAIT} state_t;
  state_t state;

  logic [ADDR_WIDTH-1:0] addr;
  logic [DATA_WIDTH-1:0] data;

  initial begin
    addr = 32'h00000004;
    data = 32'h12345678;
    state = IDLE;
  end

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      axi.AWVALID <= 0;
      axi.WVALID  <= 0;
      axi.BREADY  <= 0;
      axi.ARVALID <= 0;
      axi.RREADY  <= 0;
      state <= IDLE;
    end else begin
      case (state)
        IDLE: begin
          axi.AWADDR <= addr;
          axi.WDATA  <= data;
          axi.AWVALID <= 1;
          axi.WVALID  <= 1;
          state <= WRITE_ADDR;
        end

        WRITE_ADDR: begin
          if (axi.AWREADY && axi.WREADY) begin
            axi.AWVALID <= 0;
            axi.WVALID  <= 0;
            axi.BREADY  <= 1;
            state <= READ_ADDR;
          end
        end

        READ_ADDR: begin
          axi.ARADDR  <= addr;
          axi.ARVALID <= 1;
          state <= READ_WAIT;
        end

        READ_WAIT: begin
          if (axi.ARREADY) begin
            axi.ARVALID <= 0;
            axi.RREADY <= 1;
            state <= IDLE;
          end
        end
      endcase
    end
  end

endmodule
