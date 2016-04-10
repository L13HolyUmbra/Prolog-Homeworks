% @Author Dion de Jong
% @Date 9-20-15
% @Version 1.0
% @Project Cryptoarithmetic Problem


%The solution creates the clues:
pizza(Donna,Danny,David,Doreen,Water,Coke,Milk,Coffee,Steak,Pizza,Lasagna,Chicken) :-
%The men and women sat across from each other.
across(David,Danny),
across(Doreen,Donna),
%Other Clues:
beside(Doreen,Steak),
Chicken=Coke,
across(Lasagna,Milk),
Donna=Water,
%The three lists: People, drinks, Meals.
unique_position(Donna,Danny,David,Doreen),
unique_position(Water,Coke,Milk,Coffee),
unique_position(Steak,Pizza,Lasagna,Chicken),
%negative constraints.
\+Danny=Steak,
\+David=Coffee.


%  I assume the seating for the table is:
%  1  2
%  3  4
%  This means that across means (n+2)%4
%  and beside means (n+1)%2

position(1). position(2). position(3). position(4).
%beside(X,Y) :- beside(Y,X).
beside(X,Y) :- position(X), Y is (X+1) mod 2.
%across(X,Y) :- across(Y,X).
across(X,Y) :- position(X), Y is (X+2) mod 4.

% Ensure that each position is unique, so no position can be assigned to
% values or that no seat can be given two drinks for example.
unique_position(P1,P2,P3,P4) :-
position(P1), position(P2), position(P3), position(P4),
\+ P1=P2, \+ P1=P3, \+ P1=P4,
\+ P2=P3, \+ P2=P4,
\+ P3=P4.







