table 90254 "Book Analysis"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(90600; BookID; Integer)
        {
            Caption = 'BookID';
            NotBlank = true;
        }
        field(90700; "Recently added books"; Integer)
        {
            CalcFormula = count(Library where("Date Added" = field("Recently added books Filter")));
            Caption = 'Recently added books';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90800; "Recently added books Filter"; Date)
        {
            Caption = 'Recently added books Filter';
            FieldClass = FlowFilter;
        }
        
    }
    
    keys
    {
        key(PK; BookID)
        {
            Clustered = true;
        }
    }
    procedure InsertIfNotExists()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        Rec.SetFilter("Recently added books Filter", '>=CM-1M');
    end;
}