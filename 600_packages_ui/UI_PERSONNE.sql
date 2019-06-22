CREATE OR REPLACE PACKAGE UI_PERSONNE AS
    procedure updatepersonne_form (id in number ,r in varchar2 default 'j');
    PROCEDURE add_personne_form ;
    procedure add_personne_formadmin;
    PROCEDURE listentraineur;
    procedure listpersonne_form ;
END UI_PERSONNE;
/