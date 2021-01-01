using { joel.bookshop as my } from '../db/schema';
using { OP_API_BUSINESS_PARTNER_SRV as external} from './external/OP_API_BUSINESS_PARTNER_SRV.csn';


@path : '/browse'
// @impl : './cat-service.js'
service CatalogService {

    @readonly entity Books as select from my.Books {*,author.name as author}
    excluding {createdBy, modifiedBy};

    @readonly  entity BusinessPartners as projection on external.A_BusinessPartner {
        key BusinessPartner as BP_ID,
        FirstName,
        MiddleName,
        LastName
    };

    @requires_: 'authenticated_user'
    @insertonly entity Orders as projection on my.Orders 
}