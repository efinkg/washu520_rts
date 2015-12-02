/*
 *  Get time of day for 60 seconds, 60000 records.
 */

#include <time.h>
#include <sys/time.h>
#include <stdio.h>

int main(void);

#define SUCCESS 0
#define BUF_LEN 60000

long times[BUF_LEN];

int main() {
	int i;
	struct timespec tNew;
	struct timeval t;
	FILE *f;
	const struct timespec sleept = {.tv_nsec = 1000000};
	
    for (i=0; i<BUF_LEN; ++i) {
        //clock_gettime(CLOCK_REALTIME, &tNew);
		gettimeofday(&t, NULL);
        times[i] = (long) t.tv_usec;
        nanosleep(&sleept, NULL);
    }
    
    f = fopen("timedump","w");
    for (i=0; i<BUF_LEN; ++i) {
        fprintf(f, "%ld\n", times[i]);
    }
    fclose(f);
    
    return SUCCESS;
}