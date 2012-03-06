// structure type definition
typedef struct {
  logic unsigned [7:0] x;
  logic unsigned [7:0] y;
} t_point;


// testbench module
module structure_unpacked_wave_tb ();

// system signals
logic   clk = 1;
logic   rst = 1;
// input points
t_point point_i_A;
t_point point_i_B;
// output points
t_point point_o_A;
t_point point_o_B;

// clock generator
always #5 clk = ~clk;

// reset generator
initial begin
  repeat (4) @ (posedge clk);
  rst = 0;
end

// input data generator
always @ (posedge clk, posedge rst)
if (rst) begin
  point_i_A = '{x:8'h00, y:8'h00};
  point_i_B = '{x:8'hff, y:8'hff};
end else begin
  point_i_A.x = point_o_A.x + 8'd1;
  point_i_A.y = point_o_A.y + 8'd1;
  point_i_B.x = point_o_B.x - 8'd1;
  point_i_B.y = point_o_B.y - 8'd1;
end

// test finish
initial begin
  repeat (20) @ (posedge clk);
  $finish();
end

// module instance
structure_unpacked_wave dut (
  // system signals
  .clk        (clk),
  .rst        (rst),
  // input points
  .point_i_A  (point_i_A),
  .point_i_B  (point_i_B),
  // output points
  .point_o_A  (point_o_A),
  .point_o_B  (point_o_B)
);

endmodule


// RTL module
module structure_unpacked_wave (
  // system signals
  input  logic   clk,
  input  logic   rst,
  // input points
  input  t_point point_i_A,
  input  t_point point_i_B,
  // output points
  output t_point point_o_A,
  output t_point point_o_B
);

always @ (posedge clk, posedge rst)
if (rst) begin
  point_o_A = '{x:8'h00, y:8'h00};
  point_o_B = '{x:8'hff, y:8'hff};
end else begin
  point_o_A.x = point_o_A.x + 8'd1;
  point_o_A.y = point_o_A.y + 8'd1;
  point_o_B.x = point_o_B.x - 8'd1;
  point_o_B.y = point_o_B.y - 8'd1;
end

endmodule
