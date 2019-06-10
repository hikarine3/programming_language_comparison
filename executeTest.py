# _num <= good habit
import os
import re
import sys
import subprocess

class ExecuteTest:
    def __init__(self, opt):
        print("Intializing...")
        self.dir = opt["dir"]
        self.file_contents = {}
        self.CLASSPATH = "./";
        #:../doctor_class:../human_class;"

    def executeTest(self):
        print("Find in " + self.dir)
        self.asserted_num = 0
        for root, dirs, files in os.walk(self.dir):
            root = root.rstrip("/")
            for file in files:
                print(file)
                if re.search(r"\.(c|cpp|cs|go|java|js|php|pl|pm|py|rb|sh)$", file) and not re.search("executeTest", file):
                    cm = ""
                    if file.endswith(".c"):
                        execute_file = file.replace(r".c", "")
                        cm = "cc -o " + root + "/" + execute_file + " " + root + "/" + file +"; " + root + "/" + execute_file
                    elif file.endswith(".cpp"):
                        execute_file = file.replace(r".cpp", "")
                        cm = "g++ -o " + root + "/" + execute_file + " " + root + "/" + file +"; " + root + "/" + execute_file
        #  mcs hello_world.cs;mono hello_world.exe;rm hello_world.exe;
                    elif file.endswith(".cs"):
                        # print(subprocess.check_output(["ls"], shell=True).decode("UTF-8"))
                        try:
                            subprocess.check_output(["which", "mcs"])
                        except subprocess.CalledProcessError:
                            print("mcs is not installed on this machine")
                            continue
                        else:
                            pass

                        try:
                            subprocess.check_output(["which", "mono"])
                        except subprocess.CalledProcessError:
                            print("mono is not installed on this machine")
                            continue
                        else:
                            pass
                            
                        execute_file = file.replace(r".cs", ".exe")
                        cm = "mcs " + root + "/" + file + "; mono " + root + "/" + execute_file
                    elif file.endswith(".go"):
                        # print(subprocess.check_output(["ls"], shell=True).decode("UTF-8"))
                        try:
                            subprocess.check_output(["which", "go"])
                        except subprocess.CalledProcessError:
                            print("go is not installed on this machine")
                            continue
                        else:
                            pass
                        execute_file = file.replace(r".go", "")
                        cm = "cd " + root + "; go build " + file + "; ./" + execute_file + ";cd .."
                    elif file.endswith(".java"):
                        execute_file = file.replace(r".java", "")
                        if root == "doctor_class":
                            cm = "cd human_class;javac Human.java;mv -f Human.class ../doctor_class;cd ..;"
                        else:
                            cm = ""
                        cm += "cd " + root + ";javac " + file + "; java " + execute_file
                    elif file.endswith(".js") or file.endswith(".mjs"):
                        cm = "node " + root + "/" + file
                    elif file.endswith(".pl") or file.endswith(".pm"):
                        cm = "perl " + root + "/" + file
                    elif file.endswith(".php"):
                        cm = "php " + root + "/" + file
                    elif file.endswith(".py"):
                        cm = "python " + root + "/" + file
                    elif file.endswith(".rb"):
                        cm = "ruby " + root + "/" + file
                    elif file.endswith(".sh"):
                        cm = "chmod 755 " + root + "/" + file + ";" + root + "/" + file
                    else:
                        exit("not defied extention: " + file)

                    op = ""
                    if re.search("argv\.", file):
                        op = " -a -b -c"
                    elif re.search(r"argv\.", file):
                        op = " argv1"
                    elif re.search(r"find\.", file):
                        op = "../find/subdir"
                    elif re.search("vertical2horizontal\.", file):
                        op = "./vertical2horizontal/input.txt"

                    cm += " " + op

                    if file.endswith(".c") or file.endswith(".cpp") or file.endswith(".cs") or file.endswith(".go"):
                        cm += ";rm " + root + "/" + execute_file + ";"
                    elif file.endswith(".java"):
                        cm += ";rm *.class;cd ..;"

                    fh = open(root + "/" + file, "r")
                    self.file_contents[file] = fh.read()
                    fh.close()

                    print("######################")
                    print(cm)
                    try:
                        result = subprocess.check_output([cm], shell=True).decode("UTF-8")
                        print(result)
                    except subprocess.CalledProcessError:
                        print("execution returned error.")
                        sys.exit(1)
                    else:
                        pass

                    if root == "argv":
                        assert result == "-a\n-b\n-c\n"
                        self.asserted_num += 1
                    elif root == "associative_array":
                        assert result == "January\nFebruary\nMarch\n"
                        self.asserted_num += 1
                    elif root == "crawl_yahoo_and_return_title":
                        assert re.search(r"Yahoo", result), "Failed crawling"
                        self.asserted_num += 1
                    elif root == 'defined':
                        assert result == "value is not defined\n"
                        self.asserted_num += 1
                    elif root == "doctor_class":
                        assert result == "My name is FirstName LastName\nMy sex is male\nMy specialty is cardiology\n"
                        self.asserted_num += 1
                    elif root == 'human_class':
                        assert result == "My name is FirstName LastName\nMy sex is male\n"
                        self.asserted_num += 1
                    elif root == 'join_array':
                        assert result == "a,b,c\n"
                        self.asserted_num += 1
                    elif root == "max_in_array":
                        assert result == "3\n"
                        self.asserted_num += 3
                    elif root == "min_in_array":
                        assert result == "1\n"
                        self.asserted_num += 1
                    elif root == "array_printer":
                        assert result == "3\n1\n2\n"
                    elif root == "ascend_sort_array":
                        assert result == "1\n2\n3\n"
                        self.asserted_num += 1
                    elif root == "descend_sort_array":
                        assert result == "3\n2\n1\n"
                        self.asserted_num += 1
                    elif root == "dump":
                        months = ["January", "February", "March"]
                        for month in months:
                            assert re.search(month, result), "Dump result doesn't contain " + month
                            self.asserted_num += 1
                    elif root == "hello_world":
                        assert re.search("Hello World", result), "Hello world wasn't shown."
                        self.asserted_num += 1
                    elif root == "length_string":
                        assert result == "5\n", "Returned length is different from expected one."
                        self.asserted_num += 1
                    elif root == "length_array":
                        assert result == "3\n", "Returned length is different from expected one."
                        self.asserted_num += 1
                    elif( root == "lower"):
                        assert result == "abc\n"
                        self.asserted_num += 1
                    elif root == "lower_and_replace":
                        assert result == "a_b_c\n"
                        self.asserted_num += 1
                    elif root == "trim":
                        assert result == "aaa\n"
                        self.asserted_num += 1
                    elif root == "output_to_file":
                        assert result == "Hello World!\n"
                        self.asserted_num += 1
                    elif root == "split_string":
                        assert result == "a\nb\nc\n"
                    elif root == "regex_match":
                        assert result == "Found target\n"
                    elif root == "system":
                        assert re.search(r"\d\d\d\d", result), "system wasn't executed correctly."
                        self.asserted_num += 1
                    elif root == "trim":
                        assert result == "aaa" or result == "aaa\n", "aaa wasn't shown."
                        self.asserted_num += 1
                    elif root == "sort_associative_array":
                        assert result == "1 => Janualry\n3 => March\n12 => December\n", "Result is not expected"
                        self.asserted_num += 1
                    else:
                        assert "Test is not prepared for this"
                        exit
    def reportTest(self):
        print("Report test result...")
        print("Asserted: " + str(self.asserted_num))

    def createHtml(self):
        for file in self.file_contents:
            print("<hr />")
            print("<h3>")
            if file.endswith(".c"):
                print("C")
            elif file.endswith(".cpp"):
                print("C++")
            elif file.endswith(".cs"):
                print("C#")
            elif file.endswith(".go"):
                print("Go")
            elif file.endswith(".java"):
                print("Java")
            elif file.endswith(".js"):
                print("JavaScript (node.js)")
            elif file.endswith(".pl"):
                print("Perl")
            elif file.endswith(".php"):
                print("PHP")
            elif file.endswith(".py"):
                print("Python")
            elif file.endswith(".rb"):
                print("Ruby")
            elif file.endswith(".sh"):
                print("Shell")
            print("</h3>")
            print(file)
            print("<pre>" + self.file_contents[file] + "</pre>")

    def change_into_meaningful_sentence(self, dir_name):
        dir_name.replace("_", " ")

if __name__ == "__main__":
    argvs = sys.argv
    dir = "./"
    if len(sys.argv) > 1:
        dir = argvs[1]
    else:
        pass
    print("executing...")
    executeTest = ExecuteTest({"dir": dir})
    executeTest.executeTest()
    executeTest.reportTest()
#    executeTest.createHtml()

