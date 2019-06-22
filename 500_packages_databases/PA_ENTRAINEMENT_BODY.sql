CREATE OR REPLACE PACKAGE BODY PA_ENTRAINEMENT AS


-- Procédue d'ajout d'un entrainement 

  PROCEDURE ADDENTRAINEMENT ( vnomterrain in VARCHAR2, vnumpersonne in NUMBER , vtypeentr in VARCHAR2 , vnbrmax in NUMBER ,vdate in VARCHAR2 default '', vdebutentr in VARCHAR2 , vfinentr in VARCHAR2 , vlundi in VARCHAR2 default '' , vmardi in VARCHAR2 default '' , vmercredi in VARCHAR2 default '' , vjeudi in VARCHAR2 default '',vvendredi in VARCHAR2 default '', vsamedi in VARCHAR2 default '' ,vheured in number default 17 , vduree in number default 0 ) AS
    numberdiff integer;
    valide integer;
    cursor reservationcre is select * from creneau where horaire_creneau >= TO_DATE(to_char(to_date(vdebutentr,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| (vheured-3) ||':00:00','DD/MM/YY HH24:MI:SS') and horaire_creneau <= TO_DATE(to_char(to_date(vdebutentr,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| (vheured+3) ||':00:00','DD/MM/YY HH24:MI:SS') and date_creneau = TO_DATE(to_char(to_date(vdate,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY') and nom_terrain=vnomterrain;

    BEGIN
    valide := 0;
    for j in reservationcre loop
        for m in 0..(j.duree_creneau-1) loop
            for n in 0..(vduree-1) loop
                if (j.horaire_creneau + (m*60)/1440 = TO_DATE(to_char(to_date(vdebutentr,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| vheured ||':00:00','DD/MM/YY HH24:MI:SS')+ (n*60)/1440) then
                    valide:=1;
                end if;
            end loop;
        end loop;
    end loop;         

    if (valide = 0) then
       
        insert into 
            entrainement (NUM_ENTRAINEMENT, NOM_TERRAIN , NUMERO_PERSONNE, TYPE_ENTRAINEMENT , NBR_MAX_PARTICIPANTS , DEBUT_ENTRAINEMENT , FIN_ENTRAINEMENT) 
        values 
            (SEQNUMENTRAINEMENT.NEXTVAL,vnomterrain,vnumpersonne ,vtypeentr,vnbrmax ,TO_DATE(to_char(to_date(vdebutentr,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY'),TO_DATE(to_char(to_date(vfinentr,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY'));
        insert into 
            CRENEAU (NOM_TERRAIN, DATE_CRENEAU, HORAIRE_CRENEAU, DUREE_CRENEAU , NUM_ENTRAINEMENT ) 
        values 
            (vnomterrain, TO_DATE(to_char(to_date(vdebutentr,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY'), TO_DATE(to_char(to_date(vdebutentr,'YYYY-MM-DD'),'DD/MM/YY') || ' '|| vheured ||':00:00','DD/MM/YY HH24:MI:SS'), 2, SEQNUMENTRAINEMENT.CURRVAL );
        
       insert into
            assister (NUMERO_PERSONNE ,NUM_ENTRAINEMENT)
        values 
            (vnumpersonne , SEQNUMENTRAINEMENT.CURRVAL);
        commit;
        htp.print('<h3> Terrain réservé</h3>');

    else
        htp.script('alert(" Terrain non disponible à cette horaire, veuillez réessayer sur un autre terrain ou un autre horaire");','Javascript');
        htp.print('<meta http-equiv="refresh" content="2;URL=UI_ENTRAINEMENT.LISTEMESENTRAINEMENT">');
        --htp.print('<h3 align=center"> Terrain non disponible à cette horaire, veuillez réessayer sur un autre terrain ou un autre horaire</h3>');
    end if;

               
        htp.br;
      --Confirmation de l'ajout
      htp.print('<h3> entrainement ajouté</h3>');
      htp.print('<meta http-equiv="refresh" content="2;URL=UI_ENTRAINEMENT.LISTEMESENTRAINEMENT">');

      EXCEPTION
      when others then
        htp.br;
         if (SQLCODE = -1) then
                htp.print('Erreur lors de l''ajout , ce terrain est déjà réservé ');
        htp.print('<meta http-equiv="refresh" content="2;URL=UI_ENTRAINEMENT.ADDENTRAINEMENT">');
        else      
            htp.print('Erreur lors de l''ajout : ');
            htp.print('No erreur Oracle : ' || SQLCODE);
        end if ;

  END ADDENTRAINEMENT;

--- Ajouter des participants

 procedure addparticipant (vnument in number , vnumpersonne in number) as

  BEGIN
            insert into 
                    assister (NUMERO_PERSONNE ,NUM_ENTRAINEMENT)
            values 
                    ( vnumpersonne,vnument );
      --Confirmation de l'ajout
      htp.print('<h3> participant ajouté</h3>');
      htp.print('<meta http-equiv="refresh" content="2;URL=UI_ENTRAINEMENT.LISTEMESENTRAINEMENT">');


      EXCEPTION
      when others then
        htp.br;
        if (SQLCODE = -1) then
         htp.print('le participant selectionné est déjà inscrit à cet entrainement');
        else      
            htp.print('Erreur lors de l''ajout : ');
            htp.print('No erreur Oracle : ' || SQLCODE);
        end if ;
 end addparticipant ;


-- Procédure edititon d'un entrainement
 procedure UPDATEENTRAINEMENT(vnument in NUMBER , vnomterrain in VARCHAR2 default '', vnumpersonne in NUMBER , vtypeentr in VARCHAR2 default '' , vnbrmax in NUMBER , vdebutentr in VARCHAR2 default '', vfinentr in VARCHAR2 default '')as
 BEGIN

		update entrainement ent
        set 
            ent.NOM_TERRAIN = vnomterrain,
            ent.NUMERO_PERSONNE = vnumpersonne,
            ent.TYPE_ENTRAINEMENT = vtypeentr,
            ent.NBR_MAX_PARTICIPANTS = vnbrmax,
            ent.DEBUT_ENTRAINEMENT = TO_DATE(to_char(to_date(vdebutentr,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY'),
            ent.FIN_ENTRAINEMENT = TO_DATE(to_char(to_date(vfinentr,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY')
        where 
            ent.NUM_ENTRAINEMENT = vnument;
        commit;
      htp.br;
      --Confirmation de l'ajout
    htp.print('<h3"> Modification prise en compte </h3>');
        htp.print('<meta http-equiv="refresh" content="2;URL=UI_ENTRAINEMENT.LISTEENTRAINEMENT">');

      EXCEPTION
      when others then
        htp.br;
        htp.print('Erreur lors de la modification ');
        htp.print('No erreur Oracle : ' || SQLCODE);

   END UPDATEENTRAINEMENT;


  --Procédure de suppression d entrainement
  PROCEDURE DELENTRAINEMENT (id in integer) AS
        BEGIN
        delete
            from 
                CRENEAU CRE
            where
                CRE.NUM_ENTRAINEMENT = id ;
        
       
        delete 
            from 
                ASSISTER ASSI
            where 
                ASSI.NUM_ENTRAINEMENT = id; 
        delete 
            from 
                ENTRAINEMENT ENT     
            where 
                ENT.NUM_ENTRAINEMENT = id; 
        
         
        commit;

        htp.print('<h3>Suppression effectuée</h3>');
        htp.print('<meta http-equiv="refresh" content="2;URL=UI_ENTRAINEMENT.LISTEENTRAINEMENT">');

        EXCEPTION
        when others then
        htp.print('Problème lors de la suppression :');
        htp.print('No erreur Oracle : ' || SQLERRM);
END DELENTRAINEMENT;


END PA_ENTRAINEMENT;
/