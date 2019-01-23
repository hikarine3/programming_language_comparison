#include <stdio.h>
int main(void) {
	int i, j, tmp;
	int array[] = {3, 1, 2};
  
	for (i=0; i<sizeof(array)/sizeof(array[0]); i++) {
        for(j=i+1; j<sizeof(array)/sizeof(array[0]); j++) {
            if(array[j] > array[i]) {
                tmp = array[i];
                array[i] = array[j];
                array[j] = tmp;
            }
        }
    }

    for(i=0; i < sizeof(array)/sizeof(array[0]); i++) {
        printf("%d\n", array[i]);
    }
}
