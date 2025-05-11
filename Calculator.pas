unit Calculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls;

type
  // ������Ʈ ���
  TForm1 = class(TForm)
    textDisplay: TEdit; // ��� ��� �� ���ڵ��� ��� TEdit

    // ���� ��ư
    digitBtn1: TBitBtn;
    digitBtn2: TBitBtn;
    digitBtn3: TBitBtn;
    digitBtn4: TBitBtn;
    digitBtn5: TBitBtn;
    digitBtn6: TBitBtn;
    digitBtn7: TBitBtn;
    digitBtn8: TBitBtn;
    digitBtn9: TBitBtn;
    digitBtn0: TBitBtn;

    // ���� ��ư
    pmBtn: TBitBtn;
    dotBtn: TBitBtn;
    equalsBtn: TBitBtn;
    plusBtn: TBitBtn;
    subBtn: TBitBtn;
    multiBtn: TBitBtn;
    divBtn: TBitBtn;
    bsBtn: TBitBtn;
    cBtn: TBitBtn;
    ceBtn: TBitBtn;
    pcBtn: TBitBtn;
    rtBtn: TBitBtn;
    sqrBtn: TBitBtn;
    div1ByXBtn: TBitBtn;

    // �Լ� ���
    procedure ClickNum(Sender: TObject);
    procedure ClickC(Sender: TObject);
    procedure ClickBS(Sender: TObject);
    procedure ClickCE(Sender: TObject);
    procedure ClickPM(Sender: TObject);
    procedure ClickOps(Sender: TObject);
    procedure ClickDot(Sender: TObject);
    procedure ClickEquals(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClickPS(Sender: TObject);
    procedure ClickDivOneByX(Sender: TObject);
    procedure ClickSqr(Sender: TObject);
    procedure ClickRt(Sender: TObject);
  private
    { Private declarations }

    // ���� ����
    firstNum, secondNum, result: string;
    ops: char;
    isOps: bool;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

// ������ ��ư Ŭ�� ( +, -, X, ��)
procedure TForm1.ClickOps(Sender: TObject);

var btn: TBitBtn;               // ��ư ���� ����

begin

  // Sender: �̺�Ʈ�� �߻���Ų ��ü ( TBitBtn )
  btn := Sender as TBitBtn;     // �̺�Ʈ �߻� ��ü�� TBitBtn���� ����ȯ

  firstNum := textDisplay.Text; // ����� �� �ʿ��� ���� ����
  ops := btn.Caption[1];        // ������ ��ư�� ���� � �������� �� Ȯ��

  isOps := True;                // ������ ��ư Ŭ�� Ȯ��

end;

// BS (�齺���̽�) ��ư Ŭ��
procedure TForm1.ClickBS(Sender: TObject);

begin

  // Copy(): SubString() -> ���ڿ��� �ڸ��� �Լ�
  textDisplay.Text := Copy(textDisplay.Text, 1, Length(textDisplay.Text) - 1);  // ���ڿ��� ������ ���ڸ� ����

  // ���ڿ��� ��� ����� 0���� ����
  if textDisplay.Text = '' then
    textDisplay.Text := '0';

end;

// C (����) ��ư Ŭ��
procedure TForm1.ClickC(Sender: TObject);

begin

  // ��� ���� �ʱ�ȭ
  firstNum := '0';
  secondNum := '0';
  ops := '?';

  // �ؽ�Ʈ �ʱ�ȭ
  textDisplay.Text := '0';

end;

// CE (�Է� ����) ��ư Ŭ��
procedure TForm1.ClickCE(Sender: TObject);

begin

  textDisplay.Text := '0';  // �ؽ�Ʈ �ʱ�ȭ

end;

// [1 / x] ��ư Ŭ��
procedure TForm1.ClickDivOneByX(Sender: TObject);

begin

  // ���� ���ڰ� 0�� �ƴ� ���� ����
  if textDisplay.Text <> '0' then
    textDisplay.Text := FloatToStr(1 / StrToFloat(textDisplay.Text)); // [1 / ���� ����] ����

end;

// [.] ��ư Ŭ��
procedure TForm1.ClickDot(Sender: TObject);

begin

  // Pos(subStr, str): subStr�� str�� ���� �� -> ó�� �߰ߵ� ��ġ ( ������ 0 ��ȯ )
  if Pos('.', textDisplay.Text) <> 0 then                   // ���� ���ڿ� �Ҽ����� ������
    Exit                                                    // ���� X

  else                                                      // ���� ���ڿ� �Ҽ����� ������
    textDisplay.Text := textDisplay.Text + dotBtn.Caption;  // ���� ���ڿ� �Ҽ��� �߰�

end;

// [=] ��ư Ŭ��
procedure TForm1.ClickEquals(Sender: TObject);

begin

  secondNum := textDisplay.Text;  // ��꿡 �ʿ��� ���� ����

  // �����ؾ� �� �����ڿ� ���� ����
  case ops of
    '+': result := FloatToStr(StrToFloat(firstNum) + StrToFloat(secondNum));
    '-': result := FloatToStr(StrToFloat(firstNum) - StrToFloat(secondNum));
    'X': result := FloatToStr(StrToFloat(firstNum) * StrToFloat(secondNum));
    '��': result := FloatToStr(StrToFloat(firstNum) / StrToFloat(secondNum));

    // �����ڰ� ���ٸ� ���� X
    '?': result := textDisplay.Text;
  end;

  ops := '?';                     // ������ �ʱ�ȭ
  textDisplay.Text := result;     // ���� ��� ���

end;

// ���� ��ư Ŭ��
procedure TForm1.ClickNum(Sender: TObject);

var
  btn: TBitBtn;                                         // ��ư ���� ����

begin

  btn := Sender as TBitBtn;                             // ��ư ���� �ʱ�ȭ

  // ���� ��� ������ ��ư�� �����ٸ�
  if isOps then
  begin

    isOps := False;                   // ������ �Է� Ȯ�� False
    textDisplay.Text := btn.Caption;  // ���� �Է�

  end

  // ���� ���� ���ڰ� 0�̸�
  else if textDisplay.Text = '0' then
    textDisplay.Text := btn.Caption                     // ������ ���� �߰�

  // ���� ���� ���ڰ� 0�� �ƴϸ�
  else
    textDisplay.Text := textDisplay.Text + btn.Caption; // ���� ���� �ڿ� ���� �߰�

end;

// [��] ��ư Ŭ��
procedure TForm1.ClickPM(Sender: TObject);

var
  q: Real;                                // �ӽ� ���� ���� ( �Ǽ��� )

begin

  q := StrToFloat(textDisplay.Text);      // �ӽ� ������ ���� ���� ����
  textDisplay.Text := FloatToStr(-1 * q); // ���� ���ڸ� (���� ���� * (-1))�� ����

end;

// [%] ��ư Ŭ��
procedure TForm1.ClickPS(Sender: TObject);

begin

  secondNum := textDisplay.Text;                                              // ���꿡 �ʿ��� ���� ����

  result := FloatToStr(StrToFloat(firstNum) * (StrToFloat(secondNum) / 100)); // % ����
  textDisplay.Text := result;                                                 // ���� ��� ���

end;

// [��] ��ư Ŭ��
procedure TForm1.ClickRt(Sender: TObject);

begin

  textDisplay.Text := FloatToStr(Sqrt(StrToFloat(textDisplay.Text))); // ������ ���� ����

end;

// [x��] ��ư Ŭ��
procedure TForm1.ClickSqr(Sender: TObject);

begin

  textDisplay.Text := FloatToStr(Sqr(StrToFloat(textDisplay.Text)));  // ���� ���� ����

end;

// TForm�� ������ �� ( ���α׷��� ���� �� �� )
procedure TForm1.FormCreate(Sender: TObject);

begin

  // ������ �� ���� ���� �ʱ�ȭ
  ops := '?';
  textDisplay.Text := '0';

end;

end.

