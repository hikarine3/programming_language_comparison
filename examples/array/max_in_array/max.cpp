#include <iostream>
using namespace std;

int main() {
    int array []= {3, 1, 2};
    int largest = array[0] ;
    for ( int i=1;  i < sizeof(array)/sizeof(array[0]);  ++i ) {
        if ( array[i] > largest ) {
             largest = array[i] ;
        }
    }

    cout << largest << '\n' ;
    return 0;
}