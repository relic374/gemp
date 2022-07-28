//
// Tiny interface script for transferring the binary gemp file to /usr/local/bin/ :)
//

#include <iostream>
int main() {
     printf("Transferring files..\n");
          system("mv gemp.sh.x /usr/local/bin/gemp");
          system("chmod +x /usr/local/bin/gemp");
     printf("Done. Run using 'gemp'\n");
 return 0;
}
