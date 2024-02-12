page 90256 "Authors"
{
    caption = 'Authors';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Author;

    layout
    {
        area(Content)
        {
            repeater(AuthorData)
            {
                field("Author Name"; Rec."Author Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Author Name field.';
                }
                
            }
        }
    }


}