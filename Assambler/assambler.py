op = {"nop":'{0:04b}'.format(0b0000),#
    "mul":'{0:04b}'.format(0b0001),#
    "sub":'{0:04b}'.format(0b0010),#
    "ld":'{0:04b}'.format(0b0011),
    "add":'{0:04b}'.format(0b0100),#
    ##"addi":'{0:012b}'.format(0b111000101001),
    "str":'{0:04b}'.format(5),
    "lsl":'{0:04b}'.format(6),#
    "lsr":'{0:04b}'.format(7),#
    "b":'{0:04b}'.format(8),#
    "beq":'{0:04b}'.format(4),#
    "pic":'{0:04b}'.format(9),#
    "avg":'{0:04b}'.format(10),#
    "lda":'{0:04b}'.format(11),
    "orr":'{0:04b}'.format(12),#
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

global count_pcg
count_pcg = 0
global tagdic
tagdic = {}

def comp_two(val, bits):
    """compute the 2's complement of int value val"""
    if (val & (1 << (bits - 1))) != 0:   
        val = val - (1 << bits)          
    return int((str(val)).replace("-",""))  

def code_line_manager_MEM(token_list):
    code_line = ["1110", "01", "0", " ","1","0","0", " ", " ", " ", " "]
    last_argument = token_list[-1]
    first_argument = token_list[0]
    p_index = 0
    token_list[-1] = last_argument.replace("]","")
    if "[" not in last_argument:
        token_list[-2] = token_list[-2].replace("[","")
        prelast_argument = token_list[-2] 
        p_index = 1
    token_list[-1] = token_list[-1].replace("[","")
    ##token_list[-2] = prelast_argument.replace("[","")
    last_argument = token_list[-1]
    code_line[9] = op.get(token_list[1])
    if "#" in token_list[-1]:
        code_line[2] = '1'    
    if "-" in token_list[-1]:
        code_line[4] = '1'
    if first_argument == "ld":
        code_line[3] = "0"
        code_line[7] = "1"
    if first_argument == "lda":
        code_line[3] = "1"
        code_line[7] = "1"
    if first_argument == "str":
        code_line[3] = "0"
        code_line[7] = "0"
    if first_argument == "str_1":
        code_line[3] = "1"
        code_line[7] = "0"
    if p_index == 1:
        code_line[8] = op.get(prelast_argument)
        if code_line[2] == "1":
            code_line[10] = '{0:012b}'.format(int(last_argument.replace("#","")))
        else:
            code_line[10] = str(op.get(last_argument)) + "00000000" ##Por verse, no pareciera necesario
    else:
        if code_line[2] == "1":
            code_line[8] = "0000"
            code_line[10] = '{0:012b}'.format(int(last_argument.replace("#","")))
        else:
            code_line[8] = op.get(last_argument)
            code_line[10] = '{0:012b}'.format(0)
    return code_line


def branch_manager(token_list,pc_current):
    code_line = ["cond", "1010", "offset"]
    code_line[0] = op.get(token_list[0])
    tag = token_list[1]
    tag_pos = int(tagdic.get(tag))
    print("tag_pos")
    print(tag_pos)
    branch_pos = pc_current + 1
    print("branch_pos")
    print(branch_pos)
    movement = tag_pos - branch_pos
    mov_str = str(bin(movement))
    end_str = '{0:024b}'.format(movement)
    if "-0b" in mov_str:
        mov_str = mov_str.replace("-0b","1")
        str_size = len(mov_str)
        end_str = '{0:024b}'.format(comp_two(int(mov_str,2),int(str_size)))
        print("end_str")
        print(end_str)
    code_line[2] = str(end_str)
    print(code_line)
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
    code_line[5] = op.get(token_list[2])
    code_line[6] = op.get(token_list[1])
    return code_line     

def assambler(file):
    count_pc = 0
    ##Reads lines from source file
    open('Resulting_Program.txt', 'w').close()
    with open(file) as fp:
        lines = fp.read().split("\n")
    print("lines")
    print(lines)
    ##Eliminates comas
    lines_n = []
    for i in lines:
        lines_n.append(i.replace(',',""))
    ##    print(i)
    print(count_pc)
    for j in lines_n:
        tokens = j.split(" ")
        argument = tokens[0]
        if ":" in argument:
            argument = argument.replace(":","")
            ##global count_pcg
            temp_PC = lines_n.index(j) + 1 
            ##global tagdic
            tagdic[argument] = temp_PC
        else:
            print("")
    for i in lines_n:
        tokens = i.split(" ")
        ##length = len(tokens)
        print("tokens")
        print(tokens)
        code_line = ""
        first_argument = tokens[0]
        write_flag = 1
        if (":" in first_argument) | ("\n" in first_argument): ##Check detection
            #first_argument = first_argument.replace(":","")
            #tagdic[first_argument] = count_pcg
            write_flag = 0
        elif first_argument =="nop":
            code_line += '{0:032b}'.format(0) + "\n"
        elif first_argument == "pic":
            code_line += '{0:032b}'.format(9) + "\n" ##Faltan Cambios
        ##elif first_argument == "thi":
        ##    code_line += '{0:032b}'.format(15)
        elif (first_argument == "beq") | (first_argument == "b"):
           ## print("Main tagdic")
            ##print(tagdic)
            code_line = code_line.join(branch_manager(tokens,count_pcg)) + "\n"
        elif (first_argument == "ld") | (first_argument == "str") | (first_argument == "str_1") | (first_argument == "lda"):
            code_line = code_line.join(code_line_manager_MEM(tokens)) + "\n"
        else:
            ##code_line = code_line_manager(tokens)
            code_line = code_line.join(code_line_manager_DATA(tokens)) + "\n"
        print(count_pc)
        if write_flag == 1:
            count_pc += 1
            count_pcg = count_pc
            result = open('Resulting_Program.txt', 'a+')
            result.write(code_line)
            result.write('{0:032b}'.format(0) + "\n")
            result.write('{0:032b}'.format(0) + "\n")
            result.write('{0:032b}'.format(0) + "\n")
            result.write('{0:032b}'.format(0) + "\n")
        else:
            print("TAG")
        ##code.append(code_line)
    ##print(code)
    ##print(tagdic)
    ##print(count_pc)
    ##print(count_pcg)

assambler('instructions.txt')