#include <stdio.h>

static int minValue(const int* array) {
    size_t i;
    int min;
    min = array[0];
    for (i = 1; i < sizeof(array)/sizeof(array[0]); ++i) {
        if (min > array[i]) {
            min = array[i];
        }
    }
    return min;
}

int main(void) {
    const int array[] = {3, 1, 2};
    printf("%i\n", minValue(array) );
}