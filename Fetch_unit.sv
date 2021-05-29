/*
	Description: İnstruction Fetch Unit / Fetch Ünitesi 
	Copyright: Muhammet Fatih KESKIN - 2020
*/

module lab8_mfk_p1(
	input logic clk,reset,
	output logic [31:0] pc,
	input logic pc_update,
	input logic [31:0] pc_new
);
    logic [31:0] pc_reg;
always_ff @(posedge clk,negedge reset)
    begin
        pc <= pc_reg;
        if(!reset)
        pc_reg=0;
        else if(pc_update==1)
            pc_reg <= pc_new;
        else
            pc_reg <= pc_reg+4;
    end
endmodule

