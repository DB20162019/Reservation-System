CREATE OR REPLACE PACKAGE BODY PA_PERSONNE AS

  --Procédure d'ajout d'une personne
PROCEDURE add_personne_req ( vnompersonne in varchar2, vprenompersonne in varchar2, vdatedenaissance in varchar2, vtelephone in VARCHAR2, vnumrue in number,vrue in varchar2, vcd in varchar2, vville in varchar2, vpays in varchar2 ) AS
     
    BEGIN
    insert into 
        PERSONNE (NUMERO_PERSONNE, NUMERO_NIVEAU,NOM_PERSONNE,PRENOM_PERSONNE, NAISSANCE_PERSONNE,TELEPHONE_PERSONNE,NUMERO_ADD_PERSONNE,RUE_PERSONNE,CP_PERSONNE,VILLE_PERSONNE,PAYS_PERSONNE, ROLE_PERSONNE, USER_PERSONNE,MDP_PERSONNE)
    values 
        (SEQNUMPERSONNE.NEXTVAL
        ,0
        ,vnompersonne
        ,vprenompersonne
        ,TO_DATE(to_char(to_date(vdatedenaissance,'YYYY-MM-DD')
        ,'DD/MM/YY'),'DD/MM/YY')
        ,vtelephone
        ,vnumrue
        ,vrue
        ,vcd
        ,vville
        ,vpays
        ,'Joueur'
        ,vnompersonne
        ,mp.encrypt('12456'));
    insert into 
        SOUSCRIRE (NUMERO_PERSONNE,NUMERO_FORFAIT) 
    values 
        (SEQNUMPERSONNE.CURRVAL
        ,0);
    commit;
    htp.br;
      --Confirmation de l'ajout
      htp.print('<h3 align=center">' ||vnompersonne || ' , vous êtes bien inscrit(e). Bienvenue! </h3>');
      htp.print('<meta http-equiv="refresh" content="2;URL=ui_html.html_home">');
    
  END add_personne_req;

   PROCEDURE UPDATEPERSONNE_REQ (vid in number, vnom in varchar2,vprenom in varchar2,vdatedenaissance in varchar2,vtelephone in varchar2,vnumrue in number,vnomrue in varchar2,vcp in varchar2,vville in varchar2,vpays in varchar2,vniveau in number default 0,vrole in varchar default 'Joueur', vsal in number default 0,vdateembauche in varchar2 default '') as
   BEGIN

        if (get_role_personne = 'Joueur') then
            if (vrole = 'Joueur') then
                update
                    personne 
                set 
                     NOM_PERSONNE = vnom
                    ,PRENOM_PERSONNE = vprenom
                    ,NAISSANCE_PERSONNE = TO_DATE(to_char(to_date(vdatedenaissance,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY')
                    ,TELEPHONE_PERSONNE = vtelephone
                    ,NUMERO_ADD_PERSONNE = vnumrue
                    ,RUE_PERSONNE = vnomrue
                    ,CP_PERSONNE = vcp
                    ,VILLE_PERSONNE = vville
                    ,PAYS_PERSONNE = vpays 
                where
                    NUMERO_PERSONNE=vid;
                commit;
                htp.br;
                --Confirmation de l'ajout
                htp.print('<h3 align=center"> Modification prise en compte </h3>');
                htp.print('<meta http-equiv="refresh" content="2;URL=ui_html.html_home">');
                return;
            end if;
        else 
            if (vrole = 'Joueur') then
                update 
                    personne 
                set 
                     NOM_PERSONNE = vnom
                    ,PRENOM_PERSONNE = vprenom
                    ,NAISSANCE_PERSONNE = TO_DATE(to_char(to_date(vdatedenaissance,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY')
                    ,TELEPHONE_PERSONNE = vtelephone
                    ,NUMERO_ADD_PERSONNE = vnumrue
                    ,RUE_PERSONNE = vnomrue
                    ,CP_PERSONNE = vcp
                    ,VILLE_PERSONNE = vville
                    ,PAYS_PERSONNE = vpays
                    ,NUMERO_NIVEAU = vniveau
                    ,ROLE_PERSONNE = vrole
                where 
                    NUMERO_PERSONNE=vid;
                commit;
                htp.br;
                --Confirmation de l'ajout
                htp.print('<h3 align=center"> Modification prise en compte </h3>');
                htp.print('<meta http-equiv="refresh" content="2;URL=ui_personne.listpersonne_form">');
                return;
            else 
                update 
                     personne 
                set 
                     NUMERO_NIVEAU = vniveau
                    ,NOM_PERSONNE = vnom
                    ,PRENOM_PERSONNE = vprenom
                    ,NAISSANCE_PERSONNE = TO_DATE(to_char(to_date(vdatedenaissance,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY')
                    ,TELEPHONE_PERSONNE = vtelephone
                    ,NUMERO_ADD_PERSONNE = vnumrue
                    ,RUE_PERSONNE = vnomrue
                    ,CP_PERSONNE = vcp
                    ,VILLE_PERSONNE = vville
                    ,PAYS_PERSONNE = vpays
                    ,ROLE_PERSONNE = vrole
                    ,SALAIRE_ENTRAINEUR = vsal
                    ,DATE_EMBAUCHE_ENTRAINEUR =  TO_DATE(to_char(to_date(vdateembauche,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY')
                where
                     NUMERO_PERSONNE=vid;
                commit;
                htp.br;
                --Confirmation de l'ajout
                htp.print('<h3 align=center"> Modification prise en compte </h3>');
                htp.print('<meta http-equiv="refresh" content="2;URL=ui_personne.listentraineur">');
                return;
            end if;
        end if;
      htp.br;
   END UPDATEPERSONNE_REQ;
   
PROCEDURE add_personne_reqadmin ( vnompersonne in varchar2, vprenompersonne in varchar2, vdatedenaissance in varchar2, vtelephone in VARCHAR2, vnumrue in number,vrue in varchar2, vcd in varchar2, vville in varchar2, vpays in varchar2, vniveau in number, vrole in varchar2) AS
     
    BEGIN
    insert into 
        PERSONNE (NUMERO_PERSONNE, NUMERO_NIVEAU,NOM_PERSONNE,PRENOM_PERSONNE, NAISSANCE_PERSONNE,TELEPHONE_PERSONNE,NUMERO_ADD_PERSONNE,RUE_PERSONNE,CP_PERSONNE,VILLE_PERSONNE,PAYS_PERSONNE, ROLE_PERSONNE, USER_PERSONNE,MDP_PERSONNE)
    values 
        (SEQNUMPERSONNE.NEXTVAL
        ,vniveau
        ,vnompersonne
        ,vprenompersonne
        ,TO_DATE(to_char(to_date(vdatedenaissance,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY')
        ,vtelephone
        ,vnumrue
        ,vrue
        ,vcd
        ,vville
        ,vpays
        ,vrole
        ,vnompersonne
        ,mp.encrypt('123456'));
    insert into 
        souscrire (NUMERO_PERSONNE,NUMERO_FORFAIT) 
    values 
    (SEQNUMPERSONNE.CURRVAL
    ,0);
    commit;
    htp.br;
      --Confirmation de l'ajout
      htp.print('<h3 align=center">' ||vnompersonne || ' , vous êtes bien inscrit(e). Bienvenue! </h3>');
      htp.print('<meta http-equiv="refresh" content="2;URL=ui_personne.add_personne_formadmin">');
  END add_personne_reqadmin;
  
Procedure delpersonne(id in number)as

    BEGIN

        delete from 
                    ASSISTER ASSI
                WHERE
                    ASSI.NUMERO_PERSONNE = id ;
        delete from
                    FACTURE fact
                where
                    fact.NUMERO_PERSONNE = id ;
        delete from 
                    SOUSCRIRE SOUS
                where 
                    SOUS.NUMERO_PERSONNE = id  ;
             delete from
                    FACTURE fact
                where
                    fact.NUMERO_PERSONNE = id ;
        delete from
                    Reservation res
                where
                    res.NUMERO_FACTURE in (select 
                                                fact.NUMERO_FACTURE
                                            FROM 
                                                 FACTURE fact
                                            where
                                                fact.NUMERO_PERSONNE = id  
                                                ) ;
         delete from 
                personne pers 
            
               where 
                pers.NUMERO_PERSONNE = id ;
                
        commit;

        htp.print('<h3 align=center>Suppression effectuée</h3>');
        htp.print('<meta http-equiv="refresh" content="2;URL=ui_personne.listpersonne_form">');

        EXCEPTION
        when others then
        htp.print('Problème lors de la suppression :');
        htp.print('No erreur Oracle : ' || SQLERRM);


end delpersonne ;

Procedure delentraineur_req(id in number)as

    BEGIN
       
        delete from 
                    ASSISTER ASSI
                WHERE
                    ASSI.NUMERO_PERSONNE = id ;
        delete from 
                    ENTRAINEMENT ENTR
                where 
                    ENTR.NUMERO_PERSONNE = id  ;
        delete from 
                    SOUSCRIRE SOUS
                where 
                    SOUS.NUMERO_PERSONNE = id  ;
        delete from
                    FACTURE fact
                where
                    fact.NUMERO_PERSONNE = id ;
        delete from
                    Reservation res
                where
                    res.NUMERO_FACTURE in (select 
                                                fact.NUMERO_FACTURE
                                            FROM 
                                                 FACTURE fact
                                            where
                                                fact.NUMERO_PERSONNE = id  
                                                ) ;
         delete from 
                personne pers 
            
               where 
                pers.NUMERO_PERSONNE = id ;
                
        commit;

        htp.print('<h3 align=center>Suppression effectuée</h3>');
        htp.print('<meta http-equiv="refresh" content="2;URL=ui_personne.listentraineur">');

        EXCEPTION
        when others then
        htp.print('Problème lors de la suppression :');
        htp.print('No erreur Oracle : ' || SQLERRM);


end delentraineur_req ;


end PA_PERSONNE;
/