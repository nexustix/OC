

a_string = "(witch true)(menu (0 spam)(1 eggs))(colour blue)(max_speed 42)"

testa = {}


def deserialize(the_string):
    level = 0
    cur_key = ""
    cur_value = ""
    atKey = True
    cur_data = ""

    for c in the_string:
        print(("    "*level) +c)



        if c == "(":
            level = level + 1
            atKey = True
        elif c == ")":
            level = level - 1

            if level == 0:
                if cur_data:
                    print("d>"+cur_data+"<d")
                    cur_data = ""
                else:
                    print(cur_data)
                    print(">"+cur_key+"< >"+cur_value+"<")
                    cur_key = ""
                    cur_value = ""
            pass
        elif c == " ":
            atKey = False
            pass
        else:
            if level <= 1:
                if atKey:
                    cur_key += c
                else:
                    cur_value += c


    #print(">"+cur_key+"< >"+cur_value+"<")



deserialize(a_string)
