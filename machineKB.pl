machine(snipeWhacker).
machine(coyoteBane).
machine(weevSieve). 

part(spring).
part(steel).
part(rod).
part(wheel).
part(chain).
part(screen).

cost(spring,2).
cost(steel,5).
cost(rod,3).
cost(wheel,1).
cost(chain,2).
cost(screen,2).

recipe(weevSieve,[[rod,2],[screen,1]]).
recipe(coyoteBane,[[spring,2],[rod,4],[chain,2],[steel,2]]). 
recipe(snipeWhacker,[[steel,5],[wheel,4],[spring,4],[rod,2]]). 

%Question: how can we get the total cost of a machine, assuming it's cost is the sum of part costs?
cost(Mach,Cost) :- machine(Mach),recipe(Mach,Rec), get_total_cost(Rec,Cost).

get_total_cost([],0).
get_total_cost([H|T],Cost) :- H=[Part,Ct], cost(Part,PtCost), 
    get_total_cost(T,RestCost), Cost is PtCost*Ct+RestCost.
    
%Question: what would we change about the KB if we wanted to add the cost of labor (specifically)?
%A: just add labor in hours and go from there

%Define a query sellPrice(Item,Price) that will give prices for Machines (marked up 100%) and parts (marked up 50%)
sellPrice(Item,Price) :- part(Item),      cost(Item,BasePr),Price is 1.5*BasePr.
sellPrice(Item,Price) :- machine(Item),cost(Item,BasePr),Price is 2.0*BasePr.

    
%Q: wite a predicate (and any other predicates needed) to print a list of parts to make a machine
%prints a recipe in a nice form
print_recipe(Mach) :- write(Mach), write(' recipe:'), nl,
    recipe(Mach,Parts), printParts(Parts).
    
printParts([H|T]) :- H=[Part,Ct], write('    '), write(Ct),write('*'),write(Part),nl,printParts(T).