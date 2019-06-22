CREATE OR REPLACE PACKAGE BODY UI_TERRAIN AS

    procedure listterrain as
    id_adh integer;
    nom_adh varchar2(128);
    prenom_adh varchar2(128);
    cursor infos_user is 
    select 
        PERS.* 
    from
        personne PERS
    where 
        PERS.NUMERO_PERSONNE = id_adh;
    cursor terrains is 
    select 
        * 
    from 
        terrain join TYPE_TERRAIN using(NUM_TYPE_TERRAIN);
    begin
    htp.htmlOpen;
    htp.headOpen;

    if(test_cookie = 1) then
      -- Adhérent : récupération des infos :
      id_adh := get_id_personne;
      for curs_per in infos_user loop
          nom_adh := curs_per.nom_personne;
          prenom_adh := curs_per.prenom_personne;
      end loop;
      htp.title('Tennischool - ' || nom_adh || ' ' || prenom_adh);
    else
      htp.title( 'Tennischool');
    end if;

    htp.print( '<link href="/public/projets/G02_TENNIS/css/knacss.css"  rel="stylesheet" type="text/css" media="screen" />');
    htp.print( '<link href="/public/projets/G02_TENNIS/css/styles.css"  rel="stylesheet" type="text/css" media="screen" />');
    htp.headClose;
    htp.bodyOpen;
    ui_html.html_header;


    htp.print( '<div class="flex-container">' );
    htp.print( '<aside class="mod w20 pam aside">' );
    ui_html.html_menugauche;
    htp.print( '</aside>' );

    htp.print( '<main id="main" role="main" class="flex-item-fluid pam">' );
    htp.br(  cattributes => ' /');
    if(test_cookie = 1) then
        if(get_role_personne = 'Entraineur') then
            htp.print('<h3 align=center>Liste des terrains</h3>');
              htp.tableOpen(cattributes => 'style="text-align:center"; width=50%');
              htp.tablerowopen;
              htp.tableheader('Terrains');
              htp.tableheader('Types');
              htp.tableheader('Descriptions');
              htp.tableheader('Edit');

              htp.tablerowclose;

              for i in terrains loop
                htp.tablerowopen;
                htp.tabledata(i.NOM_TERRAIN);
                htp.tabledata(i.DESIGNATION_TYPE_TERRAIN);
                htp.tabledata(i.DESCRIPTION_TERRAIN);
                htp.tabledata(htf.anchor('ui_terrain.updateterrain_form?nom=' || i.NOM_TERRAIN, 'Edit'));
                htp.tablerowclose;
              end loop;

              htp.tableclose;

            htp.anchor('ui_terrain.addterrain_form',' Ajouter un terrain');
        end if;
    end if;

    htp.print( '</main>' );
    htp.print( '</div>' );

    ui_html.html_footer;
    htp.bodyClose;
    htp.htmlClose;
    end listterrain;

    procedure addterrain_form as
    id_adh integer;
    nom_adh varchar2(128);
    prenom_adh varchar2(128);
    cursor infos_user is 
    select 
        pers.* 
    from 
        personne pers
    where 
        pers.NUMERO_PERSONNE = id_adh;
    cursor terrains_types is
    select 
        TP.* 
    from 
        TYPE_TERRAIN TP;
    begin
    htp.htmlOpen;
    htp.headOpen;

    if(test_cookie = 1) then
      -- Adhérent : récupération des infos :
      id_adh := get_id_personne;
      for curs_per in infos_user loop
          nom_adh := curs_per.nom_personne;
          prenom_adh := curs_per.prenom_personne;
      end loop;
      htp.title('Tennischool - ' || nom_adh || ' ' || prenom_adh);
    else
      htp.title( 'Tennischool');
    end if;

    htp.print( '<link href="/public/projets/G02_TENNIS/css/knacss.css"  rel="stylesheet" type="text/css" media="screen" />');
    htp.print( '<link href="/public/projets/G02_TENNIS/css/styles.css"  rel="stylesheet" type="text/css" media="screen" />');
    htp.headClose;
    htp.bodyOpen;
    ui_html.html_header;


    htp.print( '<div class="flex-container">' );
    htp.print( '<aside class="mod w20 pam aside">' );
    ui_html.html_menugauche;
    htp.print( '</aside>' );

    htp.print( '<main id="main" role="main" class="flex-item-fluid pam">' );
    htp.br(  cattributes => ' /');
    if(test_cookie = 1) then
        htp.print('<h3 align=center>Ajouter un terrain</h3>');
          htp.formopen(owa_util.get_owa_service_path || 'pa_terrain.addterrain_req','POST');
          htp.tableopen;
          htp.tablerowopen;
          htp.tableData('Nom : ');
          htp.tableData(htf.formtext(cname => 'vnom'));
          htp.tablerowclose;


          htp.tableRowOpen;
          htp.tableData('Type :');
          htp.print('<td>');
          htp.formselectopen('vtype','');
          for curs_type in terrains_types loop
             htp.formselectoption(cvalue=>curs_type.DESIGNATION_TYPE_TERRAIN, cattributes=>'VALUE='||curs_type.NUM_TYPE_TERRAIN);
             htp.print('</option>');
          end loop;
          htp.print('</select></td>');
          htp.tableRowClose;

          htp.tablerowopen;
          htp.tableData('Description : ');
          htp.tableData(htf.formtext(cname => 'vdes'));
          htp.tablerowclose;

          htp.tablerowopen;
          htp.tabledata;
          htp.print('<td>');htp.formsubmit(cvalue => 'Ajouter');htp.print('</td>');
          htp.tablerowclose;
          htp.tableclose;
          htp.formclose;
    end if;

    htp.print( '</main>' );
    htp.print( '</div>' );

    ui_html.html_footer;
    htp.bodyClose;
    htp.htmlClose;
    end addterrain_form;

	--Update d'un terrain de tennis
	procedure updateterrain_form (nom in varchar2) as
	    id_adh integer;
    nom_adh varchar2(128);
    prenom_adh varchar2(128);
    cursor infos_user is select 
        PERS.* 
    from 
        personne PERS
    where 
        PERS.NUMERO_PERSONNE = id_adh;
    cursor terrains_types is 
    select 
        TP.* 
    from 
        TYPE_TERRAIN TP;
	cursor curs_terrain is 
    select 
        TER.* 
    from 
        terrain TER
    where 
        TER.NOM_TERRAIN = nom ;
    begin
    htp.htmlOpen;
    htp.headOpen;

    if(test_cookie = 1) then
      -- Adhérent : récupération des infos :
      id_adh := get_id_personne;
      for curs_per in infos_user loop
          nom_adh := curs_per.nom_personne;
          prenom_adh := curs_per.prenom_personne;
      end loop;
      htp.title('Tennischool - ' || nom_adh || ' ' || prenom_adh);
    else
      htp.title( 'Tennischool');
    end if;

    htp.print( '<link href="/public/projets/G02_TENNIS/css/knacss.css"  rel="stylesheet" type="text/css" media="screen" />');
    htp.print( '<link href="/public/projets/G02_TENNIS/css/styles.css"  rel="stylesheet" type="text/css" media="screen" />');
    htp.headClose;
    htp.bodyOpen;
    ui_html.html_header;


    htp.print( '<div class="flex-container">' );
    htp.print( '<aside class="mod w20 pam aside">' );
    ui_html.html_menugauche;
    htp.print( '</aside>' );

    htp.print( '<main id="main" role="main" class="flex-item-fluid pam">' );
    htp.br(  cattributes => ' /');
    for i in curs_terrain loop        

      htp.print('<h3 align=center>Modifier un terrain </h3>');
        htp.formopen(owa_util.get_owa_service_path || 'pa_terrain.updateterrain_req','POST', cattributes=>'name="formupdater"');
        htp.tableopen;
          htp.tablerowopen;
          htp.tableData('Nom :');
          htp.tableData(htf.formText('vnom', 20,20,i.NOM_TERRAIN));
          htp.tablerowclose;


          htp.tableRowOpen;
          htp.tableData('Type :');
          htp.print('<td>');
          htp.formselectopen('vtype','');
            for curs_type in terrains_types loop
                if (i.NUM_TYPE_TERRAIN = curs_type.NUM_TYPE_TERRAIN) then
                    htp.formselectoption(cvalue=>curs_type.DESIGNATION_TYPE_TERRAIN,cselected=>'TRUE', cattributes=>'VALUE='||curs_type.NUM_TYPE_TERRAIN);
               else
                    htp.formselectoption(cvalue=>curs_type.DESIGNATION_TYPE_TERRAIN, cattributes=>'VALUE='||curs_type.NUM_TYPE_TERRAIN);
              end if;
             htp.print('</option>');
          end loop;
          htp.print('</select></td>');
          htp.tableRowClose;
          
          htp.tableRowOpen;
          htp.tableData('Description :');
          htp.tableData(htf.formText('vdes', 30,30,i.DESCRIPTION_TERRAIN));
          htp.tableRowClose;
          htp.tablerowopen;
          htp.tabledata;
          htp.print('<td><input type="button" value="MAJ" onClick="if(document.formupdater.vnom.value=='''')alert(''Veuillez entrer un nom'');else document.formupdater.submit();" /></td>');

          htp.tablerowclose;
        htp.tableclose;
        htp.formclose;

      end loop;

    htp.print( '</main>' );
    htp.print( '</div>' );

    ui_html.html_footer;
    htp.bodyClose;
    htp.htmlClose;
	end updateterrain_form;

END UI_TERRAIN;
/