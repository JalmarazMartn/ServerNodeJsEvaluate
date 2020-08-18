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
                    EvaluateExpr();
                end;
            }
        }
    }

    var
        ExprToEvaluate: Text;
        UrlDestino: Label 'https://istrueevaluator.jalmarazmartn.repl.co/Evaluate';

    local procedure EvaluateExpr()
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