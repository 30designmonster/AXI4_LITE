//Interface connection for Master to Slave
//Author:Praveen Saravanan
interface axi_lite_if #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32);

  logic                 ACLK;
  logic                 ARESETn;

  // Write Address Channel
  logic [ADDR_WIDTH-1:0] AWADDR;
  logic                  AWVALID;
  logic                  AWREADY;

  // Write Data Channel
  logic [DATA_WIDTH-1:0] WDATA;
  logic                  WVALID;
  logic                  WREADY;

  // Write Response Channel
  logic [1:0]            BRESP;
  logic                  BVALID;
  logic                  BREADY;

  // Read Address Channel
  logic [ADDR_WIDTH-1:0] ARADDR;
  logic                  ARVALID;
  logic                  ARREADY;

  // Read Data Channel
  logic [DATA_WIDTH-1:0] RDATA;
  logic [1:0]            RRESP;
  logic                  RVALID;
  logic                  RREADY;

  modport master (
    input  ARESETn, ACLK, AWREADY, WREADY, BVALID, BRESP, ARREADY, RVALID, RRESP, RDATA,
    output AWADDR, AWVALID, WDATA, WVALID, BREADY, ARADDR, ARVALID, RREADY
  );

  modport slave (
    input  ARESETn, ACLK, AWADDR, AWVALID, WDATA, WVALID, BREADY, ARADDR, ARVALID, RREADY,
    output AWREADY, WREADY, BVALID, BRESP, ARREADY, RVALID, RRESP, RDATA
  );

endinterface
