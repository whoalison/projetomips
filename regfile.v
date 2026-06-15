/*
-------------------------------------------------------------------------
Disciplina: Arquitetura e Organização de Computadores - 2026.1
Projeto 2VA - Implementação de processador monociclo MIPS em verilog
Grupo: Alison Guilherme, Murilo Antonino e Otávio Olimpio
-------------------------------------------------------------------------
*/
module regfile(
  input clock,
  input reset,
  input RegWrite,            // permite escrita
  input [4:0] ReadAddr1,     // end  rs
  input [4:0] ReadAddr2,     // end  rt
  input [4:0] WriteAddr,     // end rd (ou rt em tipo-I)
  input [31:0] WriteData,    // dado a ser escrito
  output [31:0] ReadData1,   // saida rs
  output [31:0] ReadData2    // saida rt
);
  reg [31:0] registers [0:31]; 
  integer i;

  // leitura assincrona
  assign ReadData1 = (ReadAddr1 == 0) ? 32'b0 : registers[ReadAddr1];
  assign ReadData2 = (ReadAddr2 == 0) ? 32'b0 : registers[ReadAddr2];

  // escrita sincrona
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      for (i=0; i<32; i=i+1) registers[i] <= 0;
    end 
    else if (RegWrite && WriteAddr != 0) begin
      registers[WriteAddr] <= WriteData;
    end
  end
endmodule