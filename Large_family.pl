% @Author Dion de Jong
% @Date 9-20-15
% @Version 1.0
% @Database Large Family


%genders
male('Dion').   male('Opa').     male('Erric').
male('Peter'). male('Husband#1'). male('Rene').
male('Aranka').
male('Vincent'). male('Rembrandt'). %Imaginary great grandparents
male('Paul'). male('Jaime'). %Peter's brother and father
male('Joffrey'). %Peter's brother and Maruska's child.

female('Desiree').  female('Natascha').  female('Oma').
female('Demi'). female('Rowena'). female('Maruska').
female('Petra').
female('Beatrix'). female('Juliana'). %Imaginary great grandparents
female('Arya'). %Rowena's imaginary child
female('Cerse'). %Peter's Mom
female('Rachel'). female('Jessica').

opp_sex(X,Y) :- male(X), female(Y).
opp_sex(Y,X) :- male(X), female(Y).

%Basic family
child('Dion','Desiree'). %child(X,Y) X is the child of Y
child('Natascha','Desiree'). child('Natascha','Husband#1').
child('Maruska','Desiree'). child('Maruska','Husband#1').
child('Rowena','Petra'). child('Rowena','Rene').
child('Demi','Petra'). child('Demi','Rene').
child('Aranka','Petra'). child('Aranka','Rene').
child('Erric','Natascha'). child('Erric','Peter').
child('Arya','Rowena').
child('Peter','Cerse'). child('Peter','Jaime').
child('Paul','Cerse'). child('Paul','Jaime').
child('Rachel','Jaime').
child('Joffrey','Maruska'). child('Joffrey','Paul').
child('Jessica','Rachel'). child('Jessica','Dion').
%child(''). child('').
child('Desiree','Opa').
child('Petra','Oma'). child('Petra','Opa').
child('Oma','Juliana'). child('Oma','Vincent').
child('Opa','Beatrix'). child('Opa','Rembrandt').
child('Lady','Arya').

%parental relations
parent(X,Child) :- child(Child,X). %X is the parent of a child if the child is a child of X

father(X,Child) :- parent(X,Child), male(X). %X is the father of Child if X is the parent and male.
mother(X,Child) :- parent(X,Child), female(X). %X is the mother of Child if X is the parent and female.

grand_parent(X,GChild) :- parent(X,Parent), parent(Parent,GChild). %X is the grandparent of GChild if X is the parent of GChild's parent.

grand_father(X,GChild) :- father(X,Parent), parent(Parent,GChild). %X is the grandfather of GChild if X is the father of GChild's parent.
grand_mother(X,GChild) :- mother(X,Parent), parent(Parent,GChild). %X is the grandmother of GChild if X is the mother of GChild's parent.

great_grand_father(X,GGChild) :- grand_father(X,Parent), parent(Parent,GGChild). %X is the great grandfather of GGChild if X is the grandfather of GGChilds parent.
great_grand_mother(X,GGChild) :- grand_mother(X,Parent), parent(Parent,GGChild). %X is the great grandmother of GGChild if X is the grandmother of GGChilds parent.


%Sibling relations
sibling(X,Y) :- parent(Parent1,X), parent(Parent1,Y), X\==Y. %X and Y are siblings if they share a parent.
brother(X,Y) :- sibling(X,Y), male(X). %X is a brother of Y if he is a sibling of Y and a male.
sister(X,Y) :- sibling(X,Y), female(X). %X is a sister of Y if she is a sibling of Y and a female.
% half_sibling(X,Y) :- parent(Parent1,X), parent(Parent1,Y), parent(Parent2,X), parent(Parent3,Y), X\==Y, Parent1\==Parent2, Parent1\==Parent3, Parent2\==Parent3.
% half_sibling(X,Y) :- sibling(X,Y), parent(P1,X), parent(P1,Y),parent(P2,X),\+parent(P2,Y).
full_sibling(X,Y) :- parent(P1,X), parent(P1,Y), parent(P2,X), parent(P2,Y), X\==Y, P1\==P2. %X and Y are full siblings if they share two distinct parents
half_sibling(X,Y) :- sibling(X,Y), \+full_sibling(X,Y). %X and Y are half siblings if they are siblings but not full siblings; in other words, they are half siblings if they share 1 parent. However, it was done this way to account for those without two recorded parents.

%Cousin Relations
uncle(X,Child) :- brother(X,Parent), parent(Parent,Child). %an uncle is the brother of your parent
aunt(X,Child) :- sister(X,Parent), parent(Parent,Child). %an aunt is the sister of your parent

% cousin(X,Y) :- uncle(Uncle,X), father(Uncle,Y). %X and Y are cousins if
% the uncle of X is Y's father
% cousin(X,Y) :- aunt(Aunt,X), mother(Aunt,Y). %X
first_cousin(X,Y):- parent(P1,X), parent(P2,Y), P1\==P2, sibling(P1,P2).

double_first_cousin(X,Y) :- parent(P1,X), parent(P2,Y), P1\==P2, sibling(P1,P2), parent(P3,X), parent(P4,Y),P3\==P4, sibling(P3,P4),P1\==P3,P1\==P4.
half_first_cousin(X,Y) :- parent(P1,X), parent(P2,Y), P1\==P2, half_sibling(P1,P2).

second_cousin(X,Y) :- parent(P1,X), parent(P2,Y), P1\==P2, first_cousin(P1,P2).

first_cousin_twice_removed(X,Y) :- first_cousin(Z,X), grand_parent(Z,Y).
first_cousin_twice_removed(X,Y) :- grand_parent(Z,X), first_cousin(Z,Y).


descendant(X,Y) :- child(X,Y). %If x is a child of Y
descendant(X,Y) :- child(X,Z), descendant(Z,Y). %or if X is the child of someone who is a descendant of Y.

ancestor(X,Y) :- descendant(Y,X).

child_is_ancestor(X,Y,Z) :- child(Q,X), ancestor(Q,Y), ancestor(Q,Z).
closest_common_ancestor(X,Cousin1,Cousin2) :- ancestor(X,Cousin1), ancestor(X,Cousin2), (Cousin1\==Cousin2), \+child_is_ancestor(X,Cousin1,Cousin2).
%closest_common_ancestor(X,Cousin1,Cousin2) :- descendant(


%cousin(X,Y) :- child(X,Z),sibling(Z,W),child(Y,W).

%nthcousin(X,Y) :- cousin(X,Y).
cousin(X,Y) :- parent(P1,X), parent(P2,Y), P1\==P2, sibling(P1,P2).
cousin(X,Y) :- parent(P1,X), parent(P2,Y), P1\==P2, cousin(P1,P2).


write_child(X,Y) :- write(X), write(' is a child of '), write(Y), nl.
% write_descendant_chain(X,Y) :- descendant(X,Y), write_child(X,Y),
% child(C,X), write_descendant_chain(C,X).
write_descendant_chain(X,Y) :- child(X,Y), write_child(X,Y).
write_descendant_chain(X,Y) :- child(Z,Y), descendant(X,Z), write_child(Z,Y), write_descendant_chain(X,Z).



%This is a loop that prints all half-siblings.
%print_half_siblings :-
%	nl, nl, tab(10),
%        write(' HALF SIBLING LIST'),
%       nl, tab(10),
%        write('==================='),
%    nl, nl, print_all_half_siblings.
%
% print_all_half_siblings :-
%        half_sibling(X,Y),
%        write(X),
%	write(' is half sibling of '),
%	write(Y),
%        nl, fail.
% print_all_half_siblings.













