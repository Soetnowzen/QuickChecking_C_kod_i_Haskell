
int inline_c_Main_0_3b8db6e1fc1c97d88b3dffffe54a31f6913feee0(long bs_inline_c_0, char * bs_inline_c_1) {

      int i, bits = 0;
      for (i = 0; i < bs_inline_c_0; i++) {
        char ch = bs_inline_c_1[i];
        bits += (ch * 01001001001ULL & 042104210421ULL) % 017;
      }
      return bits;
    
}

