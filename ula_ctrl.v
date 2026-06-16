/*
-------------------------------------------------------------------------
Disciplina: Arquitetura e Organização de Computadores - 2026.1
Projeto 2VA - Implementação de processador monociclo MIPS em verilog
Grupo: Alison Guilherme, Murilo Antonino e Otávio Olimpio
-------------------------------------------------------------------------
*/
`include "defines.vh"

module ula_ctrl(
  input [1:0] ALUOp,     // Vindo da UC (Unidade de controle)
  input [5:0] funct,     // Campo funct da instrução
  output reg [3:0] OP_ula // Codigo p a ULA
);
  always @(*) begin
    case (ALUOp)
      `ALUOP_LW_SW_ADDI: OP_ula = `ALU_ADD; 
      `ALUOP_BEQ_BNE:    OP_ula = `ALU_SUB; 
      `ALUOP_ANDI_ORI_XORI: OP_ula = `ALU_OR; // Assumindo OR para imediatos logicos genericos
      
      `ALUOP_RTYPE: begin
        case (funct)
          `FUNCT_ADD:  OP_ula = `ALU_ADD;
          `FUNCT_SUB:  OP_ula = `ALU_SUB;
          `FUNCT_AND:  OP_ula = `ALU_AND;
          `FUNCT_OR:   OP_ula = `ALU_OR;
          `FUNCT_XOR:  OP_ula = `ALU_XOR;
          `FUNCT_NOR:  OP_ula = `ALU_NOR;
          `FUNCT_SLT:  OP_ula = `ALU_SLT;
          `FUNCT_SLTU: OP_ula = `ALU_SLTU;
          `FUNCT_SLL:  OP_ula = `ALU_SLL;
          `FUNCT_SRL:  OP_ula = `ALU_SRL;
          `FUNCT_SRA:  OP_ula = `ALU_SRA;
          `FUNCT_SLLV: OP_ula = `ALU_SLLV;
          `FUNCT_SRLV: OP_ula = `ALU_SRLV;
          `FUNCT_SRAV: OP_ula = `ALU_SRAV;
          `FUNCT_JR:   OP_ula = `ALU_JR;
          default:     OP_ula = `ALU_ADD;
        endcase
      end
      default: OP_ula = `ALU_ADD;
    endcase
  end
endmodule