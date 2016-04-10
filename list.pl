% Q: define a disjoint(A,B) predicate that is true if the two list arguments have no members in common ( you can use member/2). 
disjoint(A,B) :- \+ (member(X,A),member(X,B) ).

% define a predicate maxL to return the max of a list
maxL([Max],Max).
maxL([H|T],Max) :- maxL(T,TMax), TMax >  H, Max is TMax.
maxL([H|T],Max) :- maxL(T,TMax), TMax =< H, Max is H.

% define a predicate maxL to return the max of a list
% using disjunction (;) and parentheses -- sometimes not a bad idea (this isn't the best case)
maxL2([Max],Max).
maxL2([H|T],Max) :- maxL2(T,TMax) , 
    (   ( TMax >  H, Max is TMax) ; ( Max is H) ).

%see if list has e,v,i,l atoms consecutively in it
listEvil([e,v,i,l|_]). 
listEvil([H|T]) :-listEvil(T).
