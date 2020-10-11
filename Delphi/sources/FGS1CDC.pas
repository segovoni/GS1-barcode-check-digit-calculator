unit FGS1CDC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCheckDigitCalculator = class(TForm)
    btnCalculate: TButton;
    edtBarcode: TLabeledEdit;
    edtCheckDigit: TEdit;
    procedure btnCalculateClick(Sender: TObject);
  private
  public
  end;

var
  frmCheckDigitCalculator: TfrmCheckDigitCalculator;

implementation

uses
  UGS1CDC.Classes;

{$R *.dfm}

procedure TfrmCheckDigitCalculator.btnCalculateClick(Sender: TObject);
var
  LGS1CDC: TGS1CheckDigitCalculator;
begin
  LGS1CDC := TGS1CheckDigitCalculator.Create(edtBarcode.Text);
  try
    edtCheckDigit.Text := LGS1CDC.GetCheckDigit.ToString;
  finally
    LGS1CDC.Free;
  end;
end;

end.
