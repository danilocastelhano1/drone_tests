unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBGrids;

type
  TFrmMain = class(TForm)
    GroupBox1: TGroupBox;
    edtDroneName: TEdit;
    Label1: TLabel;
    edtMaxWeight: TEdit;
    Label2: TLabel;
    Button1: TButton;
    tempTableDrone: TFDMemTable;
    tempTableDronedrone_name: TStringField;
    tempTableDronemax_weight: TFloatField;
    DBGrid1: TDBGrid;
    dsDrone: TDataSource;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    edtLocation: TEdit;
    edtPackageWeight: TEdit;
    Button3: TButton;
    DBGrid2: TDBGrid;
    tempLocation: TFDMemTable;
    dsLocation: TDataSource;
    tempLocationlocation: TStringField;
    tempLocationmax_weight: TFloatField;
    Button4: TButton;
    GroupBox3: TGroupBox;
    memOutPut: TMemo;
    Button5: TButton;
    tempLocationdrone_name: TStringField;
    Button6: TButton;
    Button7: TButton;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    final_text:string;
    { Private declarations }
    procedure CleanFields;
    procedure CleanTempTables(table:TFDMemTable);
    procedure AddDummyDataLocation(location:string;max_weight:Double);
    procedure AddDummyDataDrone(drone:string;max_weight:Double);
    procedure MyKeyPress(Sender: TObject; var Key: Char);
    procedure GenerateTrips;
    procedure AddLineText(text:string);
    procedure TotalWeight(field:string; lbl:Tlabel; table:TFDMemTable);
    procedure CleanUsedLocation;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.AddDummyDataDrone(drone: string; max_weight: Double);
begin
  try
    tempTableDrone.Append;
    tempTableDronedrone_name.AsString := drone;
    tempTableDronemax_weight.AsFloat := max_weight;
    tempTableDrone.Post;
    tempTableDrone.Refresh;
  Except on E:Exception do
    begin
      ShowMessage('Error to Add Drone Registration, Error:'+#13+#10+E.Message);
    end;
  end;
end;

procedure TFrmMain.AddDummyDataLocation(location: string; max_weight: Double);
begin
  try
    tempLocation.Append;
    tempLocationlocation.AsString := location;
    tempLocationmax_weight.AsFloat := max_weight;
    tempLocation.Post;
    tempLocation.Refresh;
  Except on E:Exception do
    begin
      ShowMessage('Error to Add a Location Registration, Error:'+#13+#10+E.Message);
    end;
  end;
end;

procedure TFrmMain.AddLineText(text: string);
begin
  final_text := final_text + text +#13+#10;
end;

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  if edtDroneName.Text  = EmptyStr then
  begin
    ShowMessage('Drone Name is Required!');
    exit;
  end;
  if edtMaxWeight.Text = EmptyStr then
  begin
    ShowMessage('Max Weight is Required!');
    exit;
  end;

  if tempTableDrone.RecordCount >= 100 then
  begin
    ShowMessage('The Maximum Register to Drone is 100 Registration');
    exit;
  end;

  AddDummyDataDrone(edtDroneName.Text, StrToFloat(edtMaxWeight.Text));
  CleanFields();
end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin
  if tempTableDrone.RecordCount > 0 then
    if MessageDlg('Are You Sure to Delete This Record?', mtConfirmation, [mbYes, MbNo], 0) = mrYes then
      tempTableDrone.Delete;
end;

procedure TFrmMain.Button3Click(Sender: TObject);
begin
  if edtLocation.Text  = EmptyStr then
  begin
    ShowMessage('Location is Required!');
    exit;
  end;
  if edtPackageWeight.Text = EmptyStr then
  begin
    ShowMessage('Package Weight is Required!');
    exit;
  end;

  if tempLocation.RecordCount >= 100 then
  begin
    ShowMessage('The Maximum Register to Location is 100 Registrations');
    exit;
  end;

  AddDummyDataLocation(edtLocation.Text, StrToFloat(edtPackageWeight.Text));
  CleanFields();
end;

procedure TFrmMain.Button4Click(Sender: TObject);
begin
  if tempLocation.RecordCount > 0 then
    if MessageDlg('Are You Sure to Delete This Record?', mtConfirmation, [mbYes, MbNo], 0) = mrYes then
      tempLocation.Delete;
end;

procedure TFrmMain.Button5Click(Sender: TObject);
begin
  if (tempTableDrone.RecordCount = 0) or (tempLocation.RecordCount = 0) then
  begin
    ShowMessage('Please, Add Informations Above!');
    exit;
  end;

  GenerateTrips();
  Button7.Click;
end;

procedure TFrmMain.Button6Click(Sender: TObject);
begin
  CleanTempTables(tempTableDrone);

  AddDummyDataDrone('Drone #'+inttostr(tempTableDrone.RecordCount+1), 40);
  AddDummyDataDrone('Drone #'+inttostr(tempTableDrone.RecordCount+1), 90);
  AddDummyDataDrone('Drone #'+inttostr(tempTableDrone.RecordCount+1), 20);
  AddDummyDataDrone('Drone #'+inttostr(tempTableDrone.RecordCount+1), 55);
  AddDummyDataDrone('Drone #'+inttostr(tempTableDrone.RecordCount+1), 65);
  AddDummyDataDrone('Drone #'+inttostr(tempTableDrone.RecordCount+1), 55);
  AddDummyDataDrone('Drone #'+inttostr(tempTableDrone.RecordCount+1), 65);
  AddDummyDataDrone('Drone #'+inttostr(tempTableDrone.RecordCount+1), 60);
  AddDummyDataDrone('Drone #'+inttostr(tempTableDrone.RecordCount+1), 70);
  AddDummyDataDrone('Drone #'+inttostr(tempTableDrone.RecordCount+1), 85);

  TotalWeight('max_weight', label6, tempTableDrone);
end;

procedure TFrmMain.Button7Click(Sender: TObject);
begin
  CleanTempTables(tempLocation);

  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),16);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),14);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),8);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),15);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),8);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),8);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),17);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),5);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),13);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),11);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),10);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),17);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),15);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),9);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),10);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),18);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),5);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),12);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),17);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),8);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),13);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),11);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),12);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),16);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),19);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),20);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),16);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),18);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),11);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),20);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),20);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),10);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),6);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),5);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),19);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),18);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),11);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),19);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),8);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),12);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),15);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),17);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),20);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),17);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),11);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),16);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),15);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),16);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),6);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),10);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),6);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),8);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),12);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),17);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),14);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),9);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),10);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),18);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),11);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),6);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),5);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),15);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),14);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),6);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),15);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),13);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),7);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),11);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),16);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),6);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),6);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),9);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),7);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),12);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),17);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),17);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),5);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),16);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),6);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),9);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),16);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),10);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),10);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),13);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),8);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),6);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),15);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),10);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),8);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),12);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),8);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),10);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),20);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),11);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),13);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),14);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),13);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),18);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),10);
  AddDummyDataLocation('Location #'+IntToStr(tempLocation.RecordCount+1),20);

  TotalWeight('max_weight', label5, tempLocation);
end;

procedure TFrmMain.CleanFields;
begin
  edtDroneName.Clear;
  edtMaxWeight.Clear;

  edtLocation.Clear;
  edtPackageWeight.Clear;
end;

procedure TFrmMain.CleanTempTables(table:TFDMemTable);
begin
  table.EmptyDataset;
end;

procedure TFrmMain.CleanUsedLocation;
begin
  tempLocation.First;
  while not tempLocation.Eof do
  begin
    if tempLocationdrone_name.AsString <> '' then
      tempLocation.Delete;

    tempLocation.next;
  end;
  tempLocation.Refresh;
  tempLocation.First;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  label5.Caption := '';
  label6.Caption := '';

  memOutPut.Lines.Clear;
  CleanFields();

  tempTableDrone.Open;
  tempLocation.Open;

  CleanTempTables(tempTableDrone);
  CleanTempTables(tempLocation);

  edtMaxWeight.OnKeyPress := MyKeyPress;
  edtPackageWeight.OnKeyPress := MyKeyPress;
end;

procedure TFrmMain.GenerateTrips;
var
  current_weight:Real;
  weight_used:Real;
  trip_text:string;
  trip_seq:integer;
  I:integer;
begin
  current_weight := 0;
  weight_used := 0;
  final_text := EmptyStr;

  trip_text := EmptyStr;
  trip_seq  := 0;

  tempTableDrone.First;

    while not tempTableDrone.Eof do
    begin
      trip_seq  := 0;
      AddLineText('[Drone '+tempTableDronedrone_name.AsString+']');

      current_weight := tempTableDronemax_weight.AsFloat;
      
      for I := 1 to 3 do
      begin
        CleanUsedLocation();
        tempLocation.RecordCount;
        while not tempLocation.Eof do
        begin
          if tempLocationdrone_name.AsString <> '' then
            tempLocation.Next
          else
          begin
            if current_weight >= (tempLocationmax_weight.AsFloat + weight_used) then
            begin
              tempLocation.Edit;
              tempLocationdrone_name.AsString := tempTableDronedrone_name.AsString;
              tempLocation.Post;

              weight_used := weight_used + tempLocationmax_weight.AsFloat;
              trip_text := trip_text + '['+tempLocationlocation.AsString+']' + #13+#10;
            end else
            begin
              inc(trip_seq);
              trip_text := 'Trip: #'+trip_seq.ToString + #13+#10 + trip_text;
              AddLineText(trip_text);

              trip_text := EmptyStr;
              weight_used := 0;

              tempLocation.Last;
            end;
          end;
          tempLocation.Next;
        end;

      end;

      tempTableDrone.Next;
    end;

  memOutPut.Lines.Clear;
  memOutPut.Lines.Add(final_text);
end;

procedure TFrmMain.MyKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', ',']) then
    Key := #0;
end;

procedure TFrmMain.TotalWeight(field:string; lbl:Tlabel; table:TFDMemTable);
var
  total:Real;
begin
  total := 0;
  table.First;
  while not table.Eof do
  begin
    total := total + table.FieldByName(field).AsFloat;
    table.Next;
  end;
  lbl.Caption := 'Total Weight: '+ FormatFloat('###,##0.00', total);
end;

end.
