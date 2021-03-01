//Alexandropoulos Stamatis (03117060)
#include <iostream>
#include <list>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
using namespace std;
//Print all the elements of a list
void showlist(list <int> g)
{
  list <int> :: iterator it;
  printf("[");
  for(it = g.begin(); it != g.end(); ++it){
    if (it==g.begin()) printf("%d",*it);
    else printf(",%d",*it);
}
  printf("]\n");
}
// Function to solve the the problem for one time. Prints k numbers which are powers of two
// and whose sum is equal to n
list <int> solveforone(int n, int k)
{
    // Initialising the sum with k
    int sum = k;
    int A[k];
    for (int i=0; i<k;i++){
      A[i]=1;
    }
    list <int> list1;
    int prev=1;
    int count=0;
    for (int i = k - 1; i >= 0; --i) {

        while (sum + A[i] <= n) {

            // Update sum and A[i] till sum + A[i] is less than equal to n
            sum += A[i];
            A[i] *= 2;
          //  cout<<sum+A[i]<<endl;
        }
    }

    // Impossible to find combination
    if (sum != n) {
      showlist(list1);
      return list1;
    }

    // Possible solution is stored in A[]
    else {
      for (int i=0;i<k;i++){
        if(A[i]==prev) count++;
        else{
          list1.push_back(count);
          i--;
          count=0;
          prev=2*prev;
        }
      }
      if (k!=0) list1.push_back(count);
      showlist(list1);
      return list1;
    }
}
//Solves the problem
void solve (int n,int a[],int i){
  if (n<=0) return;
  else{
     solveforone(a[i], a[i+1]);
     solve(n-1,a,i+2);
   }
}

int main(int argc, char * argv[])
  {
    //Read the file
    FILE *myfile =fopen(argv[1],"r");
    if( myfile==NULL){
      printf("Error opening the file\n");
      exit(1);
    }
    int number;
    int counter = 0;
    int count;
    //cout <<argv[1]<<endl;
    if(fscanf(myfile,"%d",&count) !=1){
      printf("Error: One argument expected\n");
      exit(1);
    }
    number=count;

    int *inputArray = new int[2*number];

    for (counter = 0; counter < 2*number; counter++){
        if (fscanf(myfile,"%d",&count) !=1){
          printf("Error:One argument expected\n");
          exit(1);
        }
        inputArray[counter]=count;

    }

      solve(number,inputArray,0);
      fclose(myfile);
      delete[] inputArray;
      return 0;
  }
