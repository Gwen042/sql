-- 1. Quels sont les tickets qui comportent l’article d’ID 500, afficher le numéro de ticket uniquement ?

select v.numero_ticket
from ventes v 
where v.id_article = 50;

-- 2. Afficher les tickets du 15/01/2014.

select t.numero_ticket
from ticket t
where t.date_vente = "2014-01-15"; 

-- 3. Afficher les tickets émis du 15/01/2014 et le 17/01/2014.

select t.numero_ticket
from ticket t
where t.date_vente = "2014-01-15"
or t.DATE_VENTE = "2014-01-17";

-- 4. Editer la liste des articles apparaissant à 50 et plus exemplaires sur un ticket.

select a.id_article
, a.nom_article
, v.QUANTITE
from ventes v inner join ticket t on t.NUMERO_TICKET = v.NUMERO_TICKET
	inner join article a on v.ID_ARTICLE = a.ID_ARTICLE
where v.QUANTITE >= 50;

-- 5. Quelles sont les tickets émis au mois de mars 2014. 

select t.numero_ticket
, t.DATE_VENTE
from ticket t
where t.date_vente like "2014-03-%%";

-- 6. Quelles sont les tickets émis entre les mois de mars et avril 2014 ?

select t.numero_ticket
, t.DATE_VENTE
from ticket t
where t.date_vente between "2014-03-01" and "2014-04-30";

-- 7. Quelles sont les tickets émis au mois de mars et juin 2014 ?

select t.numero_ticket
, t.DATE_VENTE
from ticket t
where t.date_vente like "2014-03-%%" 
or t.DATE_VENTE like "2014-06-%%";

-- 8. Afficher la liste des bières classée par couleur. (Afficher l’id et le nom)

select a.id_article
, a.nom_article
-- , c.id_couleur
from couleur c right join article a on a.id_couleur = c.id_couleur
order by c.NOM_COULEUR
;

-- 9. Afficher la liste des bières n’ayant pas de couleur. (Afficher l’id et le nom)

select a.id_article
, a.nom_article
, c.id_couleur
from couleur c right join article a on a.id_couleur = c.id_couleur
where c.id_couleur is null
;

-- 10. Lister pour chaque ticket la quantité totale d’articles vendus. (Classer par quantité décroissante)

select a.id_article
, a.nom_article
, sum( v.QUANTITE) quantité_totale
from ventes v inner join ticket t on t.NUMERO_TICKET = v.NUMERO_TICKET
	inner join article a on v.ID_ARTICLE = a.ID_ARTICLE
group by a.ID_ARTICLE
, a.NOM_ARTICLE
order by quantité_totale desc
;

-- 11. Lister chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. (Classer par quantité décroissante)

