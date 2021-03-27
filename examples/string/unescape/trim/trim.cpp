#include <iostream>

using namespace std;
int main() {
    const std::string& chars = "\t\n\v\f\r ";
    std::string str = "   aaa   \n\t";
    str.erase(str.find_last_not_of(chars) + 1);
    str.erase(0, str.find_first_not_of(chars));
    std::cout << str << endl;
}
