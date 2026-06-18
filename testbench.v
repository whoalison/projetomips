/*
-------------------------------------------------------------------------
Disciplina: Arquitetura e Organização de Computadores - 2026.1
Projeto 2VA - Implementação de processador monociclo MIPS em verilog
Grupo: Alison Guilherme, Murilo Antonino e Otávio Olimpio
-------------------------------------------------------------------------
*/
//Gera clock/reset e monitora a execução do processador.exibir 0 em vez de Z na leitura de memória.

`include "defines.vh"

module testbench;
  reg clock;
  reg reset;
  wire [31:0] PCOut;
  wire [31:0] ALUResultOut;
  wire [31:0] MemOut;

  // instacia do DUT (Device Under Test) - O Processador MIPS
  mips dut(
    .clock(clock),
    .reset(reset),
    .PCOut(PCOut),
    .ALUResultOut(ALUResultOut),
    .MemOut(MemOut)
  );

  // gerando Clock (Período = 10ns)
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  // sequencia de Controle da simulacao
  initial begin
    // configura arquivo para visualizar ondas no GTKWave
    $dumpfile("mips_waveform.vcd");
    $dumpvars(0, testbench);

    // reset inicial
    $display("Iniciando Simulação...");
    reset = 1;
    #10;
    reset = 0;
    
    // tempo de simulacao para a lista de 64 instrucoes
    #800; 
    
    $display("---------------------------------------------------------");
    $display("Simulacao finalizada.");
    $finish;
  end

  // monitoramento(exibe no terminal a cada ciclo de clock)
  always @(posedge clock) begin
    if (!reset) begin
      // alterado p (dut.MemRead ? MemOut : 32'h0)
      // se estiver lendo (MemRead=1), mostra o valor real. Se nao, mostra 0.
      $write("Time: %4d | PC: %h | Instr: %h | ULA: %h | Mem: %h", 
             $time, PCOut, dut.instruction, ALUResultOut, 
             (dut.MemRead ? MemOut : 32'h0));

      // logs extras
      if (dut.MemWrite) begin
          $display(" | [MEM WRITE] Escreveu %h no end. %h", dut.dmem.WriteData, ALUResultOut);
      end
      else if (dut.MemRead) begin
          $display(" | [MEM READ] Leu %h do end. %h", MemOut, ALUResultOut);
      end
      else begin
          $display(""); // pular linha para manter a forma
      end
    end
  end
endmodule