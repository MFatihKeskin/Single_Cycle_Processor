/*
	Description: Execute Unit / Execute Unitesi
	Copyright: Muhammet Fatih KESKIN - 2020
*/

module lab8_mfk_p3 ( 
    input logic [31:0] rs1_data,rs2_data, 
    input logic [31:0] imm, 
    input logic [6:0] opcode, 
    input logic [3:0] func,  
    output logic [31:0] sonuc, 
    output logic pc_update, 
    output logic we, 
    output logic hata_e
);





always_comb
case(opcode)
opcode==7'b0000001: 
    begin 
        if (func==4'b000) begin //ADD
        sonuc = $signed(rs1_data) + $signed(rs2_data);
        hata_e= 0;
        pc_update = 0;
        we = 1;
        end
        else if (func==4'b1000) begin //SUB
        sonuc = $signed(rs1_data) - $signed(rs2_data); 
        hata_e= 0;
        pc_update = 0;
        we = 1;
        end
        else if (func==4'b0111) begin //AND
        sonuc = $signed(rs1_data) & $signed(rs2_data);
        hata_e= 0;
        pc_update = 0;
        we = 1;
        end
        else if (func==4'b0110) begin //OR
        sonuc = $signed(rs1_data)| $signed(rs2_data);
        hata_e= 0;
        pc_update = 0;
        we = 1;
        end
        else if (func==4'b0100) begin //EOR
        sonuc = $signed(rs1_data)^ $signed(rs2_data);
        end
        else if (func==4'b0001) begin //LSL
        sonuc = $signed(rs1_data) << $signed(rs2_data);
        hata_e= 0;
        pc_update = 0;
        we = 1;
        end
        else if (func==4'b0101) begin //LSR
        sonuc = $signed(rs1_data) >> $signed(rs2_data);
        hata_e= 0;
        pc_update = 0;
        we = 1;
        end
        else if (func==4'b1101) begin //ASR
        sonuc = $signed(rs1_data) >>> $signed(rs2_data);
        hata_e= 0;
        pc_update = 0;
        we = 1;
        end
        else begin
        sonuc = 32'b0;
        hata_e= 0;
        pc_update = 0;
        we = 1;
        end
    end
opcode==7'b0000011: 
    begin           
        if (func==4'b0000) begin //ADD    
        sonuc = $signed(rs1_data) + $signed(imm);
        hata_e= 0;        
        we = 1;        
        pc_update = 0;        end
        else if (func==4'b0111) begin //AND
        sonuc = $signed(rs1_data) & $signed(imm);  
        hata_e= 0;        
        we = 1;        
        pc_update = 0;        end
        else if (func==4'b0110) begin //OR
        sonuc = $signed(rs1_data) | $signed(imm); 
        hata_e= 0;        
        we = 1;        
        pc_update = 0;        end
        else if (func==4'b0100)   begin //XOR
        sonuc = $signed(rs1_data) ^ $signed(imm);
        hata_e= 0;        
        we = 1;        
        pc_update = 0;         end
        else if (func==4'b0001) begin //LSR 
        sonuc = $signed(rs1_data) << $signed(imm);  
        hata_e= 0;
        we = 1;
        pc_update = 0;        end
        else if (func==4'b0101)    begin //LSR
        sonuc = $signed(rs1_data) >> $signed(imm); 
        hata_e= 0;        
        we = 1;        
        pc_update = 0;        end
        else       begin
        sonuc = 32'b0;       
        hata_e= 0;        
        we = 1;        
        pc_update = 0;  end
    end 
opcode==7'b0000111: 
        begin    
            hata_e= 0;    
            we = 1;    
            pc_update =0;    
            sonuc = {32'd0,imm[19:0]};    
        end 
opcode==7'b0001111: 
        begin     
            hata_e= 0;        
            we = 0;        
            sonuc = {32'b0,imm[12:6] , imm[5:1]};        
            if (func==4'b0011)      
            pc_update = 1;        
            else if(func==4'b0000)  //EŞİT İSE PC_UPDATE=1   
            pc_update = ($signed(rs1_data)==$signed(rs2_data))?1:0;
            else if (func==4'b0001) //EŞİT DEĞİL İSE  PC_UPDATE=1
            pc_update = ($signed(rs1_data)!=$signed(rs2_data))?1:0;
            else if (func==4'b0100) //KÜÇÜK İSE  PC_UPDATE=1
            pc_update = ($signed(rs1_data)<$signed(rs2_data))?1:0;
            else if (func==4'b0101) //BÜYÜK EŞİT İSE  PC_UPDATE=1
            pc_update = ($signed(rs1_data)>=$signed(rs2_data))?1:0;
            else if (func==4'b0101) //KÜÇÜK İSE  PC_UPDATE=1(UNSİGNED)
            pc_update = ($unsigned(rs1_data)<$unsigned(rs2_data))?1:0;
            else if (func==4'b0111) //BÜYÜK EŞİT İSE  PC_UPDATE=1(UNSİGNED)
            pc_update = ($unsigned(rs1_data)>=$unsigned(rs2_data))?1:0;     
            else pc_update = 1'bX;     
            end    
    endcase
endmodule
