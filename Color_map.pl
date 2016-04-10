% @Author Dion de Jong
% @Date 9-20-15
% @Version 1.0
% @Project Color_Map_Western_Europe

% solution(A,B,C,D,E,F,G) holds if A,B,C,D,E,F,G are the countries
% France, Belgium, the Netherlands, Germany, Switzerland, Italy, and
% Austria, respectively, where we want to solve a map-coloring problem
% using the colors red, yellow, and orange.

% The three colors:
color(red).
color(yellow).
color(orange).

% Solution using variables of the countries, where each variable is
% colored and the variables that don't equal each other are the
% counries that share borders.
solution(France,Belgium,Netherlands,Germany,Switzerland,Italy,Austria) :-
	color(France), color(Belgium), color(Netherlands), color(Germany), color(Switzerland), color(Italy), color(Austria),
	\+ France=Belgium, \+ France=Switzerland, \+ France=Germany, \+France=Italy, \+ Belgium=Netherlands, \+ Belgium=Germany,
	\+Netherlands=Germany, \+ Germany=Switzerland, \+ Germany=Austria, \+Switzerland=Austria, \+ Switzerland=Italy,
	\+ Italy=Austria.

%Write out of the solution.
write_solution(A,B,C,D,E,F,G) :-
	solution(A,B,C,D,E,F,G),
	write('France is colored '), write(A), nl,
	write('Belgium is colored '), write(B), nl,
	write('The Netherlands is colored '), write(C), nl,
	write('Germany is colored '), write(D), nl,
	write('Switzerland is colored '), write(E), nl,
	write('Italy is colored '), write(F), nl,
	write('Austria is colored '), write(G), nl.
