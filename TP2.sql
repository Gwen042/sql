create database if not exists TP2;

create table if not exists TP2.pays(
 id_pays int not null auto_increment,
 nom_pays varchar(45) not null,
 id_ville int not null,
 id_langue int not null,
 primary key (id_pays),
 unique index id_pays_UNIQUE (id_pays ASC) VISIBLE);
 
 create table if not exists TP2.ville(
 id_ville int not null auto_increment,
 nom_ville varchar(45) not null,
 id_pays int not null,
 primary key (id_ville),
 unique index id_ville_UNIQUE (id_ville ASC) VISIBLE);
 
 create table if not exists TP2.langue(
 id_langue int not null auto_increment,
 langue varchar(45) not null,
 id_pays int not null,
 primary key (id_langue),
 unique index id_langue_UNIQUE (id_langue ASC) VISIBLE);
 
 alter table tp2.pays add constraint foreign key (id_ville)
 references ville(id_ville)
	on update cascade
	on delete restrict;
 
 alter table tp2.pays add constraint foreign key (id_langue)
 references langue(id_langue)
	on update cascade
	on delete restrict;
 
 alter table tp2.ville add constraint foreign key (id_pays)
 references pays(id_pays)
	on update cascade
	on delete restrict;
 
  alter table tp2.langue add constraint foreign key (id_pays)
 references pays(id_pays)
	on update cascade
	on delete restrict;
 
  insert into TP2.pays(id_pays, nom_pays, id_ville, id_langue) 
 values(1, "France", 1, 1), (1, "France", 1, 2),
 (2, "Australie", 3, 2), (3, "Espagne", 4, 3), (4, "Royaume_Uni", 5, 2), (5, "Italie", 6, 5), (6, "Etats_Unis", 7, 2), (6, "Etats_Unis", 8, 2), (7, "Allemagne", 9, 4)
;

insert into Tp2.langue(langue)
values("français"), ("anglais"), ("espagnol"), ("allemand"), ("italien")
;

insert into tp2.ville(nom_ville)
values("Paris"), ("Lille"), ("Sydney"), ("Madrid"), ("Londres"), ("Rome"), ("Miami"), ("Chicago"), ("Berlin")
