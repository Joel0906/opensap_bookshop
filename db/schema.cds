namespace joel.bookshop;

using
{
    Currency,
    managed,
    cuid
}
from '@sap/cds/common';

@cds.autoexpose
entity Authors : managed
{
    key ID : Integer;
    dateOfBirth : Date;
    dateOfDeath : Date;
    name : String(111);
    placeOfBirth : String;
    placeOfDeath : String;
    books : Association to many Books on books.author = $self;
}

entity Books : managed
{
    key ID : Integer;
    currency : Currency;
    descr : localized String(1111);
    price : Decimal(9,2);
    stock : Integer;
    title : localized String(111);
    author : Association to one Authors;
}

entity OrderItems : cuid, managed
{
    amount : Integer;
    netAmount : Decimal(9,2);
    book : Association to one Books;
    parent : Association to one Orders;
}

entity Orders : cuid, managed
{
    currency : Currency;
    orderNo : String
        @title : 'Order Number';
    total : Decimal(9,2)
        @readonly;
    items : Composition of many OrderItems on items.parent = $self;
}
