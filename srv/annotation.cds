using { AdminService as my} from './admin-service';


/* Books Annotation */

annotate my.Books with @(
	UI: {
        HeaderInfo:{
            Title:{ $Type : 'UI.DataField', Value : title,},
            TypeName: 'Book',
            TypeNamePlural:'Books'
        },
	    SelectionFields: [ ID, title ],
		LineItem: [
			{Value: title},
            {Value: ID},
            {Value: stock},
            {Value: price}
        ]
	}
);

annotate my.Books with {
    title @title : '{i18n>title}';
    ID  @title : '{i18n>ID}';
    stock @title : '{i18n>stock}';
    price @title : '{i18n>price}' 
};
