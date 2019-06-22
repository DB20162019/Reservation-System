CREATE OR REPLACE PACKAGE BODY UI_REGLEMENT AS
    -- Page principale
PROCEDURE listforfait AS
-- On passe en paramètre err : indique si il y a eu une erreur lors de la connexion
-- On précise où est la feuille de style

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
cursor forfaits is 
select 
    forf.* 
from 
    forfait forf;
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
            htp.print('<h3 align=center>Liste des forfaits</h3>');
              htp.tableOpen(cattributes => 'style="text-align:center"; width=50%');
              htp.tablerowopen;
              htp.tableheader('Forfaits');
              htp.tableheader('Prix');
              htp.tableheader('Nombre d''heure ');
              htp.tableheader('Durée validité ');
              htp.tableheader('');
              htp.tableheader('');

              htp.tablerowclose;

              for i in forfaits loop
                htp.tablerowopen;
                htp.tabledata(i.DESIGNATION_FORFAIT);
                htp.tabledata(i.PRIX_FORFAIT);
                htp.tabledata(i.NOMBRE_HEURE_FORFAIT);
                htp.tabledata(i.DUREE_VAL_FORFAIT);
                htp.tabledata(htf.anchor('ui_reglement.updateforfait_form?id=' || i.NUMERO_FORFAIT, 'Editer'));
                htp.tabledata(htf.anchor('pa_reglement.delforfait_req?id=' || i.NUMERO_FORFAIT, 'Supprimer'));
                htp.tablerowclose;
              end loop;

              htp.tableclose;

            htp.anchor('ui_reglement.addforfait_form',' Ajouter un forfait');
        end if;
end if;

htp.print( '</main>' );
htp.print( '</div>' );

ui_html.html_footer;
htp.bodyClose;
htp.htmlClose;
END listforfait;


procedure addforfait_form as
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
        htp.print('<h3 align=center>Ajouter un forfait</h3>');

          htp.formopen(owa_util.get_owa_service_path || 'pa_reglement.addforfait_req','POST');
          htp.tableopen;

          htp.tablerowopen;
          htp.tableData('Forfaits : ');
          htp.tableData(htf.formtext(cname => 'vnom'));
          htp.tablerowclose;


          htp.tableRowOpen;
          htp.tableData('Prix :');
          htp.tableData(htf.formtext(cname => 'vprix'));
          htp.tableRowClose;

          htp.tablerowopen;
          htp.tableData('Nombre d''heure : ');
          htp.tableData(htf.formtext(cname => 'vnbh'));
          htp.tablerowclose;

          htp.tablerowopen;
          htp.tableData('Durée validité : ');
          htp.tableData(htf.formtext(cname => 'vval'));
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
    end addforfait_form;

	--Update d'un forfait
	procedure updateforfait_form (id in number) as
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
    cursor forfaits is 
        select 
            forf.* 
        from 
            forfait forf
        where
            forf.NUMERO_FORFAIT = id;
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
    for i in forfaits loop        

      htp.print('<h3 align=center>Modifier un forfait</h3>');
        htp.formopen(owa_util.get_owa_service_path || 'pa_reglement.updateforfait_req','POST', cattributes=>'name="formupdater"');
        htp.tableopen;

          --htp.formhidden('vid',i.NUMERO_FORFAIT);
          htp.tableRowOpen;
          htp.tableData('Numéro :');
          htp.tableData(htf.formText('vid', 5, 5, i.NUMERO_FORFAIT, cattributes => 'readonly="readonly"'));
          htp.tableRowClose;

          htp.tablerowopen;
          htp.tableData('Désignation :');
          htp.tableData(htf.formText('vnom', 20,20,i.DESIGNATION_FORFAIT));
          htp.tablerowclose;


          htp.tablerowopen;
          htp.tableData('Prix :');
          htp.tableData(htf.formText('vprix', 15,15,i.PRIX_FORFAIT));
          htp.tablerowclose;

          htp.tablerowopen;
          htp.tableData('Nombre d''heure :');
          htp.tableData(htf.formText('vnbh', 3,3,i.NOMBRE_HEURE_FORFAIT));
          htp.tablerowclose;

          htp.tablerowopen;
          htp.tableData('Durée validité :');
          htp.tableData(htf.formText('vval', 3,3,i.DUREE_VAL_FORFAIT));
          htp.tablerowclose;

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
	end updateforfait_form;
    
    procedure souscription as
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
    cursor personnes is 
    select 
        pers.* 
    from 
        personne pers
    where 
        ROLE_PERSONNE = 'Joueur' 
    order by 
         NOM_PERSONNE
        ,PRENOM_PERSONNE;
    cursor forfaits is 
    select 
        forf.* 
    from 
        forfait forf
    order by 
        forf.NUMERO_FORFAIT;
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
        htp.print('<h3 align=center>Ajout souscription</h3>');

          htp.formopen(owa_util.get_owa_service_path || 'pa_reglement.souscription_req','POST');
          htp.tableopen;

          htp.tableRowOpen;
          htp.tableData('Personne :');
          htp.print('<td>');
          htp.formselectopen('vpersonne','');
            for personne in personnes loop
             htp.formselectoption(cvalue=>personne.nom_personne||' '||personne.PRENOM_PERSONNE, cattributes=>'VALUE='||personne.NUMERO_PERSONNE);
             htp.print('</option>');
          end loop;
          htp.print('</select></td>');
          htp.tableRowClose;

          htp.tableRowOpen;
          htp.tableData('Forfait :');
          htp.print('<td>');
          htp.formselectopen('vforfait','');
            for forfait in forfaits loop
             htp.formselectoption(cvalue=>forfait.DESIGNATION_FORFAIT ||' '|| forfait.PRIX_FORFAIT || '€ '||forfait.DUREE_VAL_FORFAIT||'J', cattributes=>'VALUE='||forfait.NUMERO_FORFAIT);
             htp.print('</option>');
          end loop;
          htp.print('</select></td>');
          htp.tableRowClose;

          htp.tablerowopen;
          htp.tabledata;
          htp.print('<td>');htp.formsubmit(cvalue => 'Souscrire');htp.print('</td>');
          htp.tablerowclose;
          htp.tableclose;
          htp.formclose;
    end if;

    htp.print( '</main>' );
    htp.print( '</div>' );

    ui_html.html_footer;
    htp.bodyClose;
    htp.htmlClose;
    end souscription;

END UI_REGLEMENT;
/