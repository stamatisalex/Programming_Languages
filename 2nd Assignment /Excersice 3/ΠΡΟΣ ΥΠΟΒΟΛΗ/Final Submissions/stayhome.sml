

fun stayhome file =
let
(*Diabasma arxeiou kata grammes. Molis allazei grammi kleinei mia lista. Etsi exo ena mia lista apo char list*)
fun linelist file =
    let val instr = TextIO.openIn file
        val str   = TextIO.inputAll instr
    in String.tokens Char.isSpace str
       before
       TextIO.closeIn instr
    end;


fun parse file   = map explode (linelist file);



fun showMatrix2 arr =
    Array2.appi Array2.RowMajor (fn (_, col, c) =>
      print (Int.toString(c) ^ (if col + 1 = Array2.nCols arr then "\n" else "    " )))
      {base=arr,row=0,col=0,nrows=NONE,ncols=NONE}




fun showMatrix arr =
    Array2.appi Array2.RowMajor (fn (_, col, c) =>
      print (str c ^ (if col + 1 = Array2.nCols arr then "\n" else "" )))
      {base=arr,row=0,col=0,nrows=NONE,ncols=NONE}

fun thefunct (map2:int Array2.array) (list1:(int*int*int) list) list2 list3 list4=
showMatrix2 map2

(*MEXRI EDO MPOMPA*)
(* AYti den xreiazetai. ektiponei lista int*int*int *)
fun checklist (list3:(int*int*int) list)=
if(list3=[]) then print("\n")
else
let
val head =hd list3
val i= #1 head
val j= #2 head
val time= #3 head
in
print(Int.toString(i));
print(" ");
print(Int.toString(j));
print(" ");
print(Int.toString(time));
print(" ");
checklist (tl list3)
end


fun checklist2 (list3:(int*int) list)=
if(list3=[]) then print("\n")
else
let
  val head =hd list3
  val i= #1 head
  val j= #2 head

  in
  print(Int.toString(i));
  print(" ");
  print(Int.toString(j));
  print("\n");
  checklist2(tl list3)
end


(*Ektiponei to epiuimito apotelesma*)
fun moveprint(moves)=print(Char.toString(hd moves) ^ String.concatWith "" (map Char.toString (tl moves))^ "\n")

(*Apokodikopoiise tis kiniseis apo ti lista poy exei tis katalliles ueseis*)
fun decode (ans:(int*int) list) (moves:char list) counter =
  if((tl ans) =[]) then (
  print(Int.toString(counter));
  print("\n");
  moveprint(moves)
  )
  else
  let
    val head = hd ans
    val zz = #1 head (*zero zero*)
    val zo = #2 head (*zero one*)
    val head2= hd (tl ans)
    val oz = #1 head2
    val oo = #2 head2
    val minus= zz-oz
    val minus2=zo-oo
  in
    if(minus<>0) then(
      if(minus<0)then decode (tl ans) (moves@[#"D"]) (counter+1)
      else decode (tl ans) (moves@[#"U"]) (counter+1)
      )
    else(
      if(minus2<0)then decode (tl ans) (moves@[#"R"]) (counter+1)
      else decode (tl ans) (moves@[#"L"]) (counter+1)
      )
    end


(*Tsekarei an einai dekto to simio, diladi an einai mesa sto pinaka*)
fun isValid x y map2 =
let
val rows= Array2.nRows(map2)
val collumns=Array2.nCols(map2)
in
if(x>=0 andalso x<rows andalso y>=0 andalso y<collumns) then true
else false
end




(*na tin kaleso Array2.nRows*)
fun printpath  map3 (rows:int) (collumns:int) (list1:(int*int*int) list) (list4:(int*int) list) ( ans:(int*int) list) (queue:(int*int) list)=
let
val head=hd list4
val first= #1 head (*dld to dx*)
val second= #2 head (*dld to dy*)

val possiblex=Array.array(4,0)
val possibley=Array.array(4,0)
val head2=hd list1
val sx= #1 head2
val sy= #2 head2
val queue=(sx,sy)::queue
val visited=Array2.array(rows,collumns,0)
val Parx=Array2.array(rows,collumns,~1)
val Pary= Array2.array(rows,collumns, ~1)
in
Array.update(possiblex,0,1);
Array.update(possiblex,3,~1);
Array.update(possibley,1,~1);
Array.update(possibley,2,1);
Array2.update(visited,sx,sy,1);
      let
                fun foorloop i limit p q possiblex possibley map3   queue visited  =
                if(i=limit) then queue
                else(
                  let
                  val x=p + Array.sub(possiblex,i)
                  val y=q + Array.sub(possibley,i)
                  in
                  if ((isValid x y map3) andalso (Array2.sub(visited,x,y)= 0) andalso (Array2.sub(map3,x,y)<>0))(*LEIPEI I SINUIKII ME TO XRONOOOO*) then(
                    Array2.update(visited,x,y,1);
                    let
                      val queue=queue@[(x,y)]
                    in
                        Array2.update(Parx,x,y,p);
                        Array2.update(Pary,x,y,q);
                        foorloop (i+1) limit p q possiblex possibley map3   queue visited
                    end
                    )
                    else foorloop (i+1) limit p q possiblex possibley map3   queue visited

                    end
                )
                fun whileloop queue sx sy possiblex possibley map3   visited  =
                  if(queue=[]) then visited(*lgk cout impossible*)
                  else(
                    let
                    val head = hd queue
                    val p= #1 head
                    val q= #2 head
                    val queue= tl queue
                    in
                            let
                            val queue = foorloop 0 4 p q possiblex possibley map3   queue visited
                            in
                              whileloop queue sx sy possiblex possibley map3   visited
                            end

                    end
                    )

            val visited = whileloop queue sx sy possiblex possibley map3   visited
      in
      if(Array2.sub(visited,first,second)=0) then print("IMPOSSIBLE\n")
      else(
        let
                    val p=first
                    val q=second
                    val ans=ans@[(p,q)]

                    fun whileloop2 p q (ans:(int*int) list) =
                    if(p=sx andalso q=sy) then ans
                    else(
                        let
                        val s= Array2.sub(Parx,p,q)
                        val t= Array2.sub(Pary,p,q)
                        val p=s
                        val q=t

                        in

                          whileloop2 p q ((s,t)::ans)
                        end
                    )
                  val ans2=whileloop2 p q ans
            in
          decode ans2 [] 0

        end
        )
      end
end




(*periexei to pinaka me tis dinates ueseis tou sotiri, an den einia dinati bale 0*)
fun corona3 thecopylistoflist1 map2  map1 map3 rows collumns (list1:(int*int*int) list) (list2:(int*int*int) list) (list3:(int*int*int) list) (list4:(int*int) list) sotiris flag (*flag to check if airplanes sintegmanes have been visited*)=
if (list1=[]) then (
  (*thefunct map3 list1 list2 list3 list4;*) (*Prints the map3 matrix*)
  let
  val rows= Array2.nRows(map3)
  val collumns=Array2.nCols(map3)
  in
  printpath map3 rows collumns thecopylistoflist1 list4 [] []
  end
  )
else(
  let
  val head =hd list1
  val i= #1 head
  val j= #2 head
  val time= #3 head
  in

    if ((i+1<=rows) andalso (Char.toString(Array2.sub(map1,i+1,j))="T" orelse Char.toString(Array2.sub(map1,i+1,j))="W" orelse  Char.toString(Array2.sub(map1,i+1,j))="." orelse Char.toString(Array2.sub(map1,i+1,j))="A") andalso (Array2.sub(map3,i+1,j)=0) andalso ((time+1)<Array2.sub(map2,i+1,j)) )then(
    Array2.update(map3,i+1,j,time+1);

    let

    val sotiris=(i+1,j,time+1)::sotiris
    in
    corona3 thecopylistoflist1 map2  map1 map3 rows collumns list1 list2 list3 list4 sotiris flag
    end
)
else if ((j+1<=collumns )andalso (Char.toString(Array2.sub(map1,i,j+1))="T" orelse Char.toString(Array2.sub(map1,i,j+1))="W" orelse  Char.toString(Array2.sub(map1,i,j+1))="." orelse Char.toString(Array2.sub(map1,i,j+1))="A") andalso (Array2.sub(map3,i,j+1)=0) andalso ((time+1)<Array2.sub(map2,i,j+1)) )then(
  Array2.update(map3,i,j+1,time+1);
  let

  val sotiris=(i,j+1,time+1)::sotiris
  in
  corona3 thecopylistoflist1 map2  map1 map3 rows collumns list1 list2 list3 list4 sotiris flag
  end
  )
  else if ((j-1>=0) andalso (Char.toString(Array2.sub(map1,i,j-1))="T" orelse Char.toString(Array2.sub(map1,i,j-1))="W" orelse  Char.toString(Array2.sub(map1,i,j-1))="." orelse Char.toString(Array2.sub(map1,i,j-1))="A") andalso (Array2.sub(map3,i,j-1)=0)  andalso ((time+1)<Array2.sub(map2,i,j-1))  )then(
    Array2.update(map3,i,j-1,time+1);
    let

    val sotiris=(i,j-1,time+1)::sotiris
    in
    corona3 thecopylistoflist1 map2  map1 map3 rows collumns list1 list2 list3 list4 sotiris flag
    end
    )
  else if ((i-1>=0) andalso (Char.toString(Array2.sub(map1,i-1,j))="T" orelse   Char.toString(Array2.sub(map1,i-1,j))="W" orelse  Char.toString(Array2.sub(map1,i-1,j))="." orelse Char.toString(Array2.sub(map1,i-1,j))="A")andalso (Array2.sub(map3,i-1,j)=0) andalso ((time+1)<Array2.sub(map2,i-1,j)) )then(
  Array2.update(map3,i-1,j,time+1);
  let

  val sotiris=(i-1,j,time+1)::sotiris
  in
  corona3 thecopylistoflist1 map2  map1 map3 rows collumns list1 list2 list3 list4 sotiris flag
  end
)
else if ((tl list1 )=[]) then corona3 thecopylistoflist1 map2  map1 map3 rows collumns sotiris list2 list3 list4 [] flag
else corona3 thecopylistoflist1 map2  map1 map3 rows collumns (tl list1) list2 list3 list4 sotiris flag
end
)











(*ananeonei to pinaka me ta aerodromia oste na ton prosthsei meta sto pinaka me tous coronografous KAI ANANEONIE KAI TON MAP2*)
fun renew (list3:(int*int*int) list) time i j newlist map2=
  if (list3=[]) then (newlist,map2)
  else(
    let
     val head=hd list3
     val ai= #1 head
     val jey= #2 head
     val hastime= #3 head
     in
    if ((ai=i) andalso (jey=j)) then renew (tl list3) time i j newlist map2(*agnoei to stixio auto*)
    else(
      Array2.update(map2,ai,jey,time+7);
      renew (tl list3) time i j ([(ai,jey,time+7)]@newlist) map2
)
    end
    )
(*bazei Ston map2  tous xronous pou paei o kaue ios sto kaue koutaki*)
fun corona2 map1 map2 rows collumns (list1:(int*int*int) list) (list2:(int*int*int) list) (list3:(int*int*int) list) (list4:(int*int) list) coronolist flag (*flag to check if airplanes sintegmanes have been visited*)=
if (list2=[]) then (
  (*thefunct map2 list1 list2 list3 list4;*) (*Prints the map2 matrix*)
let
val rows= Array2.nRows(map1)
val collumns=Array2.nCols(map1)
val map3= Array2.array(rows,collumns,0)
in
corona3 list1 map2 map1 map3 (rows-1) (collumns-1) list1 list2 list3 list4 [] 1
end
)
else(

  let
  val head =hd list2
  val i= #1 head
  val j= #2 head
  val time= #3 head
  val timer= time+2
  in

    if ((i+1<=rows) andalso (Char.toString(Array2.sub(map1,i+1,j))="T" orelse Char.toString(Array2.sub(map1,i+1,j))="S" orelse  Char.toString(Array2.sub(map1,i+1,j))="." orelse Char.toString(Array2.sub(map1,i+1,j))="A") andalso ((Array2.sub(map2,i+1,j)=0) orelse (Array2.sub(map2,i+1,j)>timer)) )then(
    Array2.update(map2,i+1,j,time+2);

    let

    val coronolist=(i+1,j,time+2)::coronolist
    in
    if ((Char.toString(Array2.sub(map1,i+1,j))="A") andalso flag=1) then
    let
    val map2= #2 (renew list3 time (i+1) j [] map2)
    val list2=list2@(#1 (renew list3 time (i+1) j [] map2))
    in

    corona2 map1 map2 rows collumns list1 list2 list3 list4 coronolist 0
    end
    else corona2 map1 map2 rows collumns list1 list2 list3 list4 coronolist flag
    end
)
else if ((j+1<=collumns )andalso (Char.toString(Array2.sub(map1,i,j+1))="T" orelse Char.toString(Array2.sub(map1,i,j+1))="S" orelse  Char.toString(Array2.sub(map1,i,j+1))="." orelse Char.toString(Array2.sub(map1,i,j+1))="A") andalso ((Array2.sub(map2,i,j+1)=0) orelse (Array2.sub(map2,i,j+1)>timer)) )then(
  Array2.update(map2,i,j+1,time+2);
  let

  val coronolist=(i,j+1,time+2)::coronolist
  in
  if ((Char.toString(Array2.sub(map1,i,j+1))="A") andalso flag=1) then
  let
  val map2= #2 (renew list3 time i (j+1) [] map2)
  val list2=list2@(#1 (renew list3 time i (j+1) [] map2))
  in

  corona2 map1 map2 rows collumns list1 list2 list3 list4 coronolist 0
  end
  else corona2 map1 map2 rows collumns list1 list2 list3 list4 coronolist flag
  end
  )
  else if ((j-1>=0) andalso (Char.toString(Array2.sub(map1,i,j-1))="T" orelse Char.toString(Array2.sub(map1,i,j-1))="S" orelse  Char.toString(Array2.sub(map1,i,j-1))="." orelse Char.toString(Array2.sub(map1,i,j-1))="A") andalso ((Array2.sub(map2,i,j-1)=0)  orelse (Array2.sub(map2,i,j-1)>timer))  )then(
    Array2.update(map2,i,j-1,time+2);
    let

    val coronolist=(i,j-1,time+2)::coronolist
    in
    if ((Char.toString(Array2.sub(map1,i,j-1))="A") andalso flag=1) then
    let
    val map2= #2 (renew list3 time i (j-1) [] map2)
    val list2=list2@(#1 (renew list3 time i (j-1) [] map2))
    in

    corona2 map1 map2 rows collumns list1 list2 list3 list4 coronolist 0
    end


    else corona2 map1 map2 rows collumns list1 list2 list3 list4 coronolist flag
    end
    )
  else if ((i-1>=0) andalso (Char.toString(Array2.sub(map1,i-1,j))="T" orelse   Char.toString(Array2.sub(map1,i-1,j))="S" orelse  Char.toString(Array2.sub(map1,i-1,j))="." orelse Char.toString(Array2.sub(map1,i-1,j))="A")andalso ((Array2.sub(map2,i-1,j)=0) orelse (Array2.sub(map2,i-1,j)>timer))  )then(
  Array2.update(map2,i-1,j,time+2);
  let

  val coronolist=(i-1,j,time+2)::coronolist
  in
  if ((Char.toString(Array2.sub(map1,i-1,j))="A") andalso flag=1) then
  let
  val map2= #2 (renew list3 time (i-1) j [] map2)
  val list2=list2 @ (#1 (renew list3 time (i-1) j [] map2))
  in

  corona2 map1 map2 rows collumns list1 list2 list3 list4 coronolist 0
  end


  else corona2 map1 map2 rows collumns list1 list2 list3 list4 coronolist flag
  end
)
else if ((tl list2 )=[]) then corona2 map1 map2 rows collumns list1 coronolist list3 list4 [] flag
else corona2 map1 map2 rows collumns list1 (tl list2) list3 list4 coronolist flag
end
)











      (*ουσιαστικα τοποθετει τις θέσεις που εχω εμποδιο στο πινακα και βάζει στις παρακατω λιστες τις θεσεις που ειναι τα στοιχεια αυτα στο πινακα*)
      fun corona1 map1 rows collumns (map2:int Array2.array) newrows newcollumns (list1:(int*int*int) list) list2 list3 list4=
      (*list1 stands for sotiris place
      list2 stands for coronavirus place*)
      (*list3 stands for airports places
      list4 stands for the final place*)
      if (Char.toString(Array2.sub(map1,rows,collumns))="S") then(

        let
          val list1=(rows,collumns,0)::list1
        in
          if(collumns=0 andalso rows=0) then (*thefunct map2 list1 list2 list3 list4*)
          corona2 map1 map2 (newrows-1) (newcollumns-1) list1 list2 list3 list4 [] 1(*elegxame olo to map1*)
          else if (collumns=0) then corona1 map1 (rows-1) (newcollumns-1) map2 newrows newcollumns list1 list2 list3 list4
          else corona1 map1 rows (collumns-1) map2 newrows newcollumns list1 list2 list3 list4
        end
        )
      else if (Char.toString(Array2.sub(map1,rows,collumns))="X") then(
          Array2.update(map2,rows,collumns,~2);
          if(collumns=0 andalso rows=0) then (*thefunct map2 list1 list2 list3 list4*)
          corona2 map1 map2 (newrows-1) (newcollumns-1) list1 list2 list3 list4 [] 1(*elegxame olo to map1*)
          else if (collumns=0) then corona1 map1 (rows-1) (newcollumns-1) map2 newrows newcollumns list1 list2 list3 list4
          else corona1 map1 rows (collumns-1) map2 newrows newcollumns list1 list2 list3 list4
      )
      else if(Char.toString(Array2.sub(map1,rows,collumns))="A") then(

          let
           val list3=(rows,collumns,0)::list3
          in
          if(collumns=0 andalso rows=0) then (*thefunct map2 list1 list2 list3 list4*)
          corona2 map1 map2 (newrows-1) (newcollumns-1) list1 list2 list3 list4 [] 1(*elegxame olo to map1*)
          else if (collumns=0) then corona1 map1 (rows-1) (newcollumns-1) map2 newrows newcollumns list1 list2 list3 list4
          else corona1 map1 rows (collumns-1) map2 newrows newcollumns list1 list2 list3 list4
        end
      )
      else if (Char.toString(Array2.sub(map1,rows,collumns))="W") then(

        let
          val list2=(rows,collumns,0)::list2
        in
          if(collumns=0 andalso rows=0) then (*thefunct map2 list1 list2 list3 list4*)
          corona2 map1 map2 (newrows-1) (newcollumns-1) list1 list2 list3 list4 [] 1(*elegxame olo to map1*)
          else if (collumns=0) then corona1 map1 (rows-1) (newcollumns-1) map2 newrows newcollumns list1 list2 list3 list4
          else corona1 map1 rows (collumns-1) map2 newrows newcollumns list1 list2 list3 list4
        end
        )
      else if (Char.toString(Array2.sub(map1,rows,collumns))="T") then(

          let
          val list4=(rows,collumns)::list4
          in
          if(collumns=0 andalso rows=0) then (*thefunct map2 list1 list2 list3 list4*)
          corona2 map1 map2 (newrows-1) (newcollumns-1) list1 list2 list3 list4 [] 1(*elegxame olo to map1*)
          else if (collumns=0) then corona1 map1 (rows-1) (newcollumns-1) map2 newrows newcollumns list1 list2 list3 list4
          else corona1 map1 rows (collumns-1) map2 newrows newcollumns list1 list2 list3 list4
      end
          )
      else (

            if(collumns=0 andalso rows=0) then (*thefunct map2 list1 list2 list3 list4*)
            corona2 map1 map2 (newrows-1) (newcollumns-1) list1 list2 list3 list4 [] 1(*elegxame olo to map1*)
            else if (collumns=0) then corona1 map1 (rows-1) (newcollumns-1) map2 newrows newcollumns list1 list2 list3 list4
            else corona1 map1 rows (collumns-1) map2 newrows newcollumns list1 list2 list3 list4

        )



  val map1= Array2.fromList(parse file)
  val rows= Array2.nRows(map1)
  val collumns=Array2.nCols(map1)
  val map2= Array2.array(rows,collumns,0)
  val S=[] (*ξεκινά ο Σωτηρης*)
  val W=[] (*ξεκινά ο Ιος*)
  val A=[] (*θεσεις αεροδρομιων*)
  val T=[]
in

 corona1 map1 (rows-1) (collumns-1) map2 rows collumns S W A T
end

;
