-- -----------------------------------------------------------------------------
--       VUE : PERSONNE_ENTRAINEUR
-- -----------------------------------------------------------------------------

CREATE VIEW PERSONNE_ENTRAINEUR  (NUMERO_PERSONNE, NUMERO_NIVEAU, NOM_PERSONNE, PRENOM_PERSONNE, NAISSANCE_PERSONNE, TELEPHONE_PERSONNE, NUMERO_ADD_PERSONNE, RUE_PERSONNE, CP_PERSONNE, VILLE_PERSONNE, PAYS_PERSONNE, ROLE_PERSONNE, USER_PERSONNE, MDP_PERSONNE, NUM_ENTRAINEUR, DATE_EMBAUCHE_ENTRAINEUR, SALAIRE_ENTRAINEUR) AS
SELECT PERSONNE.NUMERO_PERSONNE, PERSONNE.NUMERO_NIVEAU, PERSONNE.NOM_PERSONNE, PERSONNE.PRENOM_PERSONNE, PERSONNE.NAISSANCE_PERSONNE, PERSONNE.TELEPHONE_PERSONNE, PERSONNE.NUMERO_ADD_PERSONNE, PERSONNE.RUE_PERSONNE, PERSONNE.CP_PERSONNE, PERSONNE.VILLE_PERSONNE, PERSONNE.PAYS_PERSONNE, PERSONNE.ROLE_PERSONNE, PERSONNE.USER_PERSONNE, PERSONNE.MDP_PERSONNE, PERSONNE.NUM_ENTRAINEUR, PERSONNE.DATE_EMBAUCHE_ENTRAINEUR, PERSONNE.SALAIRE_ENTRAINEUR
FROM PERSONNE ;