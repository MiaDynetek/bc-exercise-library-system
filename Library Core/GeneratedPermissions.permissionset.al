permissionset 90100 GeneratedPermissions
{
    Assignable = true;
    Permissions = tabledata BookSeries=RIMD,
        tabledata BookTransactions=RIMD,
        tabledata "General Setup"=RIMD,
        tabledata Library=RIMD,
        table BookSeries=X,
        table BookTransactions=X,
        table "General Setup"=X,
        table Library=X,
        codeunit LibarayBookMgmt=X,
        page BookSeries=X,
        page BookSpecifications=X,
        page "General Setup"=X,
        page LibraryBookList=X,
        page LibraryRoleCenter=X,
        page "Open Library"=X,
        page RentBook=X;
}