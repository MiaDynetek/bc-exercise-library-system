table 90255 "Library Books Temp"
{
    DataClassification = ToBeClassified;
    // TableType = Temporary;
    fields
    {
        field(90000; "Open Library ID"; Text[1000])
        {
            Caption = 'Open Library ID';
        }
        
        field(90010; "Title"; Text[50])
        {
            Caption = 'Title';
            NotBlank = true;
        }
        field(90020; "Created"; Text[50])
        {
            Caption = 'Created';
            NotBlank = true;
        }
        field(90030; "Description"; Text[2048])
        {
            Caption = 'Description';
        }
        field(90040; "Search Title"; Text[50])
        {
            Caption = 'Search Title';
            NotBlank = true;
        }
        field(90050; "Temp Book ID"; Integer)
        {
            Caption = 'Temp Book ID';
            NotBlank = true;
        }
        field(90060; "Add Book"; Boolean)
        {
            Caption = 'Add Book';
            NotBlank = true;
        }
        
    }
    procedure GetBookDescription(BookID: Text[500]; GetSpecificBookData: Text): Text
    var
        JsonObject: JsonObject;
        JsonObject1: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
        JsonTokenValue: JsonToken;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        if JsonObject.Get('description', JsonToken) then begin
            JsonTokenValue := JsonToken;
            if JsonToken.IsObject = true then begin
                JsonObject1 := JsonToken.AsObject();
                JsonObject1.Get('value', JsonTokenValue);
                Exit(Format(JsonTokenValue));
            end else begin
                Exit(Format(JsonToken));
            end;
        end else begin
            Exit(Format('N/A'));
        end;
    end;

    procedure GetBookCreated(BookID: Text[500]; GetSpecificBookData: Text): Text
    var
        JsonObject: JsonObject;
        JsonObject1: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
        JsonTokenValue: JsonToken;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        if JsonObject.Get('created', JsonToken) then begin
            JsonObject1 := JsonToken.AsObject();
            if JsonObject1.Get('value', JsonTokenValue) then begin
                Exit(Format(JsonTokenValue));
            end else begin
                exit('N/A');
            end;
        end else begin
            exit('N/A');
        end;
    end;

   

    procedure RemoveAllQuotes(FinalOutput: Text): Text
    var
        RemoveTags: List of [Text];
        PureOutput: Text;
    begin
        if FinalOutput.Contains('"') then begin
            RemoveTags := FinalOutput.Split('"');
            if RemoveTags.Count() = 2 then begin
                PureOutput := RemoveTags.Get(1);
                Exit(PureOutput);
            end else begin
                PureOutput := RemoveTags.Get(2);
                Exit(PureOutput);
            end;
        end else begin
            PureOutput := Created;
            Exit(PureOutput);
        end;
    end;

    procedure GetBookTitle(BookID: Text[500]; GetSpecificBookData: Text): Text
    var
        JsonObject: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        if JsonObject.Get('title', JsonToken) then begin
            Exit(Format(JsonToken));
        end else begin
            exit('N/A');
        end;
    end;

    // keys
    // {
    //     key(PK; "Temp Book ID")
    //     {
    //         Clustered = true;
    //     }
    // }

}