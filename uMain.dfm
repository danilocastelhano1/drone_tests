object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Drone Test Danilo A. Castelhano'
  ClientHeight = 487
  ClientWidth = 998
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 489
    Height = 209
    Caption = 'Drone Registration:'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 23
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object Label2: TLabel
      Left = 200
      Top = 23
      Width = 81
      Height = 13
      Caption = 'Maximum Weight'
    end
    object Label6: TLabel
      Left = 288
      Top = 193
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Label6'
    end
    object edtDroneName: TEdit
      Left = 16
      Top = 40
      Width = 169
      Height = 21
      MaxLength = 50
      TabOrder = 0
    end
    object edtMaxWeight: TEdit
      Left = 200
      Top = 40
      Width = 81
      Height = 21
      MaxLength = 10
      TabOrder = 1
    end
    object Button1: TButton
      Left = 304
      Top = 36
      Width = 75
      Height = 25
      Caption = 'Add Drone'
      TabOrder = 2
      OnClick = Button1Click
    end
    object DBGrid1: TDBGrid
      Left = 16
      Top = 67
      Width = 363
      Height = 120
      DataSource = dsDrone
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'drone_name'
          Title.Caption = 'Drone Name'
          Width = 187
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'max_weight'
          Title.Caption = 'Maximum Weight'
          Width = 102
          Visible = True
        end>
    end
    object Button6: TButton
      Left = 385
      Top = 18
      Width = 101
      Height = 25
      Caption = 'Add Dummy Data'
      TabOrder = 4
      OnClick = Button6Click
    end
  end
  object Button2: TButton
    Left = 385
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Del Drone'
    TabOrder = 1
    OnClick = Button2Click
  end
  object GroupBox2: TGroupBox
    Left = 492
    Top = 0
    Width = 489
    Height = 209
    Caption = 'Drone Registration:'
    TabOrder = 2
    object Label3: TLabel
      Left = 16
      Top = 23
      Width = 44
      Height = 13
      Caption = 'Location:'
    end
    object Label4: TLabel
      Left = 200
      Top = 23
      Width = 77
      Height = 13
      Caption = 'Package Weight'
    end
    object Label5: TLabel
      Left = 312
      Top = 193
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Label5'
    end
    object edtLocation: TEdit
      Left = 16
      Top = 40
      Width = 169
      Height = 21
      MaxLength = 60
      TabOrder = 0
    end
    object edtPackageWeight: TEdit
      Left = 199
      Top = 40
      Width = 81
      Height = 21
      MaxLength = 10
      TabOrder = 1
    end
    object Button3: TButton
      Left = 304
      Top = 36
      Width = 75
      Height = 25
      Caption = 'Add Location'
      TabOrder = 2
      OnClick = Button3Click
    end
    object DBGrid2: TDBGrid
      Left = 16
      Top = 67
      Width = 363
      Height = 120
      DataSource = dsLocation
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'location'
          Title.Caption = 'Location'
          Width = 225
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'max_weight'
          Title.Caption = 'Max Weight'
          Width = 86
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'drone_name'
          Visible = False
        end>
    end
    object Button4: TButton
      Left = 385
      Top = 67
      Width = 75
      Height = 25
      Caption = 'Del Location'
      TabOrder = 4
      OnClick = Button4Click
    end
    object Button7: TButton
      Left = 385
      Top = 18
      Width = 101
      Height = 25
      Caption = 'Add Dummy Data'
      TabOrder = 5
      OnClick = Button7Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 270
    Width = 998
    Height = 217
    Align = alBottom
    Caption = 'Output:'
    TabOrder = 3
    object memOutPut: TMemo
      Left = 2
      Top = 15
      Width = 994
      Height = 200
      Align = alClient
      Lines.Strings = (
        'memOutPut')
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Button5: TButton
    Left = 0
    Top = 223
    Width = 998
    Height = 47
    Align = alBottom
    Caption = 'Calculate Drones Location'
    TabOrder = 4
    OnClick = Button5Click
  end
  object tempTableDrone: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 448
    Top = 96
    object tempTableDronedrone_name: TStringField
      FieldName = 'drone_name'
      Size = 50
    end
    object tempTableDronemax_weight: TFloatField
      FieldName = 'max_weight'
    end
  end
  object dsDrone: TDataSource
    DataSet = tempTableDrone
    Left = 386
    Top = 96
  end
  object tempLocation: TFDMemTable
    Filtered = True
    Filter = 'drone_name <> '#39#39
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 880
    Top = 96
    object tempLocationlocation: TStringField
      FieldName = 'location'
      Size = 60
    end
    object tempLocationmax_weight: TFloatField
      FieldName = 'max_weight'
    end
    object tempLocationdrone_name: TStringField
      DisplayWidth = 50
      FieldName = 'drone_name'
      Size = 30
    end
  end
  object dsLocation: TDataSource
    DataSet = tempLocation
    Left = 944
    Top = 96
  end
end
