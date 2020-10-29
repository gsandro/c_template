/* thread.c */
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
/* 100000 elements */
#define MAX 100000

int test_array1[MAX]; 
int test_array2[MAX]; 

void init_test_array(int *array) {
   int i, j; 
   for(i = MAX,j=0; i >= 0; i--,j++)
      array[j] = i; 
}

// thread 1
static void *bubble1(void* val) {
   static int i, temp, elemente=MAX; 
   printf("Thread bubble1() started\n");
   while(elemente--)
      for(i = 1; i <= elemente; i++)
         if(test_array1[i-1] > test_array1[i]) {
            temp=test_array1[i]; 
            test_array1[i]=test_array1[i-1]; 
            test_array1[i-1]=temp; 
         }
   printf("Thread bubble1() finished\n");
   return NULL; 
}

// thread 2
static void *bubble2(void* val) {
   static int i, temp, elemente=MAX; 
   printf("Thread bubble2() started\n");
   while(elemente--)
      for(i = 1; i <= elemente; i++)
         if(test_array2[i-1] > test_array2[i]) {
            temp=test_array2[i]; 
            test_array2[i]=test_array2[i-1]; 
            test_array2[i-1]=temp; 
         }
   printf("Thread bubble2() finished\n");
   return NULL; 
}


int main (void) {
    pthread_t thread1, thread2; 
    int i, rc; 

    freopen("myoutput.txt", "w+", stdout); 

    printf("main thread main() started\n");
    
    init_test_array(test_array1); 
    init_test_array(test_array2); 
   
    // Thread 1 
    rc = pthread_create( &thread1, NULL, &bubble1, NULL ); 
    if( rc != 0 ) {
        printf("couldn't create thread 1\n");
        return EXIT_FAILURE; 
    }
    // Thread 2 
    rc = pthread_create( &thread2, NULL, &bubble2, NULL ); 
    if( rc != 0 ) {
        printf("couldn't create thread 2\n");
        return EXIT_FAILURE; 
    }
    // main-thread waits
    pthread_join( thread1, NULL ); 
    pthread_join( thread2, NULL ); 

    // write result into myoutput.txt 
    for(i = 0; i < MAX; i++) {
       printf("[%d-%d]", test_array1[i], test_array2[i]); 
    }
    printf("\nmain-thread main() finished\n");
    return EXIT_SUCCESS; 
}
