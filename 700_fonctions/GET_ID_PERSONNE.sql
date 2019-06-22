--------------------------------------------------------
--  DDL for Function GET_ID_PERSONNE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "G02_TENNIS"."GET_ID_PERSONNE" RETURN number AS
info OWA_COOKIE.cookie;
BEGIN

  info := OWA_COOKIE.get('user_tennis');

  return(info.vals(1));

END GET_ID_PERSONNE;

/
