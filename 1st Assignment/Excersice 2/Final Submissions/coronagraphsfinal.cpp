#include<iostream>
#include <list>
#include <limits.h>
#include <fstream>
#include <stack>
#include <vector>
#include <stdio.h>
using namespace std;

int *color= new int[1000002]; //gia na min exei parapano apo 1 kiklous
int *par=new int[1000002];
int *check=new int[1000002];

//ΧΡΗΣΙΜΟΠΟΙΗΘΗΚΕ Η ΔΟΜΗ ΤΟΥ ΓΡΑΦΟΥ ΑΠΟ ΤΟ https://www.geeksforgeeks.org/detect-cycle-undirected-graph/
class Graph
{
    int V;    // No. of vertices
    list<int> *adj;    // Pointer to an array containing adjacency lists
    //int DFSUtil(int v);
    int count(int v,int parent,int &counter,int l);
public:
    Graph(int V);   // Constructor
    void addEdge(int v, int w);   // to add an edge to graph
    bool cycles(int &sumof,list<int>&c);
    //int NumberOfconnectedComponents();
    void dfs_cycle(int u, int p ,int& numberofcycles);
};

Graph::Graph(int V)
{
    this->V = V;
    adj = new list<int>[V];
}
//Add Edges
void Graph::addEdge(int v, int w)
{
    adj[v].push_back(w); // Add w to v’s list.
    adj[w].push_back(v); // Add v to w’s list.
}


//βασική συνάρτηση
//ousiastika kanei dfs se kaue kombo
//afairontas tous geitonikous kombous tou kiklou
int Graph::count(int v ,int parent,int &counter,int l){
  list<int>::iterator i;
  for (i = adj[v].begin(); i != adj[v].end(); ++i){
          //cout <<v<<" "<< *i <<" "<<"in"<<endl;
    if ((*i==parent)||(check[*i]==1)){
    //  cout <<*i<<" "<<parent<<endl;
      continue;
    }
    else{counter++;
     count(*i,v,counter,l+1);
   }
 }
  if(l==1) return counter;
  return 0;
}
  //cout <<v<<" "<<*i<<" "<<parent<<"out"<<endl;
  //cout<< counter<<endl;

//EURESI AN EXEI ENA KIKLO
//https://www.geeksforgeeks.org/print-all-the-cycles-in-an-undirected-graph/ εγινε χρηση καιτροποποίηση συναρτησης απο τον κωδικα αυτό
void Graph::dfs_cycle(int u, int p,int& numberofcycles)
{
    if(numberofcycles==2) return;
    // already (completely) visited vertex.
    if (color[u] == 2) {
        return;
    }

    // seen vertex, but was not completely visited -> cycle detected.
    // backtrack based on parents to find the complete cycle.
    if (color[u] == 1) {

        numberofcycles++;
        int this_node=p;
        check[this_node]=numberofcycles;
        while (this_node != u) {
            this_node = par[this_node];
            check[this_node] = numberofcycles;
        }
        return;
    }
    par[u] = p;

    // partially visited.
    color[u] = 1;
    list<int>::iterator i;
    // simple dfs on graph
    for (i = adj[u].begin(); i != adj[u].end(); ++i) {

        // if it has not been visited previously
        if (*i == par[u]) {
            continue;
        }
        dfs_cycle(*i, u,numberofcycles);
    }

    // completely visited.
    color[u] = 2;
}
//Pairnei to pinaka check pou periexei to kombous pou einia
//se ena kiklo kai gia kaue kombo kalei tin count pou ousiastika kanei dfs se kaue kombo
//afairontas tous geitonikous kombous tou kiklou
bool Graph::cycles(int &sumof,list<int>&c){
  list <int> counters;
  int sum=0;
  for(int i=1;i<V;i++){
  //  cout<<check[i]<<endl;
    if (check[i]==1){
      sum++;
      int counter=1;
      counters.push_back(count(i,-1,counter,1));
      //cout<< counter<<"damn"<<endl;
    //  cout<<i<<endl;
    }
    }
    sumof=sum;
    //cout <<"CORONA "<<sum<<endl;
    counters.sort();
    c=counters;
    //showlist(counters);
   return true;

}
//Print the list
void showlist(list <int> g)
{
    list <int> :: iterator it;
    int k=1;
    for(it = g.begin(); it != g.end(); ++it){
        if (k==1) printf("%d",*it);
        else printf(" %d",*it);
        k++;
    }
    printf("\n");
}
//Check if is connected
bool addSum(list<int> g, int vertices){
  list <int> :: iterator it;
  int sum=0;
  for(it = g.begin(); it != g.end(); ++it){
    sum=sum + *it;
  }
  if(sum==vertices) return true;
  else return false;
}


// Driver program to test above functions
int main(int argc, char * argv[])
{
  FILE *myfile = fopen(argv[1],"r");
  if(myfile==NULL){
    printf("Error opening the file\n");
    exit(1);
  }
  int number;
  int counter = 0;
  int count;

  if(fscanf(myfile,"%d",&count)!=1){
    printf("Error: One argument expected\n");
    exit(1);
  }
  number=count;
  //cout<<number<<endl;
  for(int i=0;i<number;i++){
    for (int i=0; i<1000002; i++){
      color[i]=0;
      par[i]=0;
      check[i]=0;
    }
    int edges;
    int vertices;
    if(fscanf(myfile,"%d",&count)!=1){
      printf("Error: One argument expected\n");
      exit(1);
    }
    vertices=count;
    if(fscanf(myfile,"%d",&count)!=1){
      printf("Error: One argument expected\n");
      exit(1);
    }
     edges=count;
    //cout<<edges<<endl;
    Graph g(vertices+1);
    int *inputArray = new int[2*edges];
    for (counter = 0; counter < edges; counter++){
      if(fscanf(myfile,"%d",&count)!=1){
        printf("Error: One argument expected\n");
        exit(1);
      }
        inputArray[counter]=count;
        if(fscanf(myfile,"%d",&count)!=1){
          printf("Error: One argument expected\n");
          exit(1);
        }
         inputArray[counter+1]=count;
        g.addEdge(inputArray[counter],inputArray[counter+1]);

    }
    int sum=0;
    int numberofcycles = 0;
    list<int> c;
    g.dfs_cycle(1, 0,numberofcycles);

    //Result
    if ( (numberofcycles==1) &&(g.cycles(sum,c))) {
      if (addSum(c,vertices)){
       printf("CORONA %d\n",sum);
       showlist(c);
     }
     else printf("NO CORONA\n");
  }
    else printf("NO CORONA\n");
    c.clear();
    delete [] inputArray;
  }

    fclose(myfile);
    return 0;
}
