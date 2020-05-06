% Edge case: single element list
mergesort([X], [X]).
% Edge case: empty list
mergesort([], []).
% Edge case: sorted items
mergesort([A, B], [A, B]) :- A =< B.
% Edge case: inverted items
mergesort([A, B], [B, A]) :- A > B.
% Base call: split, recurse, merge
mergesort(L, O) :-
    split(L, Ll, Lr),
    mergesort(Ll, Llo),
    mergesort(Lr, Lro),
    merge_lists(Llo, Lro, O).

% Edge case: empty lists
merge_lists([], [], []).
% Edge case, Lr is empty
merge_lists(Ll, [], Ll).
% Edge case: Ll is empty
merge_lists([], Lr, Lr).
% First item on first list is the smallest
merge_lists([X|Ll], [Y|Lr], [X|O]) :-
    X < Y,
    merge_lists(Ll, [Y|Lr], O).
% First items on both lists are the same
merge_lists([X|Ll], [X|Lr], [X,X|O]) :- merge_lists(Ll, Lr, O).
% First item on second list is the smallest
merge_lists([X|Ll], [Y|Lr], [Y|O]) :-
    X > Y,
    merge_lists([X|Ll], Lr, O).

% Even length case
split(L, A, B) :-
    append(A, B, L), same_length(A, B), !.
% Odd edge case, first list is longer
split(L, A, [X|B]) :-
    append(A, [X|B], L), same_length(A, B), !.