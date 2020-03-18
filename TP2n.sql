create database if not exists TP2n;

create table if not exists TP2n.pays(
 id_pays int not null auto_increment,
 nom_pays varchar(45) not null,
 primary key (id_pays),
 unique index id_pays_UNIQUE (id_pays ASC) VISIBLE);
 
 create table if not exists TP2n.ville(
 id_ville int not null auto_increment,
 nom_ville varchar(45) not null,
 id_pays int not null,
 primary key (id_ville),
 unique index id_ville_UNIQUE (id_ville ASC) VISIBLE);
 
 create table if not exists TP2n.langue(
 id_langue int not null auto_increment,
 langue varchar(45) not null,
 primary key (id_langue),
 unique index id_langue_UNIQUE (id_langue ASC) VISIBLE);
 
 create table if not exists TP2n.langue_pays(
 id_pays int not null,
 id_langue int not null);
 
 insert into tp2n.pays (nom_pays) values ("France"), ("Royaume-uni"), ("Espagne"), ("Italie"), ("Allemagne"), ("Suisse"), ("Australie"), ("Etats-unis"), ("Portugal"), ("Canada");
 
 insert into tp2n.langue (langue) values ("français"), ("anglais"), ("espagnol"), ("italien"), ("allemand"), ("portuguais");
 
 insert into tp2n.ville (nom_ville, id_pays) values ("Rome", 4), ("Paris", 1), ("Lille", 1), ("Bordeaux", 1), ("Naples", 4), ("Londres", 2), ("Oxford", 2), ("Madrid", 3), ("Séville", 3), ("Berlin", 5), ("Lucerne", 6), ("Sydney", 7), ("Chigago", 8), ("Miami", 8), ("Philadelphie", 8), ("Lisbonne", 9), ("Toronto", 10), ("Chicoutimi", 10), ("Québec", 10);
 
 insert into tp2n.langue_pays (id_pays, id_langue) values (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 1), (6, 2), (6, 4), (6, 5), (7, 2), (8, 2), (9, 6), (10, 2);
  
 alter table tp2n.ville add constraint foreign key (id_pays)
 references pays(id_pays)
	on update cascade
	on delete restrict;
 
alter table tp2n.langue_pays add constraint foreign key (id_pays)
 references pays(id_pays)
	on update cascade
	on delete restrict;
    
alter table tp2n.langue_pays add constraint foreign key (id_langue)
 references langue(id_langue)
	on update cascade
	on delete restrict;
    
select nom_pays 
from tp2n.pays p
, tp2n.langue_pays lp
, tp2n.langue l 
where p.id_pays = lp.id_pays
and lp.id_langue = l.id_langue
and l.id_langue = 2;