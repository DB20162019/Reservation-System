CREATE OR REPLACE PACKAGE BODY PA_TERRAIN AS

  --Procédure d'ajout de terrain
  PROCEDURE ADDTERRAIN_REQ (vnom in varchar2, vtype in number, vdes in varchar2) AS
    
    BEGIN
		insert into terrain values (vnom,vtype,vdes);
        commit;
      htp.br;
      --Confirmation de l'ajout
      htp.print('<h3 align=center">' ||vnom || ' ajouté</h3>');
      htp.print('<meta http-equiv="refresh" content="2;URL=ui_terrain.addterrain_form">');


      EXCEPTION
      when others then
        htp.br;
        htp.print('Erreur lors de l''ajout');
        htp.print('No erreur Oracle : ' || SQLCODE);
  END ADDTERRAIN_REQ;

  --Procédure de mise à jour du terrain
  PROCEDURE UPDATETERRAIN_REQ (vnom in varchar2, vtype in number, vdes in varchar2) AS
	
    BEGIN
		update 
            terrain ter 
        set 
            ter.DESCRIPTION_TERRAIN=vdes, ter.NUM_TYPE_TERRAIN=vtype where ter.nom_terrain=vnom;
        commit;
      htp.br;

    htp.print('<meta http-equiv="refresh" content="2;URL=ui_terrain.listterrain">');

      EXCEPTION
      when others then
        htp.br;
        htp.print('Erreur lors de l''ajout');
        htp.print('No erreur Oracle : ' || SQLCODE);
  END UPDATETERRAIN_REQ;

END PA_TERRAIN;
/