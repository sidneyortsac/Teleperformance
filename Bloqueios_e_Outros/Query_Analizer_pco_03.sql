SELECT AKD.AKD_FILIAL AS Fil_AKD,SD1.D1_FILIAL AS Fil_SD1,AKD.AKD_DATA AS sDia_AKD, SD1.D1_DTDIGIT AS sDia_SD1,
       CONVERT(varchar(10), CONVERT(date, AKD.AKD_DATA), 103) AS dDia_AKD,
       CONVERT(varchar(10), CONVERT(date, SD1.D1_DTDIGIT), 103) AS dDia_SD1, 
       AKD.AKD_HIST,
        SD1.D1_DOC AS NumNF_SD1,SD1.D1_ITEM AS Item, 
       CASE AKD.AKD_TPSALD WHEN 'RE' THEN - 1 * AKD.AKD_VALOR1 ELSE AKD.AKD_VALOR1 END AS Valor_AKD, SD1.D1_TOTAL AS TotNF_SD1, SD1.D1_VALIPI AS IPI_SD1, SD1.D1_ICMSRET AS IcmRet_SD1,
       SD1.D1_VALFRE AS Frete_SD1, -1*SD1.D1_DESC AS Desc_SD1, SD1.D1_TES AS Tes_SD1,	   
       LTRIM(RTRIM(AKD.AKD_CO)) + ' ** ' + AK5.AK5_DESCRI AS ContaDesc, 
       LTRIM(RTRIM(AKD.AKD_CC)) + ' ** ' + CTT.CTT_DESC01 AS CCustoDesc, AKD.AKD_CO AS Conta, 
       AKD.AKD_CC AS CCusto, AKD.AKD_TPSALD AS SaldoCod,AL2.AL2_DESCRI AS SaldoDesc, AKD.AKD_PROCES AS ProcesCod, 
       AK8.AK8_DESCRI AS ProcesDesc, 
       AKD.AKD_CHAVE AS Chave, AKD.AKD_USER AS Usuario,
	   SUBSTRING(akd.akd_data,5,2) as sMes, 
       (CASE WHEN SUBSTRING(akd.akd_data,5,2)='01' THEN 'Jan'
             WHEN SUBSTRING(akd.akd_data,5,2)='02' THEN 'Fev'
             WHEN SUBSTRING(akd.akd_data,5,2)='03' THEN 'Mar'
             WHEN SUBSTRING(akd.akd_data,5,2)='04' THEN 'Abr'
             WHEN SUBSTRING(akd.akd_data,5,2)='05' THEN 'Mai'
             WHEN SUBSTRING(akd.akd_data,5,2)='06' THEN 'Jun'
             WHEN SUBSTRING(akd.akd_data,5,2)='07' THEN 'Jul'
             WHEN SUBSTRING(akd.akd_data,5,2)='08' THEN 'Ago'
             WHEN SUBSTRING(akd.akd_data,5,2)='09' THEN 'Set'
             WHEN SUBSTRING(akd.akd_data,5,2)='10' THEN 'Out'
             WHEN SUBSTRING(akd.akd_data,5,2)='11' THEN 'Nov'
             WHEN SUBSTRING(akd.akd_data,5,2)='12' THEN 'Dez'
        ELSE 'Outro' END) Mes , 
       (CASE WHEN SUBSTRING(akd.akd_data,5,2) between '01' and '03' THEN 'Trim_01'
             WHEN SUBSTRING(akd.akd_data,5,2) between '04' and '06' THEN 'Trim_02'
             WHEN SUBSTRING(akd.akd_data,5,2) between '07' and '09' THEN 'Trim_03'
             WHEN SUBSTRING(akd.akd_data,5,2) between '10' and '12' THEN 'Trim_04'
        ELSE 'Outro' END) Trimestre

FROM    AKD010(NOLOCK) AS AKD 
        INNER JOIN AK5010(NOLOCK) AS AK5 
        ON AK5.AK5_CODIGO = AKD.AKD_CO
		INNER JOIN CTT010(NOLOCK) AS CTT 
		ON CTT.CTT_CUSTO = AKD.AKD_CC 
		INNER JOIN AL2010(NOLOCK) AS AL2 
		ON AL2.AL2_TPSALD = AKD.AKD_TPSALD 
		INNER JOIN AK8010(NOLOCK) AS AK8 
		ON AK8.AK8_CODIGO = AKD.AKD_PROCES
		INNER JOIN SD1010(NOLOCK) AS SD1
		ON LTRIM(RTRIM(SD1.D1_FILIAL+SD1.D1_DOC+SD1.D1_SERIE+D1_FORNECE+SD1.D1_LOJA+SD1.D1_COD+SD1.D1_ITEM)) = LTRIM(RTRIM(SUBSTRING(AKD.AKD_CHAVE,4,97)))
		
WHERE  (AKD.D_E_L_E_T_ = ' ') AND 
(AK5.D_E_L_E_T_ = ' ') AND 
(CTT.D_E_L_E_T_ = ' ') AND 
(AL2.D_E_L_E_T_ = ' ') AND 
(AK8.D_E_L_E_T_ = ' ') AND 
(AK5.AK5_FILIAL = ' ') AND
(SD1.D_E_L_E_T_ = ' ') AND
(AKD.AKD_CHAVE <> ' ') AND
(AKD_DATA = '20170904') AND
(SD1.D1_DOC = '000751134')
ORDER BY SD1.D1_ITEM