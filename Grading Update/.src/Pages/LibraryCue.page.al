page 90260 "Library Cue"
{
    Caption = 'Library Cue';
    PageType = CardPart;
    RefreshOnActivate = true;
    
    layout
    {
        area(Content)
        {
            cuegroup(LibraryBooks)
            {
                actions
                {
                    action(RecentlyAddedBooks)
                    {
                        RunObject=page "Book Analysis";
                        Image=TileNew;
                        ToolTip='Select to view all library books';
                        ApplicationArea=All;
                        // trigger OnAction()
                        // var
                        //     Library: Page Libr
                        // begin
                                             
                        // end;
                    }
                }   
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}