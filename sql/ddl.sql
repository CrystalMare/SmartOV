/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     26-5-2016 11:41:51                           */
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
   where r.fkeyid = object_id('EENMALIGE_REISPRODUCT') and o.name = 'FK_EENMALIG_BESTAAT_U_REISPROD')
alter table EENMALIGE_REISPRODUCT
   drop constraint FK_EENMALIG_BESTAAT_U_REISPROD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KAART') and o.name = 'FK_KAART_GEKOPPELD_ACCOUNT')
alter table KAART
   drop constraint FK_KAART_GEKOPPELD_ACCOUNT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KORTINGSREISPRODUCT') and o.name = 'FK_KORTINGS_BESTAAT_U_REISPROD')
alter table KORTINGSREISPRODUCT
   drop constraint FK_KORTINGS_BESTAAT_U_REISPROD
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
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PRODUCT_OP_KAART') and o.name = 'FK_PRODUCT__GEKOPPELD_KAART')
alter table PRODUCT_OP_KAART
   drop constraint FK_PRODUCT__GEKOPPELD_KAART
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PRODUCT_OP_KAART') and o.name = 'FK_PRODUCT__GEKOPPELD_REISPROD')
alter table PRODUCT_OP_KAART
   drop constraint FK_PRODUCT__GEKOPPELD_REISPROD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('REGIOPRODUCT') and o.name = 'FK_REGIOPRO_IS_GELDIG_REGIO')
alter table REGIOPRODUCT
   drop constraint FK_REGIOPRO_IS_GELDIG_REGIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('REGIOPRODUCT') and o.name = 'FK_REGIOPRO_SUBTYPE_V_KORTINGS')
alter table REGIOPRODUCT
   drop constraint FK_REGIOPRO_SUBTYPE_V_KORTINGS
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
            from  sysobjects
           where  id = object_id('EENMALIGE_REISPRODUCT')
            and   type = 'U')
   drop table EENMALIGE_REISPRODUCT
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
           where  id = object_id('KORTINGSREISPRODUCT')
            and   type = 'U')
   drop table KORTINGSREISPRODUCT
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

if exists (select 1
            from  sysindexes
           where  id    = object_id('PRODUCT_OP_KAART')
            and   name  = 'FK_GEKOPPELD_AAN3'
            and   indid > 0
            and   indid < 255)
   drop index PRODUCT_OP_KAART.FK_GEKOPPELD_AAN3
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PRODUCT_OP_KAART')
            and   name  = 'FK_GEKOPPELD_AAN2'
            and   indid > 0
            and   indid < 255)
   drop index PRODUCT_OP_KAART.FK_GEKOPPELD_AAN2
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PRODUCT_OP_KAART')
            and   type = 'U')
   drop table PRODUCT_OP_KAART
go

if exists (select 1
            from  sysobjects
           where  id = object_id('REGIO')
            and   type = 'U')
   drop table REGIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('REGIOPRODUCT')
            and   name  = 'FK_IS_GELDIG_IN'
            and   indid > 0
            and   indid < 255)
   drop index REGIOPRODUCT.FK_IS_GELDIG_IN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('REGIOPRODUCT')
            and   type = 'U')
   drop table REGIOPRODUCT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('REISPRODUCT')
            and   type = 'U')
   drop table REISPRODUCT
go

if exists(select 1 from systypes where name='BANKREKENING')
   drop type BANKREKENING
go

if exists(select 1 from systypes where name='DAGEN')
   drop type DAGEN
go

if exists(select 1 from systypes where name='DATUM')
   drop type DATUM
go

if exists(select 1 from systypes where name='EMAILADRES')
   drop type EMAILADRES
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

if exists(select 1 from systypes where name='NAAM')
   drop type NAAM
go

if exists(select 1 from systypes where name='PERCENTAGE')
   drop type PERCENTAGE
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
/* Domain: DAGEN                                                */
/*==============================================================*/
create type DAGEN
   from int
go

/*==============================================================*/
/* Domain: DATUM                                                */
/*==============================================================*/
create type DATUM
   from datetime
go

/*==============================================================*/
/* Domain: EMAILADRES                                           */
/*==============================================================*/
create type EMAILADRES
   from varchar(255)
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
/* Domain: POSTCODE                                             */
/*==============================================================*/
create type POSTCODE
   from char(6)
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
   constraint PK_ACCOUNT primary key (ACCOUNTID)
)
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




create nonclustered index FK_IS_KAARTHOUDER_VAN on PERSOONLIJKE_KAART (PERSOONID ASC)
go

/*==============================================================*/
/* Table: PRODUCT_OP_KAART                                      */
/*==============================================================*/
create table PRODUCT_OP_KAART (
   KAARTID              SURROGATEKEY         not null,
   REISPRODUCTID        SURROGATEKEY         not null,
   KOPPELDATUM          DATUM                not null,
   constraint PK_PRODUCT_OP_KAART primary key nonclustered (KAARTID, REISPRODUCTID)
)
go

/*==============================================================*/
/* Index: FK_GEKOPPELD_AAN2                                     */
/*==============================================================*/




create nonclustered index FK_GEKOPPELD_AAN2 on PRODUCT_OP_KAART (KAARTID ASC)
go

/*==============================================================*/
/* Index: FK_GEKOPPELD_AAN3                                     */
/*==============================================================*/




create nonclustered index FK_GEKOPPELD_AAN3 on PRODUCT_OP_KAART (REISPRODUCTID ASC)
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
   NAAM                 NAAM                 not null,
   GELDIGHEID           DAGEN                not null,
   constraint PK_REISPRODUCT primary key (REISPRODUCTID)
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

alter table PRODUCT_OP_KAART
   add constraint FK_PRODUCT__GEKOPPELD_KAART foreign key (KAARTID)
      references KAART (KAARTID)
go

alter table PRODUCT_OP_KAART
   add constraint FK_PRODUCT__GEKOPPELD_REISPROD foreign key (REISPRODUCTID)
      references REISPRODUCT (REISPRODUCTID)
go

alter table REGIOPRODUCT
   add constraint FK_REGIOPRO_IS_GELDIG_REGIO foreign key (REGIOID)
      references REGIO (REGIOID)
go

alter table REGIOPRODUCT
   add constraint FK_REGIOPRO_SUBTYPE_V_KORTINGS foreign key (REISPRODUCTID)
      references KORTINGSREISPRODUCT (REISPRODUCTID)
go

