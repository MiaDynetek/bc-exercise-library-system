report 90251 "Library Books RDLC"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "Library Books RDLC";
    
    dataset
    {
        dataitem(DataItemName; Library)
        {
            DataItemTableView = sorting(Author);
            
            column(Title_DataItemName; Title)
            {
            }
            column(BookStatus_DataItemName; "Book Status")
            {
            }
            column(Author_DataItemName; Author)
            {
            }
            column(BookGrade_DataItemName; "Book Grade")
            {
            }

        }
    }
    
    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;
                        
    //                 }
    //             }
    //         }
    //     }
    
    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;
                    
    //             }
    //         }
    //     }
    // }
    
    rendering
    {
        layout("Library Books RDLC")
        {
            Type = RDLC;
            LayoutFile = 'LibraryBooksRDLC.rdl';
        }
    }
    
    var
        myInt: Integer;
}