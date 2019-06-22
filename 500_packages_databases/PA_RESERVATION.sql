CREATE OR REPLACE PACKAGE PA_RESERVATION AS 
    PROCEDURE ADDRESERVATION_REQ (vdate in VARCHAR2,vheured in number,vduree in Number,vtype in VARCHAR2);

    PROCEDURE DELRESERVATION_REQ (res in integer);
    PROCEDURE UPDATERESERVATION_REQ (vnumresa in NUMBER,vnumfact in Number,vdate in VARCHAR2,vheured in number,vduree in Number,vtype in VARCHAR2);
    --PROCEDURE ADDRESERVATION_REQ ( DATE_CRENEAU in DATE,HORAIRE_CRENEAU in DATE, NOM_TERRAIN in VARCHAR2,  DATE_RESERVATION in DATE);

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 

END PA_RESERVATION;
/