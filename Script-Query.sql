select v.id_vehicle, 
	m.name as model, 
	b.name as brand, 
	cg.name as company_group,
	v.purchase_date,
	v.registration_number,
	v.kms,
	i.name as insurance,
	v.insurance_number 
from vk.vehicles v, 
	vk.models m, 
	vk.brands b, 
	vk.company_groups cg,
	vk.insurances i 
where v.id_model = m.id_model 
and m.id_brand = b.id_brand 
and b.id_company_group = cg.id_company_group 
and v.id_insurance = i.id_insurance 
