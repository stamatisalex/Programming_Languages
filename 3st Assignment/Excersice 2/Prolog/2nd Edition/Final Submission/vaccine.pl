:-dynamic hashset/10.

noty(X,Y):-
  ((X==false)->Y=true
  ;(X==true)->Y=false
  ).

vaccine(File,Answer):-
  open(File,read, Stream),
  read_line(Stream,[N]),
  checkthefile(0,N,Stream,[],P1),
  letsmake(P1,[],P),
  Answer=P.


  read_line(Stream, L) :-
      read_line_to_codes(Stream, Line),
      atom_codes(Atom, Line),
      atomic_list_concat(Atoms, ' ', Atom),
      maplist(atom_number, Atoms, L),!.

%Makes a list of the string chars for each string
  read_line_s(Stream, L,Ans) :-
      read_line_to_codes(Stream, L),
        atom_codes(Atom, L),
        atom_chars(Atom,Ans).

letsmake([],Result,Answer):-Answer=Result.
letsmake([H|T],Result,Answer):-
  bfs(H,Ans),
  retractall(hashset(_,_,_,_,_,_,_,_,_,_)),
  atom_chars(Str,Ans),
  append(Result,[Str],TheResult),
  letsmake(T,TheResult,Answer).


%%Υλοποιηση με λιστες, ενω στην παιθον και στην τζαβα ηταν με strings
checkthefile(N,N,_,Result,Answer):- Answer=Result.
checkthefile(Start,N,Stream,Result,Answer):-
  read_line_s(Stream,_,A),
  append(Result,[A],TheResult),
  %%write(Str),nl,
  Starter is Start+1,
  checkthefile(Starter,N,Stream,TheResult,Answer),!.


checkunvisited(Firsttop,IsA,IsC,IsG,IsU):-
  (((Firsttop=@='A',IsA=:=0);(Firsttop=@='C',IsC=:=0);(Firsttop=@='G',IsG=:=0);(Firsttop=@='U',IsU=:=0))->true
  ;false),!.



  complement([],L,Ans):-Ans=L,!.
  complement([H|T],L,Ans):-
    (H=@='G'-> append(L,['C'],New)
    ;H=@='C'->append(L,['G'],New)
    ;H=@='A'->append(L,['U'],New)
    ;H=@='U'->append(L,['A'],New)
    )
    ,complement(T,New,Ans),!.


pair('A','U').
pair('U','A').
pair('C','G').
pair('G','C').
rnamatch(A,B) :- maplist(pair,A,B).


whilebfs(_,[],_,_).
whilebfs(Line,[H|T],TheAnswer):-
  %%writeln(H),
  (Ans,Remain,S,Bottom,Flag,Flag2,IsA,IsC,IsG,IsU,Compare)=H,
  Q=T,

  (
    %%not((X=Seen.get(Hi),X=:=1))->
    not(hashset(Remain,S,Bottom,Flag,Flag2,IsA,IsC,IsG,IsU,Compare))->
      (
      assertz(hashset(Remain,S,Bottom,Flag,Flag2,IsA,IsC,IsG,IsU,Compare)),
      Liner is Line+1,

      (
      (Remain=[])->(TheAnswer=Ans),!
      ;
      (
        Second1=S,
        (
          (Flag2*Flag=:=0)->
            (
            (Flag=:=0)->
              (
              append(Ans,['c'],Copy1),
              noty(Compare,K),
              append(Q,[(Copy1,Remain,S,Bottom,1,Flag2,IsA,IsC,IsG,IsU,K)],Q3),
              append(Remain11,[Last],Remain),
              (
              (Compare==true)->
                (pair(Last,Snew),
                (
                  ((Snew=@=S);checkunvisited(Snew,IsA,IsC,IsG,IsU))->(
                          (Snew=@='A')->(
                      append(Ans,['p'],Copya),
                      append(Q3,[(Copya,Remain11,Snew,Bottom,0,0,1,IsC,IsG,IsU,Compare)],Q4)
                      )
                      ;   (Snew=@='U')->(
                          append(Ans,['p'],Copya),
                          append(Q3,[(Copya,Remain11,Snew,Bottom,0,0,IsA,IsC,IsG,1,Compare)],Q4)
                      )
                      ;   (Snew=@='C')->(
                          append(Ans,['p'],Copya),
                          append(Q3,[(Copya,Remain11,Snew,Bottom,0,0,IsA,1,IsG,IsU,Compare)],Q4)
                      )
                      ;   (Snew=@='G')->(
                          append(Ans,['p'],Copya),
                          append(Q3,[(Copya,Remain11,Snew,Bottom,0,0,IsA,IsC,1,IsU,Compare)],Q4)
                      )
                      )
                      ;Q4=Q3
                )
              )
              ;(Compare==false->
              (
              ((S=@=Last);checkunvisited(Last,IsA,IsC,IsG,IsU))->(
                      (Last=@='A')->(
                  append(Ans,['p'],Copyas),
                  append(Q3,[(Copyas,Remain11,Last,Bottom,0,0,1,IsC,IsG,IsU,Compare)],Q4)
                  )
                  ;   (Last=@='U')->(
                      append(Ans,['p'],Copyas),
                      append(Q3,[(Copyas,Remain11,Last,Bottom,0,0,IsA,IsC,IsG,1,Compare)],Q4)
                  )
                  ;   (Last=@='C')->(
                      append(Ans,['p'],Copyas),
                      %%writeln("Hi"),
                      append(Q3,[(Copyas,Remain11,Last,Bottom,0,0,IsA,1,IsG,IsU,Compare)],Q4)
                  )
                  ;   (Last=@='G')->(
                      append(Ans,['p'],Copyas),
                      append(Q3,[(Copyas,Remain11,Last,Bottom,0,0,IsA,IsC,1,IsU,Compare)],Q4)
                  )
                  )
                  ;Q4=Q3
              )
              )
              )

              ,

              %%writeln('Q4= '+ Q4),
              (
                (Flag2*Flag=:=0)->(
                  (Flag2=:=0)->(
                    %%reverse(Second1,Second1New),
                    %%push1(Q4,Ans,'r',Remain,Second1New,Flag,1,0,IsA,IsC,IsG,IsU,SosNewList2),
                    append(Ans,['r'],Copy2),
                    append(Q4,[(Copy2,Remain,Bottom,Second1,Flag,1,IsA,IsC,IsG,IsU,Compare)],SosNewList2),
                    whilebfs(Liner,SosNewList2,TheAnswer),!
                    )
                    ;whilebfs(Liner,Q4,TheAnswer),!
                  )
              ;
              whilebfs(Liner,Q4,TheAnswer),!
              )
              )

              ;
              (
              append(Remain112,[Last1],Remain),
              (
              Compare=true->
                (pair(Last1,Snew1),
                (
                  ((Snew1=@=S);checkunvisited(Snew1,IsA,IsC,IsG,IsU))->(
                          (Snew1=@='A')->(
                      append(Ans,['p'],Copya),
                      append(Q,[(Copya,Remain112,Snew1,Bottom,0,0,1,IsC,IsG,IsU,Compare)],Q2)
                      )
                      ;   (Snew1=@='U')->(
                          append(Ans,['p'],Copya),
                          append(Q,[(Copya,Remain112,Snew1,Bottom,0,0,IsA,IsC,IsG,1,Compare)],Q2)
                      )
                      ;   (Snew1=@='C')->(
                          append(Ans,['p'],Copya),
                          append(Q,[(Copya,Remain112,Snew1,Bottom,0,0,IsA,1,IsG,IsU,Compare)],Q2)
                      )
                      ;   (Snew1=@='G')->(
                          append(Ans,['p'],Copya),
                          append(Q,[(Copya,Remain112,Snew1,Bottom,0,0,IsA,IsC,1,IsU,Compare)],Q2)
                      )
                      )
                      ;Q2=Q
                )
              )
              ;(
              ((S=@=Last1);checkunvisited(Last1,IsA,IsC,IsG,IsU))->(
                      (Last1=@='A')->(
                  append(Ans,['p'],Copya),
                  append(Q,[(Copya,Remain112,Last1,Bottom,0,0,1,IsC,IsG,IsU,Compare)],Q2)
                  )
                  ;   (Last1=@='U')->(
                      append(Ans,['p'],Copya),
                      append(Q,[(Copya,Remain112,Last1,Bottom,0,0,IsA,IsC,IsG,1,Compare)],Q2)
                  )
                  ;   (Last1=@='C')->(
                      append(Ans,['p'],Copya),
                      append(Q,[(Copya,Remain112,Last1,Bottom,0,0,IsA,1,IsG,IsU,Compare)],Q2)
                  )
                  ;   (Last1=@='G')->(
                      append(Ans,['p'],Copya),
                      append(Q,[(Copya,Remain112,Last1,Bottom,0,0,IsA,IsC,1,IsU,Compare)],Q2)
                  )
                  )
                  ;Q2=Q
              )
              )

,



                    (
                      (Flag2*Flag=:=0)->(

                        (Flag2=:=0)->(

                          append(Ans,['r'],Copy31),
                          append(Q2,[(Copy31,Remain,Bottom,S,Flag,1,IsA,IsC,IsG,IsU,Compare)],SosNewList),
                          whilebfs(Liner,SosNewList,TheAnswer),!
                          )
                          ;whilebfs(Liner,Q2,TheAnswer),!
                          )
                    ;
                    whilebfs(Liner,Q2,TheAnswer),!
                    )
                  )
            )
        ;(


        append(Remain1123,[Last1234],Remain),
        (
        Compare=true->
          (pair(Last1234,Snew1234),
          (
            ((Snew1234=@=S);checkunvisited(Snew1234,IsA,IsC,IsG,IsU))->(
                    (Snew1234=@='A')->(
                append(Ans,['p'],Copyas123),
                append(Q,[(Copyas123,Remain1123,Snew1234,Bottom,0,0,1,IsC,IsG,IsU,Compare)],Q2)
                )
                ;   (Snew1234=@='U')->(
                    append(Ans,['p'],Copyas123),
                    append(Q,[(Copyas123,Remain1123,Snew1234,Bottom,0,0,IsA,IsC,IsG,1,Compare)],Q2)
                )
                ;   (Snew1234=@='C')->(
                    append(Ans,['p'],Copyas123),
                    append(Q,[(Copyas123,Remain1123,Snew1234,Bottom,0,0,IsA,1,IsG,IsU,Compare)],Q2)
                )
                ;   (Snew1234=@='G')->(
                    append(Ans,['p'],Copyas123),
                    append(Q,[(Copyas123,Remain1123,Snew1234,Bottom,0,0,IsA,IsC,1,IsU,Compare)],Q2)
                )
                )
                ;Q2=Q
          )
        )
        ;(
        ((S=@=Last1234);checkunvisited(Last1234,IsA,IsC,IsG,IsU))->(
                (Last1234=@='A')->(
            append(Ans,['p'],Copyas123),
            append(Q,[(Copyas123,Remain1123,Last1234,Bottom,0,0,1,IsC,IsG,IsU,Compare)],Q2)
            )
            ;   (Last1234=@='U')->(
                append(Ans,['p'],Copyas123),
                append(Q,[(Copyas123,Remain1123,Last1234,Bottom,0,0,IsA,IsC,IsG,1,Compare)],Q2)
            )
            ;   (Last1234=@='C')->(
                append(Ans,['p'],Copyas123),
                append(Q,[(Copyas123,Remain1123,Last1234,Bottom,0,0,IsA,1,IsG,IsU,Compare)],Q2)
            )
            ;   (Last1234=@='G')->(
                append(Ans,['p'],Copyas123),
                append(Q,[(Copyas123,Remain1123,Last1234,Bottom,0,0,IsA,IsC,1,IsU,Compare)],Q2)
            )
            )
            ;Q2=Q
        )
        )


    ,


              (
                (Flag2*Flag=:=0)->
                  (
                  (Flag2=:=0)->(
                    append(Ans,['r'],Copy4s),
                    append(Q2,[(Copy4s,Remain,Bottom,S,Flag,1,IsA,IsC,IsG,IsU,Compare)],SosNewList),
                    whilebfs(Liner,SosNewList,TheAnswer),!
                    )
                    ;whilebfs(Liner,Q2,TheAnswer),!
                    )
              ;
              whilebfs(Liner,Q2,TheAnswer),!
              )
          )
        )
      )
      )
    )
    ;
    whilebfs(Line,T,TheAnswer),!
  ),!.




bfs(S1,Ans):-
  append(S1New,[Top],S1),
  (
  (Top=@='A')->append([],[([p],S1New,Top,Top,0,0,1,0,0,0,false)],Q)
  ;(Top=@='G')->append([],[([p],S1New,Top,Top,0,0,0,0,1,0,false)],Q)
  ;(Top=@='C')->append([],[([p],S1New,Top,Top,0,0,0,1,0,0,false)],Q)
  ;(Top=@='U')->append([],[([p],S1New,Top,Top,0,0,0,0,0,1,false)],Q)
  )
  ,
  whilebfs(0,Q,P),
  Ans=P.
