// Módulo do PC (Program Counter)
module PC(PC, nextPC, clock, reset);

    // Entradas do circuito
    input wire clock;            // Sinal de clock para atualizar o PC
    input wire reset;            // Sinal de reset para zerar o PC quando necessário
    input wire [31:0] nextPC;    // O endereço da próxima instrução

    // Saída do circuito
    // Mantemos 'reg' para poder atualizar o valor dentro do bloco 'always'
    output reg [31:0] PC;        // Endereço da instrução atual que vai para a memória

    // Este bloco roda sempre que o clock ou o reset sobem (borda de subida)
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Se o reset for ativado, o PC volta para o início (endereço 0)
            PC <= 32'h00000000;
        end else begin
            // Se não estiver em reset, o PC recebe o próximo endereço normalmente
            PC <= nextPC;
        end
    end
endmodule