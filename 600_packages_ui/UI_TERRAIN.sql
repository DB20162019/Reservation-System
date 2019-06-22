CREATE OR REPLACE PACKAGE UI_TERRAIN AS
    procedure listterrain;
    procedure addterrain_form;
    procedure updateterrain_form (nom in varchar2);
END UI_TERRAIN;
/