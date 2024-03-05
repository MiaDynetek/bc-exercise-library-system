table 90102 "General Library Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            //AutoIncrement = true;
        }
        field(510; StartAmount; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(520; EndAmount; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(530; "No. Series"; Code[1000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

}