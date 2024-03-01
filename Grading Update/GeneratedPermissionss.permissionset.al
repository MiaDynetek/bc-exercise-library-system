permissionset 90250 GeneratedPerm
{
    Assignable = true;
    Permissions = tabledata "Grade and Status Setup"=RIMD,
        tabledata "Genre"=RIMD,
        tabledata "Book Analysis"=RIMD,
        tabledata "Author"=RIMD,
        tabledata "Library Specification"=RIMD,
        tabledata "Library Books Temp"=RIMD,
        table "Grade and Status Setup"=X,
        table "Genre"=X,
        report "Library Books"=X,
        report "Library Books RDLC"=X,
        report "Library Report Excel"=X,
        report "Sales Order Data"=X,
        codeunit UpdateBookStatusOnLoad=X,
        page AddBookSequel=X,
        page "Book Transactions"=X,
        page "Grade and Status Setup"=X,
        page "Rented Book List"=X;
}