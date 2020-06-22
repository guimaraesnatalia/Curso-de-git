function get_dtainiafast_s2200(p_anomes varchar2 , tpAdmissao number , p_cod_vinculo number  , p_tp_amb number , p_dtTransf date   ,  p_dtAltCPF date) return date as
     v_dtiniafast date;
     v_cod_seq_orgao admsfp.orgao.cod_seq_orgao%type ;
   begin
              --cod seq orgao
              select v.cod_seq_orgao into v_cod_seq_orgao from vinculo v where v.cod_vinculo  =  p_cod_vinculo ;
              v_dtiniafast := null ;
              if tpAdmissao <> 1 then  --Não informar se {tpAdmissao} = [1]. layout v 2.5 pagina 85 linha 207
               begin
                --afastado na data de início da obrigatoriedade dos eventos não periódicos para o empregador no eSocial
                 select dtiniafast  into v_dtiniafast --,
                        --codmotafast
                   from table( esocial.pkg_pl_esocial.PL_OBTER_S2230(:p_anomes , v_cod_seq_orgao , '99999999999'  , p_tp_amb ,p_cod_vinculo) )
                   where (:p_anomes =  to_char(to_date(:dta_ini_obrigatoriedade , 'dd/mm/yyyy') ,  'yyyymm'))
                   ;
                    if tpAdmissao in [2,3,4]  then
                      -- afastado na data de transferencia
                       select dtiniafast  into v_dtiniafast --,
                              --codmotafast
                         from table( esocial.pkg_pl_esocial.PL_OBTER_S2230(:p_anomes , v_cod_seq_orgao , '99999999999'  , p_tp_amb ,p_cod_vinculo) )
                            where p_dtTransf between dtiniafast and dttermafast
                         ;
                    end if;
                 if tpAdmissao in [6]  then
                -- alteração de CPF do empregado
                 select dtiniafast into v_dtiniafast --,
                        --codmotafast
                   from table( esocial.pkg_pl_esocial.PL_OBTER_S2230(:p_anomes , v_cod_seq_orgao , '99999999999'  , p_tp_amb ,p_cod_vinculo) )
                      where :p_dtAltCPF between dtiniafast and dttermafast
                   ;
                 end if ;
                end if;
               return v_dtiniafast ;
    end;
    function get_codMotivoAfast_s2200(p_anomes varchar2 , tpAdmissao number , p_cod_vinculo number  , p_tp_amb number , p_dtTransf date   ,  p_dtAltCPF date) return date as
     v_codmotafast number;
     v_cod_seq_orgao admsfp.orgao.cod_seq_orgao%type ;
   begin
              --cod seq orgao
             select v.cod_seq_orgao into v_cod_seq_orgao from vinculo v where v.cod_vinculo  =  p_cod_vinculo ;
             v_codmotafast := null ;
             if tpAdmissao <> 1 then  --Não informar se {tpAdmissao} = [1]. layout v 2.5 pagina 85 linha 207
                 begin
                  --afastado na data de início da obrigatoriedade dos eventos não periódicos para o empregador no eSocial
                   select --dtiniafast  into v_dtiniafast --,
                          codmotafast  into v_codmotafast
                     from table( esocial.pkg_pl_esocial.PL_OBTER_S2230(:p_anomes , v_cod_seq_orgao , '99999999999'  , p_tp_amb ,p_cod_vinculo) )
                     where (:p_anomes =  to_char(to_date(:dta_ini_obrigatoriedade , 'dd/mm/yyyy') ,  'yyyymm'))
                     ;
                  -- afastado na data de transferencia
                    if tpAdmissao in [2,3,4]  then
                       select --dtiniafast  into v_dtiniafast --,
                              codmotafast  into v_codmotafast
                         from table( esocial.pkg_pl_esocial.PL_OBTER_S2230(:p_anomes , v_cod_seq_orgao , '99999999999'  , p_tp_amb ,p_cod_vinculo) )
                            where p_dtTransf between dtiniafast and dttermafast
                         ;
                     end if;
                  -- alteração de CPF do empregado
                  if tpAdmissao in [6]  then
                   select --dtiniafast into v_dtiniafast --,
                           codmotafast into v_codmotafast
                     from table( esocial.pkg_pl_esocial.PL_OBTER_S2230(:p_anomes , v_cod_seq_orgao , '99999999999'  , p_tp_amb ,p_cod_vinculo) )
                        where :p_dtAltCPF between dtiniafast and dttermafast;
                  end if;
                 end;
              return  v_codmotafast ;
    end;