CREATE OR REPLACE PACKAGE BODY MP AS

  -- key must be exactly 8 bytes long
  c_encrypt_key varchar2(8) := 'TENNIS18';

  function encrypt (i_password varchar2) return varchar2 is
    v_encrypted_val varchar2(38);
    v_data          varchar2(38);
  begin
     -- Input data must have a length divisible by eight
   v_data := RPAD(i_password,(TRUNC(LENGTH(i_password)/8)+1)*8,CHR(0));

     DBMS_OBFUSCATION_TOOLKIT.DESENCRYPT(
        input_string     => v_data,
        key_string       => c_encrypt_key,
        encrypted_string => v_encrypted_val);
     return v_encrypted_val;
  end encrypt;

  function decrypt (i_password varchar2) return varchar2 is
    v_decrypted_val varchar2(38);
  begin
     DBMS_OBFUSCATION_TOOLKIT.DESDECRYPT(
        input_string     => i_password,
        key_string       => c_encrypt_key,
        decrypted_string => v_decrypted_val);
     return v_decrypted_val;
  end decrypt;


end mp;
/