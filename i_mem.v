// Componente: Memória de Instrução (i_mem) - Tipo ROM
// Armazena as instruções do programa que o processador irá executar.
// A leitura é assíncrona (combinacional) e alinhada por palavra (32 bits).


module i_mem (
    input  wire [31:0] address, // Entrada de 32 bits vinda do PC com o endereço atual.
    output wire [31:0] i_out    // Saída de 32 bits que envia a instrução lida para a Unidade de Controle.
);

    // Definição do tamanho da memória: 256 palavras de 32 bits.
    parameter MEMORIA_TAMANHO = 256;    
    
    // Matriz de 256 linhas (endereçadas de 0 a 255), onde cada linha armazena uma palavra de 32 bits.
    reg [31:0] memoria_ROM [0:MEMORIA_TAMANHO-1];  
    
    // Variável auxiliar utilizada no for de inicialização.
    integer i;

    // Bloco executado uma única vez no início da simulação.
    initial begin
        
        // 1. Loop para zerar todas as 256 posições da memória.
        // Garante que posições vazias fiquem com 0 e evita que o simulador exiba valores indefinidos.
        for (i = 0; i < MEMORIA_TAMANHO; i = i + 1) begin
            memoria_ROM[i] = 32'b0;
        end

        // 2. Carga do arquivo de texto externo para dentro da memória ROM.
        $readmemb("instructions.list", memoria_ROM); 
    end
    
    /* Explicação da Indexação Combinacional (Leitura Assíncrona):
       
       1. No MIPS padrão, o PC avança de 4 em 4 bytes (Endereço 0, 4, 8, 12...).
       2. Porém, o nosso array 'memoria_ROM' é indexado linha por linha (Linha 0, 1, 2, 3...).
       3. Para converter o endereço do PC para o índice correto da nossa matriz, precisamos dividir por 4.
       4. Dividir por 4 em binário equivale a deslocar o número 2 bits para a direita (fazer um Shift Right de 2).
       
       Matemática da Máscara [9:2]:
       - Ignoramos os bits address[1:0], pois eles sempre serão "00" devido ao alinhamento de 4 em 4 bytes.
       - Como nossa memória tem 256 posições e 2^8 = 256, precisamos de exatamente 8 bits para mapear tudo.
       - Portanto, pegamos do bit 2 até o bit 9 (totalizando os 8 bits necessários).
    */
    assign i_out = memoria_ROM[address[9:2]];

endmodule