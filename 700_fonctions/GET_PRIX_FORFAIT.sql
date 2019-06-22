--------------------------------------------------------
--  DDL for Function GET_PRIX_FORFAIT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "G02_TENNIS"."GET_PRIX_FORFAIT" (id in number) RETURN number AS
prix number;

cursor forfaits is select * from forfait where NUMERO_FORFAIT = id;
BEGIN

for i in forfaits loop
  prix:=i.PRIX_FORFAIT;
end loop;

return(prix);

END get_prix_forfait;

/
