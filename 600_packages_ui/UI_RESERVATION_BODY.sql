CREATE OR REPLACE PACKAGE BODY UI_RESERVATION AS
    -- Page principale
     --ProcÈdure d'ajout de rÈservation

     
  PROCEDURE ADDRESERVATION (vdatesel in varchar2 default to_date(sysdate,'YYYY-MM-DD')) AS
    test1 integer;
    test2 integer;
  	id_adh integer;
    nom_adh varchar2(128);
    prenom_adh varchar2(128);
    creneau varchar(128);
    --dateresa varchar2(128) default to_char(sysdate,'DD/MM/YY');
    --horaire creneau.horaire_creneau%type;
    nom_terrain terrain.nom_terrain%type;
     cursor infos_user is 
                select 
                         prs.nom_personne
                        ,prs.prenom_personne
                from 
                    personne prs
                where 
                    prs.NUMERO_PERSONNE = id_adh;
    cursor terrains_types is 
                            select 
                                    ter.* 
                            from 
                                    TYPE_TERRAIN ter;
    cursor terrains is 
                            select 
                                    * 
                            from 
                                    terrain
                            join 
                                    TYPE_TERRAIN 
                            using
                                    (NUM_TYPE_TERRAIN) 
                            order by 
                                    NOM_TERRAIN;
    --cursor nb_creneaux is select count(date_creneau) as nb from creneau where date_creneau=to_char(sysdate,'DD/MM/YY') and nom_terrain=nom_terrain;
    cursor creneaux is 
                            select 
                                    crn.* 
                            from 
                                    creneau crn 
                            where 
                                crn.date_creneau = TO_DATE(to_char(to_date(vdatesel,'YYYY-MM-DD'),'DD/MM/YY'),'DD/MM/YY') 
                            order by 
                                 crn.nom_terrain
                                ,crn.horaire_creneau;

    begin
    htp.htmlOpen;
    htp.headOpen;
    /*htp.print('<script type="texte/javascript">
    function getdate() {
        document.getElementById("date").value;
    }
    </script>');
    */
   -- dateresa := getdate();

    if(test_cookie = 1) then
      -- AdhÃ©rent : rÃ©cupÃ©ration des infos :
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
        htp.print('<h3 align=center>Ajouter une réservation</h3>');
            htp.formopen(owa_util.get_owa_service_path || 'ui_reservation.addreservation','POST');
            htp.tableopen;
            htp.tablerowopen;
            --htp.tableRowOpen;
            htp.tableData('Date :');
            htp.print('<td><input  onchange="this.form.submit()" type="date" id="vdatesel" name="vdatesel" value="'||to_char(to_date(vdatesel,'YYYY-MM-DD'),'YYYY-MM-DD')||'"/></td>');
            --htp.Tabledata(htf.formtext(cname=>'vdate'));
            --htp.tableRowClose;
            htp.tableRowClose;
            htp.formclose;
        
          htp.formopen(owa_util.get_owa_service_path || 'pa_reservation.ADDRESERVATION_REQ','POST');
          htp.tableopen;
          htp.tablerowopen;
         --Choix de la date
            /*htp.tableRowOpen;
            htp.tableData('Date :');*/
            htp.print('<td><input hidden="true" type="date" id="date" name="vdate" value="'||to_char(to_date(vdatesel,'YYYY-MM-DD'),'YYYY-MM-DD')||'"/></td>');
            --htp.Tabledata(htf.formtext(cname=>'vdate'));
            htp.tableRowOpen;
            --Choix de l'heure
            htp.tableData('Heure de début :');
            htp.print('<td>');
            htp.formselectopen('vheured','');
            for i in 8..20 loop
                htp.formselectoption(cvalue=>i||'h00', cattributes=>'SELECTED=''SELECTED'' VALUE='||i);

              htp.print('</option>');

            end loop;
            htp.print('</select></td>');
            htp.tableRowClose;


            htp.tableRowOpen;
            htp.tableData('Durée :');
            htp.print('<td>');
            htp.formselectopen('vduree','');
            for i in 1..3 loop
                htp.formselectoption(cvalue=>i||'h', cattributes=>'VALUE='||i);
                htp.print('</option>');

            end loop;
            htp.print('</select></td>');
            htp.tableRowClose;

         htp.tableRowOpen;
          htp.tableData('Nom terrain :');
          htp.print('<td>');
          htp.formselectopen('vtype','');
          for curs_type in terrains loop
             htp.formselectoption(cvalue=>curs_type.NOM_TERRAIN, cattributes=>'VALUE='||curs_type.NOM_TERRAIN);
             htp.print('</option>');
          end loop;
          htp.print('</select></td>');
          htp.tableRowClose;



          htp.tablerowopen;
          htp.tabledata;
          htp.print('<td>');htp.formsubmit(cvalue => 'Ajouter');htp.print('</td>');
          htp.tablerowclose;
          htp.tableclose;
          htp.formclose;
          
        htp.tableopen();
        htp.tablerowopen;
        htp.tableheader('Horaires');
        for terr in terrains loop
            htp.tableheader(terr.nom_terrain || '-'||terr.designation_type_terrain);
        end loop;
        htp.tablerowclose;

        test1 :=0;
        test2:=0;
       for i in 8..20 loop
            htp.tablerowopen;
            htp.tabledata(i|| 'h00', cattributes => 'width=10%');
            
            for terr in terrains loop
                nom_terrain := terr.nom_terrain;
                --htp.tableData('');
                -- if (to_char(to_date(to_char(sysdate,'MM/DD/YY') || ' '|| i ||':00:00','MM/DD/YY HH24:MI:SS'),'HH24') = '07') then 
                --        htp.tableData('');
                 --   end if;
               
                for m in creneaux loop
                    --htp.tableData('RÃ©servÃ©');
                    if (terr.nom_terrain = m.nom_terrain) then
                        if (m.duree_creneau >= 1) then
                            if (to_char(to_date(to_char(sysdate,'MM/DD/YY') || ' '|| i ||':00:00','MM/DD/YY HH24:MI:SS'),'HH24') = to_char( (m.horaire_creneau),'HH24')) then 
                              --htp.tableData('Reserve');
                              htp.print('<td style="background-color: brown;"></td>'); 
                              test2 := test2 +1;
                            end if;
                        end if;
                        if (m.duree_creneau >= 2) then
                            if (to_char(to_date(to_char(sysdate,'MM/DD/YY') || ' '|| i ||':00:00','MM/DD/YY HH24:MI:SS'),'HH24')+0 = to_char( m.horaire_creneau,'HH24')+1) then 
                              --htp.print('<td rowspan="2" style="background-color: brown;"></td>');
                              htp.print('<td style="background-color: brown;"></td>');
                              test2 := test2 +1;
                            end if;
                        end if;
                        if (m.duree_creneau = 3) then
                            if (to_char(to_date(to_char(sysdate,'MM/DD/YY') || ' '|| i ||':00:00','MM/DD/YY HH24:MI:SS'),'HH24')+0 = to_char( m.horaire_creneau,'HH24')+2) then 
                              --htp.print('<td rowspan="3" style="background-color: brown;"></td>');
                              htp.print('<td style="background-color: brown;"></td>');
                             test2 := test2 +1;
                            end if;
                        end if;
                    else
                         test1 := 1;
                    end if;  
                       /* if (m.duree_creneau = 2) then 
                            htp.tableData('RÃ©servÃ©');
                        end if*/
                    -- end if;   

                    --creneau:= m.horaire_creneau;
                end loop;
                 --htp.tableData(creneau);
                if (test1 = 1 and test2 = 0) then
                    htp.tableData('');
                    test1 := 0;
                else
                    test2 := test2 -1;
                end if;
            end loop;
            
            htp.tablerowclose;
        end loop;
            


        htp.tableclose;
    end if;

    htp.print( '</main>' );
    htp.print( '</div>' );

    ui_html.html_footer;
    htp.bodyClose;
    htp.htmlClose;
    end ADDRESERVATION;

    PROCEDURE LISTERESERVATION AS

    id_num_resa integer;
    id_adh integer;
    nom_adh varchar2(128);
    prenom_adh varchar2(128);
    h varchar2(5);
    cursor infos_user is 
                select 
                         prs.nom_personne
                        ,prs.prenom_personne
                from 
                    personne prs
                where 
                    prs.NUMERO_PERSONNE = id_adh;
    cursor liste_reservation is 
                select 
                         numero_reservation
                        ,date_creneau
                        ,duree_creneau
                        ,horaire_creneau
                        ,prix_reservation
                        ,creneau.NOM_terrain 
                from 
                        RESERVATION 
                join 
                        creneau 
                using
                        (date_creneau
                        ,horaire_creneau) 
                where 
                        NUMERO_PERSONNE = get_id_personne 
                and 
                        horaire_creneau >= sysdate 
                order by 
                         date_creneau
                        ,horaire_creneau;
    cursor reservation_ant is 
                select 
                         date_creneau
                        ,duree_creneau
                        ,horaire_creneau
                        ,prix_reservation
                        ,creneau.NOM_terrain 
                from 
                        RESERVATION 
                join 
                        creneau 
                using
                        (date_creneau
                        ,horaire_creneau) 
                where 
                        NUMERO_PERSONNE = get_id_personne 
                and 
                        horaire_creneau < sysdate 
                order by 
                         date_creneau
                        ,horaire_creneau;
    cursor liste_participant is 
                    select 
                            * 
                    from 
                            PERSONNE 
                    join 
                            participer 
                    using 
                            (numero_personne) 
                    where 
                            numero_personne !=get_id_personne;
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
        if(test_cookie = 0) then
            htp.print();
        else
            -- A EDITER SELON LES PACKAGES

                 htp.print('<h3 align=center>Mes réservations à venir</h3>');
                  htp.print('<br>');

                  htp.tableOpen(cattributes => 'width=100%');
                  htp.tableRowOpen;
                  htp.tableheader('Date');
                  htp.tableheader('Heure');
                  htp.tableheader('Durée');
                  htp.tableheader('Terrain');
                  htp.tableheader('Prix');
                  /*htp.tableheader('Participant');*/
                  htp.tableheader('');
                  htp.tableheader('');
                  htp.tableRowClose;

                for i in liste_reservation loop
                  id_num_resa:=id_num_resa;
                  htp.tableRowOpen;
                  htp.tableData(to_char(i.DATE_CRENEAU, 'DD/MM/YY'));
                  htp.tableData(replace(to_char(i.HORAIRE_CRENEAU, 'HH24:MI'),':','h'));
                  htp.tableData(i.duree_creneau||'h');
                 /* if(i.HORAIRE_CRENEAU='.5') then
                    h:=replace(i.HORAIRE_CRENEAU,'.5','0h30');
                  elsif(instr(i.HORAIRE_CRENEAU,'.5')!=0) then
                    h:=replace(i.HORAIRE_CRENEAU,'.5','h30');
                  else h:=i.HORAIRE_CRENEAU||'h';
                  end if;*/

                 /* htp.tableData(h, cattributes => 'align=center');
                  htp.tableData(i.lib_ter||' ('||i.lib_surface_ter||')', cattributes => 'align=center');
                  htp.print('<td align=center>');*/

                  htp.print('</td>');
                  --htp.tableData( to_char(i.HORAIRE_CRENEAU, 'HH24:MI')||'', cattributes => 'align=center');

                  htp.tableData(i.NOM_TERRAIN||'');
                  htp.tableData(i.PRIX_RESERVATION||' €');
                  /*for j in liste_participant loop
                    htp.print(j.nom_personne ||' ');
                    end loop;*/
                  htp.tableData(htf.anchor('ui_reservation.updatereservation?id=' || i.numero_reservation,'edit'));
                  htp.tableData(htf.anchor('pa_reservation.delreservation_req?res=' || i.numero_reservation,'delete'));
                  htp.tableRowClose;

                end loop;
                htp.tableClose;
                htp.anchor('ui_reservation.addreservation',' Ajouter une réservation');
                htp.print('<br>');
                htp.print('<br>');
                htp.print('<h3 align=center>Mes anciennes réservations</h3>');
                htp.print('<br>');

                htp.tableOpen(cattributes => 'width=100%');
                  htp.tableRowOpen;
                  htp.tableheader('Date');
                  htp.tableheader('Heure');
                  htp.tableheader('Durée');
                  htp.tableheader('Terrain');
                  htp.tableheader('Prix');
                  htp.tableheader('');
                  htp.tableheader('');
                  htp.tableRowClose;
                 for i in reservation_ant loop
                  id_num_resa:=id_num_resa;
                  htp.tableRowOpen;
                  htp.tableData(to_char(i.DATE_CRENEAU, 'DD/MM/YY'));
                  htp.tableData(replace(to_char(i.HORAIRE_CRENEAU, 'HH24:MI'),':','h'));
                  htp.tableData(i.duree_creneau||'h');

                 /* htp.tableData(h, cattributes => 'align=center');
                  htp.tableData(i.lib_ter||' ('||i.lib_surface_ter||')', cattributes => 'align=center');
                  htp.print('<td align=center>');*/

                  htp.print('</td>');
                  --htp.tableData( to_char(i.HORAIRE_CRENEAU, 'HH24:MI')||'', cattributes => 'align=center');

                  htp.tableData(i.NOM_TERRAIN||'');
                  htp.tableData(i.PRIX_RESERVATION||' €');
                  /*htp.tableData(htf.anchor('ui_reservation.updatereservation?id=' || i.numero_reservation,'edit'));
                  htp.tableData(htf.anchor('pa_resaterrain.delreservation_req?res=' || i.numero_reservation,'delete'));*/
                  htp.tableRowClose;

                end loop;

              htp.tableClose;
        end if;

        htp.print( '</main>' );
        htp.print( '</div>' );

        ui_html.html_footer;
        htp.bodyClose;
        htp.htmlClose;
    END LISTERESERVATION;

    --Update d'un terrain de tennis
	procedure updatereservation (id in number) as
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
                    prs.NUMERO_PERSONNE = id_adh;
    cursor reservations is 
                            select 
                                    * 
                            from 
                                RESERVATION 
                            join 
                                creneau 
                            using
                                (date_creneau,horaire_creneau) 
                            where 
                                NUMERO_RESERVATION = id;

    cursor terrains is 
                            select 
                                    * 
                            from 
                                    terrain
                            join 
                                    TYPE_TERRAIN 
                            using
                                    (NUM_TYPE_TERRAIN) 
                            order by 
                                    NOM_TERRAIN;

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
    for i in reservations loop        

      htp.print('<h3 align=center>Modifier une réservation</h3>');
        htp.formopen(owa_util.get_owa_service_path || 'PA_RESERVATION.UPDATERESERVATION_REQ','POST', cattributes=>'name="formupdater"');


          htp.formhidden('vnumresa',cvalue=>i.numero_reservation);
          htp.formhidden('vnumfact',cvalue=>i.numero_facture);
          
          htp.tableopen;
         --Choix de la date
            htp.tableRowOpen;
            htp.tableData('Date :');
            
            htp.print('<td><input type="date" name="vdate" value="'||TO_CHAR(i.date_creneau,'YYYY-MM-DD')||'"/></td>');
            
            htp.tablerowclose;
            --Choix de l'heure
            htp.tableRowOpen;
            htp.tableData('Heure de début :');
            htp.print('<td>');
            htp.formselectopen('vheured','');
            for j in 8..20 loop
              htp.formselectoption(cvalue=>j||'h00', cattributes=>'SELECTED=''SELECTED'' VALUE='||j);
              
              htp.print('</option>');

            end loop;
            htp.print('</select></td>');
            htp.tableRowClose;


            htp.tableRowOpen;
            htp.tableData('Durée :');
            htp.print('<td>');
            htp.formselectopen('vduree','');
            for f in 1..3 loop
              if(i.DUREE_CRENEAU = f) then
                htp.formselectoption(cvalue=>f||'h',cselected=>'TRUE', cattributes=>'VALUE='||f);
                htp.print('</option>');
              end if;
              if(i.DUREE_CRENEAU != f) then
                htp.formselectoption(cvalue=>f||'h', cattributes=>'VALUE='||f);
                htp.print('</option>');
              end if;
              /*
              if(i!=3) then
                htp.formselectoption(cvalue=>i||'h30', cattributes=>'VALUE='||i||'.5');
                htp.print('</option>');
              end if;*/
            end loop;
            htp.print('</select></td>');
            htp.tableRowClose;

        htp.tableRowOpen;
          htp.tableData('Type :');
          htp.print('<td>');
          htp.formselectopen('vtype','');
          for curs_type in terrains loop
             htp.formselectoption(cvalue=>curs_type.NOM_TERRAIN, cattributes=>'VALUE='||curs_type.NOM_TERRAIN);
             htp.print('</option>');
          end loop;

          
     
         /* htp.tablerowopen;
          htp.tableData('Durée validité :');
          htp.tableData(htf.formText('vval', 3,3,i.DUREE_VAL_FORFAIT));
          htp.tablerowclose;*/

          htp.tablerowopen;
          htp.tabledata;
          htp.print('<td><input type="button" value="MAJ" onClick="document.formupdater.submit();"/></td>');

          htp.tablerowclose;
        htp.tableclose;
        htp.formclose;

    end loop;

    htp.print( '</main>' );
    htp.print( '</div>' );

    ui_html.html_footer;
    htp.bodyClose;
    htp.htmlClose;
	end updatereservation;
END UI_RESERVATION;
/