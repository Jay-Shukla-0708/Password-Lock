module Password_Lock_rtl (input wire clk, input wire reset, input wire latch_en, input wire [3:0] stored_pw_in, input wire [3:0] entered_pw, output reg match, output reg no_match);

reg [3:0] stored_pw;

always @(posedge clk or posedge reset)
begin 
if (reset)
stored_pw <= 4'b0000;
else if (latch_en)
stored_pw <= stored_pw_in;
end

always @(*)
begin
if(stored_pw == entered_pw)
match = 1'b1;
else 
match = 1'b0;
end
 
assign no_match = ~match;

endmodule

