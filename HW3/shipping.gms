SETS i suppliers /KansasCity, Dallas/
     j dealerships /Minneapolis, NewYork, SanFrancisco, Seattle/;

PARAMETERS
    supply(i)
    / KansasCity 1000
      Dallas      800 /
    demand(j) 
    / Minneapolis  400
      NewYork      250
      SanFrancisco 450
      Seattle      450 /;

TABLE cost(i,j)
                Minneapolis  NewYork  SanFrancisco  Seattle
KansasCity            4       12            18       18
Dallas                9       15            17       21;

POSITIVE VARIABLES x(i,j);
VARIABLES z;

EQUATIONS
    PROFIT
    SupplyLimit(i)
    DemandRequirement(j);

PROFIT..  z =e= 100*sum((i,j), cost(i,j)*x(i,j));

supplyLimit(i)..  sum(j, x(i,j)) =l= supply(i);

demandRequirement(j)..  sum(i, x(i,j)) =g= demand(j);

MODEL shipping /PROFIT, SupplyLimit, DemandRequirement/;

SOLVE shipping USING LP MINIMIZING z;
