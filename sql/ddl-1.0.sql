/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     12-5-2016 11:24:06                           */
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

if exists (select 1
           from  sysindexes
           where  id    = object_id('ACCOUNT')
                  and   name  = 'FK_IS_SALDOBEHEERDER_VAN'
                  and   indid > 0
                  and   indid < 255)
  drop index ACCOUNT.FK_IS_SALDOBEHEERDER_VAN
go

if exists (select 1
           from  sysobjects
           where  id = object_id('ACCOUNT')
                  and   type = 'U')
  drop table ACCOUNT
go

if exists (select 1
           from  sysobjects
           where  id = object_id('ANONIEME_KAART')
                  and   type = 'U')
  drop table ANONIEME_KAART
go

if exists (select 1
           from  sysindexes
           where  id    = object_id('KAART')
                  and   name  = 'FK_GEKOPPELD_AAN'
                  and   indid > 0
                  and   indid < 255)
  drop index KAART.FK_GEKOPPELD_AAN
go

if exists (select 1
           from  sysobjects
           where  id = object_id('KAART')
                  and   type = 'U')
  drop table KAART
go

if exists (select 1
           from  sysobjects
           where  id = object_id('PERSOON')
                  and   type = 'U')
  drop table PERSOON
go

if exists (select 1
           from  sysindexes
           where  id    = object_id('PERSOONLIJKE_KAART')
                  and   name  = 'FK_IS_KAARTHOUDER_VAN'
                  and   indid > 0
                  and   indid < 255)
  drop index PERSOONLIJKE_KAART.FK_IS_KAARTHOUDER_VAN
go

if exists (select 1
           from  sysobjects
           where  id = object_id('PERSOONLIJKE_KAART')
                  and   type = 'U')
  drop table PERSOONLIJKE_KAART
go

if exists(select 1 from systypes where name='BANKREKENING')
  drop type BANKREKENING
go

if exists(select 1 from systypes where name='DATUM')
  drop type DATUM
go

if exists(select 1 from systypes where name='GELD')
  drop type GELD
go

if exists(select 1 from systypes where name='HUISNUMMER')
  drop type HUISNUMMER
go

if exists(select 1 from systypes where name='KAARTNAAM')
  drop type KAARTNAAM
go

if exists(select 1 from systypes where name='KAARTNUMMER')
  drop type KAARTNUMMER
go

if exists(select 1 from systypes where name='POSTCODE')
  drop type POSTCODE
go

if exists(select 1 from systypes where name='SURROGATEKEY')
  drop type SURROGATEKEY
go

if exists(select 1 from systypes where name='TELEFOONNUMMER')
  drop type TELEFOONNUMMER
go

/*==============================================================*/
/* Domain: BANKREKENING                                         */
/*==============================================================*/
create type BANKREKENING
from varchar(34)
go

/*==============================================================*/
/* Domain: DATUM                                                */
/*==============================================================*/
create type DATUM
from datetime
go

/*==============================================================*/
/* Domain: GELD                                                 */
/*==============================================================*/
create type GELD
from money
go

/*==============================================================*/
/* Domain: HUISNUMMER                                           */
/*==============================================================*/
create type HUISNUMMER
from varchar(5)
go

/*==============================================================*/
/* Domain: KAARTNAAM                                            */
/*==============================================================*/
create type KAARTNAAM
from varchar(26) not null
go

/*==============================================================*/
/* Domain: KAARTNUMMER                                          */
/*==============================================================*/
create type KAARTNUMMER
from char(16)
go

/*==============================================================*/
/* Domain: POSTCODE                                             */
/*==============================================================*/
create type POSTCODE
from varchar(10)
go

/*==============================================================*/
/* Domain: SURROGATEKEY                                         */
/*==============================================================*/
create type SURROGATEKEY
from uniqueidentifier
go

/*==============================================================*/
/* Domain: TELEFOONNUMMER                                       */
/*==============================================================*/
create type TELEFOONNUMMER
from varchar(15)
go

/*==============================================================*/
/* Table: ACCOUNT                                               */
/*==============================================================*/
create table ACCOUNT (
  ACCOUNTID            SURROGATEKEY         not null,
  PERSOONID            SURROGATEKEY         not null,
  SALDO                GELD                 not null,
  REKENINGNUMMER       BANKREKENING         null,
  constraint PK_ACCOUNT primary key nonclustered (ACCOUNTID)
)
go

/*==============================================================*/
/* Index: FK_IS_SALDOBEHEERDER_VAN                              */
/*==============================================================*/
create index FK_IS_SALDOBEHEERDER_VAN on ACCOUNT (
  PERSOONID ASC
)
go

/*==============================================================*/
/* Table: ANONIEME_KAART                                        */
/*==============================================================*/
create table ANONIEME_KAART (
  KAARTID              SURROGATEKEY         not null,
  constraint PK_ANONIEME_KAART primary key (KAARTID)
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
  constraint PK_KAART primary key nonclustered (KAARTID),
  constraint AK_IDENTIFIER_1_KAART unique (KAARTNUMMER)
)
go

/*==============================================================*/
/* Index: FK_GEKOPPELD_AAN                                      */
/*==============================================================*/
create index FK_GEKOPPELD_AAN on KAART (
  ACCOUNTID ASC
)
go

/*==============================================================*/
/* Table: PERSOON                                               */
/*==============================================================*/
create table PERSOON (
  PERSOONID            SURROGATEKEY         not null,
  NAAM                 varchar(255)         null,
  POSTCODE             POSTCODE             not null,
  HUISNUMMER           HUISNUMMER           not null,
  GEBOORTEDATUM        DATUM                not null,
  TELEFOONNUMMER       TELEFOONNUMMER       null,
  E_MAILADRES          varchar(255)         null,
  constraint PK_PERSOON primary key nonclustered (PERSOONID)
)
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

/*==============================================================*/
/* Index: FK_IS_KAARTHOUDER_VAN                                 */
/*==============================================================*/
create index FK_IS_KAARTHOUDER_VAN on PERSOONLIJKE_KAART (
  PERSOONID ASC
)
go

alter table ACCOUNT
  add constraint FK_ACCOUNT_IS_SALDOB_PERSOON foreign key (PERSOONID)
references PERSOON (PERSOONID)
go

alter table ANONIEME_KAART
  add constraint FK_ANONIEME_IS_EEN_KAART foreign key (KAARTID)
references KAART (KAARTID)
go

alter table KAART
  add constraint FK_KAART_GEKOPPELD_ACCOUNT foreign key (ACCOUNTID)
references ACCOUNT (ACCOUNTID)
go

alter table PERSOONLIJKE_KAART
  add constraint FK_PERSOONL_IS_EEN2_KAART foreign key (KAARTID)
references KAART (KAARTID)
go

alter table PERSOONLIJKE_KAART
  add constraint FK_PERSOONL_IS_KAARTH_PERSOON foreign key (PERSOONID)
references PERSOON (PERSOONID)
go

