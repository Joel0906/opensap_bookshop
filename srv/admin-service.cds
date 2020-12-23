using {joel.bookshop as my} from '../db/schema';

service AdminService @(_requires : 'admin') {
    entity Books   as projection on my.Books;
    entity Authors as projection on my.Authors;
    entity Orders  as projection on my.Orders
}

// Restrict access to Orders with only "admin" role
annotate AdminService.Orders with @restrict : [
    {grant: 'READ', to: 'admin' }
];
 


/* Authors Annotation */

annotate AdminService.Authors with @(
    UI : { 
        HeaderInfo: {
            Title : {Value : name},
            TypeName : 'Author',
            TypeNamePlural : 'Authors'
        },
        SelectionFields : [ID, name],
        LineItem : [
            {Value : ID, Label: 'Author ID'},
            {Value : name}
        ],

        HeaderFacets: [
            {$Type : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#AuthorsDetail', Label : 'Personal information',},
        ],
        Facets  : [
            
        ],

        FieldGroup#AuthorsDetail :{
            Data : [
                { $Type : 'UI.DataField', Value : placeOfBirth, Label : 'Place of Birth',},
                { $Type : 'UI.DataField', Value : placeOfDeath, Label : 'Place of Death'}
            ]
        }
     }
);

annotate AdminService.Authors with {
    name @title : 'Author Name'
}