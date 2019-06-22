--------------------------------------------------------
--  DDL for Function GET_ROLE_PERSONNE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "G02_TENNIS"."GET_ROLE_PERSONNE" RETURN varchar2 AS
role_personne varchar2(20);
cursor curs_role_pers is select role_personne
                        from personne
                        where numero_personne=get_id_personne;
BEGIN

for i in curs_role_pers loop
  role_personne:=i.role_personne;
end loop;

return(role_personne);

END GET_ROLE_PERSONNE;

/
