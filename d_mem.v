/*
-------------------------------------------------------------------------
Disciplina: Arquitetura e Organização de Computadores - 2026.1
Projeto 2VA - Implementação de processador monociclo MIPS em verilog
Grupo: Alison Guilherme, Murilo Antonino e Otávio Olimpio
-------------------------------------------------------------------------
*/
`include "defines.vh"

module d_mem(
  input clock,
  input MemRead,          // Habilita leitura
  input MemWrite,         // Habilita escrita
  input [31:0] address,   // Endereco
  input [31:0] WriteData, // Dado que vai ser escrito
  output [31:0] ReadData  // Dado lido
);
  reg [31:0] mem [0:`DMEM_SIZE-1];
  integer k;

  initial begin
     for (k=0; k<`DMEM_SIZE; k=k+1) mem[k] = 32'b0;
  end

  assign ReadData = MemRead ? mem[address[11:2]] : 32'bz;
  
  always @(posedge clock) begin
    if (MemWrite) 
      mem[address[11:2]] <= WriteData;
  end
endmodule