#include <stdio.h>
int main() {
    int array[] = {3, 1, 2};
    for(unsigned int i = 0;i<sizeof(array)/sizeof(array[0]); i++) {
        printf("%i\n", array[i]);
    }
}
