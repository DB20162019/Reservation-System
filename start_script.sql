define dir=./

--schema réalisé par le prof
--@&dir\100_schema\109_drop_schema_cascade.sql
--@&dir\100_schema\100_create_schema.sql
--@&dir\100_schema\101_grant_schema.sql
--@&dir\100_schema\102_connect_schema.sql

--structure_base_donnee
@&dir\200_structure_base_donnee\290_drop_table_cascade.sql
&dir\200_structure_base_donnee\291_purge_recyclebin.sql
@&dir\200_structure_base_donnee\200_create_table.sql
@&dir\200_structure_base_donnee\220_create_fk.sql
@&dir\200_structure_base_donnee\245_create_view.sql
@&dir\200_structure_base_donnee\240_create_sequence.sql



--optimisation_access
@&dir\400_optimisation_acces\400_create_index.sql


--packages_databases
@&dir\500_packages_databases\MP.sql
@&dir\500_packages_databases\MP_BODY.sql
@&dir\500_packages_databases\PA_ENTRAINEMENT.sql
@&dir\500_packages_databases\PA_ENTRAINEMENT_BODY.sql
@&dir\500_packages_databases\PA_PERSONNE.sql
@&dir\500_packages_databases\PA_PERSONNE_BODY.sql
@&dir\500_packages_databases\PA_REGLEMENT.sql
@&dir\500_packages_databases\PA_REGLEMENT_BODY.sql
@&dir\500_packages_databases\PA_RESERVATION.sql
@&dir\500_packages_databases\PA_RESERVATION_BODY.sql
@&dir\500_packages_databases\PA_TERRAIN.sql
@&dir\500_packages_databases\PA_TERRAIN_BODY.sql


--insertion_donnee
@&dir\300_insertion_donnee\300_insert_data.sql
--@&dir\300_insertion_donnee\390_delete_data.sql






--packages_ui
@&dir\600_packages_ui\UI_ENTRAINEMENT.sql
@&dir\600_packages_ui\UI_ENTRAINEMENT_BODY.sql
@&dir\600_packages_ui\UI_FACTURE.sql
@&dir\600_packages_ui\UI_FACTURE_BODY.sql
@&dir\600_packages_ui\UI_HTML.sql
@&dir\600_packages_ui\UI_HTML_BODY.sql
@&dir\600_packages_ui\UI_PERSONNE.sql
@&dir\600_packages_ui\UI_PERSONNE_BODY.sql
@&dir\600_packages_ui\UI_REGLEMENT.sql
@&dir\600_packages_ui\UI_REGLEMENT_BODY.sql
@&dir\600_packages_ui\UI_RESERVATION.sql
@&dir\600_packages_ui\UI_RESERVATION_BODY.sql
@&dir\600_packages_ui\UI_TERRAIN.sql
@&dir\600_packages_ui\UI_TERRAIN_BODY.sql

--creation du DAD
@&dir\200_structure_base_donnee\260_create_dad.sql
/