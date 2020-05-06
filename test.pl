delete_all([], _, []).
delete_all([X|Xs], X, Y) :- delete_all(Xs, X, Y).
delete_all([T|Xs], X, [T|Y]) :- delete_all(Xs, X, Y).

replace_all([], _, _, []).
replace_all([X|Xs], X, Z, [Z|Y]) :- replace_all(Xs, X, Z, Y).
replace_all([T|Xs], X, Z, [T|Y]) :- replace_all(Xs, X, Z, Y).

tran(eins,one).
tran(zwei,two).
tran(drei,three).
tran(vier,four).
tran(fuenf,five).
tran(sechs,six).
tran(sieben,seven).
tran(acht,eight).
tran(neun,nine).

list_tran([], []).
list_tran([X|Xs], [T|Y]) :- tran(X, T), list_tran(Xs, Y).
list_tran([X|Xs], [T|Y]) :- tran(T, X), list_tran(Xs, Y).

twice([], []).
twice([X|Xs], [X,X|Y]) :- twice(Xs, Y).