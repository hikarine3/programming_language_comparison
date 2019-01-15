#include <iostream>
using namespace std;

int main() {
    int array []= {3, 1, 2};
    int smallest = array[0] ;
    for ( int i=1;  i < sizeof(array)/sizeof(array[0]);  ++i ) {
        if ( array[i] < smallest ) {
             smallest = array[i] ;
        }
    }
    cout << smallest << '\n' ;
    return 0;
}