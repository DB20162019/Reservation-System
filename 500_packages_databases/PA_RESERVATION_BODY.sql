CREATE OR REPLACE PACKAGE BODY PA_RESERVATION AS
  
    --Procédure d'ajout d'une réservation'

  PROCEDURE ADDRESERVATION_REQ (vdate in VARCHAR2, vheured in number, vduree in Number, vtype in VARCHAR2) AS
    valide integer;
    id_adh integer;
    numfac integer;
    forfait integer;
    nom_adh varchar2(128);
    prenom_adh varchar2(128);
    prixtarif integer;

    cursor infos_user is 
                        select 
                                 prs.nom_personne
                                ,prs.prenom_personne
                        from 
                            personne prs
                        where 
                            prs.NUMERO_PERSONNE = id_adh;
    cursor forfait_resa is 
                        select 
                                src.numero_forfait 
                        from 
                            souscrire src
                        where 
                            src.numero_personne = id_adh;
    cursor reservationcre is 
                            select 
                                crn.* 
                            from 
                                creneau crn 
                            where 
                                crn.horaire_creneau >= TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| (vheured-3) ||':00:00','DD/MM/YY HH24:MI:SS') 
                            and 
                                crn.horaire_creneau <= TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| (vheured+3) ||':00:00','DD/MM/YY HH24:MI:SS') 
                            and 
                                crn.date_creneau = TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY') 
                            and 
                                crn.nom_terrain=vtype;
    
    BEGIN

    if(test_cookie = 1) then
      -- Adhérent : récupération des infos :
      id_adh := get_id_personne;
      --numfac := SEQNUMFACTURE.nextval;
      for curs_per in infos_user loop
          nom_adh := curs_per.nom_personne;
          prenom_adh := curs_per.prenom_personne;
      end loop;
    end if;
    
    for i in forfait_resa loop
        forfait := i.numero_forfait;
        if(forfait = 0) then
            prixtarif := 5;
        else
            prixtarif := 1;
        end if;
    end loop;
    

    valide := 0;
    for j in reservationcre loop
        for m in 0..(j.duree_creneau-1) loop
            for n in 0..(vduree-1) loop
                if (j.horaire_creneau + (m*60)/1440 = TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| vheured ||':00:00','DD/MM/YY HH24:MI:SS')+ (n*60)/1440) then
                    valide:=1;
                end if;
            end loop;
        end loop;
    end loop;         

    if (valide = 0) then
        insert into 
                CRENEAU 
                    (NOM_TERRAIN
                    ,DATE_CRENEAU
                    ,HORAIRE_CRENEAU
                    ,DUREE_CRENEAU) 
        values 
            (vtype
             ,TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY')
             ,TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| vheured ||':00:00','DD/MM/YY HH24:MI:SS')
             ,vduree);
        insert into 
                FACTURE 
                    (NUMERO_FACTURE
                    ,NUMERO_FORFAIT
                    ,NUMERO_PERSONNE
                    ,DATE_FACTURE
                    ,MONTANT_FACTURE) 
        values 
                (SEQNUMFACTURE.nextval
                 ,forfait
                 ,id_adh
                 ,TO_DATE(sysdate,'DD-MM-YYYY')
                 ,prixtarif);
        insert into 
                RESERVATION
                    (NUMERO_RESERVATION
                    ,NUMERO_FACTURE
                    ,DATE_CRENEAU
                    ,HORAIRE_CRENEAU
                    ,NUMERO_PERSONNE
                    ,NOM_TERRAIN
                    ,DATE_RESERVATION
                    ,PRIX_RESERVATION
                    ,NOM_PERSONNE
                    ,PRENOM_PERSONNE) 
        values 
                    (SEQNUMRESERVATION.nextval
                    ,SEQNUMFACTURE.currval
                    ,TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY')
                    ,TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| vheured ||':00:00','DD/MM/YY HH24:MI:SS')
                    ,id_adh,vtype
                    ,TO_DATE(sysdate,'DD-MM-YY')
                    ,prixtarif
                    ,nom_adh
                    ,prenom_adh );
        insert into 
                PARTICIPER 
        values 
                    (get_id_personne
                    ,SEQNUMRESERVATION.currval);
        commit;
        htp.print('<h3 align=center"> Terrain réservé</h3>');
        htp.br;
        htp.print('<meta http-equiv="refresh" content="2;URL=UI_RESERVATION.LISTERESERVATION">');


    else
        htp.script('alert(" Terrain non disponible à cette horaire, veuillez réessayer sur un autre terrain ou un autre horaire");','Javascript');
        htp.print('<meta http-equiv="refresh" content="2;URL=UI_RESERVATION.ADDRESERVATION">');
    end if;
    
END ADDRESERVATION_REQ;

PROCEDURE DELRESERVATION_REQ (res in integer) AS
        cursor reservations is 
                            select 
                                 rsv.nom_terrain
                                ,rsv.date_creneau
                                ,rsv.horaire_creneau 
                            from 
                                RESERVATION rsv
                            where 
                                rsv.NUMERO_RESERVATION = res;
        num_creneau integer;
        id_adh integer;
        nom_adh varchar2(128);
        prenom_adh varchar2(128);
        cursor infos_user is 
                        select 
                                 prs.nom_personne
                                ,prs.prenom_personne
                        from 
                            personne prs
                        where 
                            prs.NUMERO_PERSONNE = id_adh;        datecre varchar(128);
        horaire varchar(128);
        nomterr varchar(128);
        BEGIN
        htp.htmlOpen;
        htp.headOpen;

        if(test_cookie = 1) then
          -- Adhérent : récupération des infos :
          id_adh := get_id_personne;
          for curs_per in infos_user loop
              nom_adh := curs_per.nom_personne;
              prenom_adh := curs_per.prenom_personne;
          end loop;
        end if;
       


        --On efface les valeurs dans les tables
        delete from 
                    PARTICIPER 
                where 
                    NUMERO_RESERVATION = res;

        for i in reservations loop
            delete from 
                        CRENEAU 
                    where 
                        nom_terrain=i.nom_terrain 
                    and 
                        TO_CHAR(HORAIRE_CRENEAU,'DD/MM/YY HH:MI:SS') = TO_CHAR(i.HORAIRE_CRENEAU,'DD/MM/YY HH:MI:SS') 
                    and 
                        TO_CHAR(DATE_CRENEAU,'DD/MM/YY') = TO_CHAR(i.DATE_CRENEAU,'DD/MM/YY');
        end loop;
        delete from 
                    RESERVATION 
                where 
                    NUMERO_RESERVATION=res;
        commit;

        htp.print('<h3 align=center>Réservation supprimée</h3>');
        htp.print('<meta http-equiv="refresh" content="2;URL=ui_reservation.listereservation">');
END DELRESERVATION_REQ;

  --Procédure de modification de réservation
  PROCEDURE UPDATERESERVATION_REQ (vnumresa in number, vnumfact in Number, vdate in VARCHAR2, vheured in number, vduree in Number, vtype in VARCHAR2) AS
  valide integer;
    id_adh integer;
    numfac integer;
    nom_adh varchar2(128);
    prenom_adh varchar2(128);
    prixtarif integer;
    forfait integer;
    cursor infos_user is 
                select 
                         prs.nom_personne
                        ,prs.prenom_personne
                from 
                    personne prs
                where 
                    prs.NUMERO_PERSONNE = id_adh;
    cursor reservations is 
                        select 
                                 rsv.* 
                        from 
                                RESERVATION rsv 
                        where 
                            rsv.NUMERO_RESERVATION = vnumresa;
    cursor forfait_resa is 
                        select 
                            src.* 
                        from 
                            souscrire src 
                        where 
                            src.numero_personne = get_id_personne;
    cursor reservationcre is 
                        select 
                                crn.* 
                        from 
                                creneau crn
                        where 
                                crn.horaire_creneau >= TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| (vheured-3) ||':00:00','DD/MM/YY HH24:MI:SS') 
                        and 
                                crn.horaire_creneau <= TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| (vheured+3) ||':00:00','DD/MM/YY HH24:MI:SS') 
                        and 
                                crn.date_creneau = TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY') 
                        and 
                                crn.nom_terrain=vtype;


    BEGIN

        if(test_cookie = 1) then
      -- Adhérent : récupération des infos :
      id_adh := get_id_personne;
      for curs_per in infos_user loop
          nom_adh := curs_per.nom_personne;
          prenom_adh := curs_per.prenom_personne;
      end loop;
    end if;
    for i in forfait_resa loop
        forfait := i.numero_forfait;
        if(forfait = 0) then
            prixtarif := 7;
        else
            prixtarif := 2;
        end if;
    end loop;

    valide := 0;
    for j in reservationcre loop
        for m in 0..(j.duree_creneau-1) loop
            for n in 0..(vduree-1) loop
                if (j.horaire_creneau + (m*60)/1440 = TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| vheured ||':00:00','DD/MM/YY HH24:MI:SS')+ (n*60)/1440) then
                    --RAISE_APPLICATION_ERROR(-20999,null);
                    valide:=1;
                end if;
            end loop;
        end loop;
    end loop;         

    if (valide = 0) then
        update 
            facture 
        set 
             date_facture = sysdate
            ,montant_facture = prixtarif 
        where 
            numero_facture=vnumfact;
        for i in reservations loop
            update 
                creneau 
            set 
                 duree_creneau = vduree
                ,DATE_CRENEAU = TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY')
                ,HORAIRE_CRENEAU = TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| vheured ||':00:00','DD/MM/YY HH24:MI:SS') 
            where 
                TO_CHAR(DATE_CRENEAU,'DD/MM/YY') = TO_CHAR(i.DATE_CRENEAU,'DD/MM/YY') 
            and 
                TO_CHAR(HORAIRE_CRENEAU,'DD/MM/YY HH:MI:SS') = TO_CHAR(i.HORAIRE_CRENEAU,'DD/MM/YY HH:MI:SS') 
            and nom_terrain = i.nom_terrain;
        end loop;
        update 
            reservation 
        set 
             DATE_CRENEAU = TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY')
            ,HORAIRE_CRENEAU = TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| vheured ||':00:00','DD/MM/YY HH24:MI:SS')
            ,nom_terrain = vtype
            ,date_reservation = sysdate
            ,prix_reservation= prixtarif 
        where 
            numero_reservation = vnumresa;
        commit;
        htp.print('<h3 align=center"> Réservation modifié </h3>');
        htp.br;
        htp.print('<meta http-equiv="refresh" content="2;URL=UI_RESERVATION.LISTERESERVATION"/>');
    
    else
        htp.print('<h3 align=center"> Terrain non disponible ce jour et à cette horaire, veuillez réessayer </h3>');
    end if;
    


  END UPDATERESERVATION_REQ;

END PA_RESERVATION;
/