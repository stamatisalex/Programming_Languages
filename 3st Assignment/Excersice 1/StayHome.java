import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;
import java.util.List;
import java.util.Collections;



public class StayHome {


	public static void main(String[] args) {
		int rows=0,collumns=0,i=0,a=0,j=0;
		String line;
		List<String> list = new ArrayList<String>();
		try {
			BufferedReader reader = new BufferedReader(new FileReader(args[0]));
			while ((line = reader.readLine()) != null) {
				rows++;
				collumns=line.length();
			}
			reader.close();
		} catch (IOException e) {
				// TODO Auto-generated catch block
			e.printStackTrace();
		}
    char map1[][] = new char[rows][collumns];
    try {
      BufferedReader reader2 = new BufferedReader(new FileReader(args[0]));
      while ((line = reader2.readLine()) != null) {
        list.add(line);
        for (j = 0; j < line.length(); j++)
          map1[i][j] = line.charAt(j);
        i++;
      }
      reader2.close();
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    //////////////////////////////////
    //Εκτύπωση του map1 δεν χρειαζεται
    /*
    for(i=0;i<rows;i++){
      for(j=0;j<collumns;j++){
        System.out.print(map1[i][j]);
        if(j==collumns-1)
          System.out.println(' ');
      }
    }
    */
    ////////////////////////////////
    List<Integer> list1 = new ArrayList<Integer>(); //για την θέση του Σωτήρη
		List<Integer> listsotir = new ArrayList<Integer>(); //για την θέση του Σωτήρη
    List<Integer> list2 = new ArrayList<Integer>();
    List<Integer> list3 = new ArrayList<Integer>(); //για το αεροδρόμιο
    List<Integer> list4 = new ArrayList<Integer>();//για τη τελική θέση
    List<Integer> sotiris = new ArrayList<Integer>(); //για να μην χαθεί απο την corona2
    int map2[][]= new int[rows][collumns];
    int map3[][]= new int[rows][collumns];
    for(i=0;i<rows;i++){
      for(j=0;j<collumns;j++){
        if(map1[i][j]=='W') {
          list2.add(i);
          list2.add(j);
          list2.add(0);
        }
        else if (map1[i][j]=='S'){
          list1.add(i);
          list1.add(j);
          list1.add(0);
					listsotir.add(i);
					listsotir.add(j);
          sotiris.add(i);
          sotiris.add(j);
        }
        else if (map1[i][j]=='A'){
          list3.add(i);
          list3.add(j);
          list3.add(0);

        }
        else if (map1[i][j]=='T'){
          list4.add(i);
          list4.add(j);
        }
        else if (map1[i][j]=='X'){
          map2[i][j]=-2;
        }
      }
    }
//System.out.println(list3);
/*
    for(i=0;i<rows;i++){
      for(j=0;j<collumns;j++){
        System.out.print(map2[i][j]);
        if(j==collumns-1)
          System.out.println(' ');
      }
    }
*/

    //Lets make corona2.
		//map2 contain the coronaplaces
    int flag=1;
    int time=0;
    int timer;
    //int a=0;
    while(true){
      int flag2=0;
      int numberofelements=0;
      if(list2.size()>0){
        flag2=1;
        numberofelements=list2.size()/3;
        i=list2.get(0);
        j=list2.get(1);
        time=list2.get(2); //exei tis sintetagmenes tou W
      }
      for(a=0;a<numberofelements;a++){
        //System.out.print(a);
        timer=time+2;
        if((i+1<rows) && ((map1[i+1][j]=='T') || (map1[i+1][j]=='S') || (map1[i+1][j]=='.') || (map1[i+1][j]=='A') ) && (map2[i+1][j]==0 || (map2[i+1][j]>timer))){
          map2[i+1][j]=timer;
          list2.add(i+1);
          list2.add(j);
          list2.add(timer);
          if((map1[i+1][j]=='A') && (flag==1)){
              List<Integer> newlist = new ArrayList<Integer>();
              int ai,jey;
              while(list3.size()>0){
                ai=list3.get(0);
                jey=list3.get(1);
                if((ai==i+1) && (jey==j)){
                  list3.remove(0);
                  list3.remove(0);
                  list3.remove(0);
                }
                else{
                  map2[ai][jey]=time+7;
                  list3.remove(0);
                  list3.remove(0);
                  list3.remove(0);
                  newlist.add(0,ai);
                  newlist.add(1,jey);
                  newlist.add(2,time+7);
                }
              }
              flag=0;
              list2.addAll(newlist);
          }
        }

        if((i-1>=0) && ((map1[i-1][j]=='T') || (map1[i-1][j]=='S') || (map1[i-1][j]=='.') || (map1[i-1][j]=='A') ) && (map2[i-1][j]==0 || (map2[i-1][j]>timer))){
            map2[i-1][j]=timer;
            list2.add(i-1);
            list2.add(j);
            list2.add(timer);
            if((map1[i-1][j]=='A') && (flag==1)){
              List<Integer> newlist = new ArrayList<Integer>();
              int ai,jey;
              while(list3.size()>0){
                ai=list3.get(0);
                jey=list3.get(1);
                if((ai==i-1) && (jey==j)){
                  list3.remove(0);
                  list3.remove(0);
                  list3.remove(0);
                }
                else{
                  map2[ai][jey]=time+7;
                  list3.remove(0);
                  list3.remove(0);
                  list3.remove(0);
                  newlist.add(0,ai);
                  newlist.add(1,jey);
                  newlist.add(2,time+7);
                }
              }
              flag=0;
              list2.addAll(newlist);
            }
          }
          if((j+1<collumns) && ((map1[i][j+1]=='T') || (map1[i][j+1]=='S') || (map1[i][j+1]=='.') || (map1[i][j+1]=='A') ) && (map2[i][j+1]==0 || (map2[i][j+1]>timer))){
              map2[i][j+1]=timer;
              list2.add(i);
              list2.add(j+1);
              list2.add(timer);
              if((map1[i][j+1]=='A') && (flag==1)){
                List<Integer> newlist = new ArrayList<Integer>();
                int ai,jey;
                while(list3.size()>0){
                  ai=list3.get(0);
                  jey=list3.get(1);

                  if((ai==i) && (jey==j+1)){
                    list3.remove(0);
                    list3.remove(0);
                    list3.remove(0);
                  }
                  else{
                    map2[ai][jey]=time+7;
                    list3.remove(0);
                    list3.remove(0);
                    list3.remove(0);
                    newlist.add(0,ai);
                    newlist.add(1,jey);
                    newlist.add(2,time+7);
                  }
                }
                flag=0;
                list2.addAll(newlist);
            }
          }

          if((j-1>=0) && ((map1[i][j-1]=='T') || (map1[i][j-1]=='S') || (map1[i][j-1]=='.') || (map1[i][j-1]=='A')) && (map2[i][j-1]==0 || (map2[i][j-1]>timer))) {
              map2[i][j-1]=timer;
              list2.add(i);
              list2.add(j-1);
              list2.add(timer);
              if((map1[i][j-1]=='A') && (flag==1)){
                List<Integer> newlist = new ArrayList<Integer>();
                int ai,jey;
                while(list3.size()>0){
                  //System.out.println(list3.size());
                  ai=list3.get(0);
                  jey=list3.get(1);
                  if((ai==i) && (jey==j-1)){
                    list3.remove(0);
                    list3.remove(0);
                    list3.remove(0);
                  }
                  else{
                    //System.out.println(numberofelements);
                    map2[ai][jey]=time+7;
                    list3.remove(0);
                    list3.remove(0);
                    list3.remove(0);
                    newlist.add(0,ai);
                    newlist.add(1,jey);
                    newlist.add(2,time+7);
                  }
                }
                flag=0;
                list2.addAll(newlist);
            }
          }
          //System.out.println(list2);
          //System.out.println(numberofelements);
          list2.remove(0);
          list2.remove(0);
          list2.remove(0);
          if (list2.size()>0){
            i=list2.get(0);
            j=list2.get(1);
            time=list2.get(2); //exei tis sintetagmenes tou W
          }
        }
          if (flag2==0){
              break;
            }


    }


/*
    for(i=0;i<rows;i++){
      for(j=0;j<collumns;j++){
        System.out.print(map2[i][j]);
				System.out.print(" ");
        if(j==collumns-1)
          System.out.println(' ');
      }
    }
*/

//φτιάχνει ένα πίνακα που έχει τις δυνατές θέσεις που μπορεί να πάιε ο Σωτήρης και τις χρονικές στιγμές που θα φτάσει σε αυτές.
//Όταν δεν μπορεί να μπεί σε κάποια θέση βάλε 0

while(true){
	int flag2=0;
	int numberofelements=0;
	int sz=list1.size();
	if(sz>0){
		flag2=1;
		numberofelements=sz/3;
		i=list1.get(0);
		j=list1.get(1);
		time=list1.get(2);
	}
	for(a=0;a<numberofelements;a++){
		if((i+1<rows) && ((map1[i+1][j]=='T') || (map1[i+1][j]=='W') || (map1[i+1][j]=='.') || (map1[i+1][j]=='A') ) && (map3[i+1][j]==0) && ((time+1) < map2[i+1][j]) ){
							map3[i+1][j]=time+1;
							list1.add(i+1);
							list1.add(j);
							list1.add(time+1);
						}
					if((i-1>=0) && ((map1[i-1][j]=='T') || (map1[i-1][j]=='W') || (map1[i-1][j]=='.') || (map1[i-1][j]=='A') ) && (map3[i-1][j]==0) && (time+1<map2[i-1][j]) ){
							map3[i-1][j]=time+1;
							list1.add(i-1);
							list1.add(j);
							list1.add(time+1);
						}

					if((j+1<collumns) && ((map1[i][j+1]=='T') || (map1[i][j+1]=='W') || (map1[i][j+1]=='.') || (map1[i][j+1]=='A') ) &&  (map3[i][j+1]==0) && (time+1<map2[i][j+1])){
							map3[i][j+1]=time+1;
							list1.add(i);
							list1.add(j+1);
							list1.add(time+1);
						}
					if((j-1>=0) && ((map1[i][j-1]=='T') || (map1[i][j-1]=='W') || (map1[i][j-1]=='.') || (map1[i][j-1]=='A') ) && (map3[i][j-1]==0) && (time+1<map2[i][j-1]) ){
							map3[i][j-1]=time+1;
							list1.add(i);
							list1.add(j-1);
							list1.add(time+1);
						}


						list1.remove(0);
	          list1.remove(0);
	          list1.remove(0);
	          if (list1.size()>0){
	            i=list1.get(0);
	            j=list1.get(1);
	            time=list1.get(2); //exei tis sintetagmenes tou W
	          }
	        }
	          if (flag2==0){
	              break;
	            }

		}
		/*
		for(i=0;i<rows;i++){
			for(j=0;j<collumns;j++){
				System.out.print(map3[i][j]);
				System.out.print(" ");
				if(j==collumns-1)
					System.out.println(' ');
			}
		}
*/
//#ΒFS στο τελικό πίνακα για να βρούμε το ζητούμενο αποτέλεσμα
int visited[][]= new int[rows][collumns];
int Parx[][]=new int[rows][collumns];
int Pary[][]=new int[rows][collumns];
for(a=0;a<rows;a++){
	for(i=0;i<collumns;i++){
		Parx[a][i]=-1;
		Pary[a][i]=-1;
	}
}
List<Integer> possiblex = Arrays.asList(1,0,0,-1);
List<Integer> possibley = Arrays.asList(0,-1,1,0);
int first=list4.get(0);
int second=list4.get(1);
list1=listsotir;
int sx=list1.get(0);
int sy=list1.get(1);
int p,q;
List<Integer> queue = new ArrayList<Integer>();
queue.add(sx);
queue.add(sy);
visited[sx][sy]=1;
while(queue.size()>0){
	p=queue.get(0);
	q=queue.get(1);
	queue.remove(0);
	queue.remove(0);
	for(i=0;i<4;i++){
		int tx=p+possiblex.get(i);
		int ty=q+possibley.get(i);
		if((tx>=0 && tx<rows && ty>=0 && ty<collumns) && visited[tx][ty]==0 && map3[tx][ty]!=0){
			queue.add(tx);
			queue.add(ty);
			visited[tx][ty]=1;
			Parx[tx][ty]=p;
			Pary[tx][ty]=q;
		}
	}
}
if(visited[first][second]==0){
 System.out.println("IMPOSSIBLE");
}
else{
	p=first;
	q=second;
	List<Integer> ans = new ArrayList<Integer>();
	ans.add(p);
	ans.add(q);
	int s,t;
	while(!((p==sx)&&(q==sy))){
		s=Parx[p][q];
		t=Pary[p][q];
		ans.add(0,s);
		ans.add(1,t);
		p=s;
		q=t;
	}
	System.out.println(ans.size()/2 -1);
	List<Character> moves = new ArrayList<Character>();
	while(ans.size()/2>1){
		int minus=ans.get(0)-ans.get(2);
		if(minus!=0){
			if(minus<0){
				moves.add('D');
			}
			else{
				moves.add('U');
			}
		}
		else{
			int minus2=ans.get(1)-ans.get(3);
			if(minus2<0){
				moves.add('R');
			}
			else {
				moves.add('L');
			}
		}
		ans.remove(0);
		ans.remove(0);
	}

	String teliko2 =moves.toString().replace("[", "").replace("]", "").replace(",", "").replace(" ","");
	char[] teliko = teliko2.toCharArray();
 	System.out.println(teliko);

}
  }
}
