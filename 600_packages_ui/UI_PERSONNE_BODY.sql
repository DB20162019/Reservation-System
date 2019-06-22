CREATE OR REPLACE PACKAGE BODY UI_PERSONNE AS
PROCEDURE add_personne_form AS
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
    NUMERO_PERSONNE = id_adh;

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
--TODO INSCRIPTION
htp.print('<h3 align=center>Saisir les informations</h3>');
htp.formopen(owa_util.get_owa_service_path || 'pa_personne.add_personne_req','POST');
		htp.tableOpen;

			htp.tableRowOpen;
			htp.tableData('NOM : ');
			htp.tableData(htf.formText('vnompersonne',20));
			htp.tableRowClose;

			htp.tableRowOpen;
			htp.tableData('PRENOM : ');
			htp.tableData(htf.formText('vprenompersonne',20));
			htp.tableRowClose;

			htp.tableRowOpen;
			htp.tableData('DATE DE NAISSANCE: ');
			htp.tableData(htf.formText('vdatedenaissance',20));
			htp.tableRowClose;

			htp.tableRowOpen;
			htp.tableData('TELEPHONE : ');
			htp.tableData(htf.formText('vtelephone',20));
			htp.tableRowClose;

			htp.tableRowOpen;
			htp.tableData(' N° de rue : ');
			htp.tableData(htf.formText('vnumrue',30,5));
			htp.tableRowClose;

            htp.tableRowOpen;
			htp.tableData(' Nom de rue : ');
			htp.tableData(htf.formText('vrue',30));
			htp.tableRowClose;

            htp.tableRowOpen;
			htp.tableData(' Code postal : ');
			htp.tableData(htf.formText('vcd',20));
			htp.tableRowClose;

      htp.tableRowOpen;
			htp.tableData(' Ville : ');
      htp.tableData(htf.formText('vville',20));
			htp.tableRowClose;

      htp.tableRowOpen;
			htp.tableData('Pays : ');
			htp.tableData(htf.formText('vpays',20));
			htp.tableRowClose;

      htp.tablerowopen;
          htp.tabledata;
          htp.print('<td>');htp.formsubmit(cvalue => 'Inscrire');htp.print('</td>');
          htp.tablerowclose;

		htp.br;
		htp.tableClose;
		htp.formClose;


htp.print( '</main>' );
htp.print( '</div>' );

ui_html.html_footer;
htp.bodyClose;
htp.htmlClose;
END add_personne_form;

PROCEDURE add_personne_formadmin AS
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
    NUMERO_PERSONNE = id_adh;
cursor roles is 
select 
    distinct pers.ROLE_PERSONNE 
from 
    personne pers;
cursor niveaux is 
select 
    niv.*
from 
    niveau niv
order by 
    1;
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
--TODO INSCRIPTION
if (get_role_personne = 'Entraineur') then
    htp.print('<h3 align=center>Saisir les informations</h3>');
    htp.formopen(owa_util.get_owa_service_path || 'pa_personne.add_personne_reqadmin','POST');
            htp.tableOpen;
    
                htp.tableRowOpen;
                htp.tableData('NOM : ');
                htp.tableData(htf.formText('vnompersonne',20));
                htp.tableRowClose;
    
                htp.tableRowOpen;
                htp.tableData('PRENOM : ');
                htp.tableData(htf.formText('vprenompersonne',20));
                htp.tableRowClose;
    
                htp.tableRowOpen;
                htp.tableData('DATE DE NAISSANCE: ');
                htp.print('<td><input type="date" name="vdatedenaissance"/></td>');
                htp.tableRowClose;
    
                htp.tableRowOpen;
                htp.tableData('TELEPHONE : ');
                htp.tableData(htf.formText('vtelephone',20));
                htp.tableRowClose;
    
                htp.tableRowOpen;
                htp.tableData(' N° de rue : ');
                htp.tableData(htf.formText('vnumrue',30,5));
                htp.tableRowClose;
    
                htp.tableRowOpen;
                htp.tableData(' Nom de rue : ');
                htp.tableData(htf.formText('vrue',30));
                htp.tableRowClose;
    
                htp.tableRowOpen;
                htp.tableData(' Code postal : ');
                htp.tableData(htf.formText('vcd',20));
                htp.tableRowClose;
    
                htp.tableRowOpen;
                htp.tableData(' Ville : ');
                htp.tableData(htf.formText('vville',20));
                htp.tableRowClose;
    
                htp.tableRowOpen;
                htp.tableData('Pays : ');
                htp.tableData(htf.formText('vpays',20));
                htp.tableRowClose;
                
                htp.tableRowOpen;
                htp.tableData('Niveau :');
                htp.print('<td>');
                htp.formselectopen('vniveau','');
                    for niv in niveaux loop
                        htp.formselectoption(cvalue=>niv.NOM_NIVEAU, cattributes=>'VALUE='||niv.NUMERO_NIVEAU);
                        htp.print('</option>');
                    end loop;
                htp.print('</select></td>');
                htp.tableRowClose;
                
                htp.tableRowOpen;
                htp.tableData('Role :');
                htp.print('<td>');
                htp.formselectopen('vrole','');
                    for rol in roles loop
                        htp.formselectoption(cvalue=>rol.ROLE_PERSONNE, cattributes=>'VALUE='||rol.ROLE_PERSONNE);
                        htp.print('</option>');
                    end loop;
                htp.print('</select></td>');
                htp.tableRowClose;
    
              htp.tablerowopen;
              htp.tabledata;
              htp.print('<td>');htp.formsubmit(cvalue => 'Inscrire');htp.print('</td>');
              htp.tablerowclose;
    
            htp.br;
    htp.tableClose;
    htp.formClose;
else 
    htp.print('<script language="javascript" type="text/javascript"> window.location.replace( "ui_html.ERR_403");</script>');
end if;


htp.print( '</main>' );
htp.print( '</div>' );

ui_html.html_footer;
htp.bodyClose;
htp.htmlClose;
END add_personne_formadmin;

PROCEDURE listentraineur AS
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
cursor entraineurs is 
    select 
        * 
    from 
        personne
            join NIVEAU using (NUMERO_NIVEAU) 
    where 
        ROLE_PERSONNE = 'Entraineur';
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
            htp.print('<h3 align=center>Liste des entraineurs</h3>');
              htp.tableOpen(cattributes => 'style="text-align:center"; width=50%');
              htp.tablerowopen;
              htp.tableheader('Nom');
              htp.tableheader('Prénom');
              htp.tableheader('Niveau');
              htp.tableheader('Date d''embauche');
              htp.tableheader('Salaire');
              htp.tableheader('');
              htp.tableheader('');

              htp.tablerowclose;

              for i in entraineurs loop
                htp.tablerowopen;
                htp.tabledata(i.NOM_PERSONNE);
                htp.tabledata(i.PRENOM_PERSONNE);
                htp.tabledata(i.NOM_NIVEAU);
                htp.tabledata(i.DATE_EMBAUCHE_ENTRAINEUR);
                htp.tabledata(i.SALAIRE_ENTRAINEUR);
                htp.tabledata(htf.anchor('ui_personne.updatepersonne_form?id=' || i.NUMERO_PERSONNE || '&r=e', 'Editer'));
                htp.tabledata(htf.anchor('pa_personne.delentraineur_req?id=' || i.NUMERO_PERSONNE, 'Supprimer'));
                htp.tablerowclose;
              end loop;

              htp.tableclose;

           -- htp.anchor('ui_reglement.addforfait_form',' Ajouter un forfait');
        end if;
end if;

htp.print( '</main>' );
htp.print( '</div>' );

ui_html.html_footer;
htp.bodyClose;
htp.htmlClose;
END listentraineur;

PROCEDURE listpersonne_form AS
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
cursor joueurs is 
    select 
        * 
    from 
        personne
            join NIVEAU using (NUMERO_NIVEAU) 
    where 
        ROLE_PERSONNE = 'Joueur' 
    order by 
         Nom_personne
        ,prenom_personne;
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
            htp.print('<h3 align=center>Liste des inscrits</h3>');
              htp.tableOpen(cattributes => 'style="text-align:center"; width=50%');
              htp.tablerowopen;
              htp.tableheader('Nom');
              htp.tableheader('Prénom');
              htp.tableheader('Niveau');
              htp.tableheader('Date naissance');
              htp.tableheader('Ville');
              htp.tableheader('');
              htp.tableheader('');

              htp.tablerowclose;

              for i in joueurs loop
                htp.tablerowopen;
                htp.tabledata(i.NOM_PERSONNE);
                htp.tabledata(i.PRENOM_PERSONNE);
                htp.tabledata(i.NOM_NIVEAU);
                htp.tabledata(i.NAISSANCE_PERSONNE);
                htp.tabledata(i.VILLE_PERSONNE);
                htp.tabledata(htf.anchor('ui_personne.updatepersonne_form?id=' || i.NUMERO_PERSONNE , 'Editer'));
                htp.tabledata(htf.anchor('pa_personne.delpersonne?id=' || i.NUMERO_PERSONNE, 'Supprimer'));
                htp.tablerowclose;
              end loop;

              htp.tableclose;

           -- htp.anchor('ui_reglement.addforfait_form',' Ajouter un forfait');
        end if;
end if;

htp.print( '</main>' );
htp.print( '</div>' );

ui_html.html_footer;
htp.bodyClose;
htp.htmlClose;
END listpersonne_form;

procedure updatepersonne_form (id in number ,r in varchar2 default 'j') as
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
    cursor c_personne is 
    select 
        pers.* 
    from
        personne pers
    where 
        NUMERO_PERSONNE = id;
    cursor roles is 
        select distinct pers.ROLE_PERSONNE 
    from 
        personne pers;
    cursor niveaux is 
    select 
        niv.*
    from 
        niveau niv
    order by 
        1;
        
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
    for i in c_personne loop        

      htp.print('<h3 align=center>Modifier les informations</h3>');
        htp.formopen(owa_util.get_owa_service_path || 'pa_personne.updatepersonne_req','POST', cattributes=>'name="formupdater"');
        htp.tableopen;

          htp.formhidden('vid',i.NUMERO_PERSONNE);

          htp.tablerowopen;
          htp.tableData('NOM :');
          htp.tableData(htf.formText('vnom', 20,20,i.NOM_PERSONNE));
          htp.tablerowclose;


          htp.tablerowopen;
          htp.tableData('Prénom :');
          htp.tableData(htf.formText('vprenom', 20,20,i.PRENOM_PERSONNE));
          htp.tablerowclose;

          htp.tablerowopen;
          htp.tableData('Date de naissance :');
          htp.print('<td><input type="date" name="vdatedenaissance" value="'||TO_CHAR(i.NAISSANCE_PERSONNE,'YYYY-MM-DD')||'"/></td>');
          htp.tablerowclose;

          htp.tablerowopen;
          htp.tableData('N° tel :');
          htp.tableData(htf.formText('vtelephone',20,20,i.TELEPHONE_PERSONNE));
          htp.tablerowclose;
          
           htp.tablerowopen;
          htp.tableData('Numero de rue :');
          htp.tableData(htf.formText('vnumrue', 20,20,i.NUMERO_ADD_PERSONNE));
          htp.tablerowclose;
          
          htp.tablerowopen;
          htp.tableData('Nom de la rue :');
          htp.tableData(htf.formText('vnomrue',20,20,i.RUE_PERSONNE));
          htp.tablerowclose;
          
          htp.tablerowopen;
          htp.tableData('Code postal :');
          htp.tableData(htf.formText('vcp', 20,20,i.CP_PERSONNE));
          htp.tablerowclose;
          
            htp.tablerowopen;
          htp.tableData('Ville :');
          htp.tableData(htf.formText('vville', 20,20,i.VILLE_PERSONNE));
          htp.tablerowclose;
          
            htp.tablerowopen;
          htp.tableData('Pays :');
          htp.tableData(htf.formText('vpays', 20,20,i.PAYS_PERSONNE));
          htp.tablerowclose;
          
          if (get_role_personne = 'Entraineur') then
            htp.tableRowOpen;
                htp.tableData('Niveau :');
                htp.print('<td>');
                htp.formselectopen('vniveau','');
                    for niv in niveaux loop
                        if (i.NUMERO_NIVEAU = niv.NUMERO_NIVEAU) then
                            htp.formselectoption(cvalue=>niv.NOM_NIVEAU,cselected=>'TRUE', cattributes=>'VALUE='||niv.NUMERO_NIVEAU);
                        else
                            htp.formselectoption(cvalue=>niv.NOM_NIVEAU, cattributes=>'VALUE='||niv.NUMERO_NIVEAU);
                        end if;
                        htp.print('</option>');
                    end loop;
                htp.print('</select></td>');
                htp.tableRowClose;
                
                htp.tableRowOpen;
                htp.tableData('Role :');
                htp.print('<td>');
                htp.formselectopen('vrole','');
                    for rol in roles loop
                        if (i.ROLE_PERSONNE = rol.ROLE_PERSONNE) then
                             htp.formselectoption(cvalue=>rol.ROLE_PERSONNE,cselected=>'TRUE', cattributes=>'VALUE='||rol.ROLE_PERSONNE);
                        else
                            htp.formselectoption(cvalue=>rol.ROLE_PERSONNE, cattributes=>'VALUE='||rol.ROLE_PERSONNE);
                        end if;
                        htp.print('</option>');
                       
                        htp.print('</option>');
                    end loop;
                htp.print('</select></td>');
                htp.tableRowClose;
                
                if (r = 'e') then 
                    htp.tablerowopen;
                    htp.tableData('Salaire :');
                    htp.tableData(htf.formText('vsal', 20,20,i.salaire_entraineur));
                    htp.tablerowclose;
                      
                    htp.tablerowopen;
                    htp.tableData('Date embauche :');
                    htp.print('<td><input type="date" name="vdateembauche" value="'||TO_CHAR(i.DATE_EMBAUCHE_ENTRAINEUR,'YYYY-MM-DD')||'"/></td>');
                    htp.tablerowclose;
                        
                end if;
                
          end if;

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
	end updatepersonne_form;
    
END UI_PERSONNE;
/