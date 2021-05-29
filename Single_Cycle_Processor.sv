/*
	Description: Single Cycle Processor / Tek Ritimli İşlemci
	Copyright: Muhammet Fatih KESKIN - 2020
*/

module decode ( //lab7_mfk_p3 ile aynı
input logic clk,reset, 
input logic we,
input logic [31:0] komut,
input logic [31:0] rd_data,
output logic [6:0] opcode,
output logic [3:0] aluop,
output logic [4:0] rs1,
output logic [4:0] rs2,
output logic [31:0] rs1_data, 
output logic [31:0] rs2_data, 
output logic [4:0] rd,
output logic [31:0] imm,
output logic hata_d
);
//p2 instantiate edilerek register file görevi görecek 
lab7_mfk_p2 inst2 (.clk(clk), .reset(reset), .rs1_data(rs1_data),.rs2_data(rs2_data),.rs1(rs1), .rs2(rs2),.we(we),.wbdata(rd_data),.waddr(rd));
//p1 intantiate edilmek yerine register olmadan p3 için 
//atandı.(çünkü modelsim ekranı görülmüyordu)

assign opcode = komut[6:0];

always_comb
begin
    if(komut[6:0] == 7'b0000001) //R Tipi değişken
    begin
        rs1 = komut[19:15];
        rs2 = komut[24:20];
        rd = komut[11:7];
        aluop[3] = komut[30]; aluop[2:0] = komut[14:12];
        aluop[3] = 1'b0; 
        imm = 32'd0;
        hata_d = 1'b0;
    end
    
    else if(komut[6:0] == 7'b0000011) //I Tipi değişken
    begin
        rs1 = komut[19:15];
        rd = komut[11:7];
        aluop[2:0] = komut[14:12]; aluop[3] = 1'b0;
        imm[11:0] = komut[31:20];
        imm[31:12] = 20'b0;
        hata_d = 1'b0;
        rs2 = 5'b00000;
    end

    else if(komut[6:0] == 7'b0000111) //U Tipi değişken
    begin
        rd = komut[11:7];
        imm[19:0] = komut[31:12]; imm[31:20] = 12'd0;
        hata_d = 1'b0;
        rs1 = 5'b00000;
        rs2 = 5'b00000;
        aluop = 4'b0000;
    end

    else if(komut[6:0] == 7'b0001111) //B Tipi değişken
    begin
        rs1 = komut[19:15];
        rs2 = komut[24:20];
        aluop[2:0] = komut[14:12]; aluop[3] = 1'b0;
        imm[12:6] = komut[31:25];  imm[5:1] = komut[11:7];
        imm[31:13] = 7'b0; imm[0] = 1'b0;
        hata_d = 1'b0;
        rd = 5'b00000;
    end
    
    else begin
        hata_d = 1;
        rs1 = 5'b0;
        rs2 = 5'b0;
        rd = 5'b0;
        aluop = 4'b0;
        imm = 32'b0;
    end
end
endmodule

module keskin(
 input logic clk,reset,
 input logic [31:0] komut,
 output logic [31:0]pc,
 output logic hata_d,
 input logic pc_update,
 input logic [31:0]pc_new
 
);
//fetch ve decode üniteleri çağırıldı
lab8_mfk_p1 inst0 (.clk(clk), .reset(reset), .pc(pc), .pc_new(pc_new), .pc_update(pc_update));
decode inst1 (.komut(komut),.hata_d(hata_d));
lab8_mfk_p3 (.func(func), .sonuc(sonuc), .pc_update(pc_update), .we(we), .rs1_data(rs1_data), .rs2_data(rs2_data), .imm(imm), .opcode(.opcode), .hata_e(.hata_e))
assign​ hata = hata_e | hata_d; 
endmodule
