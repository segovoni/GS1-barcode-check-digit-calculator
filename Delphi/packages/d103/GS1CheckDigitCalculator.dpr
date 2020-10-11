program GS1CheckDigitCalculator;

uses
  Vcl.Forms,
  FGS1CDC in '..\..\sources\FGS1CDC.pas' {frmCheckDigitCalculator},
  UGS1CDC.Classes in '..\..\sources\UGS1CDC.Classes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCheckDigitCalculator, frmCheckDigitCalculator);
  Application.Run;
end.
