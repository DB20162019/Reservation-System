CREATE OR REPLACE PACKAGE PA_REGLEMENT AS

  PROCEDURE addforfait_req (vnom in varchar2, vprix in number, vnbh in number,vval in number);
  PROCEDURE updateforfait_req (vid in number, vnom in varchar2, vprix in number, vnbh in number,vval in number);
  PROCEDURE delforfait_req(id in number);
  procedure souscription_req(vpersonne in number,vforfait in number);

END PA_REGLEMENT;
/