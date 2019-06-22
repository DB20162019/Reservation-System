-- -----------------------------------------------------------------------------
--       TABLE : PERSONNE
-- -----------------------------------------------------------------------------

CREATE TABLE PERSONNE
   (
    NUMERO_PERSONNE NUMBER(4)  NOT NULL,
    NUMERO_NIVEAU NUMBER(4)  NOT NULL,
    NOM_PERSONNE VARCHAR2(40)  NOT NULL,
    PRENOM_PERSONNE VARCHAR2(40)  NOT NULL,
    NAISSANCE_PERSONNE DATE  NOT NULL,
    TELEPHONE_PERSONNE VARCHAR2(15)  NOT NULL,
    NUMERO_ADD_PERSONNE NUMBER(5)  NULL,
    RUE_PERSONNE VARCHAR2(30)  NULL,
    CP_PERSONNE VARCHAR2(7)  NULL,
    VILLE_PERSONNE VARCHAR2(30)  NULL,
    PAYS_PERSONNE VARCHAR2(30)  NULL,
    ROLE_PERSONNE VARCHAR2(20)  NOT NULL,
    USER_PERSONNE VARCHAR2(15)  NOT NULL,
    MDP_PERSONNE VARCHAR2(15)  NOT NULL,
    NUM_ENTRAINEUR NUMBER(2)  NULL,
    DATE_EMBAUCHE_ENTRAINEUR DATE  NULL,
    SALAIRE_ENTRAINEUR NUMBER(4)  NULL
,   CONSTRAINT PK_PERSONNE PRIMARY KEY (NUMERO_PERSONNE)  
   ) ;
   
   
   -- -----------------------------------------------------------------------------
--       TABLE : FACTURE
-- -----------------------------------------------------------------------------

CREATE TABLE FACTURE
   (
    NUMERO_FACTURE NUMBER(2)  NOT NULL,
    NUMERO_PERSONNE NUMBER(4)  NOT NULL,
    NUMERO_FORFAIT NUMBER(2)  NOT NULL,
    DATE_FACTURE DATE  NOT NULL,
    MONTANT_FACTURE NUMBER(4,2)  NOT NULL,
    DATE_SOUSCRIRE DATE  NULL
,   CONSTRAINT PK_FACTURE PRIMARY KEY (NUMERO_FACTURE)  
   ) ;
   
   -- -----------------------------------------------------------------------------
--       TABLE : FORFAIT
-- -----------------------------------------------------------------------------

CREATE TABLE FORFAIT
   (
    NUMERO_FORFAIT NUMBER(2)  NOT NULL,
    DESIGNATION_FORFAIT VARCHAR2(40)  NOT NULL,
    PRIX_FORFAIT NUMBER(13,2)  NOT NULL,
    NOMBRE_HEURE_FORFAIT NUMBER(3)  NOT NULL,
    DUREE_VAL_FORFAIT NUMBER(3)  NOT NULL
,   CONSTRAINT PK_FORFAIT PRIMARY KEY (NUMERO_FORFAIT)  
   ) ;
   
   
   -- -----------------------------------------------------------------------------
--       TABLE : ENTRAINEMENT
-- -----------------------------------------------------------------------------

CREATE TABLE ENTRAINEMENT
   (
    NUM_ENTRAINEMENT NUMBER(4)  NOT NULL,
    NOM_TERRAIN VARCHAR2(20)  NOT NULL,
    NUMERO_PERSONNE NUMBER(4)  NOT NULL,
    TYPE_ENTRAINEMENT VARCHAR2(30)  NOT NULL,
    FREQUENCE_ENTRAINEMENT CHAR(32)  NOT NULL,
    NBR_MAX_PARTICIPANTS NUMBER(2)  NOT NULL,
    DEBUT_ENTRAINEMENT DATE  NOT NULL,
    FIN_ENTRAINEMENT DATE  NOT NULL
,   CONSTRAINT PK_ENTRAINEMENT PRIMARY KEY (NUM_ENTRAINEMENT)  
   ) ;
   
   -- -----------------------------------------------------------------------------
--       TABLE : TYPE_TERRAIN
-- -----------------------------------------------------------------------------

CREATE TABLE TYPE_TERRAIN
   (
    NUM_TYPE_TERRAIN NUMBER(2)  NOT NULL,
    DESIGNATION_TYPE_TERRAIN VARCHAR2(50)  NOT NULL
,   CONSTRAINT PK_TYPE_TERRAIN PRIMARY KEY (NUM_TYPE_TERRAIN)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : TERRAIN
-- -----------------------------------------------------------------------------

CREATE TABLE TERRAIN
   (
    NOM_TERRAIN VARCHAR2(20)  NOT NULL,
    NUM_TYPE_TERRAIN NUMBER(2)  NOT NULL,
    DESCRIPTION_TERRAIN VARCHAR2(30)  NOT NULL
,   CONSTRAINT PK_TERRAIN PRIMARY KEY (NOM_TERRAIN)  
   ) ;

   -- -----------------------------------------------------------------------------
--       TABLE : CRENEAU
-- -----------------------------------------------------------------------------

CREATE TABLE CRENEAU
   (
    NOM_TERRAIN VARCHAR2(20)  NOT NULL,
    DATE_CRENEAU DATE  NOT NULL,
    HORAIRE_CRENEAU DATE  NOT NULL,
    NUM_ENTRAINEMENT NUMBER(4)  NULL,
    DUREE_CRENEAU NUMBER(1)  NOT NULL
,   CONSTRAINT PK_CRENEAU PRIMARY KEY (NOM_TERRAIN, DATE_CRENEAU, HORAIRE_CRENEAU)  
   ) ;

   -- -----------------------------------------------------------------------------
--       TABLE : RESERVATION
-- -----------------------------------------------------------------------------

CREATE TABLE RESERVATION
   (
    NUMERO_RESERVATION NUMBER(5)  NOT NULL,
    NUMERO_FACTURE NUMBER(2)  NULL,
    DATE_CRENEAU DATE  NOT NULL,
    HORAIRE_CRENEAU DATE  NOT NULL,
    NUMERO_PERSONNE NUMBER(4)  NOT NULL,
    NOM_TERRAIN VARCHAR2(20)  NOT NULL,
    DATE_RESERVATION DATE  NOT NULL,
    PRIX_RESERVATION NUMBER(2)  NOT NULL,
    NOM_PERSONNE VARCHAR2(40)  NOT NULL,
    PRENOM_PERSONNE VARCHAR2(40)  NOT NULL
,   CONSTRAINT PK_RESERVATION PRIMARY KEY (NUMERO_RESERVATION)  
   ) ;

   -- -----------------------------------------------------------------------------
--       TABLE : NIVEAU
-- -----------------------------------------------------------------------------

CREATE TABLE NIVEAU
   (
    NUMERO_NIVEAU NUMBER(4)  NOT NULL,
    NOM_NIVEAU VARCHAR2(20)  NOT NULL
,   CONSTRAINT PK_NIVEAU PRIMARY KEY (NUMERO_NIVEAU)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : PARTICIPER
-- -----------------------------------------------------------------------------

CREATE TABLE PARTICIPER
   (
    NUMERO_PERSONNE NUMBER(4)  NOT NULL,
    NUMERO_RESERVATION NUMBER(5)  NOT NULL
,   CONSTRAINT PK_PARTICIPER PRIMARY KEY (NUMERO_PERSONNE, NUMERO_RESERVATION)  
   ) ;

 -- -----------------------------------------------------------------------------
--       TABLE : ENTRAINER
-- -----------------------------------------------------------------------------

CREATE TABLE ENTRAINER
   (
    NUMERO_NIVEAU NUMBER(4)  NOT NULL,
    NUMERO_PERSONNE NUMBER(4)  NOT NULL
,   CONSTRAINT PK_ENTRAINER PRIMARY KEY (NUMERO_NIVEAU, NUMERO_PERSONNE)  
   ) ;

   -- -----------------------------------------------------------------------------
--       TABLE : SOUSCRIRE
-- -----------------------------------------------------------------------------

CREATE TABLE SOUSCRIRE
   (
    NUMERO_PERSONNE NUMBER(4)  NOT NULL,
    NUMERO_FORFAIT NUMBER(2)  NOT NULL
,   CONSTRAINT PK_SOUSCRIRE PRIMARY KEY (NUMERO_PERSONNE, NUMERO_FORFAIT)  
   ) ;
   
   -- -----------------------------------------------------------------------------
--       TABLE : ASSISTER
-- -----------------------------------------------------------------------------

CREATE TABLE ASSISTER
   (
    NUMERO_PERSONNE NUMBER(4)  NOT NULL,
    NUM_ENTRAINEMENT NUMBER(4)  NOT NULL
,   CONSTRAINT PK_ASSISTER PRIMARY KEY (NUMERO_PERSONNE, NUM_ENTRAINEMENT)  
   ) ;

   
   