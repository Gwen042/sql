create database if not exists TP1;

create table if not exists TP1.visiteur(
 id_visiteur int not null auto_increment,
 adresse_IP varchar(45) not null,
 date_premiere_visite date not null,
 date_derniere_visite date not null,
 nb_visite int not null,
 primary key (id_visiteur),
 unique index id_visiteur_UNIQUE (id_visiteur ASC) VISIBLE);
 
 insert into TP1.visiteur(adresse_IP, date_premiere_visite, date_derniere_visite, nb_visite) 
 values("168.212.226.204", "1999-02-05", "2017-03-15", 30),
 ("168.212.220.204", "2009-08-25", "2010-07-15", 20),
 ("169.212.226.204", "2019-01-01", "2020-02-10", 25),
 ("168.252.226.204", "2015-02-05", "2018-09-15", 66),
 ("168.212.226.204", "2001-01-12", "2018-03-11", 130),
 ("168.212.226.204", "2013-10-06", "2020-03-14", 83)
;

select count(id_visiteur) from tp1.visiteur ;