/*Alexandropoulos Stamatis(03117060)*/
/*Final function*/
powers2(File,Answer) :-
    open(File, read, Stream),
    read_line(Stream, [N]),
    checkthefile(0,N,Stream,[],P),
    Answer=P,!.
/*Reads a line*/
read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

checkthefile(End,End,_,Result,Answer):-Answer=Result.
checkthefile(Start,End,Stream,Result,Answer):-
  read_line(Stream,[N,K]),
  solveforone(N,K,P),
  append(Result,P,Thelist),
  Starter is Start+1,
  checkthefile(Starter,End,Stream,Thelist,Answer).


  /*Solves each case independently*/
solveforone(N,K,Answer) :-
  Sum is K,
  function(1,K,[],Sum,N,Check),
  Answer=[Check],!.
/*Solves the problem*/
  solve(Sum,N,L,Check):-(Sum=\=N ->Check=[]
                ;makelist(L,1,0,[],Check)).

/*LIke my programm in C++, creates k numbers which are powers of two and whose sum is equal to n.
Then we insert these numbers in a list, in order to have the final result */
    function(First,K,List2,Sum,N,Check):-
      ((First + Sum =<N )-> Newsum is Sum+First,Newelement is First*2,function(Newelement,K,List2,Newsum,N,Check)
      ;K=:=1
       ->append([First],List2,Thelist),solve(Sum,N,Thelist,Check)
      ;append([First],List2,Thelist),Ki is K-1,function(1,Ki,Thelist,Sum,N,Check)
      ),!.

/*make the list*/
makelist([],_,Counter,List,Check):-append(List,[Counter],Check).
makelist([A|B],Prev,Counter,List,Check):-((A=:=Prev)-> Count is Counter+1,makelist(B,A,Count,List,Check)
                            ;append(List,[Counter],List2),Prev1 is 2* Prev, makelist([A|B],Prev1,0,List2,Check)).
