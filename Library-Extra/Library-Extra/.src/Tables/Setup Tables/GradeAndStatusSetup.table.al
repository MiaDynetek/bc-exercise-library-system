table 90253 "Grade and Status Setup"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        // field(700;GradeStatusSetupID; )
        // {
        //     DataClassification = ToBeClassified;
        //     AutoIncrement = true;
        // }
        field(710;BookGrade; Enum BookGrade)
        {
            DataClassification = ToBeClassified;
            
        }
        field(720;BookStatus; Enum BookStatus)
        {
            DataClassification = ToBeClassified;
            
        }
        // field(730; SetupTableID; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }
    }
    
    keys
    {
        key(Key1; BookGrade)
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        //Message(Format(Rec.GradeStatusSetupID));
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}