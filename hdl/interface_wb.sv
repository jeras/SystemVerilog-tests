////////////////////////////////////////////////////////////////////////////////
// interface declaration
////////////////////////////////////////////////////////////////////////////////

interface zbus #(
  WA = 32,  // width address
  WD = 32   // width data
)(
  input clk,  // clock
  input rst   // reset
);

  interface p2p #(
    WA = 32,  // width address
    WD = 32   // width data
  )(
    input clk,  // clock
    input rst   // reset
  );

    // bus ports
    logic          vld;
    logic          aen;
    logic          den;
    logic [WA-1:0] adr;
    logic [WD-1:0] dat;
    logic          rdy;

    // local signals 
    // output
    modport o (
      output vld,
      output aen, den,
      output adr, dat,
      input  rdy
    );

    // input
    modport i (
      input  vld,
      input  aen, den,
      input  adr, dat,
      output rdy
    );

    // local test control signals
    bit            trn;  // bus transfer
    bit            chk;  // bus check
    int            err;

    // registered bus values
    logic          aen_r;
    logic          den_r;
    logic [WA-1:0] adr_r;
    logic [WD-1:0] dat_r;

    // bus transfer
    assign trn = vld & rdy;

    // bus checker
    always @ (posedge clk, posedge rst)
    if (rst)  chk <= 1'b0;
    else      chk <= vld & !trn;

    // registered bus values
    always @ (posedge clk)
    begin
      aen_r <= aen;
      den_r <= den;
      adr_r <= adr;
      dat_r <= dat;
    end

    // error trigger
    always @ (posedge clk, posedge rst)
    if (rst)  err <= 0;
    else if (chk) begin
      if (aen_r == aen)  err <= err + 1;
      if (den_r == den)  err <= err + 1;
      if (adr_r == adr)  err <= err + 1;
      if (dat_r == dat)  err <= err + 1;
    end

  endinterface : p2p

  // master
  modport m (
    p2p.o w,  // write port
    p2p.i r   // read  port
  );
    
  // master
  modport m (
    p2p.i w,  // write port
    p2p.o r   // read  port
  );

endinterface : zbus

////////////////////////////////////////////////////////////////////////////////
// master demo
////////////////////////////////////////////////////////////////////////////////
