--------------------------------------------------------
--  DDL for Function TEST_COOKIE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "G02_TENNIS"."TEST_COOKIE" RETURN VARCHAR2 AS
BEGIN
  if(OWA_COOKIE.get('user_tennis').num_vals != 0) then
    return (1);
  else
    return (0);
  end if;
END TEST_COOKIE;

/
