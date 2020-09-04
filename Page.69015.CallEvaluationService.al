page 69015 "Call Evaluation Server"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(ExprToEvaluate; ExprToEvaluate)
                {
                    Caption = 'Expression to eval';
                    ApplicationArea = All;

                }
                field(UrlScreen; UrlScreen)
                {
                    Caption = 'Url Screen server';
                    ApplicationArea = all;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Evaluate)
            {
                ApplicationArea = All;
                Caption = 'Evaluate';
                ToolTip = 'Solve the expression with an API hosted in Repl';
                Image = "8ball";
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    EvaluateExprServer(UrlDestinoRepl, StrSubstNo('{"Formula":"%1"}', ExprToEvaluate));
                end;
            }
            action(EvaluateIBM)
            {
                ApplicationArea = All;
                Caption = 'Evaluate With IBM Cloud';
                ToolTip = 'Solve the expression with an IBM Cloud API';
                Image = "8ball";
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    EvaluateExprServer(UrlDestinoIBM, StrSubstNo('{"Formula":"%1"}', ExprToEvaluate));
                end;
            }
            action(EvaluateLocal)
            {
                ApplicationArea = All;
                Caption = 'Evaluate With input Url';
                ToolTip = 'Solve the expression with API address typed in textbox';
                Image = "8ball";
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    EvaluateExprServer(UrlScreen, ExprToEvaluate);
                end;
            }

        }
    }

    var
        ExprToEvaluate: Text;
        UrlScreen: Text;
        UrlDestinoRepl: Label 'https://istrueevaluator.jalmarazmartn.repl.co/Evaluate';
        UrlDestinoIBM: Label 'https://3e71fc70.eu-gb.apigw.appdomain.cloud/evaluate-bool-expression/Evaluate';
        UrlDestinoLocal: Label 'http://localhost:8080';

    local procedure EvaluateExprServer(UrlDestino: Text; BodyText: Text);
    var
        ClientExpr: HttpClient;
        RequestExpr: HttpRequestMessage;
        Header: HttpHeaders;
        Response: HttpResponseMessage;
        ReqBody: HttpContent;
        TextoResponse: Text;
    begin
        RequestExpr.SetRequestUri(UrlDestino);
        RequestExpr.Method('POST');
        ReqBody.WriteFrom(BodyText);
        ReqBody.GetHeaders(Header);
        Header.Remove('Content-Type');
        Header.Add('Content-Type', 'application/json');
        RequestExpr.Content(ReqBody);
        ClientExpr.send(RequestExpr, Response);
        Response.Content.ReadAs(TextoResponse);
        Message(TextoResponse);
    end;

}