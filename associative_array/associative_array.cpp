#include <iostream>
#include <map>
using namespace std;
int main() {
    map<string, string> monArray;
    monArray["1"] = "January";
    monArray["2"] = "February";
    monArray["3"] = "March";
    for (map<string, string>::iterator p = monArray.begin(); p != monArray.end(); ++p ) {
         cout << p->second << endl;
   }
}