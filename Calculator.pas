unit Calculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls;

type
  // 오브젝트 목록
  TForm1 = class(TForm)
    textDisplay: TEdit; // 계산 결과 및 숫자들을 띄울 TEdit

    // 숫자 버튼
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

    // 연산 버튼
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

    // 함수 목록
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

    // 변수 선언
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

// 연산자 버튼 클릭 ( +, -, X, ÷)
procedure TForm1.ClickOps(Sender: TObject);

var btn: TBitBtn;               // 버튼 변수 생성

begin

  // Sender: 이벤트를 발생시킨 객체 ( TBitBtn )
  btn := Sender as TBitBtn;     // 이벤트 발생 객체를 TBitBtn으로 형변환

  firstNum := textDisplay.Text; // 계산할 때 필요한 숫자 저장
  ops := btn.Caption[1];        // 연산자 버튼에 따라 어떤 연산자인 지 확인

  isOps := True;                // 연산자 버튼 클릭 확인

end;

// BS (백스페이스) 버튼 클릭
procedure TForm1.ClickBS(Sender: TObject);

begin

  // Copy(): SubString() -> 문자열을 자르는 함수
  textDisplay.Text := Copy(textDisplay.Text, 1, Length(textDisplay.Text) - 1);  // 문자열의 마지막 글자를 지움

  // 문자열을 모두 지우면 0으로 변경
  if textDisplay.Text = '' then
    textDisplay.Text := '0';

end;

// C (제거) 버튼 클릭
procedure TForm1.ClickC(Sender: TObject);

begin

  // 모든 변수 초기화
  firstNum := '0';
  secondNum := '0';
  ops := '?';

  // 텍스트 초기화
  textDisplay.Text := '0';

end;

// CE (입력 제거) 버튼 클릭
procedure TForm1.ClickCE(Sender: TObject);

begin

  textDisplay.Text := '0';  // 텍스트 초기화

end;

// [1 / x] 버튼 클릭
procedure TForm1.ClickDivOneByX(Sender: TObject);

begin

  // 현재 숫자가 0이 아닐 때만 실행
  if textDisplay.Text <> '0' then
    textDisplay.Text := FloatToStr(1 / StrToFloat(textDisplay.Text)); // [1 / 현재 숫자] 연산

end;

// [.] 버튼 클릭
procedure TForm1.ClickDot(Sender: TObject);

begin

  // Pos(subStr, str): subStr이 str에 있을 때 -> 처음 발견된 위치 ( 없으면 0 반환 )
  if Pos('.', textDisplay.Text) <> 0 then                   // 현재 숫자에 소수점이 있으면
    Exit                                                    // 실행 X

  else                                                      // 현재 숫자에 소수점이 없으면
    textDisplay.Text := textDisplay.Text + dotBtn.Caption;  // 현재 숫자에 소수점 추가

end;

// [=] 버튼 클릭
procedure TForm1.ClickEquals(Sender: TObject);

begin

  secondNum := textDisplay.Text;  // 계산에 필요한 숫자 저장

  // 연산해야 할 연산자에 따라서 연산
  case ops of
    '+': result := FloatToStr(StrToFloat(firstNum) + StrToFloat(secondNum));
    '-': result := FloatToStr(StrToFloat(firstNum) - StrToFloat(secondNum));
    'X': result := FloatToStr(StrToFloat(firstNum) * StrToFloat(secondNum));
    '÷': result := FloatToStr(StrToFloat(firstNum) / StrToFloat(secondNum));

    // 연산자가 없다면 연산 X
    '?': result := textDisplay.Text;
  end;

  ops := '?';                     // 연산자 초기화
  textDisplay.Text := result;     // 연산 결과 출력

end;

// 숫자 버튼 클릭
procedure TForm1.ClickNum(Sender: TObject);

var
  btn: TBitBtn;                                         // 버튼 변수 생성

begin

  btn := Sender as TBitBtn;                             // 버튼 변수 초기화

  // 만약 방금 연산자 버튼을 눌렀다면
  if isOps then
  begin

    isOps := False;                   // 연산자 입력 확인 False
    textDisplay.Text := btn.Caption;  // 숫자 입력

  end

  // 만약 현재 숫자가 0이면
  else if textDisplay.Text = '0' then
    textDisplay.Text := btn.Caption                     // 생으로 숫자 추가

  // 만약 현재 숫자가 0이 아니면
  else
    textDisplay.Text := textDisplay.Text + btn.Caption; // 현재 숫자 뒤에 숫자 추가

end;

// [±] 버튼 클릭
procedure TForm1.ClickPM(Sender: TObject);

var
  q: Real;                                // 임시 변수 생성 ( 실수형 )

begin

  q := StrToFloat(textDisplay.Text);      // 임시 변수에 현재 숫자 저장
  textDisplay.Text := FloatToStr(-1 * q); // 현재 숫자를 (현재 숫자 * (-1))로 저장

end;

// [%] 버튼 클릭
procedure TForm1.ClickPS(Sender: TObject);

begin

  secondNum := textDisplay.Text;                                              // 연산에 필요한 숫자 저장

  result := FloatToStr(StrToFloat(firstNum) * (StrToFloat(secondNum) / 100)); // % 연산
  textDisplay.Text := result;                                                 // 연산 결과 출력

end;

// [√] 버튼 클릭
procedure TForm1.ClickRt(Sender: TObject);

begin

  textDisplay.Text := FloatToStr(Sqrt(StrToFloat(textDisplay.Text))); // 제곱근 연산 수행

end;

// [x²] 버튼 클릭
procedure TForm1.ClickSqr(Sender: TObject);

begin

  textDisplay.Text := FloatToStr(Sqr(StrToFloat(textDisplay.Text)));  // 제곱 연산 수행

end;

// TForm이 생성될 때 ( 프로그램이 실행 될 때 )
procedure TForm1.FormCreate(Sender: TObject);

begin

  // 연산자 및 현재 숫자 초기화
  ops := '?';
  textDisplay.Text := '0';

end;

end.

