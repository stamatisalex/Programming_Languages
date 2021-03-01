

fun coronograph file =
    let
        	(* A function to read an integer from specified input. *)
              fun readInt input =
        	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

        	(* Open input file. *)
            	val inStream = TextIO.openIn file

          (* Read an integer (number of countries) and consume newline. *)
              	val n = readInt inStream
              	val _ = TextIO.inputLine inStream
                fun readInts i=
                  if (i=0) then nil
                  else (readInt inStream :: readInt inStream :: readInts (i-1))
                fun downfor n lim =
                let
                            fun solveforone k  =
                            let
                             val vertices=readInt inStream
                             val edges=readInt inStream
                             val color=Array.array((vertices+1),0)
                             val par=Array.array((vertices+1),0)
                             val check=Array.array((vertices+1),0)
                             val numberofcycles=Array.array(1,0)
                             val counterforcount=Array.array(1,0)
                             val sumofarray=Array.array(1,0)
                             val counterslistc=Array.array(1,[])
                             val lenghts=Array.array((vertices+1),0) (*Ουσιαστικά οι παρακάτω πίνακες γινονται για να περασμα κατα αναφορα, αντιστοιχα όπως το χα κάνει στη C++*)
                             val counter=Array.array((vertices+1),0)



                             (*ΦΤΙΑΧΝΩ ΤΟΝ ΓΡΑΦΟ Ο ΟΠΟΙΟΣ ΕΙΝΑΙ ΤΥΠΟΥ Int array list*)
                              fun makegraph ver e  =
                                   let
                                     val x =Array.array((ver+1),[]:(int list));
                                     fun fordown v limit  x=
                                       if v=limit then x
                                       else (
                                         let
                                         val one=readInt inStream
                                         val two=readInt inStream
                                         in

                                         Array.update(x,one,Array.sub(x,one)@(two::nil));
                                         Array.update(x,two,Array.sub(x,two)@(one::nil));
                                         Array.update(lenghts,one,(Array.sub(lenghts,one)+1));
                                         Array.update(lenghts,two,(Array.sub(lenghts,two)+1));
                                         fordown (v+1) limit  x
                                         end
                                         )

                                   in
                                    fordown 0 e  x (*pleon exo ena (int array list) list pou ua einai ver+1 ueseon*)
                                   end

                                 val sol1=makegraph vertices edges






                (*BRISKEI AN EXOUME ENAN KIKLO*)
               fun hasonecycle (ver:int) (*dld ver=u*) (iter:int) (lim:int) (parent:int)  (flag:int) (graph:(int list array)) =
               let
                           fun forloop (ver:int) (*dld ver=u*) (iter:int) (lim:int) (parent:int)  (flag:int) (graph:(int list array))  =
                           if (iter=lim)then
                             Array.update(color,ver,2)




                              else(
                                let
                                val i_ = List.nth(Array.sub(graph,ver),iter)
                                in
                                if (i_ =(Array.sub(par,ver))) then forloop ver (iter+1) lim parent flag graph
                                else (
                                  hasonecycle i_ 0 (Array.sub(lenghts,i_)) ver flag graph;
                                  forloop ver (iter+1) lim parent  flag graph

                                  )
                                  end
                                )
               in

               if (flag=1) then ()
               else(
                 if(Array.sub(numberofcycles,0)=2) then ()
                 else if (Array.sub(color,ver)=2) then ()

                else if (Array.sub(color,ver)=1) then (
                      let
                      val this_node=parent
                      fun whileloop (this_node:int) (ver:int) =
                            if(this_node=ver) then ()
                            else(
                              let
                              val this_node= Array.sub(par,this_node)
                              in
                              Array.update(check,this_node,Array.sub(numberofcycles,0));
                              whileloop this_node ver
                              end
                              )

                in
                Array.update(numberofcycles,0,Array.sub(numberofcycles,0)+1);
                Array.update(check,this_node,Array.sub(numberofcycles,0));
                whileloop this_node ver

                end
                )
                else (

                   Array.update(par,ver,parent);
                   Array.update(color,ver,1);
                   forloop ver 0  (Array.sub(lenghts,ver)) parent flag graph
)
                 )


               end
              (*Metraei ta dektra apo kaue kombo tou kiklou kata analogia me tin C*)
               fun count (ver:int) (parent:int) (l:int) (graph:(int list array)) =
               let
               fun fordown (iter:int) (theend:int)=
               if(iter = theend) then Array.sub(counterforcount,0)
               else(
                 let
                      val i_ = List.nth(Array.sub(graph,ver),iter)
                 in

                       if ((i_ = parent) orelse  (Array.sub(check,i_ )=1)) then fordown (iter+1) theend
                       else(
                       let
                            val has=Array.sub(counterforcount,0)
                       in
                           Array.update(counterforcount,0,has+1);
                           count (i_)  ver  (l+1) graph;
                           fordown (iter+1) theend
                       end
                   )
                   end
                   )
                   in
                   fordown 0 (Array.sub(lenghts,ver)) ;
                   if(l=1) then
                   Array.sub(counterforcount,0)

                   else 0
                   end


(*Kalei tin count gia kaue kombo pou anikei ston kiklo*)

                   fun cycles graph V  =
                   let
                   fun loop2 (v:int) (limit:int) (sum:int)=
                   if (v=limit) then sum
                   else(
                     if(Array.sub(check,v)=1) then (
                       Array.update(counterforcount,0,1);
                       let


                          val list=(count v 0 1  graph)



                       in
                       Array.update(counter,list,(Array.sub(counter,list)+1));
                       loop2 (v+1) limit (sum+1)
                       end
                       )
                       else loop2 (v+1) limit sum
                       )
                       val sumof=(loop2 1 V 0 )
                       in

                       Array.update(sumofarray,0,sumof);

                       true
                       end


                                fun addSum2 l vertices sum =
                                let
                                fun forloop iter limit sum =
                                  if(iter=limit) then sum
                                  else
                                  forloop (iter+1) limit (sum+(Array.sub(l,iter)*iter))

                                val sumis=forloop 0 (vertices+1) 0
                                in

                                if(sumis = vertices) then(
                                true)
                                else false
                                end

                              val flag=Array.array(1,0) (*ousiastika san perasma kata anafora gia to flag sti parakato sinartisi*)
                              (*Ektiponei to zitoumeno*)
                              fun printcount s =
                              let
                                fun forloop iter limit value =
                                if (iter =limit ) then ()
                                else (
                                  if(Array.sub(flag,0)=0) then (
                                    Array.update(flag,0,1);
                                    print(Int.toString(value));
                                    forloop (iter+1) limit value
                                    )
                                    else(
                                  print(" ");
                                  print(Int.toString(value));
                                  forloop (iter+1) limit value
                                  )
                                  )
                                fun forloop2 iter limit=
                                if(iter=limit) then ()
                                else(
                                  let
                                    val value=Array.sub(s,iter)
                                  in
                                    forloop 0 value iter;
                                    forloop2 (iter+1) limit
                                  end

                                  )
                              in
                                forloop2 0 (vertices+1)
                              end


                         in
                          Array.update(numberofcycles,0,0);
                          hasonecycle 1 0 (Array.sub(lenghts,1)) 0 0 sol1;

                                (*Result*)
                                if ((Array.sub(numberofcycles,0) = 1) andalso (cycles sol1 (vertices+1))) then (
                                  let

                                        val sum = Array.sub(sumofarray,0)
                                  in
                                  if (addSum2 counter vertices 0 ) then(
                                  print ("CORONA ");
                                  print( Int.toString (sum ));
                                  print ("\n");
                                  printcount counter;
                                  print ("\n")

                                )
                                else print ("NO CORONA\n")
                                end
                                )
                                else print ("NO CORONA\n")



                          end

         in
           if(n=lim) then()
           else (
             solveforone 1;   (*DEN XREIAZETAI PARAMETROS*)
             downfor (n+1) lim
             )
         end

 in
   n;
   downfor 0 n
 end;
