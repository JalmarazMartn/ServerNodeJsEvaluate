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
                Image = "8ball";
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    EvaluateExprRepl();
                end;
            }
            action(EvaluateIBM)
            {
                ApplicationArea = All;
                Caption = 'Evaluate With IBM Cloud';
                Image = "8ball";
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    EvaluateExprIBMCloud();
                end;
            }

        }
    }

    var
        ExprToEvaluate: Text;
        UrlDestinoRepl: Label 'https://istrueevaluator.jalmarazmartn.repl.co/Evaluate';
        UrlDestinoIBM: Label 'https://3e71fc70.eu-gb.apigw.appdomain.cloud/evaluate-bool-expression/Evaluate';

    local procedure EvaluateExprRepl()
    var
        ClientExpr: HttpClient;
        RequestExpr: HttpRequestMessage;
        Header: HttpHeaders;
        Response: HttpResponseMessage;
        ReqBody: HttpContent;
        TextoResponse: Text;
    begin
        RequestExpr.SetRequestUri(UrlDestinoRepl);
        RequestExpr.Method('POST');
        ReqBody.WriteFrom(StrSubstNo('{"Formula":"%1"}', ExprToEvaluate));
        ReqBody.GetHeaders(Header);
        Header.Remove('Content-Type');
        Header.Add('Content-Type', 'application/json');
        RequestExpr.Content(ReqBody);
        ClientExpr.send(RequestExpr, Response);
        Response.Content.ReadAs(TextoResponse);
        Message(TextoResponse);
    end;

    local procedure EvaluateExprIBMCloud()
    var
        ClientExpr: HttpClient;
        RequestExpr: HttpRequestMessage;
        Header: HttpHeaders;
        Response: HttpResponseMessage;
        ReqBody: HttpContent;
        TextoResponse: Text;
    begin
        RequestExpr.SetRequestUri(UrlDestinoIBM);
        RequestExpr.Method('POST');
        ReqBody.WriteFrom(StrSubstNo('{"Formula":"%1"}', ExprToEvaluate));
        ReqBody.GetHeaders(Header);
        Header.Remove('Content-Type');
        Header.Add('Content-Type', 'application/json');
        RequestExpr.Content(ReqBody);
        ClientExpr.send(RequestExpr, Response);
        Response.Content.ReadAs(TextoResponse);
        Message(TextoResponse);
    end;
}