radixsort(L, O) :-
    radixsort_start(L, 1, O).

% Start of recursion: bucketize items acording to Pth digit
radixsort_start(L, P, O) :-
    choose_bucket(L, P, Dmax, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    append(B0, B1, T1),
    append(T1, B2, T2),
    append(T2, B3, T3),
    append(T3, B4, T4),
    append(T4, B5, T5),
    append(T5, B6, T6),
    append(T6, B7, T7),
    append(T7, B8, T8),
    append(T8, B9, Lp),
    radixsort_decide(Lp, P, Dmax, O).

% Edge case: no items with P digits or more
radixsort_decide(L, _, Dmax, L) :-
    Dmax = -1.
% Else, just continue
radixsort_decide(L, P, Dmax, O) :-
    Dmax > -1,
    radixsort_start(L, P + 1, O).

% Edge case: no more items to sort
choose_bucket([], _, -1, [], [], [], [], [], [], [], [], [], []).
% Else, get the Pth digit and put it in its bucket
choose_bucket([X|L], P, Dmax, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9) :-
    get_nth_digit(X, P, D),
    put_in_bucket([X|L], P, D, Dmax, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9).

% This is MADNESS, but I do not know a better way :(
put_in_bucket([X|L], P, -1, Dmax, [X|B0], B1, B2, B3, B4, B5, B6, B7, B8, B9) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(-1, DmaxP).

put_in_bucket([X|L], P, 0, Dmax, [X|B0], B1, B2, B3, B4, B5, B6, B7, B8, B9) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(0, DmaxP).

put_in_bucket([X|L], P, 1, Dmax, B0, [X|B1], B2, B3, B4, B5, B6, B7, B8, B9) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(1, DmaxP).

put_in_bucket([X|L], P, 2, Dmax, B0, B1, [X|B2], B3, B4, B5, B6, B7, B8, B9) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(2, DmaxP).

put_in_bucket([X|L], P, 3, Dmax, B0, B1, B2, [X|B3], B4, B5, B6, B7, B8, B9) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(3, DmaxP).

put_in_bucket([X|L], P, 4, Dmax, B0, B1, B2, B3, [X|B4], B5, B6, B7, B8, B9) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(4, DmaxP).

put_in_bucket([X|L], P, 5, Dmax, B0, B1, B2, B3, B4, [X|B5], B6, B7, B8, B9) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(5, DmaxP).

put_in_bucket([X|L], P, 6, Dmax, B0, B1, B2, B3, B4, B5, [X|B6], B7, B8, B9) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(6, DmaxP).

put_in_bucket([X|L], P, 7, Dmax, B0, B1, B2, B3, B4, B5, B6, [X|B7], B8, B9) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(7, DmaxP).

put_in_bucket([X|L], P, 8, Dmax, B0, B1, B2, B3, B4, B5, B6, B7, [X|B8], B9) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(8, DmaxP).

put_in_bucket([X|L], P, 9, Dmax, B0, B1, B2, B3, B4, B5, B6, B7, B8, [X|B9]) :-
    choose_bucket(L, P, DmaxP, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9),
    Dmax is max(9, DmaxP).

% Edge case, P does not have digits
get_nth_digit(X, P, D) :-
    PowP is 10**(P - 1),
    X / PowP < 1,
    D is -1.
% Calculate the nth digit
get_nth_digit(X, P, D) :-
    PowP is 10**(P - 1),
    X / PowP >= 1,
    Pow is 10*PowP,
    D is ((X mod Pow) - (X mod PowP)) / PowP.