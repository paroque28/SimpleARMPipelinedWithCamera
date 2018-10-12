op = {"nop":'{0:04b}'.format(0b0000),#
    "mul":'{0:04b}'.format(0b0001),#
    "sub":'{0:04b}'.format(0b0010),#
    "ld":'{0:04b}'.format(0b0011),
    "add":'{0:04b}'.format(0b0100),#
    ##"addi":'{0:012b}'.format(0b111000101001),
    "str":'{0:04b}'.format(5),
    "lsl":'{0:04b}'.format(6),#
    "lsr":'{0:04b}'.format(7),#
    "b":'{0:04b}'.format(8),
    "pic":'{0:04b}'.format(9),#
    "avg":'{0:04b}'.format(10),#
    "lda":'{0:04b}'.format(11),
    "orr":'{0:04b}'.format(12),
    "str_one":'{0:04b}'.format(13),
    "thi":'{0:04b}'.format(15),
    "r1":'{0:04b}'.format(1),
    "r2":'{0:04b}'.format(2),
    "r3":'{0:04b}'.format(3),
    "r4":'{0:04b}'.format(4),
    "r5":'{0:04b}'.format(5),
    "r6":'{0:04b}'.format(6),
    "r7":'{0:04b}'.format(7),
    "r8":'{0:04b}'.format(8),
    "r9":'{0:04b}'.format(9),
    "r10":'{0:04b}'.format(10),
    "r11":'{0:04b}'.format(11),
    "r12":'{0:04b}'.format(12),
    "r13":'{0:04b}'.format(13),
    "r14":'{0:04b}'.format(14),
    "r15":'{0:04b}'.format(15)}



cond_do = '0b1110'
cond_dont = '0b1111'
add = ''
add += cond_do + '00' + '1' + '0100' + '0'

print(add)

def branch_manager(token_list): ##In charge of managing the branch instructions
    code_line = op.get(token_list[0])
    adress = (token_list[1].replace("[","")).replace("]","")
    ##adress = adress.replace("]","")
    if "#" in adress:
        code_line += '{0:024b}'.format(int(adress.replace("#","")))
    else:
        code_line += '{0:04b}'.format(op.get(adress))
        code_line += '{0:020b}'.format(0)
    return code_line

def code_line_manager_DATA(token_list):
    code_line = ["1110", "00", "0", "", "1", " ", " ", " "]
    last_argument = token_list[-1]
    token_list[-1] = (last_argument.replace("#",""))
    if token_list[0] == "avg":
        code_line[3] = op.get(token_list[0])
        code_line[5] = op.get(token_list[1])
        code_line[6] = "0000"
        code_line[7] = "000000000000"
        return code_line
    elif "#" in last_argument:
        code_line[2] = "1"
        code_line[7] = str('{0:012b}'.format(int(token_list[-1])))
    else:
        code_line[7] = str('{0:08b}'.format(0)) + op.get(token_list[-1])
    code_line[3] = op.get(token_list[0])
    code_line[5] = op.get(token_list[1])
    code_line[6] = op.get(token_list[2])
    return code_line     

def assambler(file):
    ##Reads lines from source file
    with open(file) as fp:
        lines = fp.read().split("\n")
    print("lines")
    print(lines)
    ##Eliminates comas
    lines_n = []
    for i in lines:
        lines_n.append(i.replace(',',""))
    ##    print(i)
    code = []
    for i in lines_n:
        tokens = i.split(" ")
        ##length = len(tokens)
        print("tokens")
        print(tokens)
        code_line = ""
        first_argument = tokens[0]
        if first_argument =="nop":
            code_line += '{0:032b}'.format(0)
        elif first_argument == "pic":
            code_line += '{0:032b}'.format(9) ##Preguntar si esta lleva algún registro
        ##elif first_argument == "thi":
        ##    code_line += '{0:032b}'.format(15)
        elif (first_argument == "bne") | (first_argument == "beq") | (first_argument == "bgt"):
            code_line += branch_manager(tokens)
        elif (first_argument == "ld") | (first_argument == "str") | (first_argument == "str_1") | (first_argument == "lda"):
            print("mem_instruction")
        else:
            ##code_line = code_line_manager(tokens)
            print(code_line_manager_DATA(tokens))

        ##code.append(code_line)
    print(code)

assambler("D:\Archivos_D\TEC\Arqui 1\Proyecto1\img_proc_thin\Assambler\code.txt")   