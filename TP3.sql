create database if not exists TP3;

create table if not exists TP3.utilisateur(
 id_utilisateur int not null auto_increment,
 pseudo varchar(45) not null,
 primary key (id_utilisateur),
 unique index id_utilisateur_UNIQUE (id_utilisateur ASC) VISIBLE);
 
 create table if not exists TP3.article(
 id_article int not null auto_increment,
 nom_article varchar(45) not null,
 id_utilisateur int not null,
 primary key (id_article),
 unique index id_article_UNIQUE (id_article ASC) VISIBLE);
 
 create table if not exists TP3.salon(
 id_salon int not null auto_increment,
 nom_salon varchar(45) not null,
 id_article int not null,
 primary key (id_salon),
 unique index id_salon_UNIQUE (id_salon ASC) VISIBLE);
 
  create table if not exists TP3.tags(
 id_tags int not null auto_increment,
 tags varchar(45) not null,
 id_article int not null,
 primary key (id_tags),
 unique index id_tags_UNIQUE (id_tags ASC) VISIBLE);
 
  create table if not exists TP3.commentaire(
 id_commentaire int not null auto_increment,
 commentaire varchar(45) not null,
 id_article int not null,
 id_utilisateur int not null,
 primary key (id_commentaire),
 unique index id_commentaire_UNIQUE (id_salon ASC) VISIBLE);

alter table tp3.article add constraint foreign key (id_utilisateur)
 references utilisateur(id_utilisateur)
	on update cascade
	on delete restrict;