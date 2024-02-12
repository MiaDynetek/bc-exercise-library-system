page 90254 "Library Specifications"
{
    PageType = Card;
    SourceTable = Library;
    Caption = 'Library Specifications';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Book Specifics")
            {

                field("Book Author"; "Book Author")
                {
                    ApplicationArea = All;
                    TableRelation = Author."Author Name";
                    ToolTip = 'Filters the list of books by author when selected.';
                    trigger OnValidate();
                    begin
                        Rec.SetFilter(Rec.Author, '=%1', "Book Author");
                        CurrPage.Update();
                    end;
                }
                field("Book Genre"; "Book Genre")
                {
                    ApplicationArea = All;
                    TableRelation = Genre."Genre Name";
                    ToolTip = 'Filters the list of books by Genre when selected.';
                    trigger OnValidate();
                    begin
                        Rec.SetFilter(Rec.Genre, '=%1', "Book Genre");
                        CurrPage.Update();
                    end;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filters the list of books to display books added before the selected date.';
                    trigger OnValidate();
                    begin
                        Rec.SetFilter(Rec."Date Added", '<=%1', Rec.Date);
                        CurrPage.Update();
                    end;
                }
                field("Total available books"; Rec."Total available books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total available books field.';
                }
                field("Total damaged books"; Rec."Total damaged books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total damaged books field.';
                }
                field("Total new books"; Rec."Total new books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total new books field.';
                }
                field("Total rented books"; Rec."Total rented books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total rented books field.';
                }
                field("Total unique books"; Rec."Total unique books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total unique books field.';
                }
                // field("Recently added books"; Rec."Recently added books")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Recently added books field.';
                // }


            }
            repeater(Library)
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Author field.';
                }
                field("Book Grade"; Rec."Book Grade")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Book Grade Justification"; Rec."Book Grade Justification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Grade Justification field.';
                }
                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Price field.';
                }
                field("Book Status"; Rec."Book Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Date Added"; Rec."Date Added")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Added field.';
                }
                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Genre field.';
                }

            }
            // group("Library")
            // {
            //     part("Library Books"; "Library Books")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         //SubPageLink = SetupTableID = field("Primary Key");
            //         //SubPageLink = SetupTableID = field("Primary Key");
            //         UpdatePropagation = Both;
            //     }
            // }

        }
    }
    actions
    {
        area(Processing)
        {
            action("Reset Filters")
            {
                Caption = 'Reset Filters';
                ApplicationArea = All;
                Image = Cancel;

                trigger OnAction()
                begin
                    Rec.Reset();
                    "Book Author" := '';
                    "Book Genre" := '';
                    Rec."Date" := CalcDate('<CM+1M>');
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
        //Rec.SetFilter("Recently added books Filter", '>=CM-1M');
    end;

    var
        "Book Author": Text;
        "Book Genre": Text;
}