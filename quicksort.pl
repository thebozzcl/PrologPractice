% Edge case: single element list
quicksort([X], [X]).
% Edge case: empty list
quicksort([], []).
% Initial call: split the list in half
quicksort(L, O) :-
    split(L, Ll, Lr),
    quicksort(Ll, Lr, O).

% Edge case: empty left list
quicksort([], Lr, O) :-
    quicksort(Lr, O).
% Edge case: empty right list
quicksort(Ll, [], O) :-
    quicksort(Ll, O).
% Base call after split
quicksort(Ll, [P|Lr], O) :-
    moveAroundPivot(Ll, P, Lll, Llr),
    moveAroundPivot(Lr, P, Lrl, Lrr),
    append(Lll, Lrl, Pl),
    append(Llr, Lrr, Pr),
    quicksort(Pl, Sl),
    quicksort(Pr, Sr),
    append(Sl, [P], Ot),
    append(Ot, Sr, O).

% Edge case: empty list
moveAroundPivot([], _, [], []).
% Next number is smaller than the pivot
moveAroundPivot([X|L], P, [X|Lle], Lgt) :-
    X =< P,
    moveAroundPivot(L, P, Lle, Lgt).
% Next number is larger than the pivot
moveAroundPivot([X|L], P, Lle, [X|Lgt]) :-
    X > P,
    moveAroundPivot(L, P, Lle, Lgt).

% Even length case
split(L, A, B) :-
    append(A, B, L), same_length(A, B), !.
% Odd edge case, first list is longer
split(L, A, [X|B]) :-
    append(A, [X|B], L), same_length(A, B), !.
