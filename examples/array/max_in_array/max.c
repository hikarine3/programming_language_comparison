#include <stdio.h>

static int maxValue(const int* array, int size) {
    int i;
    int max;
    max = array[0];
    for (i = 1; i < size/sizeof(array[0]); ++i) {
        if (max < array[i]) {
            max = array[i];
        }
    }
    return max;
}

int main(void) {
    const int array[] = {3, 1, 2};
    printf("%i\n", maxValue(array, sizeof(array)) );
}