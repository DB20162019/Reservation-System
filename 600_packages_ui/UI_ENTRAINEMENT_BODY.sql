CREATE OR REPLACE PACKAGE BODY UI_ENTRAINEMENT AS

-- liste des entrainements --
  PROCEDURE LISTEENTRAINEMENT AS

id_num_entrainnement integer;
id_adh integer;
nom_adh varchar2(128);
prenom_adh varchar2(128);
cursor liste_entrainement is 
                                select 
                                    ENT.* 
                                from 
                                    ENTRAINEMENT ENT
                                order by 
                                    ENT.NOM_TERRAIN;

BEGIN
htp.htmlOpen;
htp.headOpen;

if(test_cookie = 1) then
  -- Adhérent : récupération des infos :
  id_adh := get_id_personne;

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

    htp.print('<h3 align=center>Liste des entrainements</h3>');
    htp.br(  cattributes => ' /');
          htp.tableOpen(cattributes => 'style="text-align:center"; width=50%');
          htp.tableRowOpen;
          htp.tableheader('Nom terrain');
          htp.tableheader('Type entrainement');
          htp.tableheader('Début entrainement');
          htp.tableheader('Fin entrainement');
          htp.tableheader('Nombre max des participants');
          htp.tableheader('Liste des participants');
          if(get_role_personne = 'Entraineur') then
            htp.tableheader('');
          end if;
          if(get_role_personne = 'Entraineur') then
            htp.tableheader('');
          end if;
         
          htp.tableRowClose;

        for i in liste_entrainement loop
          id_num_entrainnement:=id_num_entrainnement;
          htp.tableRowOpen;
        htp.tableData(i.NOM_TERRAIN||'');
        htp.tableData(i.TYPE_ENTRAINEMENT||'');
        htp.tableData(to_char(i.DEBUT_ENTRAINEMENT, 'DD/MM/YY'));
        htp.tableData(to_char(i.FIN_ENTRAINEMENT, 'DD/MM/YY'));
        htp.tableData(i.NBR_MAX_PARTICIPANTS||'');
        htp.tableData(htf.anchor('UI_ENTRAINEMENT.listedesparticiapnts?id=' || i.NUM_ENTRAINEMENT,'Liste'));
        if(get_role_personne = 'Entraineur') then
            htp.tableData(htf.anchor('UI_ENTRAINEMENT.UPDATEENTRAINEMENT?id=' || i.NUM_ENTRAINEMENT,'Editer'));
        end if ;
                if(get_role_personne = 'Entraineur') then
            htp.tableData(htf.anchor('PA_ENTRAINEMENT.DELENTRAINEMENT?id=' || i.NUM_ENTRAINEMENT,'Supprimer'));
        end if ;
       
        htp.tableRowClose;

        end loop;

      htp.tableClose;
else
    -- A EDITER SELON LES PACKAGES
     htp.print();
end if;

htp.print( '</main>' );
htp.print( '</div>' );

ui_html.html_footer;

htp.bodyClose;
htp.htmlClose;
END LISTEENTRAINEMENT;


-- liste de mes entrainements --
  PROCEDURE LISTEMESENTRAINEMENT AS
-- On passe en paramètre err : indique si il y a eu une erreur lors de la connexion
-- On précise où est la feuille de style

id_num_entrainnement integer;
id_adh integer;
nom_adh varchar2(128);
prenom_adh varchar2(128);
cursor liste_mes_entrainement is 
                                select 
                                    ENT.* 
                                from 
                                    ENTRAINEMENT ENT INNER JOIN ASSISTER ASSI 
                                                        ON ENT.NUM_ENTRAINEMENT = ASSI.NUM_ENTRAINEMENT  
                                where 
                                    ASSI.NUMERO_PERSONNE = get_id_personne 
                                order by 
                                    ENT.NOM_TERRAIN;
BEGIN
htp.htmlOpen;
htp.headOpen;

if(test_cookie = 1) then
  -- Adhérent : récupération des infos :
  id_adh := get_id_personne;

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

    htp.print('<h3 align=center>Mes entrainements</h3>');
    htp.br(  cattributes => ' /');
          htp.tableOpen(cattributes => 'style="text-align:center"; width=50%');
          htp.tableRowOpen;
          htp.tableheader('Nom terrain');
          htp.tableheader('Type entrainement');
          htp.tableheader('Début entrainement');
          htp.tableheader('Fin entrainement');
          htp.tableheader('Nombre max des participants');
          htp.tableheader('Liste des participants');
          htp.tableRowClose;

        for i in liste_mes_entrainement loop
          htp.tableRowOpen;
        htp.tableData(i.NOM_TERRAIN||'');
        htp.tableData(i.TYPE_ENTRAINEMENT||'');
        htp.tableData(to_char(i.DEBUT_ENTRAINEMENT, 'DD/MM/YY'));
        htp.tableData(to_char(i.FIN_ENTRAINEMENT, 'DD/MM/YY'));
        htp.tableData(i.NBR_MAX_PARTICIPANTS||'');
        htp.tableData(htf.anchor('UI_ENTRAINEMENT.listedesparticiapnts?id=' || i.NUM_ENTRAINEMENT,'Liste'));
        htp.tableRowClose;
        end loop;

      htp.tableClose;

else
    -- A EDITER SELON LES PACKAGES
     htp.print();
end if;

htp.print( '</main>' );
htp.print( '</div>' );

ui_html.html_footer;

htp.bodyClose;
htp.htmlClose;
END LISTEMESENTRAINEMENT;

-- Add entrainement

  procedure ADDENTRAINEMENT as
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
    cursor personnes is 
                        select 
                            PERS.* 
                        from 
                            PERSONNE PERS 
                        where 
                            PERS.ROLE_PERSONNE = 'Entraineur' 
                        order BY 
                            PERS.NOM_PERSONNE asc;
    cursor terrains is 
                        select 
                            TER.NOM_TERRAIN 
                        from 
                            TERRAIN TER 
                        order by 
                            TER.NOM_TERRAIN;

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
        htp.print('<h3 align=center>Ajouter un entrainement</h3>');
          htp.formopen(owa_util.get_owa_service_path || 'PA_ENTRAINEMENT.ADDENTRAINEMENT','GET');
          htp.tableopen;

              htp.tableRowOpen;
              htp.tableData('Nom Terrain :');
              htp.print('<td>');
              htp.formselectopen('vnomterrain','');
              for curs_typet in terrains loop
                 htp.formselectoption(cvalue=>curs_typet.NOM_TERRAIN , cattributes=>'VALUE='||curs_typet.NOM_TERRAIN);
                 htp.print('</option>');
              end loop;
              htp.print('</select></td>');
              htp.tableRowClose;

              htp.tableRowOpen;
              htp.tableData('Nom entraineur :');
              htp.print('<td>');
              htp.formselectopen('vnumpersonne','');
              for curs_pers in personnes loop
                 htp.formselectoption(cvalue=>curs_pers.NOM_PERSONNE || ' ' || curs_pers.PRENOM_PERSONNE , cattributes=>'VALUE='||curs_pers.NUMERO_PERSONNE);
                 htp.print('</option>');
              end loop;
              htp.print('</select></td>');
              htp.tableRowClose;

              htp.tablerowopen;
              htp.tableData('Type entrainement: ');
               htp.print('<td>');
              htp.formselectopen('vtypeentr','');
                    htp.formselectoption(cvalue=>'Collectif', cattributes=>'VALUE='||'Collectif');
                    htp.print('</option>');
                    htp.formselectoption(cvalue=>'Individuel', cattributes=>'VALUE='||'Individuel');
                    htp.print('</option>');
            htp.print('</select></td>');
            htp.tablerowclose;
       
              htp.tablerowopen;
              htp.tableData('Nombre maximum des personnes ( entre 1 et 10 ) : ');
              htp.tableData(htf.formtext('vnbrmax',19,19));
              htp.tablerowclose;

              htp.tablerowopen;
              htp.tableData('Début entrainement: ');
              htp.print('<td><input type="date" name="vdebutentr"/></td>');
              htp.tablerowclose;

              htp.tablerowopen;
              htp.tableData('Fin entrainement: ');
              htp.print('<td><input type="date" name="vfinentr"/></td>');
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
    end ADDENTRAINEMENT;

-- Update entrainement
    procedure UPDATEENTRAINEMENT (id in number) as
    
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
    cursor entrainement is 
                    select 
                        ent.* 
                    from 
                        entrainement ent 
                    where 
                        ent.NUM_ENTRAINEMENT = id;
    cursor personnes is 
                    select 
                        PERS.* 
                    from 
                        PERSONNE PERS 
                    where 
                        PERS.ROLE_PERSONNE = 'Entraineur' 
                    order BY 
                        PERS.NOM_PERSONNE asc;
    cursor terrains is 
                    select 
                        terr.NOM_TERRAIN 
                    from 
                        TERRAIN terr 
                    order by 
                        terr.NOM_TERRAIN;
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
    for i in entrainement loop        

      htp.print('<h3 align=center>Modifier un entrainement</h3>');
        htp.formopen(owa_util.get_owa_service_path || 'PA_ENTRAINEMENT.UPDATEENTRAINEMENT','POST', cattributes=>'name="formupdater"');
        
        htp.formhidden('vnument',cvalue=>i.NUM_ENTRAINEMENT);
        htp.tableopen;


          htp.tableRowOpen;
          htp.tableData('Nom Terrain :');
          htp.print('<td>');
          htp.formselectopen('vnomterrain','');
            for curs_type in terrains loop
                if (i.NOM_TERRAIN = curs_type.NOM_TERRAIN) then
                    htp.formselectoption(cvalue=>curs_type.NOM_TERRAIN ,cselected=>'TRUE', cattributes=>'VALUE='||curs_type.NOM_TERRAIN);
                    htp.print('</option>');
               else
             htp.formselectoption(cvalue=>curs_type.NOM_TERRAIN , cattributes=>'VALUE='||curs_type.NOM_TERRAIN);
             htp.print('</option>');
              end if;
          end loop;
          htp.print('</select></td>');
          htp.tableRowClose;

          htp.tableRowOpen;
          htp.tableData('Nom entraineur :');
          htp.print('<td>');
          htp.formselectopen('vnumpersonne','');
            for curs_pers in personnes  loop
                if (i.NUMERO_PERSONNE = curs_pers.NUMERO_PERSONNE) then
                   htp.formselectoption(cvalue=>curs_pers.NOM_PERSONNE || ' ' || curs_pers.PRENOM_PERSONNE ,cselected=>'TRUE', cattributes=>'VALUE='||curs_pers.NUMERO_PERSONNE);
               htp.print('</option>');
                else
             htp.formselectoption(cvalue=>curs_pers.NOM_PERSONNE || ' ' || curs_pers.PRENOM_PERSONNE , cattributes=>'VALUE='||curs_pers.NUMERO_PERSONNE);
             htp.print('</option>');
             end if;
          end loop;
          htp.print('</select></td>');
          htp.tableRowClose;
           
          htp.tablerowopen;
              htp.tableData('Type entrainement: ');
               htp.print('<td>');
              htp.formselectopen('vtypeentr','');
                    if(i.TYPE_ENTRAINEMENT = 'Collectif') then
                        htp.formselectoption(cvalue=>'Collectif', cselected=>'TRUE',cattributes=>'VALUE='||'Collectif');
                        htp.print('</option>');
                    else
                        htp.formselectoption(cvalue=>'Collectif',cattributes=>'VALUE='||'Collectif');
                        htp.print('</option>');
                    end if ;
                    if(i.TYPE_ENTRAINEMENT = 'Individuel') then
                        htp.formselectoption(cvalue=>'Individuel', cselected=>'TRUE',cattributes=>'VALUE='||'Individuel');
                        htp.print('</option>');
                    else
                        htp.formselectoption(cvalue=>'Individuel', cattributes=>'VALUE='||'Individuel');
                        htp.print('</option>');
                    end if;
            htp.print('</select></td>');
            htp.tablerowclose;
    
         htp.tablerowopen;
         htp.tableData('Nombre maximum des personnes ( entre 1 et 10 ) : ');
         htp.tableData(htf.formText('vnbrmax', 19,19,i.NBR_MAX_PARTICIPANTS));
         htp.tablerowclose;

         htp.tablerowopen;
         htp.tableData('Début entrainement: ');
         htp.print('<td><input type="date" name="vdebutentr" value="'||TO_CHAR(i.DEBUT_ENTRAINEMENT,'YYYY-MM-DD')||'"/></td>');
         htp.tablerowclose;

         htp.tablerowopen;
         htp.tableData('Fin entrainement: ');
         htp.print('<td><input type="date" name="vfinentr" value="'||TO_CHAR(i.FIN_ENTRAINEMENT,'YYYY-MM-DD')||'"/></td>');
         htp.tablerowclose;
    
          htp.tablerowopen;
          htp.tabledata;
          htp.print('<td><input type="submit"  /></td>');

          htp.tablerowclose;
        htp.tableclose;
        htp.formclose;

      end loop;

    htp.print( '</main>' );
    htp.print( '</div>' );

    ui_html.html_footer;
    htp.bodyClose;
    htp.htmlClose;
	end UPDATEENTRAINEMENT ;
    
    procedure listedesparticiapnts(id in number ) as
     id_num_entrainnement integer;
    id_adh integer;
    nom_adh varchar2(128);
    prenom_adh varchar2(128);
    cursor liste_mes_entrainement is
                                select 
                                    ENT.* 
                                from 
                                    ENTRAINEMENT ENT 
                                where 
                                    ENT.NUMERO_PERSONNE = get_id_personne;
    cursor liste_des_participants is 
                                select 
                                     PERS.NUMERO_PERSONNE 
                                    ,PERS.NOM_PERSONNE 
                                    ,PERS.PRENOM_PERSONNE 
                                    , PERS.NAISSANCE_PERSONNE 
                                FROM 
                                    PERSONNE PERS INNER JOIN ASSISTER ASSI 
                                                        ON PERS.NUMERO_PERSONNE = ASSI.NUMERO_PERSONNE
                                                  INNER JOIN ENTRAINEMENT ENT 
                                                        ON ASSI.NUM_ENTRAINEMENT = ENT.NUM_ENTRAINEMENT 
                                WHERE 
                                    ASSI.NUM_ENTRAINEMENT  = id
                                ORDER BY
                                    PERS.NOM_PERSONNE ;

    BEGIN
    htp.htmlOpen;
    htp.headOpen;
    
    if(test_cookie = 1) then
      -- Adhérent : récupération des infos :
      id_adh := get_id_personne;
    
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
    
        htp.print('<h3 align=center>Liste des participants à cet entrainement</h3>');
        htp.br(  cattributes => ' /');
              htp.tableOpen(cattributes => 'style="text-align:center"; width=50%');
              htp.tableRowOpen;
              htp.tableheader('Nom');
              htp.tableheader('Prénom');
              htp.tableheader('Date de naissance');
    
              htp.tableRowClose;
    
            for i in liste_des_participants loop
              
            htp.tableRowOpen;
            htp.tableData(i.NOM_PERSONNE||'');
            htp.tableData(i.PRENOM_PERSONNE||'');
           
            htp.tableData(to_char(i.NAISSANCE_PERSONNE, 'DD/MM/YY')||'');
            htp.tableRowClose;
  
            end loop;
            if(get_role_personne = 'Entraineur') then
              htp.anchor('UI_ENTRAINEMENT.addparticipants?id=' || id ,' Ajouter un participant');
              end if ;
          htp.tableClose;
         
    else
        -- A EDITER SELON LES PACKAGES
         htp.print();
    end if;
    
    htp.print( '</main>' );
    htp.print( '</div>' );
    
    ui_html.html_footer;
    htp.bodyClose;
    htp.htmlClose;
 end listedesparticiapnts ;

procedure addparticipants (id in number ) as 

   id_adh integer;
    nom_adh varchar2(128);
    prenom_adh varchar2(128);
    cursor infos_user is 
                    select 
                        * 
                    from 
                        personne pers 
                    where 
                        pers.NUMERO_PERSONNE = id_adh;
    cursor entrainement is 
                    select 
                        * 
                    from 
                        entrainement ent 
                    where 
                        ent.NUM_ENTRAINEMENT = id;
    cursor personnes is
                    select 
                        PERS.*
                    from 
                        PERSONNE PERS 
                    where PERS.NUMERO_PERSONNE not in ( 
                                                        select 
                                                            NUMERO_PERSONNE 
                                                        from
                                                            ASSISTER ASSI
                                                        where
                                                            ASSI.NUM_ENTRAINEMENT = id 
                                                        
                                                    ) 
                    order BY PERS.NOM_PERSONNE asc;
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
    
        for i in entrainement loop   
        htp.print('<h3 align=center>Ajouter des participants
        </h3>');
          htp.br(  cattributes => ' /');
          htp.formopen(owa_util.get_owa_service_path || 'PA_ENTRAINEMENT.ADDPARTICIPANT','POST');
          htp.formhidden('vnument',cvalue=>i.NUM_ENTRAINEMENT);
          htp.tableopen; 
          htp.tableRowOpen;
          htp.tableData('Nom est Prénom :');
          htp.print('<td>');
          htp.formselectopen('vnumpersonne','');
            for curs_pers in personnes  loop
                if (i.NUMERO_PERSONNE = curs_pers.NUMERO_PERSONNE) then
                   htp.formselectoption(cvalue=>curs_pers.NOM_PERSONNE || ' ' || curs_pers.PRENOM_PERSONNE ,cselected=>'TRUE', cattributes=>'VALUE='||curs_pers.NUMERO_PERSONNE);
               htp.print('</option>');
                else
             htp.formselectoption(cvalue=>curs_pers.NOM_PERSONNE || ' ' || curs_pers.PRENOM_PERSONNE , cattributes=>'VALUE='||curs_pers.NUMERO_PERSONNE);
             htp.print('</option>');
             end if;
             end loop;
          htp.print('</select></td>');
          htp.tableRowClose;

              htp.tablerowopen;
              htp.tabledata;
              htp.print('<td>');htp.formsubmit(cvalue => 'Ajouter');htp.print('</td>');
              htp.tablerowclose;
          htp.tableclose;
          htp.formclose;
 end loop;
    htp.print( '</main>' );
    htp.print( '</div>' );

    ui_html.html_footer;
    htp.bodyClose;
    htp.htmlClose;
    end addparticipants ;
    
END UI_ENTRAINEMENT;
/