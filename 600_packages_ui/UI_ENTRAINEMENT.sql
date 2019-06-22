CREATE OR REPLACE PACKAGE UI_ENTRAINEMENT AS 
     
     PROCEDURE LISTEMESENTRAINEMENT ;
     PROCEDURE LISTEENTRAINEMENT;
     PROCEDURE ADDENTRAINEMENT ;
     procedure UPDATEENTRAINEMENT (id in number);
     procedure listedesparticiapnts(id in number) ;
     procedure addparticipants (id in number);
     
END UI_ENTRAINEMENT;
/