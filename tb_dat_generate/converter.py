print("start")

with open('inst.txt') as f:
    lines = f.readlines()

OPCODE = {
    'addi': '0010011',
    'add' : '0110011',
    'relu': '0110011',
    'maxpool': '0110011',
    'fc' : '0110011',
    'conv2d' : '0110011',
    'bn'  : '0110011',
    'sub' : '0110011',
    'mul' : '0110011'
}

FUNCT7 = {
    'relu': '1000000',
    'maxpool': '1100000',
    'fc' : '1110000',
    'conv2d' : '1111000',
    'bn' : '1010000',
    'add' : '0000000',
    'sub' : '0100000'
}

FUNCT3 = {
    'relu': '111',
    'maxpool': '111',
    'fc' : '111',
    'conv2d' : '111',
    'bn' : '111',
    'add' : '000',
    'sub' : '000',
    'addi': '000'
}

TYPE = {
    'relu': 'R',
    'maxpool': 'R',
    'fc' : 'R',
    'conv2d' : 'R',
    'bn' : 'R',
    'add' : 'R',
    'sub' : 'R',
    'addi': 'I'
}

def bindigits(n, bits):
    s = bin(n & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

def convert_to_binary(inst_list):
    if(TYPE[inst_list[0]] == 'R'):
        funct7 = FUNCT7[inst_list[0]]
        funct3 = FUNCT3[inst_list[0]]
        opcode = OPCODE[inst_list[0]]
        rd = int(inst_list[1].replace('r',''))
        rd_bin = '{0:05b}'.format(rd)
        rs1 = int(inst_list[2].replace('r',''))
        rs1_bin = '{0:05b}'.format(rs1)
        rs2 = int(inst_list[3].replace('r',''))
        rs2_bin = '{0:05b}'.format(rs2)
        inst_binary = funct7 + rs2_bin + rs1_bin + funct3 + rd_bin + opcode
        return inst_binary
    elif(TYPE[inst_list[0]] == 'I'):
        if(int(inst_list[3]) < 0):
            imm_bin = bindigits(int(inst_list[3]), 12)
        else:
            imm = int(inst_list[3])
            imm_bin = '{0:012b}'.format(imm)
        funct3 = FUNCT3[inst_list[0]]
        opcode = OPCODE[inst_list[0]]
        rd = int(inst_list[1].replace('r',''))
        rd_bin = '{0:05b}'.format(rd)
        rs1 = int(inst_list[2].replace('r',''))
        rs1_bin = '{0:05b}'.format(rs1)
        inst_binary = imm_bin + rs1_bin + funct3 + rd_bin + opcode
        return inst_binary

with open('inst_bin.txt', 'w') as f:
    for each in lines:
        inst_list = each.replace('\n', '').replace(',', '').split(" ")
        inst_binary = convert_to_binary(inst_list)
        f.write('//' + each + '\n')
        f.write(inst_binary[0:8] + '\n')
        f.write(inst_binary[8:16] + '\n')
        f.write(inst_binary[16:24] + '\n')
        f.write(inst_binary[24:32] + '\n')
        f.write('\n')
        print(each + ' : ' +inst_binary)

