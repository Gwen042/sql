-- 1. Quels sont les tickets qui comportent l’article d’ID 500, afficher le numéro de ticket uniquement ?

select t.NUMERO_TICKET
from ticket t,
article a,
ventes v
where t.NUMERO_TICKET = v.NUMERO_TICKET
and v.ID_ARTICLE = a.ID_ARTICLE 
and a.id_article = 50;

select t.numero_ticket
from ventes v inner join ticket t on t.NUMERO_TICKET = v.NUMERO_TICKET
	inner join article a on v.ID_ARTICLE = a.ID_ARTICLE 
where a.id_article = 50;