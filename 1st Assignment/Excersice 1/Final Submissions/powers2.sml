
  fun powers2 fileName =
  let

  (*http://courses.softlab.ntua.gr/pl1/2013a/Exercises/countries.sml  Έγινε χρήση του διπλανου συνδέσμου όπως δίνεται στην εκφώνηση για το διάβασμα αρχείου*)
  fun parse file =
      let
  	(* A function to read an integer from specified input. *)
        fun readInt input =
  	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

  	(* Open input file. *)
      	val inStream = TextIO.openIn file

    (* Read an integer  and consume newline. *)
  	val n = readInt inStream
  	val _ = TextIO.inputLine inStream

    fun readInts i=
      if (i=0) then nil
      else (readInt inStream :: readInt inStream :: readInts (i-1))
    in
      (n, readInts n)
    end

  (*LINEI TIN AKSISI*)
    fun solve (n,l:int list) =
      let
      (*λυση για ενα παραδειγμα, ιδιος τροπος χρήσης με την C *)
      fun solveforone n k=
      let
        val sum=Int.toLarge k;
        val check=Int.toLarge n;
        val arr=Array.array (k,1);
        fun fordown (i:int) (sum:IntInf.int) =

        if(i<0) then (arr,sum)
        else if ((sum +Array.sub(arr,i))<=check) then(
          (*print(Int.toString(sum+Array.sub(arr,i)));
          print("\n");
          *)
          Array.update(arr,i,(2*Array.sub(arr,i)));

          fordown i (sum+((Array.sub(arr,i))div 2))
          )
        else fordown (i-1) sum
      ;
      (*to IntInf xrisimopoieitai gia epektasi prosimou *)
      val (finalarray,total_sum)= fordown (k-1) sum ;

          fun arrayToList (arr:(IntInf.int  array)) (n:int) (limit:int) =
           if n=limit then nil
           else Array.sub(arr,n)::arrayToList arr (n+1) limit

           fun makelist l count prev =
                   if (List.null l) then (count::nil)
                   else if List.hd l=prev then makelist (List.tl l) (count+1) (List.hd l)
                   else (count:: makelist l 0 (2*prev ))

      val thelist= arrayToList finalarray 0 k;
      in
      if (total_sum<>check) then nil
      else makelist thelist 0 1
      end

            (*Ektiponei ta stoixeia mias listas bazontas kai [], to n einai int gia na blepo pote uelei [*)
              fun print1s(s:int) = print (Int.toString(s))
              fun printsl (l:int list) n =
                if n=1 then (
                  print("[");
                  printsl l 0
                  )
                  else if l=([]) then print("]")
                  else
                  (
                    print1s(List.hd l);
                    if( List.tl l<>nil) then
                    (
                    print (",");
                    printsl(List.tl l) 0
                    )
                    else printsl(List.tl l) 0
                  )

      in
      if (n<=0) then ()
      else(
        printsl (solveforone (List.hd l) (List.hd (List.tl l))) 1;
        print ("\n");
        solve ((n-1),(List.drop(l,2)))
      )
      end

  in
    solve (parse fileName)
  end

;
