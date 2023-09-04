

select distinct
hou.name                                          affiliate 
,hou.organization_id
--,HP.PARTY_NUMBER
,HP.party_Id
,HCA.cust_account_id
,HCA.ACCOUNT_NUMBER
,HP.PARTY_NAME
--,HP.TAX_REFERENCE                                 party_vat_reg_nbr
,HCA.ACCOUNT_NUMBER                               account_number
--,HCA.SALES_CHANNEL_CODE  
--,HPS.PARTY_SITE_NUMBER                            site_number
,HCASA.orig_system_reference
,HCASA.cust_acct_site_id
--,Substr(HCASA.orig_system_reference,1,Instr(HCASA.orig_system_reference,'-')-1) BILL_TO_ORG_SYS_REF
,HCASA.status                                     site_status
,HCSUA.site_use_code                              site_use
,HCSUA.GL_ID_REV
,HCA.status
--,HCSUA.tax_code                                   site_use_tcc
--,HCSUA.TAX_REFERENCE                              site_use_vat_reg_nbr
--,HCSUA.status                                     use_status
--,HCSUA.LOCATION                                   site_use_location
--,HCSUA2.LOCATION                                  linked_billing_location
--,decode(HCA.SALES_CHANNEL_CODE, '01', 'PHARMACIES', '02', 'HOSPITALS', '03', 'GROSSISTES', HCA.SALES_CHANNEL_CODE)   SALES_CHANNEL_DESCRIPTION --                        sales_ch
,HCA.SALES_CHANNEL_CODE
,hca.creation_date
--,hca.last_update_date
--,HCA.ATTRIBUTE20 SIRET
--,HCASA.ATTRIBUTE1                                 cip6
--,HCASA.ATTRIBUTE2                                 cip7
--,HCASA.ATTRIBUTE3                                 uag
,HL.ADDRESS1
,HL.ADDRESS2
--,HL.ADDRESS3
,HL.POSTAL_CODE
,HL.CITY
,HL.LAST_UPDATE_DATE
--,HL.STATE
--,HL.PROVINCE
--,HL.COUNTRY
from
apps.HZ_PARTIES                                              HP
,apps.HZ_CUST_ACCOUNTS                                        HCA
,apps.HZ_PARTY_SITES                                          HPS
,apps.HZ_CUST_ACCT_SITES_ALL                                  HCASA
,apps.HZ_CUST_SITE_USES_ALL                                   HCSUA
,apps.HZ_CUST_SITE_USES_ALL                                   HCSUA2
,apps.HZ_LOCATIONS                                            HL
,apps.hr_all_organization_units                               HOU
where 1=1
AND HP.party_Id                 = HCA.party_Id
AND HP.party_id                 = HPS.party_id
AND HPS.party_site_id           = HCASA.party_site_id
AND HCA.cust_account_id         = HCASA.cust_account_id
AND HCASA.cust_acct_site_id     = HCSUA.cust_acct_site_id (+)
AND HCASA.org_id                = HOU.organization_id
AND HPS.location_id             = HL.location_id
AND HCSUA.bill_to_site_use_id   = HCSUA2.site_use_id (+)
and HCASA.org_id = 325--!= 8689
AND HL.COUNTRY = 'LU'
--AND HCA.SALES_CHANNEL_CODE = '11'
--AND HCASA.status = 'A'
--AND HCSUA.status  = 'A'
--AND HCA.status = 'I'
--AND HCSUA.site_use_code         = 'SHIP_TO'
AND HCSUA.site_use_code         = 'BILL_TO'
--AND HCA.Account_number  = '14477%'
--AND HCASA.orig_system_reference like '%DE1%'
And HCA.Account_number   like ( '%DE1')
--and HP.PARTY_NAME like '%BENU%'
--and HCA.SALES_CHANNEL_CODE       not in ('01','08')  --PHARMACIES
--and HCA.SALES_CHANNEL_CODE      = '08' -- Pharma --HOSPITALS
--and HCA.SALES_CHANNEL_CODE      = '03' --WHOLESALERS
--and HCA.Account_number = '100333DE1' --like '5%DE1' --'821961%DE1' --'23443DE1' 330122
--and HP.party_Id = '10074693'
--and (HCASA.ATTRIBUTE1 is not null or (HCASA.ATTRIBUTE2   is not null) or (HCASA.ATTRIBUTE3 is not null ))-- CIP
--and HCASA.orig_system_reference like '%DE1%'
--,HCASA.ATTRIBUTE2                                 cip7
--,HCASA.ATTRIBUTE3                                 uag
---and HCASA.orig_system_reference like '%18020%' --21913-10403DE1 
--and trunc(hca.creation_date) > '01-JAN-2022'
--and HCASA.orig_system_reference like '%306552%' --in ('22829-22829CFR','74454-74454CFR','92399-24019CFR','98509-25127CFR','86004-86004CFR','90872-90872CFR','90877-90877CFR','119536-119536CFR','86407-86407CFR','92145-92145CFR','60124-60124CFR','60123-60123CFR','140156-75888CFR','276338-24825CFR','130761-130761CFR','173762-60073CFR','413998-393696CFR','98955-98955CFR','24198-24198CFR','276774-276774CFR','441826-276775CFR','379924-379924CFR','81176-81176CFR','404797-404797CFR','433394-419286CFR','463852-463852CFR','131364-131364CFR','60461-60461CFR','163835-163835CFR','92474-92474CFR','59390-59390CFR')
--and HP.PARTY_NAME like '%Biogen%'
--and HL.CITY = 'HAGUENAU'
--AND USR.USER_NAME = 'EIPAPPSUSER'
--and hou.name  like '%Belgium%'
--and HCA.ATTRIBUTE20 is not null
--and HPS.ATTRIBUTE1 is not null
---and HCA.Account_number not like '%FRA'
order by  HL.LAST_UPDATE_DATE desc --HCA.ACCOUNT_NUMBER

----- Have we got some sales activities against 11?
select distinct 
BS.org_ID
,BS.*
,BS.CUSTOMER_NUMBER
,BS.CUSTOMER_NAME
,BS.CUST_SALES_CHANNEL_CODE
,BS.CUST_SALES_CHANNEL_DESC
from APPS.BIO_SHIPMENTS_V2 BS
where 1=1
and BS.org_ID = 321
and BS.CUST_SALES_CHANNEL_CODE = '11'

Found 222 in France but no orders
Found 2 in UK CONT0075460GBR CONT0071171GBR in UK, and last order 2018

AND BS.CUSTOMER_NUMBER = '112318DE1'

in ( '321655DE1',
'101791DE1',
'317861DE1',
'314099DE1',
'103967DE1',
'318377DE1',
'317951DE1',
'316898DE1',
'316942DE1',
'313565DE1',
'316819DE1',
'319320DE1',
'112318DE1',
'316966DE1',
'320511DE1')
--and rownum < 10*/



select distinct
hou.name                                          affiliate 
,hou.organization_id
,HCA.SALES_CHANNEL_CODE  
from
apps.HZ_PARTIES                                              HP
,apps.HZ_CUST_ACCOUNTS                                        HCA
,apps.HZ_PARTY_SITES                                          HPS
,apps.HZ_CUST_ACCT_SITES_ALL                                  HCASA
,apps.HZ_CUST_SITE_USES_ALL                                   HCSUA
,apps.HZ_CUST_SITE_USES_ALL                                   HCSUA2
,apps.HZ_LOCATIONS                                            HL
,apps.hr_all_organization_units                               HOU
where 1=1
AND HP.party_Id                 = HCA.party_Id
AND HP.party_id                 = HPS.party_id
AND HPS.party_site_id           = HCASA.party_site_id
AND HCA.cust_account_id         = HCASA.cust_account_id
AND HCASA.cust_acct_site_id     = HCSUA.cust_acct_site_id (+)
AND HCASA.org_id                = HOU.organization_id
AND HPS.location_id             = HL.location_id
AND HCSUA.bill_to_site_use_id   = HCSUA2.site_use_id (+)
AND HCA.SALES_CHANNEL_CODE = '11'
AND HCASA.status = 'A'
--and HCASA.org_id = 333--325--!= 8689
--AND HCSUA.site_use_code         = 'SHIP_TO'
AND HCSUA.site_use_code         = 'BILL_TO'
--and HP.PARTY_NAME like '%ROWLANDS%'
--and HCA.SALES_CHANNEL_CODE       not in ('01','08')  --PHARMACIES
--and HCA.SALES_CHANNEL_CODE      = '02' --HOSPITALS
--and HCA.SALES_CHANNEL_CODE      = '03' --WHOLESALERS
--and HCA.Account_number like '302440DE1' --'23443DE1'
--and HP.party_Id = '10074693'
--and (HCASA.ATTRIBUTE1 is not null or (HCASA.ATTRIBUTE2   is not null) or (HCASA.ATTRIBUTE3 is not null ))-- CIP
--and HCASA.orig_system_reference like '%318420DE1%'
--,HCASA.ATTRIBUTE2                                 cip7
--,HCASA.ATTRIBUTE3                                 uag
---and HCASA.orig_system_reference like '%18020%' --21913-10403DE1 
--and trunc(hca.creation_date) > '01-DEC-2021'
--and HCASA.orig_system_reference like '%306552%' --in ('22829-22829CFR','74454-74454CFR','92399-24019CFR','98509-25127CFR','86004-86004CFR','90872-90872CFR','90877-90877CFR','119536-119536CFR','86407-86407CFR','92145-92145CFR','60124-60124CFR','60123-60123CFR','140156-75888CFR','276338-24825CFR','130761-130761CFR','173762-60073CFR','413998-393696CFR','98955-98955CFR','24198-24198CFR','276774-276774CFR','441826-276775CFR','379924-379924CFR','81176-81176CFR','404797-404797CFR','433394-419286CFR','463852-463852CFR','131364-131364CFR','60461-60461CFR','163835-163835CFR','92474-92474CFR','59390-59390CFR')
--and HP.PARTY_NAME like '%Biogen%'
--and HL.CITY = 'HAGUENAU'
--AND USR.USER_NAME = 'EIPAPPSUSER'
--and hou.name  like '%Belgium%'
--and HCA.ATTRIBUTE20 is not null
--and HPS.ATTRIBUTE1 is not null
