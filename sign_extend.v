/*
-------------------------------------------------------------------------
Disciplina: Arquitetura e Organização de Computadores - 2026.1
Projeto 2VA - Implementação de processador monociclo MIPS em verilog
Grupo: Alison Guilherme, Murilo Antonino e Otávio Olimpio
-------------------------------------------------------------------------
*/
module sign_extend(
  input [15:0] imm,
  input ExtOp,       // 1 = Sinal, 0 = Zero
  output reg [31:0] ext_out
);
  always @(*) begin
    if (ExtOp) 
      ext_out = {{16{imm[15]}}, imm}; // extensao do sinal
    else       
      ext_out = {16'b0, imm};         // extensao do zero 
  end
endmodule