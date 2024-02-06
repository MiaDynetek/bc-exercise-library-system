report 90253 "Sales Order Data"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "Sales Order Data";

    dataset
    {
        dataitem(DataItemName; "Sales Header")
        {
            // DataItemTableView = sorting("Document Type", "No.", "Doc. No. Occurrence", "Version No.") where("Document Type" = const("Blanket Order"));
            // RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed", "Version No.";
            // RequestFilterHeading = 'Archived Blanket Sales Order';
            column(No_DataItemName; "No.")
            {
            }

            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    // column(CompanyInfo2_Picture; CompanyInfo2.Picture)
                    // {
                    // }
                }
            }
            // dataitem(loop; "Integer")
            // {
            //     DataItemTableView = sorting(Number);

            // dataitem(CopyLoop; "Integer")
            // {
            //     DataItemTableView = sorting(Number);
            //     dataitem(PageLoop; "Integer")
            //     {
            //         DataItemTableView = sorting(Number) where(Number = const(1));
            //         column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
            //         {
            //         }
            //         column(CustAddr_6_; CustAddr[6])
            //         {
            //         }
            //     }
            // }
            // }
            trigger OnPreDataItem()
            var
                SalesHeader: Record "Sales Header Archive";
                CurrRec: Report "Sales Order Data";
            begin
                //DataItemName.SetRange();
                // if not SalesHeader.get() then begin
                //     CurrReport.Break();
                // end;

                // CurrRec
            end;

            trigger OnPostDataItem()
            begin

                //Message(CurrRec."Sales Order Data".);
                //CurrentSalesLines
            end;
            // trigger OnAfterGetRecord()
            // begin
            //     CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
            //     CurrReport.FormatRegion := Language.GetFormatRegionOrDefault("Format Region");
            //     FormatAddr.SetLanguageCode("Language Code");

            //     FormatAddressFields("Sales Header Archive");
            //     FormatDocumentFields("Sales Header Archive");

            //     if not CompanyBankAccount.Get("Sales Header Archive"."Company Bank Account Code") then
            //         CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);

            //     DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

            //     CalcFields("No. of Archived Versions");
            // end;
        }

    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    rendering
    {
        layout("Sales Order Data")
        {
            Type = Word;
            LayoutFile = 'TestSalesOrder.docx';
        }
    }
    trigger OnPreReport()
    var
        SalesHeader: Record "Sales Header Archive";

    begin
        if not SalesHeader.get() then begin
            CurrReport.Break();
        end;
    end;



    var
        CurrentSalesLines: Record "Sales Line";
    // local procedure FormatAddressFields(var SalesHeaderArchive: Record "Sales Header Archive")
    // begin
    //     FormatAddr.GetCompanyAddr(SalesHeaderArchive."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
    //     FormatAddr.SalesHeaderArchBillTo(CustAddr, SalesHeaderArchive);
    //     ShowShippingAddr := FormatAddr.SalesHeaderArchShipTo(ShipToAddr, CustAddr, SalesHeaderArchive);
    // end;

    // local procedure FormatDocumentFields(SalesHeaderArchive: Record "Sales Header Archive")
    // begin
    //     with SalesHeaderArchive do begin
    //         FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
    //         FormatDocument.SetSalesPerson(SalespersonPurchaser, "Salesperson Code", SalesPersonText);
    //         FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
    //         FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, "Prepmt. Payment Terms Code", "Language Code");
    //         FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");

    //         ReferenceText := FormatDocument.SetText("Your Reference" <> '', FieldCaption("Your Reference"));
    //         VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FieldCaption("VAT Registration No."));
    //     end;
    // end;

    // protected var
    //     CompanyInfo: Record "Company Information";
    //     CompanyInfo1: Record "Company Information";
    //     CompanyInfo2: Record "Company Information";

    // var
    //     GLSetup: Record "General Ledger Setup";
    //     ShipmentMethod: Record "Shipment Method";
    //     PaymentTerms: Record "Payment Terms";
    //     PrepmtPaymentTerms: Record "Payment Terms";
    //     SalespersonPurchaser: Record "Salesperson/Purchaser";
    //     CompanyBankAccount: Record "Bank Account";
    //     SalesSetup: Record "Sales & Receivables Setup";
    //     TempVATAmountLine: Record "VAT Amount Line" temporary;
    //     TempSalesLineArchive: Record "Sales Line Archive" temporary;
    //     DimSetEntry1: Record "Dimension Set Entry";
    //     DimSetEntry2: Record "Dimension Set Entry";
    //     RespCenter: Record "Responsibility Center";
    //     CurrExchRate: Record "Currency Exchange Rate";
    //     Language: Codeunit Language;
    //     FormatAddr: Codeunit "Format Address";
    //     FormatDocument: Codeunit "Format Document";
    //     CustAddr: array[8] of Text[100];
    //     ShipToAddr: array[8] of Text[100];
    //     CompanyAddr: array[8] of Text[100];
    //     SalesPersonText: Text[50];
    //     VATNoText: Text[80];
    //     ReferenceText: Text[80];
    //     TotalText: Text[50];
    //     TotalExclVATText: Text[50];
    //     TotalInclVATText: Text[50];
    //     MoreLines: Boolean;
    //     NoOfCopies: Integer;
    //     NoOfLoops: Integer;
    //     CopyText: Text[30];
    //     ShowShippingAddr: Boolean;
    //     DimText: Text[120];
    //     OldDimText: Text[120];
    //     ShowInternalInfo: Boolean;
    //     Continue: Boolean;
    //     VATAmount: Decimal;
    //     VATBaseAmount: Decimal;
    //     VATDiscountAmount: Decimal;
    //     TotalAmountInclVAT: Decimal;
    //     VALVATBaseLCY: Decimal;
    //     VALVATAmountLCY: Decimal;
    //     VALSpecLCYHeader: Text[80];
    //     VALExchRate: Text[50];
    //     OutputNo: Integer;
    //     ReportTitleLbl: Label 'Archived Blanket Sales Order %1', Comment = '%1 = Document No.';
    //     PageCaptionLbl: Label 'Page %1', Comment = '%1 = page number';
    //     VATAmountSpecTxt: Label 'VAT Amount Specification in %1', Comment = '%1 = Currency Code';
    //     LocalCurrencyTxt: Label 'Local Currency';
    //     ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 = exchange rate, %2 = exchange amount';
    //     VersionLbl: Label 'Version %1 of %2', Comment = '%1 = current version, %2 = max. version';
    //     CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
    //     CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
    //     CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
    //     CompanyInfo__Giro_No__CaptionLbl: Label 'Giro No.';
    //     CompanyInfo__Bank_Name_CaptionLbl: Label 'Bank';
    //     CompanyInfo__Bank_Account_No__CaptionLbl: Label 'Account No.';
    //     Sales_Header_Archive___Shipment_Date_CaptionLbl: Label 'Shipment Date';
    //     Order_No_CaptionLbl: Label 'Blanket Sales Order No.';
    //     Header_DimensionsCaptionLbl: Label 'Header Dimensions';
    //     Unit_PriceCaptionLbl: Label 'Unit Price';
    //     Sales_Line_Archive___Line_Discount___CaptionLbl: Label 'Disc. %';
    //     AmountCaptionLbl: Label 'Amount';
    //     ContinuedCaptionLbl: Label 'Continued';
    //     ContinuedCaption_Control83Lbl: Label 'Continued';
    //     SalesLineArch__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
    //     SubtotalCaptionLbl: Label 'Subtotal';
    //     VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
    //     Line_DimensionsCaptionLbl: Label 'Line Dimensions';
    //     VATAmountLine__VAT___CaptionLbl: Label 'VAT %', Comment = 'VAT';
    //     VATAmountLine__VAT_Base__Control106CaptionLbl: Label 'VAT Base';
    //     VATAmountLine__VAT_Amount__Control107CaptionLbl: Label 'VAT Amount';
    //     VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
    //     VATAmountLine__Inv__Disc__Base_Amount__Control73CaptionLbl: Label 'Inv. Disc. Base Amount';
    //     VATAmountLine__Line_Amount__Control72CaptionLbl: Label 'Line Amount';
    //     VATAmountLine__Invoice_Discount_Amount__Control74CaptionLbl: Label 'Invoice Discount Amount';
    //     VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
    //     VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued';
    //     VATAmountLine__VAT_Base__Control110CaptionLbl: Label 'Continued';
    //     VATAmountLine__VAT_Base__Control114CaptionLbl: Label 'Total';
    //     VALVATAmountLCY_Control149CaptionLbl: Label 'VAT Amount';
    //     VALVATBaseLCY_Control150CaptionLbl: Label 'VAT Base';
    //     VATAmountLine__VAT____Control151CaptionLbl: Label 'VAT %', Comment = 'VAT';
    //     VATAmountLine__VAT_Identifier__Control152CaptionLbl: Label 'VAT Identifier';
    //     VALVATBaseLCYCaptionLbl: Label 'Continued';
    //     VALVATBaseLCY_Control157CaptionLbl: Label 'Continued';
    //     VALVATBaseLCY_Control160CaptionLbl: Label 'Total';
    //     PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
    //     ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method';
    //     Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
}