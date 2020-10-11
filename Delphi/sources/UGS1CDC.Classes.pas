unit UGS1CDC.Classes;

interface

type
  /// <summary>
  ///   Abstract class from which to derive classes that implement
  ///   specific check digit calculation alborithms
  /// </summary>
  THandler = class abstract
  public
    function HandleRequest(const AValue: string): Integer; virtual; abstract;
  end;

  /// <summary>
  ///   TGS1EAN8Handler
  /// </summary>
  TGS1EAN8CheckDigitHandler = class(THandler)
  private
    FHandler: THandler;
  public
    property Successor: THandler read FHandler write FHandler;
    function HandleRequest(const AValue: string): Integer; override;
  end;

  /// <summary>
  ///  TGS1EAN12Handler
  /// </summary>
  TGS1EAN12CheckDigitHandler = class(THandler)
  private
    FHandler: THandler;
  public
    property Successor: THandler read FHandler write FHandler;
    function HandleRequest(const AValue: string): Integer; override;
  end;

  /// <summary>
  ///  TGS1EAN13Handler
  /// </summary>
  TGS1EAN13CheckDigitHandler = class(THandler)
  protected
    FHandler: THandler;
  public
    property Successor: THandler read FHandler write FHandler;
    function HandleRequest(const AValue: string): Integer; override;
  end;

  /// <summary>
  ///  TGS1EAN14Handler
  /// </summary>
  TGS1EAN14CheckDigitHandler = class(THandler)
  protected
    FHandler: THandler;
  public
    property Successor: THandler read FHandler write FHandler;
    function HandleRequest(const AValue: string): Integer; override;
  end;

  /// <summary>
  ///  TGS1SSCCHandler
  /// </summary>
  TGS1SSCCCheckDigitHandler = class(THandler)
  protected
    FHandler: THandler;
  public
    property Successor: THandler read FHandler write FHandler;
    function HandleRequest(const AValue: string): Integer; override;
  end;

  /// <summary>
  ///  GS1 check digit calculator
  /// </summary>
  TGS1CheckDigitCalculator = class
  protected
    FGS1Barcode: string;
  private
    FGS1EAN8: TGS1EAN8CheckDigitHandler;
    FGS1EAN12: TGS1EAN12CheckDigitHandler;
    FGS1EAN13: TGS1EAN13CheckDigitHandler;
    FGS1EAN14: TGS1EAN14CheckDigitHandler;
    FGS1SSCC: TGS1SSCCCheckDigitHandler;
  public
    constructor Create(AValue: string);
    destructor Destroy; override;
    function GetCheckDigit: Integer;
  end;

implementation

uses
  System.SysUtils;

{ TGS1EAN8CheckDigitHandler }

function TGS1EAN8CheckDigitHandler.HandleRequest(const AValue: string): Integer;
begin
  if Length(Trim(AValue)) = 7 then
    result := (10 - (3* StrToInt(Copy(AValue, 1, 1))
                     + StrToInt(Copy(AValue, 2, 1))
                     + 3* StrToInt(Copy(AValue, 3, 1))
                     + StrToInt(Copy(AValue, 4, 1))
                     + 3* StrToInt(Copy(AValue, 5, 1))
                     + StrToInt(Copy(AValue, 6, 1))
                     + 3* StrToInt(Copy(AValue, 7, 1))
                    ) mod 10
              ) mod 10
  else
    if Assigned(Successor) then
      result := Successor.HandleRequest(AValue)
    else
      result := -1;
end;

{ TGS1EAN12CheckDigitHandler }

function TGS1EAN12CheckDigitHandler.HandleRequest(const AValue: string): Integer;
begin
  if Length(Trim(AValue)) = 11 then
    result := (10 - (3* StrToInt(Copy(AValue, 1, 1))
                     + StrToInt(Copy(AValue, 2, 1))
                     + 3* StrToInt(Copy(AValue, 3, 1))
                     + StrToInt(Copy(AValue, 4, 1))
                     + 3* StrToInt(Copy(AValue, 5, 1))
                     + StrToInt(Copy(AValue, 6, 1))
                     + 3* StrToInt(Copy(AValue, 7, 1))
                     + StrToInt(Copy(AValue, 8, 1))
                     + 3* StrToInt(Copy(AValue, 9, 1))
                     + StrToInt(Copy(AValue, 10, 1))
                     + 3* StrToInt(Copy(AValue, 11, 1))
                    ) mod 10
              ) mod 10
  else
    if Assigned(Successor) then
      result := Successor.HandleRequest(AValue)
    else
      result := -1;
end;

{ TGS1EAN13CheckDigitHandler }

function TGS1EAN13CheckDigitHandler.HandleRequest(const AValue: string): Integer;
begin
  if Length(Trim(AValue)) = 12 then
    result := (10 - (StrToInt(Copy(AValue, 1, 1))
                     + 3* StrToInt(Copy(AValue, 2, 1))
                     + StrToInt(Copy(AValue, 3, 1))
                     + 3* StrToInt(Copy(AValue, 4, 1))
                     + StrToInt(Copy(AValue, 5, 1))
                     + 3* StrToInt(Copy(AValue, 6, 1))
                     + StrToInt(Copy(AValue, 7, 1))
                     + 3* StrToInt(Copy(AValue, 8, 1))
                     + StrToInt(Copy(AValue, 9, 1))
                     + 3* StrToInt(Copy(AValue, 10, 1))
                     + StrToInt(Copy(AValue, 11, 1))
                     + 3* StrToInt(Copy(AValue, 12, 1))
                    ) mod 10
              ) mod 10
  else
    if Assigned(Successor) then
      result := Successor.HandleRequest(AValue)
    else
      result := -1;
end;

{ TGS1EAN14CheckDigitHandler }

function TGS1EAN14CheckDigitHandler.HandleRequest(const AValue: string): Integer;
begin
  if Length(Trim(AValue)) = 13 then
    result := (10 - (3* StrToInt(Copy(AValue, 1, 1))
                     + StrToInt(Copy(AValue, 2, 1))
                     + 3* StrToInt(Copy(AValue, 3, 1))
                     + StrToInt(Copy(AValue, 4, 1))
                     + 3* StrToInt(Copy(AValue, 5, 1))
                     + StrToInt(Copy(AValue, 6, 1))
                     + 3* StrToInt(Copy(AValue, 7, 1))
                     + StrToInt(Copy(AValue, 8, 1))
                     + 3* StrToInt(Copy(AValue, 9, 1))
                     + StrToInt(Copy(AValue, 10, 1))
                     + 3* StrToInt(Copy(AValue, 11, 1))
                     + StrToInt(Copy(AValue, 12, 1))
                     + 3* StrToInt(Copy(AValue, 13, 1))
                    ) mod 10
              ) mod 10
  else
    if Assigned(Successor) then
      result := Successor.HandleRequest(AValue)
    else
      result := -1;
end;

{ TGS1SSCCCheckDigitHandler }

function TGS1SSCCCheckDigitHandler.HandleRequest(const AValue: string): Integer;
begin
  if Length(Trim(AValue)) = 17 then
    result := (10 - (3* StrToInt(Copy(AValue, 1, 1))
                     + StrToInt(Copy(AValue, 2, 1))
                     + 3* StrToInt(Copy(AValue, 3, 1))
                     + StrToInt(Copy(AValue, 4, 1))
                     + 3* StrToInt(Copy(AValue, 5, 1))
                     + StrToInt(Copy(AValue, 6, 1))
                     + 3* StrToInt(Copy(AValue, 7, 1))
                     + StrToInt(Copy(AValue, 8, 1))
                     + 3* StrToInt(Copy(AValue, 9, 1))
                     + StrToInt(Copy(AValue, 10, 1))
                     + 3* StrToInt(Copy(AValue, 11, 1))
                     + StrToInt(Copy(AValue, 12, 1))
                     + 3* StrToInt(Copy(AValue, 13, 1))
                     + StrToInt(Copy(AValue, 14, 1))
                     + 3* StrToInt(Copy(AValue, 15, 1))
                     + StrToInt(Copy(AValue, 16, 1))
                     + 3* StrToInt(Copy(AValue, 17, 1))
                    ) mod 10
              ) mod 10
  else
    if Assigned(Successor) then
      result := Successor.HandleRequest(AValue)
    else
      result := -1;
end;

{ TGS1CheckDigitCalculator }

constructor TGS1CheckDigitCalculator.Create(AValue: string);
begin
  FGS1Barcode := AValue;

  FGS1EAN8 := TGS1EAN8CheckDigitHandler.Create;
  FGS1EAN12 := TGS1EAN12CheckDigitHandler.Create;
  FGS1EAN13 := TGS1EAN13CheckDigitHandler.Create;
  FGS1EAN14 := TGS1EAN14CheckDigitHandler.Create;
  FGS1SSCC := TGS1SSCCCheckDigitHandler.Create;

  FGS1EAN8.Successor := FGS1EAN12;
  FGS1EAN12.Successor := FGS1EAN13;
  FGS1EAN13.Successor := FGS1EAN14;
  FGS1EAN14.Successor := FGS1SSCC;
  FGS1SSCC.Successor := nil;
end;

destructor TGS1CheckDigitCalculator.Destroy;
begin
  FGS1SSCC.Free;
  FGS1EAN14.Free;
  FGS1EAN13.Free;
  FGS1EAN12.Free;
  FGS1EAN8.Free;

  inherited;
end;

function TGS1CheckDigitCalculator.GetCheckDigit: Integer;
begin
  result := FGS1EAN8.HandleRequest(FGS1Barcode);
  if (result < 0) then
    raise Exception.Create('The number you entered is not supported. Please try again!');
end;

initialization

finalization
  ReportMemoryLeaksOnShutdown := True;

end.
