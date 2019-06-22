CREATE OR REPLACE PACKAGE UI_REGLEMENT AS
    procedure listforfait;
    procedure addforfait_form;
    procedure updateforfait_form (id in number);
    procedure souscription;
END UI_REGLEMENT;
/