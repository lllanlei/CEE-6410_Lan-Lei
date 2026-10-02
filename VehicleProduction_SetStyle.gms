SETS
    p   products  /Truck, Sedan/
    r   resources /FuelTanks, Seats, FourWD, TotalVeh/;

PARAMETERS
    profit(p)
    / Truck  100
      Sedan  110 /
    avail(r)
    / FuelTanks  14000
      Seats      18000
      FourWD      6000
      TotalVeh   10000 /;

TABLE use(r,p)
              Truck   Sedan
FuelTanks       2       1
Seats           1       2
FourWD          1       0
TotalVeh        1       1;

* PRIMAL MODEL

POSITIVE VARIABLES X(p);
VARIABLES Z;

EQUATIONS
    OBJ
    ResourceLimit(r);

OBJ..  Z =e= sum(p, profit(p)*X(p));

ResourceLimit(r)..  sum(p, use(r,p)*X(p)) =l= avail(r);

MODEL primal /OBJ, ResourceLimit/;

SOLVE primal USING LP MAXIMIZING Z;


* DUAL MODEL

POSITIVE VARIABLES Y(r);
VARIABLES W;

EQUATIONS
    DualOBJ
    ProductReq(p);

DualOBJ..  W =e= sum(r, avail(r)*Y(r));

ProductReq(p)..  sum(r, use(r,p)*Y(r)) =g= profit(p);

MODEL dual /DualOBJ, ProductReq/;

SOLVE dual USING LP MINIMIZING W;
