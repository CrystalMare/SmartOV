/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     25-5-2016 10:29:33                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ACCOUNT') and o.name = 'FK_ACCOUNT_IS_SALDOB_PERSOON')
alter table ACCOUNT
   drop constraint FK_ACCOUNT_IS_SALDOB_PERSOON
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ANONIEME_KAART') and o.name = 'FK_ANONIEME_IS_EEN_KAART')
alter table ANONIEME_KAART
   drop constraint FK_ANONIEME_IS_EEN_KAART
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KAART') and o.name = 'FK_KAART_GEKOPPELD_ACCOUNT')
alter table KAART
   drop constraint FK_KAART_GEKOPPELD_ACCOUNT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PERSOONLIJKE_KAART') and o.name = 'FK_PERSOONL_IS_EEN2_KAART')
alter table PERSOONLIJKE_KAART
   drop constraint FK_PERSOONL_IS_EEN2_KAART
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PERSOONLIJKE_KAART') and o.name = 'FK_PERSOONL_IS_KAARTH_PERSOON')
alter table PERSOONLIJKE_KAART
   drop constraint FK_PERSOONL_IS_KAARTH_PERSOON
go

alter table ACCOUNT
   drop constraint PK_ACCOUNT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tmp_ACCOUNT')
            and   type = 'U')
   drop table tmp_ACCOUNT
go

execute sp_rename ACCOUNT, tmp_ACCOUNT
go

alter table ANONIEME_KAART
   drop constraint PK_ANONIEME_KAART
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tmp_ANONIEME_KAART')
            and   type = 'U')
   drop table tmp_ANONIEME_KAART
go

execute sp_rename ANONIEME_KAART, tmp_ANONIEME_KAART
go

alter table KAART
   drop constraint AK_IDENTIFIER_1_KAART
go

alter table KAART
   drop constraint PK_KAART
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tmp_KAART')
            and   type = 'U')
   drop table tmp_KAART
go

execute sp_rename KAART, tmp_KAART
go

alter table PERSOON
   drop constraint PK_PERSOON
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tmp_PERSOON')
            and   type = 'U')
   drop table tmp_PERSOON
go

execute sp_rename PERSOON, tmp_PERSOON
go

alter table PERSOONLIJKE_KAART
   drop constraint PK_PERSOONLIJKE_KAART
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tmp_PERSOONLIJKE_KAART')
            and   type = 'U')
   drop table tmp_PERSOONLIJKE_KAART
go

execute sp_rename PERSOONLIJKE_KAART, tmp_PERSOONLIJKE_KAART
go

/*==============================================================*/
/* Domain: EMAILADRES                                           */
/*==============================================================*/
create type EMAILADRES
   from varchar(255)
go

/*==============================================================*/
/* Domain: NAAM                                                 */
/*==============================================================*/
create type NAAM
   from varchar(255)
go

/*==============================================================*/
/* Domain: PERCENTAGE                                           */
/*==============================================================*/
create type PERCENTAGE
   from decimal
go

/*==============================================================*/
/* Table: ACCOUNT                                               */
/*==============================================================*/
create table ACCOUNT (
   ACCOUNTID            SURROGATEKEY         not null,
   PERSOONID            SURROGATEKEY         not null,
   SALDO                GELD                 not null,
   REKENINGNUMMER       BANKREKENING         null,
   constraint PK_ACCOUNT primary key (ACCOUNTID)
)
go

insert into ACCOUNT (ACCOUNTID, PERSOONID, SALDO, REKENINGNUMMER)
select ACCOUNTID, PERSOONID, SALDO, REKENINGNUMMER
from tmp_ACCOUNT
go

/*==============================================================*/
/* Index: FK_IS_SALDOBEHEERDER_VAN                              */
/*==============================================================*/




create nonclustered index FK_IS_SALDOBEHEERDER_VAN on ACCOUNT (PERSOONID ASC)
go

/*==============================================================*/
/* Table: ANONIEME_KAART                                        */
/*==============================================================*/
create table ANONIEME_KAART (
   KAARTID              SURROGATEKEY         not null,
   constraint PK_ANONIEME_KAART primary key (KAARTID)
)
go

insert into ANONIEME_KAART (KAARTID)
select KAARTID
from tmp_ANONIEME_KAART
go

/*==============================================================*/
/* Table: EENMALIGE_REISPRODUCT                                 */
/*==============================================================*/
create table EENMALIGE_REISPRODUCT (
   REISPRODUCTID        SURROGATEKEY         not null,
   TOESLAG              GELD                 not null,
   constraint PK_EENMALIGE_REISPRODUCT primary key (REISPRODUCTID)
)
go

/*==============================================================*/
/* Table: KAART                                                 */
/*==============================================================*/
create table KAART (
   KAARTID              SURROGATEKEY         not null,
   ACCOUNTID            SURROGATEKEY         null,
   KAARTNUMMER          KAARTNUMMER          not null,
   KAARTNAAM            KAARTNAAM            not null,
   VERVALDATUM          DATUM                not null,
   KOPPELDATUM          DATUM                null,
   constraint PK_KAART primary key (KAARTID),
   constraint AK_IDENTIFIER_1_KAART unique (KAARTNUMMER)
)
go

insert into KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
select KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM
from tmp_KAART
go

/*==============================================================*/
/* Index: FK_GEKOPPELD_AAN                                      */
/*==============================================================*/




create nonclustered index FK_GEKOPPELD_AAN on KAART (ACCOUNTID ASC)
go

/*==============================================================*/
/* Table: KORTINGSREISPRODUCT                                   */
/*==============================================================*/
create table KORTINGSREISPRODUCT (
   REISPRODUCTID        SURROGATEKEY         not null,
   KORTING              PERCENTAGE           not null,
   constraint PK_KORTINGSREISPRODUCT primary key (REISPRODUCTID)
)
go

/*==============================================================*/
/* Table: PERSOON                                               */
/*==============================================================*/
create table PERSOON (
   PERSOONID            SURROGATEKEY         not null,
   NAAM                 NAAM                 null,
   POSTCODE             POSTCODE             not null,
   HUISNUMMER           HUISNUMMER           not null,
   GEBOORTEDATUM        DATUM                not null,
   TELEFOONNUMMER       TELEFOONNUMMER       null,
   E_MAILADRES          EMAILADRES           null,
   constraint PK_PERSOON primary key (PERSOONID)
)
go

insert into PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
select PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES
from tmp_PERSOON
go

/*==============================================================*/
/* Table: PERSOONLIJKE_KAART                                    */
/*==============================================================*/
create table PERSOONLIJKE_KAART (
   KAARTID              SURROGATEKEY         not null,
   PERSOONID            SURROGATEKEY         not null,
   constraint PK_PERSOONLIJKE_KAART primary key (KAARTID)
)
go

insert into PERSOONLIJKE_KAART (KAARTID, PERSOONID)
select KAARTID, PERSOONID
from tmp_PERSOONLIJKE_KAART
go

/*==============================================================*/
/* Index: FK_IS_KAARTHOUDER_VAN                                 */
/*==============================================================*/




create nonclustered index FK_IS_KAARTHOUDER_VAN on PERSOONLIJKE_KAART (PERSOONID ASC)
go

/*==============================================================*/
/* Table: REGIO                                                 */
/*==============================================================*/
create table REGIO (
   REGIOID              SURROGATEKEY         not null,
   NAAM                 NAAM                 not null,
   constraint PK_REGIO primary key (REGIOID)
)
go

/*==============================================================*/
/* Table: REGIOPRODUCT                                          */
/*==============================================================*/
create table REGIOPRODUCT (
   REISPRODUCTID        SURROGATEKEY         not null,
   REGIOID              SURROGATEKEY         not null,
   constraint PK_REGIOPRODUCT primary key (REISPRODUCTID)
)
go

/*==============================================================*/
/* Index: FK_IS_GELDIG_IN                                       */
/*==============================================================*/




create nonclustered index FK_IS_GELDIG_IN on REGIOPRODUCT (REGIOID ASC)
go

/*==============================================================*/
/* Table: REISPRODUCT                                           */
/*==============================================================*/
create table REISPRODUCT (
   REISPRODUCTID        SURROGATEKEY         not null,
   KAARTID              SURROGATEKEY         not null,
   NAAM                 NAAM                 not null,
   KOPPELDATUM          DATUM                not null,
   VERVALDATUM          DATUM                not null,
   constraint PK_REISPRODUCT primary key (REISPRODUCTID)
)
go

/*==============================================================*/
/* Index: FK_STAAT_OP                                           */
/*==============================================================*/




create nonclustered index FK_STAAT_OP on REISPRODUCT (KAARTID ASC)
go

alter table ACCOUNT
   add constraint FK_ACCOUNT_IS_SALDOB_PERSOON foreign key (PERSOONID)
      references PERSOON (PERSOONID)
go

alter table ANONIEME_KAART
   add constraint FK_ANONIEME_IS_EEN_KAART foreign key (KAARTID)
      references KAART (KAARTID)
go

alter table EENMALIGE_REISPRODUCT
   add constraint FK_EENMALIG_BESTAAT_U_REISPROD foreign key (REISPRODUCTID)
      references REISPRODUCT (REISPRODUCTID)
go

alter table KAART
   add constraint FK_KAART_GEKOPPELD_ACCOUNT foreign key (ACCOUNTID)
      references ACCOUNT (ACCOUNTID)
go

alter table KORTINGSREISPRODUCT
   add constraint FK_KORTINGS_BESTAAT_U_REISPROD foreign key (REISPRODUCTID)
      references REISPRODUCT (REISPRODUCTID)
go

alter table PERSOONLIJKE_KAART
   add constraint FK_PERSOONL_IS_EEN2_KAART foreign key (KAARTID)
      references KAART (KAARTID)
go

alter table PERSOONLIJKE_KAART
   add constraint FK_PERSOONL_IS_KAARTH_PERSOON foreign key (PERSOONID)
      references PERSOON (PERSOONID)
go

alter table REGIOPRODUCT
   add constraint FK_REGIOPRO_IS_GELDIG_REGIO foreign key (REGIOID)
      references REGIO (REGIOID)
go

alter table REGIOPRODUCT
   add constraint FK_REGIOPRO_SUBTYPE_V_KORTINGS foreign key (REISPRODUCTID)
      references KORTINGSREISPRODUCT (REISPRODUCTID)
go

alter table REISPRODUCT
   add constraint FK_REISPROD_STAAT_OP_KAART foreign key (KAARTID)
      references KAART (KAARTID)
go

