/*
-------------------------------------------------------------------------
Disciplina: Arquitetura e Organização de Computadores - 2026.1
Projeto 2VA - Implementação de processador monociclo MIPS em verilog
Grupo: Alison Guilherme, Murilo Antonino e Otávio Olimpio
-------------------------------------------------------------------------
*/
`include "defines.vh"

module control(
  input [5:0] opcode,
  input [5:0] funct,
  output reg RegDst, Jump, Branch, MemRead, MemtoReg,
  output reg [1:0] ALUOp,
  output reg MemWrite, ALUSrc, RegWrite, Jr, ExtOp, JalEn, LuiEn
);

  // bloco combinacional: sensível a qualquer mudança nas entradas
  always @(*) begin
    
    // inicia todos os sinais em 0 para decodificar
    RegDst=0; Jump=0; Branch=0; MemRead=0; MemtoReg=0;
    ALUOp=`ALUOP_LW_SW_ADDI; MemWrite=0; ALUSrc=0; RegWrite=0;
    Jr=0; ExtOp=1; JalEn=0; LuiEn=0; // ExtOp=1 por padrão - extensão de sinal)

    case (opcode)
      
      //Instrucao tipo r
      `MIPS_RTYPE: begin
        RegDst = 1;      // destino sendo o registrador Rd (bits 15-11)
        RegWrite = 1;    // permite escrita no banco de registradores
        ALUOp = `ALUOP_RTYPE; // sinaliza a ULA_Ctrl para verificar o 'funct'
       
        //caso especial: JR tipo r mas afeta o fluxo
        if (funct == `FUNCT_JR) begin
            Jr = 1;
            RegWrite = 0; // JR sem escrita
        end
      end

      //Instrucao tipo i
      `MIPS_ADDI: begin 
          ALUSrc = 1;    // segundo operando da ULA eh o Imediato
          RegWrite = 1;  // grava o resultado
      end
      
      // logica = usam extensao de zero (ExtOp = 0) pq nao tem sinal
      `MIPS_ANDI: begin ALUSrc = 1; RegWrite = 1; ExtOp = 0; ALUOp = `ALUOP_ANDI_ORI_XORI; end
      `MIPS_ORI:  begin ALUSrc = 1; RegWrite = 1; ExtOp = 0; ALUOp = `ALUOP_ANDI_ORI_XORI; end
      `MIPS_XORI: begin ALUSrc = 1; RegWrite = 1; ExtOp = 0; ALUOp = `ALUOP_ANDI_ORI_XORI; end

      //instrucao de desvio condicional branch
      `MIPS_BEQ:  begin Branch = 1; ALUOp = `ALUOP_BEQ_BNE; end // ULA faz subtração
      `MIPS_BNE:  begin Branch = 1; ALUOp = `ALUOP_BEQ_BNE; end // ULA faz subtração

      //  instrucao de comparacao imediata ---
      `MIPS_SLTI: begin ALUSrc = 1; RegDst = 0; RegWrite = 1; ALUOp = 2'b10; end
      `MIPS_SLTIU:begin ALUSrc = 1; RegDst = 0; RegWrite = 1; ALUOp = 2'b11; end

      // instrucao LUI (Load Upper Immediate) 
      `MIPS_LUI:  begin 
          ALUSrc = 1; 
          RegWrite = 1; 
          LuiEn = 1; //habilita o deslocamento de 16 bits no caminho de dados
      end

      // acesso a memoria
      `MIPS_LW:   begin 
          ALUSrc = 1; 
          MemtoReg = 1; // o dado vem da Memória, nao da ULA
          RegWrite = 1; 
          MemRead = 1;  // permite leitura da RAM
      end
      
      `MIPS_SW:   begin 
          ALUSrc = 1; 
          MemWrite = 1; // permite escrita na RAM
      end

      // instrucao de salto tipo j
      `MIPS_J:    begin Jump = 1; end
      
      `MIPS_JAL:  begin 
          Jump = 1; 
          RegWrite = 1; // Precisa escrever o endereço de retorno($ra)
          JalEn = 1;    // permite a logica de salvar PC+4 em $31
      end

      default: begin end
    endcase
  end
endmodule