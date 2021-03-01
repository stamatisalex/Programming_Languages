import collections
#Alexandropoulos Stamatis(03117060)

def process(f):
    map1= f.read().split()
    main(map1)

#prints a 2D array
def print2Darray(map2):
    print('\n'.join([''.join(['{:4}'.format(item) for item in row])
    for row in map2]))

def main(map1):
    rows=len(map1)
    collumns=len(map1[0])
    list1=collections.deque() #για την θέση του Σωτήρη
    list2=collections.deque()
    list3=collections.deque() #για το αεροδρόμιο
    list4=[] #για τη τελική θέση
    sotiris=[] #για να μην χαθεί απο την corona2
    #ίδια λογική με αυτό της ml
    map2=[[0 for x in range(collumns)] for y in range(rows)] #Αυτός έχει τις τιμές της πλημμύρας
    map3=[[0 for x in range(collumns)] for y in range(rows)] #Αυτός έχει τις τιμές για τις δυνατές θέσεις του Σωτήρη
    for i in range(rows):
        for j in range(collumns):
            if (map1[i][j]=="W"):
                list2.append((i,j,0))
            elif map1[i][j]=="S":
                list1.append((i,j,0))
                sotiris.append((i,j))
            elif map1[i][j]=="A":
                list3.append((i,j,0))
            elif map1[i][j]=="T":
                list4.append((i,j))
            elif map1[i][j]=="X":
                map2[i][j]=-2
    map2=corona2(map1,map2,rows,collumns,list2,list3)
    map3 =corona3(map1,map2,map3,rows,collumns,list1)
    BFS(map3,sotiris,list4,rows,collumns)



#φτιάχνει ένα πίνακα που έχει τη αντίστοιχες στιγμές που θα φτάσει ο ιός σε κάθε κουτάκι
def corona2(map1,map2,rows,collumns,list2,list3):
    flag=1
    while 1:
        flag2=0
        numberofelements=0

        if(len(list2)>0):
            flag2=1
            numberofelements=len(list2)
            i=list2[0][0]
            j=list2[0][1]
            time=list2[0][2] #exei tis sintetagmenes tou W
        for a in range (numberofelements):
            timer=time+2
            if((i+1<rows) and ((map1[i+1][j]=="T") or (map1[i+1][j]=="S") or (map1[i+1][j]==".") or (map1[i+1][j]=="A") ) and (map2[i+1][j]==0 or (map2[i+1][j]>timer))):
                map2[i+1][j]=timer
                list2.append((i+1,j,timer))
                if((map1[i+1][j]=="A") and (flag==1)):
                    onelist,map2=renew(list3,time,i+1,j,map2)
                    flag=0
                    list2.extend(onelist)

            if((i-1>=0) and ((map1[i-1][j]=="T") or (map1[i-1][j]=="S") or (map1[i-1][j]==".") or (map1[i-1][j]=="A") ) and (map2[i-1][j]==0 or (map2[i-1][j]>timer))):
                map2[i-1][j]=timer
                list2.append((i-1,j,timer))
                if((map1[i-1][j]=="A") and (flag==1)):
                    onelist,map2=renew(list3,time,i-1,j,map2)
                    flag=0
                    list2.extend(onelist)
            if((j+1<collumns) and ((map1[i][j+1]=="T") or (map1[i][j+1]=="S") or (map1[i][j+1]==".") or (map1[i][j+1]=="A") ) and (map2[i][j+1]==0 or (map2[i][j+1]>timer))):
                map2[i][j+1]=timer
                list2.append((i,j+1,timer))
                if((map1[i][j+1]=="A") and (flag==1)):
                    onelist,map2=renew(list3,time,i,j+1,map2)
                    flag=0
                    list2.extend(onelist)
            if((j-1>=0) and ((map1[i][j-1]=="T") or (map1[i][j-1]=="S") or (map1[i][j-1]==".") or (map1[i][j-1]=="A") ) and (map2[i][j-1]==0 or (map2[i][j-1]>timer))):
                map2[i][j-1]=timer
                list2.append((i,j-1,timer))
                if((map1[i][j-1]=="A") and (flag==1)):
                    onelist,map2=renew(list3,time,i,j-1,map2)
                    flag=0
                    list2.extend(onelist)
            list2.popleft()
            if len(list2)>0:
                i=list2[0][0]
                j=list2[0][1]
                time=list2[0][2] #exei tis sintetagmenes tou W
        if flag2==0:
            break
    return map2

#λίστα που έχει τις θέσεις των αεροδρομιών με τους ανανεωμένους χρόνους. Αυτή  η λίστα θα κληθεί απο τη corona2
def renew(list3,time,i,j,map2):
    newlist=collections.deque()
    while (len(list3)>0):
        ai=list3[0][0]
        jey=list3[0][1]
        if((ai==i) and (jey==j)):
            list3.popleft()
        else:
            map2[ai][jey]=time+7
            list3.popleft()

            newlist.extendleft([(ai,jey,time+7)])
    return newlist,map2

#φτιάχνει ένα πίνακα που έχει τις δυνατές θέσεις που μπορεί να πάιε ο Σωτήρης και τις χρονικές στιγμές που θα φτάσει σε αυτές.
#Όταν δεν μπορεί να μπεί σε κάποια θέση βάλε 0
def corona3(map1,map2,map3,rows,collumns,list1):
    while 1:
        flag2=0
        numberofelements=0

        if(len(list1)>0):
            flag2=1
            numberofelements=len(list1)
            i=list1[0][0]
            j=list1[0][1]
            time=list1[0][2] #exei tis sintetagmenes tou W
        for a in range (numberofelements):
            if((i+1<rows) and ((map1[i+1][j]=="T") or (map1[i+1][j]=="W") or (map1[i+1][j]==".") or (map1[i+1][j]=="A") ) and (map3[i+1][j]==0) and ((time+1) < map2[i+1][j]) ):
                map3[i+1][j]=time +1
                list1.append((i+1,j,time+1))

            if((i-1>=0) and ((map1[i-1][j]=="T") or (map1[i-1][j]=="W") or (map1[i-1][j]==".") or (map1[i-1][j]=="A") ) and (map3[i-1][j]==0) and (time+1<map2[i-1][j]) ):
                map3[i-1][j]=time+1
                list1.append((i-1,j,time+1))

            if((j+1<collumns) and ((map1[i][j+1]=="T") or (map1[i][j+1]=="W") or (map1[i][j+1]==".") or (map1[i][j+1]=="A") ) and  (map3[i][j+1]==0) and (time+1<map2[i][j+1])):
                map3[i][j+1]=time+1
                list1.append((i,j+1,time+1))

            if((j-1>=0) and ((map1[i][j-1]=="T") or (map1[i][j-1]=="W") or (map1[i][j-1]==".") or (map1[i][j-1]=="A") ) and (map3[i][j-1]==0) and (time+1<map2[i][j-1]) ):
                map3[i][j-1]=time+1
                list1.append((i,j-1,time+1))

            list1.popleft()
            if len(list1)>0:
                i=list1[0][0]
                j=list1[0][1]
                time=list1[0][2] #exei tis sintetagmenes tou W
        if flag2==0:
            break
    return map3

#ΒFS στο τελικό πίνακα για να βρούμε το ζητούμενο αποτέλεσμα
def BFS(map3,list1,list4,rows,collumns):
    visited=[[0 for x in range(collumns)] for y in range(rows)]
    Parx=[[-1 for x in range(collumns)] for y in range(rows)]
    Pary=[[-1 for x in range(collumns)] for y in range(rows)]
    possiblex=[1,0,0,-1]
    possibley=[0,-1,1,0]
    first=list4[0][0]
    second=list4[0][1]
    sx=list1[0][0]
    sy=list1[0][1]
    queue=collections.deque()
    queue.append((sx,sy))
    visited[sx][sy]=1
    while (len(queue)>0):
        p=queue[0][0]
        q=queue[0][1]
        queue.popleft()
        for i in range(4):
            tx=p + possiblex[i]
            ty=q + possibley[i]
            if(isValid(tx,ty,rows,collumns) and (visited[tx][ty]==0) and (map3[tx][ty]!=0) ):
                queue.append((tx,ty))
                visited[tx][ty]=1
                Parx[tx][ty]=p
                Pary[tx][ty]=q
    if(visited[first][second]==0):
        print("IMPOSSIBLE")
    else:
        p=first
        q=second
        ans=collections.deque()
        ans.append((p,q))
        while(not((p==sx) and (q==sy))):
            s=Parx[p][q]
            t=Pary[p][q]
            ans.extendleft([(s,t)])
            p=s
            q=t

        print(len(ans)-1)
        decode(ans)
#Αποκωδικοποίησε τις κινήσεις απο τη λίστα που έχει τις θέσεις
def decode(ans):
    moves=collections.deque()
    while(len(ans)>1):
        minus=ans[0][0]-ans[1][0]
        if(minus!=0):
            if(minus<0):
                moves.append('D')
            else:
                moves.append('U')
        else:
            minus2=ans[0][1]-ans[1][1]
            if(minus2<0):
                moves.append('R')
            else:
                moves.append('L')
        ans.popleft()
    print(*moves,sep='')




def isValid (tx,ty,rows,collumns):
    return(tx>=0 and tx<rows and ty>=0 and ty<collumns)


if __name__ == "__main__":
        import sys
        if len(sys.argv) > 1:
                with open(sys.argv[1], "rt") as f:
                        process(f)
        else:
                process(sys.stdin)
