report 90252 "Library Report Excel"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "Library Report Excel";
    
    dataset
    {
        dataitem(DataItemName; Library)
        {
            
            column(Title_DataItemName; Title)
            {
            }
            column(BookGrade_DataItemName; "Book Grade")
            {
            }
            column(BookStatus_DataItemName; "Book Status")
            {
            }
            column(Author_DataItemName; Author)
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
        layout("Library Report Excel")
        {
            Type = Excel;
            LayoutFile = 'LibraryReport.xlsx';
        }
    }

}