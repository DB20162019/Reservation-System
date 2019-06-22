-- ===================================================================================================================
--							SUPPRESSION DES DATA
-- ===================================================================================================================


--- CRENEAUX

delete from CRENEAU CRE where CRE.NUM_ENTRAINEMENT = 59 ;

--- ASSISTER
        
delete from ASSISTER ASSI where ASSI.NUM_ENTRAINEMENT = 59; 

--- ENTRAINEMENTS

delete from ENTRAINEMENT ENT where ENT.NUM_ENTRAINEMENT = 59; 

--- FACTURES
   
delete from FACTURE fact where fact.NUMERO_PERSONNE = 0;
  
--- SOUSCRIRE
      
delete from SOUSCRIRE SOUS where SOUS.NUMERO_PERSONNE = 0  ;

--- RESERVATIONS
      
delete from Reservation res where res.NUMERO_FACTURE = 0;

---- PERSONNES

delete from personne pers where pers.NUMERO_PERSONNE = 0 ;     