/*
-------------------------------------------------------------------------
Disciplina: Arquitetura e Organização de Computadores - 2026.1
Projeto 2VA - Implementação de processador monociclo MIPS em verilog
Grupo: Alison Guilherme, Murilo Antonino e Otávio Olimpio
-------------------------------------------------------------------------
*/
`include "defines.vh"

module ula( 
  input [31:0] In1, In2,   // Operandos
  input [4:0]  shamt,      // Shift amount
  input [3:0]  OP,         // codigo da operacao
  output reg [31:0] result,// resultado
  output wire Zero_Flag    // flag Zero
);
  always @(*) begin
    case (OP)
      `ALU_ADD:   result = In1 + In2;
      `ALU_SUB:   result = In1 - In2;
      `ALU_AND:   result = In1 & In2;
      `ALU_OR:    result = In1 | In2;
      `ALU_XOR:   result = In1 ^ In2;
      `ALU_NOR:   result = ~(In1 | In2);
      `ALU_SLT:   result = ($signed(In1) < $signed(In2)) ? 1 : 0;
      `ALU_SLTU:  result = (In1 < In2) ? 1 : 0;
      `ALU_SLL:   result = In2 << shamt;
      `ALU_SRL:   result = In2 >> shamt;
      `ALU_SRA:   result = $signed(In2) >>> shamt;
      `ALU_SLLV:  result = In2 << In1[4:0];
      `ALU_SRLV:  result = In2 >> In1[4:0];
      `ALU_SRAV:  result = $signed(In2) >>> In1[4:0];
      `ALU_JR:    result = In1; 
      default:    result = 0;
    endcase
  end
  
  assign Zero_Flag = (result == 0);
endmodule