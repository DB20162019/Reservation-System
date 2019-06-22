CREATE OR REPLACE PACKAGE PA_TERRAIN AS

  PROCEDURE ADDTERRAIN_REQ (vnom in varchar2, vtype in number, vdes in varchar2);
  PROCEDURE UPDATETERRAIN_REQ (vnom in varchar2, vtype in number, vdes in varchar2);

END PA_TERRAIN;
/