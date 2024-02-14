table 90253 "Genre"
{
    Caption = 'Genre';
    LookupPageId = Genres;
    DrillDownPageId = Genres;

    fields
    {
       
        field(1; "Genre Name"; Text[500])
        {
            Caption = 'Auther Name';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Genre Name")
        {
            Clustered = true;
        }
    }

}