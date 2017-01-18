
#include <stdio.h>

int inline_c_Main_0_6966bc8e648d29886cf2aa1258fec867efb476a3(int n_inline_c_0) {

    // Read and sum n integers
   int i, sum = 0, tmp;
   for (i = 0; i < n_inline_c_0; i++) {
     scanf("%d", &tmp);
     sum += tmp;
   }
   return sum;
  
}

