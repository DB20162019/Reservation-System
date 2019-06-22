CREATE OR REPLACE PACKAGE BODY UI_HTML AS
--http://pc-gi-405.utbm.fr:8080/G02_TENNIS_rep_dad/ui_html.html_home
-- Formulaire de connection
PROCEDURE CONNECTION_FORM (err integer default 0) AS
BEGIN

  htp.formopen(owa_util.get_owa_service_path || 'ui_html.cookie_create','POST');

  htp.print('Login :');
  htp.formtext(cname => 'vlogin', csize => '13');

  htp.print('Mot de passe : ');
  htp.formpassword(cname => 'vpass', csize => '13');

  htp.formsubmit(cvalue => 'Connexion');
  htp.anchor( '#', 'Mot de passe oublié ?');

    -- Si il y a eu une erreur lors de la connexion, on affiche un message
   if(err = 1) then
    htp.print('<span class=erreur>Erreur login ou mot de passe</span>');
  end if;
  htp.formclose;
END CONNECTION_FORM;

-- Création du cookie
PROCEDURE COOKIE_CREATE (vlogin IN VARCHAR2, vpass IN VARCHAR2) AS
CURSOR connection is 
select 
     PERS.USER_PERSONNE
    ,PERS.MDP_PERSONNE
    ,PERS.NUMERO_PERSONNE
from 
    personne PERS 
where 
    PERS.USER_PERSONNE = vlogin;
BEGIN


for cur in connection loop
  -- Décryptage du mot de passe pour le test
  if(vlogin = cur.USER_PERSONNE AND mp.encrypt(vpass) = cur.MDP_PERSONNE) then
  --if(vlogin = cur.USER_PERSONNE AND vpass = cur.MDP_PERSONNE) then
        -- Si le login et mot de passe sont bon :
        -- Création de l'entête
        OWA_UTIL.mime_header('text/html',FALSE);
        -- On met les informations utiles : l'id de l'utilisateur
        OWA_COOKIE.send('user_tennis',cur.NUMERO_PERSONNE);
        OWA_UTIL.http_header_close;

        -- Redirection
        htp.print('<script language="javascript" type="text/javascript"> window.location.replace( "ui_html.html_home");</script>');
        htp.print('Loading...');

  end if;    
end loop;
htp.print('<script language="javascript" type="text/javascript"> window.location.replace( "ui_html.html_home?err=1");</script>');

END COOKIE_CREATE;

-- Suppression du cookie : lors de la déconnexion
PROCEDURE COOKIE_DELETE AS
BEGIN
  OWA_UTIL.mime_header('text/html',FALSE);
  OWA_COOKIE.remove('user_tennis',NULL);
  OWA_UTIL.http_header_close;
  htp.print('Déconnexion en cours...');
  htp.print('<meta http-equiv="refresh" content="0;URL=ui_html.html_home">');  
END COOKIE_DELETE;

-- Page d'erreur 403 : Accès non authorisé
PROCEDURE ERR_403 AS
BEGIN
htp.htmlopen;
htp.headopen;
htp.title('Tennischool - Accès non authorisé');
htp.print( '<link href="/public/projets/G02_TENNIS/css/knacss.css"  rel="stylesheet" type="text/css" media="screen" />');
htp.print( '<link href="/public/projets/G02_TENNIS/css/styles.css"  rel="stylesheet" type="text/css" media="screen" />');
htp.headClose;
htp.bodyOpen;
html_header;


htp.print( '<div class="flex-container">' );
htp.print( '<aside class="mod w20 pam aside">' );
html_menugauche;
htp.print( '</aside>' );

htp.print( '<main id="main" role="main" class="flex-item-fluid pam">' );
htp.br(  cattributes => ' /');

htp.print('<center><font color=red><b>Erreur 403 : Vous n''avez pas le droit d''accéder à cette page</b></font></center>');
htp.br;

htp.print( '</main>' );
htp.print( '</div>' );

html_footer;
htp.bodyClose;

htp.htmlClose;
END ERR_403;


-- Footer :
PROCEDURE HTML_FOOTER AS
BEGIN
 htp.print( '<footer id="footer" role="contentinfo" class="pam">' );
	htp.print( 'Site réalisé par Matthieu Bonnevalle, Daïnah Bounoua, Nesrine Khayeche et Valisoa Anjaratiana 
    dans le cadre de l''UV BD50' );
	htp.print( '</footer>' );
END HTML_FOOTER;


-- En tête de la page
PROCEDURE HTML_HEADER AS

BEGIN
  	htp.print( '<header id="header" role="banner" class="pam" style="text-align:right">' );
	HTML_MENUHAUT;
	htp.print( '</header>' );
END HTML_HEADER;

-- Page principale
PROCEDURE HTML_HOME (err integer default 0) AS
-- On passe en paramètre err : indique si il y a eu une erreur lors de la connexion
-- On précise où est la feuille de style

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
html_header;


htp.print( '<div class="flex-container">' );
htp.print( '<aside class="mod w20 pam aside">' );
html_menugauche;
htp.print( '</aside>' );

htp.print( '<main id="main" role="main" class="flex-item-fluid pam">' );
htp.br(  cattributes => ' /');
if(test_cookie = 0) then
    htp.print( '<h3>Bienvenue sur le site Tennischool</h3><p>Sur ce site vous pouvez accéder aux différentes fonctionnalités de votre compte : réserver un terrain de tennis, modifier une réservation, consulter les entrainements sur lesquels vous êtes inscrits mais aussi consulter ou mettre à jour vos informations personnelles ainsi que vos factures...
   </p><p>Pour pouvoir réserver : connectez vous avec votre nom d''utilisateur, si vous possédez déjà un compte. Sinon <a href=''ui_personne.add_personne_form'' />inscrivez-vous</a>.</p>
    ' );
else
    htp.print('<p>Bienvenue '|| prenom_adh || ' ' || nom_adh || ' sur Tennischool. 
    </p><p> Vous pouvez dès à présent réserver un terrain, modifier une réservation ou accéder aux entrainements sur lesquels vous êtes déjà inscrit');
end if;

htp.print( '</main>' );
htp.print( '</div>' );

html_footer;
htp.bodyClose;
htp.htmlClose;
END HTML_HOME;

-- Menu de droite
PROCEDURE HTML_MENUGAUCHE AS
BEGIN

-- On affiche le menu que lorsque l'utilisateur est connecté :
if(test_cookie = 1) then
  htp.ulistOpen(  cattributes => ' id="menugauche"' );

  -- Menu des réservations :
    htp.print('<h4>Réservations</h4>');
    htp.ulistOpen();
    --
        htp.listItem( htf.anchor( 'ui_reservation.listereservation', 'Mes réservations'));
        htp.listItem( htf.anchor( 'ui_reservation.addreservation', 'Réserver un terrain '));
    htp.ulistClose;

  -- Menu des cours :     
    htp.print('<h4>Entrainements</h4>');
    htp.ulistOpen();
    --
        if(get_role_personne = 'Joueur' or get_role_personne = 'Entraineur') then
           htp.listItem( htf.anchor( 'UI_ENTRAINEMENT.LISTEMESENTRAINEMENT', 'Mes entrainements'));
        end if;
        htp.listItem( htf.anchor( 'UI_ENTRAINEMENT.LISTEENTRAINEMENT', 'Liste des entrainements'));
        if(get_role_personne = 'Entraineur') then
          htp.listItem(htf.anchor('UI_ENTRAINEMENT.ADDENTRAINEMENT','Ajouter un entrainement'));      
        end if;
    htp.ulistClose;
    --Menu des factures
        htp.print('<h4>Factures</h4>');
        htp.ulistOpen();
        --
          htp.listItem( htf.anchor( 'ui_facture.mesfactures', 'Mes factures'));
        htp.ulistClose;

   -- Menu des terrains :       
        if(get_role_personne = 'Entraineur') then
        htp.print('<h4>Terrains</h4>');
        htp.ulistOpen();
        --
          htp.listItem( htf.anchor( 'ui_terrain.listterrain', 'Gestion des terrains'));
        end if;
        htp.ulistClose;

    -- Menu des personnes :
       if(get_role_personne = 'Entraineur') then
        htp.print('<h4>Personnes</h4>');
        htp.ulistOpen();
        --
          htp.listItem( htf.anchor( 'ui_personne.add_personne_formadmin', 'Ajouter une personne'));
          htp.listItem( htf.anchor( 'ui_personne.listpersonne_form', 'Joueurs'));
          htp.listItem( htf.anchor( 'ui_personne.listentraineur', 'Entraineurs'));
        end if;
        htp.ulistClose;

  -- Menu des règlements :    
    if(get_role_personne = 'Entraineur') then
        htp.print('<h4>Reglements</h4>');
        htp.ulistOpen();
        --
          htp.listItem( htf.anchor( 'ui_reglement.listforfait', 'Liste des forfaits'));
          htp.listItem( htf.anchor( 'ui_reglement.souscription', 'Ajouter un reglement'));
        end if;
        htp.ulistClose;


	htp.ulistClose;
  end if;	
END HTML_MENUGAUCHE;

PROCEDURE HTML_MENUHAUT(err integer default 0) AS
cursor personne is 
select 
     pers.NUMERO_PERSONNE
    ,pers.NUMERO_NIVEAU
    ,pers.NOM_PERSONNE
    ,pers.PRENOM_PERSONNE
    ,pers.NAISSANCE_PERSONNE
    ,pers.TELEPHONE_PERSONNE
    ,pers.NUMERO_ADD_PERSONNE
    ,pers.RUE_PERSONNE
    ,pers.CP_PERSONNE
    ,pers.VILLE_PERSONNE
    ,pers.PAYS_PERSONNE
    ,pers.ROLE_PERSONNE
    ,pers.USER_PERSONNE
    ,pers.MDP_PERSONNE
    ,pers.NUM_ENTRAINEUR
    ,pers.DATE_EMBAUCHE_ENTRAINEUR
    ,pers.SALAIRE_ENTRAINEUR 
from 
    PERSONNE pers 
where 
    pers.NUMERO_PERSONNE = get_id_personne;
BEGIN
        -- Si on est connecté, on affiche les informations de connnexion
        if(test_cookie = 1) then 
            for i in personne loop
              htp.print('Connecté en tant que ' || 
              htf.anchor('ui_personne.updatepersonne_form?id=' || get_id_personne,i.PRENOM_PERSONNE || ' ' || i.nom_personne) || ' | ' ||
              htf.anchor('ui_html.COOKIE_DELETE', 'Se déconnecter'));
            end loop;
        else
            -- Sinon on affiche le formulaire de connexion avec eventuellement l'erreur :
            ui_html.connection_form(err);
        end if;
END HTML_MENUHAUT;

END UI_HTML;
/