CREATE OR REPLACE PACKAGE UI_HTML AS
  PROCEDURE CONNECTION_FORM (err integer default 0);
  PROCEDURE COOKIE_CREATE (vlogin IN VARCHAR2, vpass IN VARCHAR2);
  PROCEDURE COOKIE_DELETE;
  PROCEDURE ERR_403;
  PROCEDURE HTML_FOOTER;
  PROCEDURE HTML_HEADER;
  PROCEDURE HTML_HOME (err integer default 0);
  PROCEDURE HTML_MENUGAUCHE;
  PROCEDURE HTML_MENUHAUT(err integer default 0);

END UI_HTML;
/