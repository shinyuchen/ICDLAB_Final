# Testbench

## Relu
```json=
ncverilog test.v CPU.v +define+Relu
```

## MaxPooling
```json=
ncverilog test.v CPU.v +define+MP
```

## FullyConnected
```json=
ncverilog test.v CPU.v +define+FC
```

## Batch Normalization
```json=
ncverilog test.v CPU.v +define+BN
```

# 新增自定義instruction流程
    也可以直接參考Relu跟MaxPooling是怎麼做的

## (1) ALU_Control.v
    加入自定義的instruction code

## (2) ALU.v
    宣告Submodule的instance並且在case裡面新增output選項

## (3) Control.v （不需要更改，只需要參考你的instruction要用哪一種opcode）
    要根據你的指令操作來決定CPU的各個option （如WriteBack）是否要被觸發，
    例如relu本質上只會用到rs1跟rd, 跟addi一樣，所以可以直接把opcode設成跟addi一樣

## (4) test.v
    可以直接參考學長寫的testbench.v會比較清楚，簡單整理如下：
    (1)我已經把檢驗的register設為r2, r3, r4, r5，所以可以想辦法把input value跟output value塞在這幾個registers裡面
    (2)剩下的可以看test.v裡面line 96~112的註解
    (3)在directory ./dat中新增test.txt跟test_golden.txt

# Functionality Introduction

## 1. MUX32 
    trivial

## 2. PC
    takes pc_i, checks if it is valid (no hazards and within the range), and output pc_o. 
    range: PC's maximum value = 32'd248 (if reached then stall).

## 3. Adder
    trivial

## 4. Instruction_Memory
    [spec] Composed of 64 32-bits memory elements
    the first instruction fragment = 1111_1110, and the last instruction fragment = 1111_1111, will be the indicators of CPU start and CPU end. (after CPU end, we stop writing instructions and start reading them)
    To write instructions, we must divide one 32-bit instruction into 4 8-bit instruction fragments due to I/O limitations.
    Address will be sent in the form of PC+4, and this module automatically transforms the address to array index.

## 5. ALU
    operations: SUM, AND, XOR, SUB, MUL, OR

## 6. shift2
    equals logical left shift by 1 bit

## 7. Sign Extend
    Simply equals MUX, but will extend 12-bit data into sign-extended 32-bit data

## 8. IF_ID
    hold three values: pc, inst, pcIm
    pcIm = the imm value of SB type instructions

## 9. Control
    op_i = opcode (last 7 bits in instructions)
    decided properties: 
    ALUOp    ,
    ALUSrc   , (second reg for ALU)
    RegWrite ,
    MemRd,
    MemWr,
    MemToReg,
    immSelect (Not sure about this one)

## 10. Registers
    RS, RT stand for two read registers, and RD stands for the write register.
    The purpose of is_pos_i remains vague, perhaps was designed for vector ALU?
    reg_o & op_address are for direct external accesses.

## 11. ID_EX

## 12. ALU_Control
    Simply control the ALU to take corresponding arithmetic through instruction identification.
    input: funct_i = {funct7, funct3} => Chances are not all bits are essential, might be simplified by logic simplification
    While adding more operations, the number of output controlling bits may also increase.
    n-bit ALU_op is generated by Main Controlling Unit and can decide op types (refer to textbooks for detailed implementation)

## 13. HazardDetect
    Consider to remove this part as it increases complexity and may be incompatible with newly added ops.

## 14. MUX_Control
    The MUX for Control which sits before ID_EX Flip-flops, trivial.

## 15. ForwardingUnit
    To deal with fixable hazards. i.e. passing register values in (EX_MEM | MEM_WB) stage back to ID_EX stage, where Forward_A(B) =
    00 => no hazard
    01 => MEM_WB to ID_EX
    10 => EX_MEM to ID_EX

## 16. ForwardingMUX
    The two MUX in front of ALU, decide whether the registers should be replaced with the Forwarded values

## 17. EX_MEM

## 18. DataMemory
    Give the address and Read/Write Memory.
    op_address & data_mem_o are for direct external accesses.

## 19. MEM_WB

## 20. VALU
    over = 1 is the indicator of overflow when negative value appears. 
    Remaining part is trivial

## 21. VALU_ctrl
    Similar to ALU_Control

# Self-defined Modules

## 1. Relu
    Instruction code:
    funct7: 1000000
    funct3: 111
    opcode: 0110011
    rs1   : Relu input
    rd    : Relu output

## 2. MaxPooling
    Instruction code:
    funct7: 1100000
    funct3: 111
    opcode: 0110011
    rs1   : MaxPooling input
    rd    : MaxPooling output

## 3. FullyConnected
    Instruction code:
    funct7: 1110000
    funct3: 111
    opcode: 0110011
    rs1   : FC input
    rs2   : FC bias
    register[25] ~register[28]: weight matrix
    rd    : FC output
    Note  :
    the weight matrix should be changed if input size / output size changed:
    Related Files: CPU.v ALU.v Register.v test.v

## Some ideas: Layer Registers (Including input, weight)
    Can we spare read/write address and I/O processing time? (as output of hidden layers are not necessarily important)
    If we can clearly constrain and point out where does the required sequence locate, we don't need to search them with read/write register address.