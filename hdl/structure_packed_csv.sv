typedef struct packed {
  logic unsigned [7:0] x;
  logic unsigned [7:0] y;
} t_point;

module structure_packed_csv (
  // system signals
  input          clk,
  input          rst,
  // input points
  input  t_point point_i_A,
  input  t_point point_i_B,
  // output points
  output t_point point_o_A,
  output t_point point_o_B
);

always @ (posedge clk, posedge rst)
if (rst) begin
  point_o_A = '{x:8'h00 , y:8'h00};
  point_o_B = '{x:8'hff , y:8'hff};
end else begin
  point_o_A.x = point_o_A.x + 8'd1;
  point_o_A.y = point_o_A.y + 8'd1;
  point_o_B.x = point_o_B.x - 8'd1;
  point_o_B.y = point_o_B.y - 8'd1;
end

endmodule
