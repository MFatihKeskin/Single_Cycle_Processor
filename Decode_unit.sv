/*
	Description: İnstruction Decode Unit  / Decode Unitesi
	Copyright: Muhammet Fatih KESKIN - 2020
*/

module lab7_mfk_p2 (
   input  logic clk, reset,
   input  logic we,
   input  logic [4:0] waddr, 
   input  logic [31:0] wbdata,
   input  logic  [4:0] rs1,
   input  logic  [4:0] rs2,
   output logic [31:0] rs1_data,
   output logic [31:0] rs2_data
);

   logic [31:0]mem[0:31];
	
	logic we_reg;
	logic [4:0] waddr_reg; 
	logic [31:0] wbdata_reg;
	logic [4:0] rs1_reg;
	logic [4:0] rs2_reg;
	logic [31:0] rs1_data_reg;
   logic [31:0] rs2_data_reg;

always_comb
begin
  rs1_data_reg=mem[rs1_reg];
  rs2_data_reg=mem[rs2_reg];
end


   always_ff @(posedge clk) 
   begin
   if (we) begin mem[waddr_reg] <= wbdata; end
	else if(reset==1)//reset varsa
		begin
		we_reg <= 0;
		waddr_reg <= 0;
		wbdata_reg <=0;
		rs1_reg <=0;
		rs2_reg <=0;
		rs1_data <=0;
		rs2_data <=0;
		end
   we_reg <= we;
   waddr_reg <= waddr;
   wbdata_reg <=wbdata;
   rs1_reg <=rs1;
   rs2_reg <=rs2;
   rs1_data <=rs1_data_reg;
   rs2_data <=rs2_data_reg;
   end


endmodule
