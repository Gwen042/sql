-- 1. Quels sont les tickets qui comportent l’article d’ID 500, afficher le numéro de ticket uniquement ?

select v.numero_ticket
from ventes v 
where v.id_article = 500;

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
from ventes v inner join article a on v.ID_ARTICLE = a.ID_ARTICLE
where v.QUANTITE >= 50;

-- 5. Quelles sont les tickets émis au mois de mars 2014. 

select t.numero_ticket
, t.DATE_VENTE
from ticket t
where t.date_vente like "2014-03-%";

-- 6. Quelles sont les tickets émis entre les mois de mars et avril 2014 ?

select t.numero_ticket
, t.DATE_VENTE
from ticket t
where t.date_vente between "2014-03-01" and "2014-04-30";

-- 7. Quelles sont les tickets émis au mois de mars et juin 2014 ?

select t.numero_ticket
, t.DATE_VENTE
from ticket t
where t.date_vente like "2014-03-%" 
or t.DATE_VENTE like "2014-06-%";

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
, a.id_couleur
from article a 
where a.id_couleur is null
;

-- 10. Lister pour chaque ticket la quantité totale d’articles vendus. (Classer par quantité décroissante)

/*select a.id_article
, a.nom_article
, sum( v.QUANTITE) quantité_totale
from ventes v inner join ticket t on t.NUMERO_TICKET = v.NUMERO_TICKET
	inner join article a on v.ID_ARTICLE = a.ID_ARTICLE
group by a.ID_ARTICLE
, a.NOM_ARTICLE
order by quantité_totale desc
;*/

select v.ID_ARTICLE
, sum(v.QUANTITE) quantité_totale
from ventes v
group by v.ID_ARTICLE
order by quantité_totale desc
;

-- 11. Lister chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. (Classer par quantité décroissante) utiliser que ventes

select  t.NUMERO_TICKET
, sum(v.QUANTITE) quantité_totale
from ventes v inner join ticket t on t.NUMERO_TICKET = v.NUMERO_TICKET
	inner join article a on v.ID_ARTICLE = a.ID_ARTICLE
 group by t.NUMERO_TICKET
 having sum(v.QUANTITE) > 500
 order by quantité_totale desc
;

-- 12. Lister chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. 
-- On exclura du total, les ventes ayant une quantité supérieure à 50 (classer par quantité décroissante)

select
v.NUMERO_TICKET
, sum(v.QUANTITE) quantité_totale
from ventes v 
where v.QUANTITE in
		(select
		v.QUANTITE
		from ventes v 
		where v.QUANTITE < 50)
group by v.NUMERO_TICKET
having quantité_totale > 500
order by quantité_totale desc
;

-- 13. Lister les bières de type ‘Trappiste’. (id, nom de la bière, volume et titrage)

select a.id_article
, a.nom_article
, a.volume
, a.titrage
-- , t.NOM_TYPE
from article a inner join beer.type t on a.ID_TYPE = t.ID_TYPE 
where t.nom_type = "Trappiste";

-- 14. Lister les marques de bières du continent ‘Afrique’

select m.NOM_MARQUE
from pays p inner join marque m on m.ID_PAYS = p.ID_PAYS
		inner join continent c on p.id_continent = c.id_continent
where c.NOM_continent = "Afrique"; 

-- 15. Lister les bières du continent ‘Afrique’

select distinct a.nom_article
from pays p inner join marque m on m.ID_PAYS = p.ID_PAYS
							inner join article a on a.ID_MARQUE = m.ID_MARQUE
			inner join continent c on p.id_continent = c.id_continent
where c.NOM_continent = "Afrique"; 

-- 16. Lister les tickets (année, numéro de ticket, montant total payé). En sachant que le prix
-- de vente est égal au prix d’achat augmenté de 15% et que l’on n’est pas assujetti à la TVA.

select v.annee
, v.NUMERO_TICKET
, sum((a.PRIX_ACHAT + (a.PRIX_ACHAT * 0.15)) * v.QUANTITE) montant_total
from ventes v inner join article a on v.id_article = a.id_article
group by v.ANNEE
, v.NUMERO_TICKET
;

-- 17. Donner le C.A. par année. 

select v.annee
, round (sum((a.PRIX_ACHAT + (a.PRIX_ACHAT * 0.15)) * v.QUANTITE), 2) CA
from ventes v inner join article a on v.id_article = a.id_article
group by v.ANNEE
;

-- 18. Lister les quantités vendues de chaque article pour l’année 2016.

select v.ID_ARTICLE
, sum(v.quantite) quantité_vendue
from ventes v
where v.ANNEE = 2016
group by v.ID_ARTICLE
order by v.ID_ARTICLE
;

-- 19. Lister les quantités vendues de chaque article pour les années 2014,2015 ,2016.

select v.annee
	, v.ID_ARTICLE
	, sum(v.quantite) quantité_vendue
from ventes v
where v.ANNEE = 2014
or v.ANNEE = 2015
or v.ANNEE = 2016
group by v.ANNEE
	, v.ID_ARTICLE
;

-- 20. Lister les articles qui n’ont fait l’objet d’aucune vente en 2014 

select distinct v.ID_ARTICLE
from ventes v
where v.ID_ARTICLE not in (select v1.ID_ARTICLE from ventes v1 where v1.ANNEE = 2014) 
;

-- 21. Coder de 3 manières différentes la requête suivante : Lister les pays qui fabriquent des bières de type ‘Trappiste’.

select distinct p.NOM_PAYS
-- , t.NOM_TYPE
from article a inner join beer.type t on a.ID_TYPE = t.ID_TYPE 
				inner join marque m on a.ID_MARQUE = m.ID_MARQUE
							inner join pays p on m.ID_PAYS = p.ID_PAYS
where t.nom_type = "Trappiste";

-- 2e façon:

select distinct p.nom_pays
from pays p
	, marque m
    , article a
    , type t
where p.ID_PAYS = m.ID_PAYS
and m.ID_MARQUE = a.ID_MARQUE
and t.ID_TYPE = a.ID_TYPE
and t.NOM_TYPE = "Trappiste";

-- 3e façon:

select p.NOM_PAYS
-- , t.NOM_TYPE
from article a inner join beer.type t on a.ID_TYPE = t.ID_TYPE 
				inner join marque m on a.ID_MARQUE = m.ID_MARQUE
							inner join pays p on m.ID_PAYS = p.ID_PAYS
where t.nom_type = "Trappiste"
group by p.NOM_PAYS
;

-- 22. Lister les tickets sur lesquels apparaissent un des articles apparaissant aussi sur le
-- ticket 2014-856 (le ticket 856 de l’année 2014)

select v.NUMERO_TICKET
from ventes v
where v.ID_ARTICLE in 
	(select v.ID_ARTICLE
    from ventes v
    where v.ANNEE = 2014
    and v.NUMERO_TICKET = 856)
;

-- 23. Lister les articles ayant un degré d’alcool plus élevé que la plus forte des trappistes.

select a.ID_ARTICLE
, a.NOM_ARTICLE
from article a inner join type t on a.id_type = t.id_type
where a.TITRAGE >
	(select max(a.TITRAGE)
    from article a inner join type t on a.id_type = t.id_type
    where t.NOM_TYPE = "Trappiste"
    )
;

-- 24. Editer les quantités vendues pour chaque couleur en 2014.

select c.nom_couleur
, sum(v.quantite) quantité_vendue
from article a inner join ventes v on a.ID_ARTICLE = v.ID_ARTICLE
				inner join couleur c on a.ID_Couleur = c.ID_Couleur
where v.ANNEE = 2014
group by c.NOM_COULEUR
;

-- 25. Donner pour chaque fabricant, le nombre de tickets sur lesquels apparait un de ses produits en 2014.

select
	f.NOM_FABRICANT
    , count(distinct v.NUMERO_TICKET) nb_tickets
from marque m inner join fabricant f on f.id_fabricant = m.id_fabricant
				inner join article a on a.id_marque = m.id_marque
								inner join ventes v on v.id_article = a.id_article
where v.ANNEE = 2014
group by f.NOM_FABRICANT
;

-- 26. Donner l’ID, le nom, le volume et la quantité vendue des 20 articles les plus vendus en 2016.

select
	a.ID_ARTICLE
    , a.NOM_ARTICLE
    , a.VOLUME
    , sum(v.QUANTITE) quantité_vendue
from article a inner join ventes v using(id_article)
where v.ANNEE = 2016
group by a.ID_ARTICLE, a.NOM_ARTICLE, a.VOLUME
order by quantité_vendue desc
limit 20
;

-- 27. Donner l’ID, le nom, le volume et la quantité vendue des 5 ‘Trappistes’ les plus vendus en 2016.

select
	a.ID_ARTICLE
    , a.NOM_ARTICLE
    , a.VOLUME
    , sum(v.QUANTITE) quantité_vendue
from article a inner join ventes v using(id_article)
				inner join type t using(id_type)
where v.ANNEE = 2016 
and t.NOM_TYPE = "Trappiste"
group by a.ID_ARTICLE, a.NOM_ARTICLE, a.VOLUME
order by quantité_vendue desc
limit 5
;

-- 28. Donner l’ID, le nom, le volume et les quantités vendues en 2015 et 2016, des bières
-- dont les ventes ont été stables. (Moins de 1% de variation)

select
	a.ID_ARTICLE
    , a.NOM_ARTICLE
    , a.VOLUME
	, v1.sum2015
    , v2.sum2016
    , sum(v.quantite) as quantité_totale
from article a inner join

						(select 
							ventes.ID_ARTICLE
							,sum(ventes.QUANTITE) as sum2015
						from ventes
						where ventes.ANNEE = 2015
						group by ventes.ID_ARTICLE) as  v1 using(ID_ARTICLE)
 
							inner join 
                            
						(select 
							ventes.ID_ARTICLE
							,sum(ventes.QUANTITE) as sum2016
						from ventes
						where ventes.ANNEE = 2016
						group by ventes.ID_ARTICLE) as  v2 using(ID_ARTICLE)    
                        
									inner join                                    
										ventes v using(id_article)
								
group by 	a.ID_ARTICLE, a.NOM_ARTICLE, a.VOLUME
having (v2.sum2016 - v1.sum2015) / v1.sum2015 < 0.01
;


-- 29. Lister les types de bières suivant l’évolution de leurs ventes entre 2015 et 2016.
-- Classer le résultat par ordre décroissant des performances.     

select
	t.ID_TYPE
	, t.NOM_TYPE
--	, v1.sum2015
--    , v2.sum2016
    , round((v2.sum2016 - v1.sum2015) / v1.sum2015) as evolution
from type t inner join article a using(id_type) 
							inner join
								(select 
									ventes.ID_ARTICLE
									,sum(ventes.QUANTITE) as sum2015
								from ventes
								where ventes.ANNEE = 2015
								group by ventes.ID_ARTICLE) as  v1 using(ID_ARTICLE)
 
								inner join 
									(select 
										ventes.ID_ARTICLE
										,sum(ventes.QUANTITE) as sum2016
									from ventes
									where ventes.ANNEE = 2016
									group by ventes.ID_ARTICLE) as  v2 using(ID_ARTICLE)    
                                    
group by 	a.ID_ARTICLE, a.NOM_ARTICLE, a.VOLUME
order by evolution  desc
;


-- 30. Existe-t-il des tickets sans vente ?

select *
from ticket
where DATE_VENTE is null;

-- 31. Lister les produits vendus en 2016 dans des quantités jusqu’à -15% des quantités de l’article le plus vendu.

