#include <stdio.h>
#include <ctype.h>

int main () {
   int i = 0;
   char str[] = "ABC";
   while( str[i] ) {
      str[i] = tolower(str[i]);
      i++;
   }
   printf("%s\n", str);
   return(0);
}