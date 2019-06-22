CREATE OR REPLACE PACKAGE PA_PERSONNE AS
    procedure add_personne_req 
        (vnompersonne in varchar2
        ,vprenompersonne in varchar2
        ,vdatedenaissance in varchar2
        ,vtelephone in VARCHAR2
        ,vnumrue in number
        ,vrue in varchar2
        ,vcd in varchar2
        ,vville in varchar2
        ,vpays in varchar2 );
    PROCEDURE UPDATEPERSONNE_REQ 
        (vid in number
        ,vnom in varchar2
        ,vprenom in varchar2
        ,vdatedenaissance in varchar2
        ,vtelephone in varchar2
        ,vnumrue in number
        ,vnomrue in varchar2
        ,vcp in varchar2
        ,vville in varchar2
        ,vpays in varchar2
        ,vniveau in number default 0
        ,vrole in varchar default 'Joueur'
        ,vsal in number default 0
        ,vdateembauche in varchar2 default '');
    procedure add_personne_reqadmin 
        (vnompersonne in varchar2
        ,vprenompersonne in varchar2
        , vdatedenaissance in varchar2
        , vtelephone in VARCHAR2
        , vnumrue in number
        ,vrue in varchar2
        ,vcd in varchar2
        ,vville in varchar2
        ,vpays in varchar2
        ,vniveau in number
        ,vrole in varchar2);
    Procedure delentraineur_req
        (id in number);
    Procedure delpersonne(id in number);
    
END PA_PERSONNE;
/