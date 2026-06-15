/*
-------------------------------------------------------------------------
Disciplina: Arquitetura e Organização de Computadores - 2025.2
Atividade: Projeto 02 - Implementação de MIPS em Verilog
Grupo: Aldo Ferreira, Andressa Américo, Carlos de Souza, Gustavo do Monte
Arquivo: defines.vh
Descrição: Definições de macros (constantes) para Opcodes, Functs e ALU.
-------------------------------------------------------------------------
*/
`ifndef DEFINES_VH
`define DEFINES_VH

// --- PARÂMETROS DE MEMÓRIA ---
`define IMEM_SIZE 1024
`define DMEM_SIZE 1024

// --- ALUOp CODES (Control -> ALU Ctrl) ---
`define ALUOP_RTYPE         2'b10
`define ALUOP_BEQ_BNE       2'b01
`define ALUOP_LW_SW_ADDI    2'b00
`define ALUOP_ANDI_ORI_XORI 2'b11

// --- ULA INTERNAL CODES (ALU Ctrl -> ULA) ---
`define ALU_ADD   4'b0001
`define ALU_SUB   4'b0010
`define ALU_AND   4'b0011
`define ALU_OR    4'b0100
`define ALU_XOR   4'b0101
`define ALU_NOR   4'b0110
`define ALU_SLT   4'b0111
`define ALU_SLTU  4'b1000
`define ALU_SLL   4'b1001
`define ALU_SRL   4'b1010
`define ALU_SRA   4'b1011
`define ALU_SLLV  4'b1100
`define ALU_SRLV  4'b1101
`define ALU_SRAV  4'b1110
`define ALU_JR    4'b1111

// --- FUNCT FOR R-TYPE (6 bits) ---
`define FUNCT_ADD   6'b100000
`define FUNCT_SUB   6'b100010
`define FUNCT_AND   6'b100100
`define FUNCT_OR    6'b100101
`define FUNCT_XOR   6'b100110
`define FUNCT_NOR   6'b100111
`define FUNCT_SLT   6'b101010
`define FUNCT_SLTU  6'b101011
`define FUNCT_SLL   6'b000000
`define FUNCT_SRL   6'b000010
`define FUNCT_SRA   6'b000011
`define FUNCT_SLLV  6'b000100
`define FUNCT_SRLV  6'b000110
`define FUNCT_SRAV  6'b000111
`define FUNCT_JR    6'b001000

// --- MIPS OPCODES (6 bits) ---
`define MIPS_RTYPE  6'b000000
`define MIPS_ADDI   6'b001000
`define MIPS_ANDI   6'b001100
`define MIPS_ORI    6'b001101
`define MIPS_XORI   6'b001110
`define MIPS_BEQ    6'b000100
`define MIPS_BNE    6'b000101
`define MIPS_SLTI   6'b001010
`define MIPS_SLTIU  6'b001011
`define MIPS_LUI    6'b001111
`define MIPS_LW     6'b100011
`define MIPS_SW     6'b101011
`define MIPS_J      6'b000010
`define MIPS_JAL    6'b000011

`endif