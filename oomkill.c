#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#define SIZE 104857600 //1 MB=1024*1024 bytes//

int main(void)
{
        int count = 0;
	sleep(20);
        while (1)
        {
                char* p = malloc(SIZE);
                if (p==NULL)
		{
			printf("Allocation done to all %d MB\n", count);
			break;
		}
		for(int i=0; i<=SIZE; i++)
		p[i] = 1;
                printf("Allocating %d MB\n", ++count);
		
        }
        
}
