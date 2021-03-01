
:- dynamic edge/2.
:- dynamic numberofcycles/2.


coronograph(File,Answer) :-
    open(File, read, Stream),
    read_line(Stream, [N]),
    checkthefile(0,N,Stream,[],P),
    Answer=P,!.



read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L),!.

checkthefile(N,N,_,Result,Answer):-Answer = Result.
checkthefile(Start,N,Stream,Result,Answer) :-
  read_line(Stream,[V,E]),
  readallthelines(0,E,Stream),
  Vi is V+1,
  functor(Color,array,V),
  functor(Parent,array,V),
  functor(Check,array,V),
  filltheclause(1,Vi,Color,Parent,Check),
  assertz(numberofcycles(0,0)),
  functor(Counters,array,1),
  functor(Sumof,array,1),
  arg(1,Sumof,1),
  arg(1,Counters,1),

  solutionforone(V,P,Color,Parent,Check,Counters,Sumof),
  append(Result,P,Theresult),
  retract(numberofcycles(_,_)),
  retractall(edge(_,_)),
  Starter is Start+1,
  checkthefile(Starter,N,Stream,Theresult,Answer),!.


  readallthelines(E,E,_):-!.
  readallthelines(Start,E,Stream):-
    read_line(Stream,[F,S]),
    assertz(edge(F,S)),
    Starter is Start+1,
    readallthelines(Starter,E,Stream).

    filltheclause(V,V,_,_,_):-!.
    filltheclause(Start,V,Color,Parent,Check):-
      arg(Start,Color,0),
      arg(Start,Parent,0),
      arg(Start,Check,0),
      Starter is Start+1,
      filltheclause(Starter,V,Color,Parent,Check).



/*make two nodes connected*/
connected(X,Y) :-edge(Y,X);edge(X,Y).
/*find a path between two nodes*/



while(Thismode,V,Num,_,Parent,Check):-
  ((Thismode=\=V)->
  arg(Thismode,Parent,X),
  Thisnode is X,
  setarg(Thisnode,Check,Num),
  while(Thisnode,V,Num,_,Parent,Check);
  true,!).

forloop([],_,_,_,_):-!.
forloop([H|T],V,Color,Parent,Check):-
  ((arg(V,Parent,X),X is H)->forloop(T,V,Color,Parent,Check);
  dfs_cycle(H,V,Color,Parent,Check),
  forloop(T,V,Color,Parent,Check)).

%%EURESI AN EXEI ENA KIKLO
dfs_cycle(V,P,Color,Parent,Check):-
  (numberofcycles(0,X),X=:=2)->true,!;
  (arg(V,Color,X),X is 2)->true,!;
  (arg(V,Color,X),X is 1)->numberofcycles(0,Numberofcycles),
                      Num is Numberofcycles+1,
                      retract(numberofcycles(0,_)),
                      assertz(numberofcycles(0,Num)) ,
                      setarg(P,Check,Num),
                      while(P,V,Num,Color,Parent,Check);
  setarg(V,Parent,P),
  setarg(V,Color,1),
  findall(Nb,connected(V,Nb),Z),
  forloop(Z,V,Color,Parent,Check),
  setarg(V,Color,2),!.




forloop1([],_,_,_,_,_):-!.
forloop1([H|T],Parent,L,Lista,Check,Counters):-
  (((H=:=Parent);(arg(H,Check,X), X is 1);(member(H,Lista)))->forloop1(T,Parent,L,Lista,Check,Counters)
  ;arg(1,Counters,Count),
  append([H],Lista,Visited),
  Counti is Count + 1,
  setarg(1,Counters,Counti),
  Li is L +1,
  findall(Nb,connected(H,Nb),List),
  forloop1(List,H,Li,Visited,Check,Counters),
  forloop1(T,Parent,L,Visited,Check,Counters)).

  %%βασική συνάρτηση
  %%ousiastika kanei dfs se kaue kombo
  %%afairontas tous geitonikous kombous tou kiklou
counttheadjacent([],_,_,Thelist,Answer,_,_):-Answer=Thelist,!.
counttheadjacent([H|T],Parent,L,Thelist,Answer,Check,Counters):-
  findall(Nb,connected(H,Nb),List),
  %%write(List),nl,
  forloop1(List,H,L,[],Check,Counters),
  %%write("yeeeeees"),nl,
  %counters(0,KO),
  arg(1,Counters,KO),
  %%write(KO),nl,
  append([KO],Thelist,New),
  setarg(1,Counters,1),
  counttheadjacent(T,Parent,L,New,Answer,Check,Counters).



  %%Pairnei to pinaka check pou periexei to kombous pou einia
  %%se ena kiklo kai gia kaue kombo kalei tin count pou ousiastika kanei dfs se kaue kombo
  %%afairontas tous geitonikous kombous tou kiklou

  cycles(An,Check,Counters,Sumof):-
    findall(Nb,arg(Nb,Check,1),Z),
     %%contains all the nodes that belong to the cycle
    proper_length(Z,Sumof2),
    setarg(1,Sumof,Sumof2),
    counttheadjacent(Z,0,1,[],Answer,Check,Counters),
    msort(Answer,L),
    An=L,!.


%%Elegxei an einai koronograhpos
    ifcorona(Answer,Color,Parent,Check,Counters,Sumof):-
      dfs_cycle(1,0,Color,Parent,Check),
      numberofcycles(0,X),
      X is 1,
      cycles(An,Check,Counters,Sumof),
      arg(1,Sumof,Haslenght),
      append([Haslenght],[An],L),
      Answer =L.

    solutionforone(V,Answer,Color,Parent,Check,Counters,Sumof):-
      (ifcorona(P,Color,Parent,Check,Counters,Sumof)->nth0(1,P,Pi),sum_list(Pi,X),
        (X=:=V->Answer=[P]
              ;Answer=["'NO CORONA'"])
      ;Answer=["'NO CORONA'"]).
