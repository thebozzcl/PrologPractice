% Edge case, our item is at the beginning of the list
binary_search(X, [X|_], M) :- M = 0.

% Initial call, splits the list for lookup
binary_search(X, L, M) :-
    split(L, Ll, Lr),
    binary_search(X, Ll, Lr, M).

% Recursive right side search
binary_search(X, Ll, [Y|Lr], O) :-
    Y < X,
    length(Ll, N),
    binary_search(X, Lr, M),
    O is (M + N + 1).
% Recursive left side search
binary_search(X, Ll, [Y|_], M) :-
    Y > X,
    binary_search(X, Ll, M).
% Edge case, the item is right in the middle of the list
binary_search(X, Ll, [X|_], M) :-
    length(Ll, M).

% Even length case
split(L, A, B) :-
    append(A, B, L), same_length(A, B), !.
% Odd length case, first list is longer
split(L, [X|A], B) :-
    append([X|A], B, L), same_length(A, B), !.
