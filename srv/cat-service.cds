using { joel.bookshop as my } from '../db/schema';

@path : '/browse'
// @impl : './cat-service.js'
service CatalogService {

    @readonly entity Books as select from my.Books {*,author.name as author}
    excluding {createdBy, modifiedBy};

    @requires_: 'authenticated_user'
    @insertonly entity Orders as projection on my.Orders 
}