page 90251 "Genres"
{
    caption = 'Genres';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Genre;

    layout
    {
        area(Content)
        {
            repeater(GenreData)
            {
                field("Genre Name"; Rec."Genre Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auther Name field.';
                }
            }
        }
    }


}