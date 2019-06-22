CREATE OR REPLACE PACKAGE PA_ENTRAINEMENT AS
    procedure UPDATEENTRAINEMENT(vnument in NUMBER , vnomterrain in VARCHAR2 default '', vnumpersonne in NUMBER , vtypeentr in VARCHAR2 default '' , vnbrmax in NUMBER , vdebutentr in VARCHAR2 default '', vfinentr in VARCHAR2 default '');
    procedure DELENTRAINEMENT(id in integer);
    procedure ADDENTRAINEMENT( vnomterrain in VARCHAR2, vnumpersonne in NUMBER , vtypeentr in VARCHAR2 , vnbrmax in NUMBER ,vdate in VARCHAR2 default '', vdebutentr in VARCHAR2 , vfinentr in VARCHAR2 , vlundi in VARCHAR2 default '' , vmardi in VARCHAR2 default '' , vmercredi in VARCHAR2 default '' , vjeudi in VARCHAR2 default '',vvendredi in VARCHAR2 default '', vsamedi in VARCHAR2 default '' ,vheured in number default 17 , vduree in number default 0 ) ;
    procedure addparticipant (vnument in number , vnumpersonne in number);
END PA_ENTRAINEMENT;
/