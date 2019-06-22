CREATE OR REPLACE PACKAGE BODY UI_FACTURE AS
    -- Page principale
PROCEDURE mesfactures AS

    id_adh integer;
    nom_adh varchar2(128);
    prenom_adh varchar2(128);
    cursor infos_user is select pers.* from personne pers where pers.NUMERO_PERSONNE = id_adh;
    cursor factures is select * from facture join personne using(NUMERO_PERSONNE)where NUMERO_PERSONNE = id_adh;
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
        --if(get_role_personne = 'Joueur') then
            htp.print('<h3 align=center>Liste des factures</h3>');
              htp.tableOpen(cattributes => 'style="text-align:center"; width=50%');
              htp.tablerowopen;
              htp.tableheader('Numéro de la facture');
              htp.tableheader('Numéro de forfait');
              htp.tableheader('Date facture');
               htp.tableheader('Montant facture');
             -- htp.tableheader('Edit');
              htp.tablerowclose;

              for i in factures loop
                htp.tablerowopen;
                htp.tabledata(i.NUMERO_FACTURE);
                htp.tabledata(i.NUMERO_FORFAIT);
                htp.tabledata(i.DATE_FACTURE);
                htp.tabledata(i.MONTANT_FACTURE || ' €');
                --htp.tabledata(htf.anchor('ui_terrain.updateterrain_form?nom=' || i.NOM_TERRAIN, 'Edit'));
                htp.tablerowclose;
              end loop;

              htp.tableclose;

           -- htp.anchor('ui_terrain.addterrain_form',' Ajouter un terrain');
        --end if;
    end if;

    htp.print( '</main>' );
    htp.print( '</div>' );

ui_html.html_footer;
htp.bodyClose;
htp.htmlClose;
END mesfactures;
END UI_FACTURE;
/