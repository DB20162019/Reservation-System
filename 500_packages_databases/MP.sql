CREATE OR REPLACE PACKAGE MP AS
   function encrypt(i_password varchar2) return varchar2;
   function decrypt(i_password varchar2) return varchar2;
END mp;
/