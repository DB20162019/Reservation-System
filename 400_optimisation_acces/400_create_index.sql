-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PERSONNE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PERSONNE_NIVEAU
     ON PERSONNE (NUMERO_NIVEAU ASC)
    ;



-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE FACTURE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_FACTURE_PERSONNE
     ON FACTURE (NUMERO_PERSONNE ASC)
    ;

CREATE  INDEX I_FK_FACTURE_FORFAIT
     ON FACTURE (NUMERO_FORFAIT ASC)
    ;





-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ENTRAINEMENT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_ENTRAINEMENT_TERRAIN
     ON ENTRAINEMENT (NOM_TERRAIN ASC)
    ;

CREATE  INDEX I_FK_ENTRAINEMENT_PERSONNE
     ON ENTRAINEMENT (NUMERO_PERSONNE ASC)
    ;


-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE TERRAIN
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_TERRAIN_TYPE_TERRAIN
     ON TERRAIN (NUM_TYPE_TERRAIN ASC)
    ;


-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CRENEAU
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CRENEAU_TERRAIN
     ON CRENEAU (NOM_TERRAIN ASC)
    ;

CREATE  INDEX I_FK_CRENEAU_ENTRAINEMENT
     ON CRENEAU (NUM_ENTRAINEMENT ASC)
    ;


-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE RESERVATION
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_RESERVATION_FACTURE
     ON RESERVATION (NUMERO_FACTURE ASC)
    ;

CREATE UNIQUE INDEX I_FK_RESERVATION_CRENEAU
     ON RESERVATION (NOM_TERRAIN ASC, DATE_CRENEAU ASC, HORAIRE_CRENEAU ASC)
    ;

CREATE  INDEX I_FK_RESERVATION_PERSONNE
     ON RESERVATION (NUMERO_PERSONNE ASC)
    ;


-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PARTICIPER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PARTICIPER_PERSONNE
     ON PARTICIPER (NUMERO_PERSONNE ASC)
    ;

CREATE  INDEX I_FK_PARTICIPER_RESERVATION
     ON PARTICIPER (NUMERO_RESERVATION ASC)
    ;


-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ENTRAINER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_ENTRAINER_NIVEAU
     ON ENTRAINER (NUMERO_NIVEAU ASC)
    ;

CREATE  INDEX I_FK_ENTRAINER_PERSONNE
     ON ENTRAINER (NUMERO_PERSONNE ASC)
    ;



-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE SOUSCRIRE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_SOUSCRIRE_PERSONNE
     ON SOUSCRIRE (NUMERO_PERSONNE ASC)
    ;

CREATE  INDEX I_FK_SOUSCRIRE_FORFAIT
     ON SOUSCRIRE (NUMERO_FORFAIT ASC)
    ;


-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ASSISTER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_ASSISTER_PERSONNE
     ON ASSISTER (NUMERO_PERSONNE ASC)
    ;

CREATE  INDEX I_FK_ASSISTER_ENTRAINEMENT
     ON ASSISTER (NUM_ENTRAINEMENT ASC)
    ;
