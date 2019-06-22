CREATE OR REPLACE PACKAGE BODY PA_REGLEMENT AS

  --Procédure d'ajout de terrain
  PROCEDURE addforfait_req (vnom in varchar2, vprix in number, vnbh in number,vval in number) AS
    BEGIN

		insert into 
                    FORFAIT 
        values 
            (seqnumforfait.nextval,vnom,vprix,vnbh,vval);
        commit;
      htp.br;
      --Confirmation de l'ajout
      htp.print('<h3 align=center">' ||vnom || ' ajouté</h3>');
      htp.print('<meta http-equiv="refresh" content="2;URL=ui_reglement.listforfait">');

      EXCEPTION
      when others then
        htp.br;
        htp.print('Erreur lors de l''ajout');
        htp.print('No erreur Oracle : ' || SQLCODE);
  END addforfait_req;

  --Procédure de mise à jour du terrain
  PROCEDURE updateforfait_req (vid in number, vnom in varchar2, vprix in number, vnbh in number,vval in number) AS
	BEGIN

		update 
            forfait forf 
        set forf.DESIGNATION_FORFAIT=vnom
        ,forf.PRIX_FORFAIT=vprix
        ,forf.NOMBRE_HEURE_FORFAIT=vnbh
        ,forf.DUREE_VAL_FORFAIT=vval 
        where 
            forf.NUMERO_FORFAIT=vid;
        commit;
      htp.br;
      --Confirmation de l'ajout
    htp.print('<meta http-equiv="refresh" content="2;URL=ui_reglement.listforfait">');

      EXCEPTION
      when others then
        htp.br;
        htp.print('Erreur lors de la modification');
        htp.print('No erreur Oracle : ' || SQLCODE);
  END updateforfait_req;

  PROCEDURE delforfait_req(id in number) AS
	BEGIN
        delete from
                FACTURE fac
                
        where 
               fac.NUMERO_FORFAIT = id;
        delete from
                SOUSCRIRE SOUS
        where
                SOUS.NUMERO_FORFAIT = id;
		DELETE FROM 
                FORFAIT forf 
        where 
            forf.NUMERO_FORFAIT = id;
        commit;
      htp.br;
      --Confirmation de l'ajout
    htp.print('<meta http-equiv="refresh" content="2;URL=ui_reglement.listforfait">');

      EXCEPTION
      when others then
        htp.br;
        htp.print('Erreur lors de l''ajout');
        htp.print('No erreur Oracle : ' || SQLCODE);
  END delforfait_req;
  
  PROCEDURE souscription_req(vpersonne in number,vforfait in number) AS
    prix number;
    cursor souscrit is select count(*) as nb from souscrire where numero_personne=vpersonne;
	BEGIN

		prix := get_prix_forfait(vforfait);
        for cursor_sousc in souscrit loop
            if (cursor_sousc.nb=1) then
                update 
                    SOUSCRIRE SOUSC
                set 
                    SOUSC.NUMERO_FORFAIT = vforfait 
                where 
                    SOUSC.NUMERO_PERSONNE=vpersonne;
            else
                insert into 
                    SOUSCRIRE 
                values (vpersonne,vforfait);
            end if; 
         end loop;   
        insert into 
            FACTURE   
        values 
            (SEQNUMFACTURE.NEXTVAL,vpersonne,vforfait,TO_Date(sysdate,'DD/MM/YY'),prix,TO_Date(sysdate,'DD/MM/YY'));
        commit;
      htp.br;
      --Confirmation de l'ajout
    htp.print('<h3 align=center">' ||vpersonne || ' ajouté au forfait '||vforfait||'</h3>');
    htp.print('<meta http-equiv="refresh" content="2;URL=ui_reglement.souscription">');

      EXCEPTION
      when others then
        htp.br;
        htp.print('Erreur lors de l''ajout');
        htp.print('No erreur Oracle : ' || SQLCODE);
  END souscription_req;

END PA_REGLEMENT;
/