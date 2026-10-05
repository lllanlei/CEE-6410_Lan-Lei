SETS
    Man    /Arnold, Supershelf/
    Sup    /Thomas, Washburn/
    Recip  /Zrox, Hewes, Rockwright/;

PARAMETERS
    cap(Man)
    / Arnold      75
      Supershelf  75 /
    dem(Recip)
    / Zrox        50
      Hewes       60
      Rockwright  40 /;

TABLE costMS(Man,Sup)
              Thomas   Washburn
Arnold          5         8
Supershelf      7         4;

TABLE costSR(Sup,Recip)
              Zrox   Hewes   Rockwright
Thomas          1      5         8
Washburn        3      4         4;

POSITIVE VARIABLES X(Man,Sup), Y(Sup,Recip);
VARIABLES Z;

EQUATIONS
    OBJ
    ManCap(Man)
    SupBal(Sup)
    RecipDem(Recip);

OBJ..  Z =e= sum((Man,Sup), costMS(Man,Sup)*X(Man,Sup)) + sum((Sup,Recip), costSR(Sup,Recip)*Y(Sup,Recip));

ManCap(Man)..  sum(Sup, X(Man,Sup)) =l= cap(Man);

SupBal(Sup)..  sum(Recip, Y(Sup,Recip)) =l= sum(Man, X(Man,Sup));

RecipDem(Recip)..  sum(Sup, Y(Sup,Recip)) =g= dem(Recip);

MODEL NetworkShipping /ALL/;

SOLVE NetworkShipping USING LP MINIMIZING Z;
