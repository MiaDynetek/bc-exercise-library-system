table 90252 "Author"
{
    Caption = 'Author';
    // DataCaptionFields = "Author Name", "Auther ID";
    LookupPageId = Authors;
    DrillDownPageId = Authors;

    fields
    {
       
        field(1; "Author Name"; Text[500])
        {
            Caption = 'Auther Name';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Author Name")
        {
            Clustered = true;
        }
    }

}