
% Initial call, calls 4 arg signature
max([X|Xs],O) :- max(Xs, X, O).

% If we find a new maximum, override it
max([X|Xs], M, O) :- X > M, max(Xs, X, O).
% Else, just keep looking
max([_|Xs], M, O) :- max(Xs, M, O).
% End of the search, no more terms
max([], X, X).
