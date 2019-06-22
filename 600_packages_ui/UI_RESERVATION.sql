CREATE OR REPLACE PACKAGE UI_RESERVATION AS
    PROCEDURE ADDRESERVATION(vdatesel in varchar2 default to_date(sysdate,'YYYY-MM-DD'));
    PROCEDURE LISTERESERVATION;
    procedure updatereservation (id in number);

END UI_RESERVATION;
/