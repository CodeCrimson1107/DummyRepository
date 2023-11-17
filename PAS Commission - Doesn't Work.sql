use [duckcreek_datamart]
go
select 
ps.policy_number,
pa.name_first,
pa.name_last,
pa.email,
pa.phone,
pa.mailing_address1,
pa.mailing_city,
pa.mailing_postal_code_base,
pa.mailing_state
from PolicySummary(nolock) ps
left join party(nolock) pa on ps.FK_Policy_max_endorsement = pa.FK_Record
where 1=1
and role_key = 'Insured'
