op = {"nop":'{0:04b}'.format(0),
    "mul":'{0:04b}'.format(1),
    "sub":'{0:04b}'.format(2),
    "ld":'{0:04b}'.format(3),
    "add":'{0:012b}'.format(8),##4, remember to correct the rest 
    "str":'{0:04b}'.format(5),
    "lsl":'{0:04b}'.format(6),
    "lsr":'{0:04b}'.format(7),
    "b":'{0:04b}'.format(8),
    "pic":'{0:04b}'.format(9),
    "avg":'{0:04b}'.format(10),
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


def code_line_generator(token_list):
    code_line = ""
    last_argument = token_list[-1]
    if ("[" in last_argument) & ("#" in last_argument): ##Case where there is a [ and a # in the las token, must set flags according to
        print("pop it") ##Meaningless print
    elif ("[" in last_argument) & ("#" not in last_argument):##Case where there is a [ and not a # in the las token, must set flags according to
        print("twist it") ##Meaningless print
    elif ("[" not in last_argument) & ("#" in last_argument):##Case where there is a # and not a [ in the las token, must set flags according to
        print("clap it") ##Meaningless print
    else: 
        for j in token_list:
            ##print(op.get(j))
            ##if '#' not in j: 
            code_line += op.get(j)
            ##else:
            ##    token = j
            ##    token = token.replace('#',"")
    ##      ##        print(token)
            ##    code_line += '{0:012b}'.format(int(token))
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
        elif first_argument == "thi":
            code_line += '{0:032b}'.format(15)
        elif (first_argument == "bne") | (first_argument == "beq") | (first_argument == "bgt"):
            code_line += branch_manager(tokens)
        else:
            code_line = code_line_generator(tokens)
        code.append(code_line)
    print(code)

##def assambler(file):
##    ##import re
##
##    ##listaOps = [*op]
##    ##strOps = ""
##    ##for i in listaOps:
##    ##    strOps+=i
##    ##    strOps+="|"
####
##    ##strOps = strOps[:-1]
##    ##patron = re.compile('^('+strOps+') (r1[0-5]|r[0-9]|#[0-9]+)* (\[?r1[0-5]|r[0-9]|#[0-9]+\]?)?')
##    ##patron2 = re.compile('^('+strOps+') (\[?r1[0-5]|r[0-9]|#[0-9]+\]?)')
####Reads lines from source file
##    with open(file) as fp:
##        lines = fp.read().split("\n")
##
##    print("lines")
##    print(lines)
####Eliminates comas
##    lines_n = []
##    for i in lines:
##        lines_n.append(i.replace(',',""))
##    ##    print(i)
##    ##print("lines_n")
##    ##print(lines_n)
##
##    code = []
##    for i in lines_n:
##        tokens = i.split(" ")
##        length = len(tokens)
##        print("tokens")
##        print(tokens)
##        if length == 2:
##            print(i)
##            ##matcher = patron2.match(i)
##            ##print("matcher.groups")
##            ##print(matcher.groups())
##            ##code_line = code_line_generator(matcher.groups())
##            code_line = code_line_generator(tokens)
##            code.append(code_line)
##    ##        for j in matcher.groups():
##    ##            ##print(op.get(j))
##    ##        
##    ##            if '#' not in j: 
##    ##                code_line += op.get(j)
##    ##            else:
##    ##                token = j
##    ##                token = token.replace('#',"")
##    ####              print(token)
##    ##                code_line += '{0:012b}'.format(int(token))
##    ##        print(code_line)
##    ##
##        elif length == 1:
##            code_line += '{0:032b}'.format(0)
##        else:
##            print(i)
##            ##matcher = patron.match(i)
##            ##print("matcher.groups")
##            ##print(matcher.groups())
##    ##      matcher.groups()
##            code_line = ""
##            ##code_line = code_line_generator(matcher.groups())
##            code_line = code_line_generator(tokens)
##            ##for j in matcher.groups():
##            ##    ##print(op.get(j))
##            ##
##            ##    if '#' not in j: 
##            ##        code_line += op.get(j)
##            ##    else:
##            ##        token = j
##            ##        token = token.replace('#',"")
##    ##      ##        print(token)
##            ##        code_line += '{0:012b}'.format(int(token))
##            ##        
##            code.append(code_line)
##            print(code_line)
##    print(code)

assambler('instructions.txt')