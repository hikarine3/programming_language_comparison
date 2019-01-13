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

    def executeTest(self):
        print("Find in " + self.dir)
        self.asserted_num = 0
        for root, dirs, files in os.walk(self.dir):
            for file in files:
                print(file)
                if re.search(r"\.(c|cpp|cs|go|java|js|php|pl|py|rb|sh)$", file) and not re.search("executeTest", file):
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
                        cm = "javac " + root + "/" + file + "; cd " + root + ";java " + execute_file
                    elif file.endswith(".js"):
                        cm = "node " + root + "/" + file
                    elif file.endswith(".pl"):
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
                    if re.search(r"argv\.", file):
                        op = " argv1"
                    elif re.search(r"find\.", file):
                        op = "../find/subdir"
                    elif re.search("vertical2horizontal\.", file):
                        op = "../vertical2horizontal/input.txt"

                    cm += " " + op

                    if file.endswith(".c") or file.endswith(".cpp") or file.endswith(".cs") or file.endswith(".go"):
                        cm += ";rm " + root + "/" + execute_file + ";"
                    elif file.endswith(".java"):
                        cm += ";rm " + execute_file + ".class;cd ..;"

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
                        continue
                    else:
                        pass

                    if(re.search(r"associative_array", root)):
                        assert result == "January\nFebruary\nMarch\n"
                        self.asserted_num += 1
                    elif(re.search(r"array_printer", root)):
                        assert result == "3\n1\n2\n"
                        self.asserted_num += 1
                    elif(re.search(r"doctor", root)):
                        assert re.search(r"My specialty is FirstName LastName", result), "Specialty wasn't shown."
                        self.asserted_num += 1
                    elif(re.search(r"dump", root)):
                        months = ["January", "February", "March"]
                        for month in months:
                            assert re.search(month, result), "Dump result doesn't contain " + month
                            self.asserted_num += 1
                    elif(re.search(r"hello_world", root)):
                        assert re.search("Hello World", result), "Hello world wasn't shown."
                        self.asserted_num += 1
                    elif(re.search(r"length", root)):
                        assert result == "5\n", "Returned length is different from expected one."
                        self.asserted_num += 1
                    elif(re.search(r"trim", root)):
                        assert result == "aaa" or result == "aaa\n", "aaa wasn't shown."
                        self.asserted_num += 1
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

