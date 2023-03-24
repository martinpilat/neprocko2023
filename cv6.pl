%vyraz(Seznam, H, Expr)

vyraz([X], X, X).
vyraz(S, H, E):-append(S1, S2, S), 
                S1 \= [], S2 \= [],
                vyraz(S1, H1, E1),
                vyraz(S2, H2, E2),
                E = (E1 + E2),
                H is H1 + H2.
vyraz(S, H, E):-append(S1, S2, S), 
            S1 \= [], S2 \= [],
            vyraz(S1, H1, E1),
            vyraz(S2, H2, E2),
            E = (E1 - E2),
            H is H1 - H2.
vyraz(S, H, E):-append(S1, S2, S), 
                S1 \= [], S2 \= [],
                vyraz(S1, H1, E1),
                vyraz(S2, H2, E2),
                E = (E1 * E2),
                H is H1 * H2.
vyraz(S, H, E):-append(S1, S2, S), 
                S1 \= [], S2 \= [],
                vyraz(S1, H1, E1),
                vyraz(S2, H2, E2),
                H2 =\= 0,
                E = (E1 / E2),
                H is H1 // H2.


akce(V1-V2, _, _, 0-V2):-V1 > 0.
akce(V1-V2, _, _, V1-0):-V2 > 0.
akce(_-V2, C1, _, C1-V2).
akce(V1-_, _, C2, V1-C2).
akce(V1-V2, _, C2, 0-NV2):-V1 + V2 =< C2,
            NV2 is V1 + V2.
akce(V1-V2, _, C2, NV1-C2):-V1 + V2 > C2,
            NV1 is V1 - (C2 - V2).
akce(V1-V2, C1, _, NV1-0):-V1 + V2 =< C1,
            NV1 is V1 + V2.
akce(V1-V2, C1, _, C1-NV2):-V1 + V2 > C1,
            NV2 is V2 - (C1 - V1).

najdi(PS, C1, C2, CS, Path):-
    %heur(PS, CS, OPK),
    between(1, inf, L),
    najdi(PS, C1, C2, [PS], L, CS, Path).

najdi(PS, _, _, Vis, 0, PS, Path):-reverse(Vis, Path).
najdi(PS, C1, C2, Vis, Lim, CS, Path):-Lim > 0,
            NLim is Lim - 1,
            akce(PS, C1, C2, NS),
            %heur(NS, CS, OPK),
            %NLim > OPK,
            \+member(NS, Vis),
            najdi(NS, C1, C2, [NS|Vis], NLim, CS, Path).

% priste - !, setof/bagof/..., rozdilove seznamy