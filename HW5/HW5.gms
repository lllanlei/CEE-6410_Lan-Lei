SETS
    t      /s1, s2/
    Dam    /High, Low/;

PARAMETERS
    Q(t)
    / s1   600
      s2   200 /
    dem(t)
    / s1   1.0
      s2   3.0 /
    K(Dam)
    / High  700
      Low   300 /
    C(Dam)
    / High  10000
      Low    6000 /;

BINARY VARIABLES Y(Dam), YP;
POSITIVE VARIABLES A, S(t), D(t), R(t), P(t);
VARIABLES Z;

EQUATIONS
    OBJ
    OneDam
    MassBal(t)
    StorCap(t)
    Diversion(t)
    PumpCap(t)
    PumpFlow(t)
    MeetDem(t);

OBJ..  Z =e= 300*A - sum(Dam, C(Dam)*Y(Dam)) - 8000*YP - 20*sum(t, P(t));

OneDam..  sum(Dam, Y(Dam)) =l= 1;

MassBal(t)..  S(t++1) =e= S(t) + Q(t) - D(t) - R(t);

StorCap(t)..  S(t) =l= sum(Dam, K(Dam)*Y(Dam));

Diversion(t)..  D(t) =l= 1300*sum(Dam, Y(Dam));

PumpCap(t)..  P(t) =l= 401.5*YP;

PumpFlow(t)..  P(t) =l= R(t) + 365;

MeetDem(t)..  D(t) + P(t) =g= dem(t)*A;

MODEL ReservoirDesign /ALL/;

SOLVE ReservoirDesign USING MIP MAXIMIZING Z;
