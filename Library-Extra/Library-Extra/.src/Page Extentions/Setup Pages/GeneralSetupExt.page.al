pageextension 90290 "General Setup Ext" extends "General Library Setup"
{
    layout
    {
        addafter("Number of days a book may be rented")
        {
            part("Grade and Status Setup"; "Grade and Status Setup")
            {
                ApplicationArea = Basic, Suite;
                //SubPageLink = SetupTableID = field("Primary Key");
                //SubPageLink = SetupTableID = field("Primary Key");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        // report.Run(Report::"Library Books");
        //report.Run(Report::"Get Sales Orders");
    end;
}