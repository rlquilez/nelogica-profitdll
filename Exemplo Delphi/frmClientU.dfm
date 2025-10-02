object frmClient: TfrmClient
  Left = 0
  Top = 0
  Caption = 'ProfitDLL Client'
  ClientHeight = 671
  ClientWidth = 1042
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 225
    Height = 671
    Align = alLeft
    TabOrder = 0
    object lbPass: TLabel
      Left = 16
      Top = 101
      Width = 34
      Height = 13
      Caption = 'Senha:'
    end
    object lbActCode: TLabel
      Left = 19
      Top = 157
      Width = 97
      Height = 13
      Caption = 'C'#243'digo de Ativa'#231#227'o:'
    end
    object lbUser: TLabel
      Left = 16
      Top = 45
      Width = 40
      Height = 13
      Caption = 'Usu'#225'rio:'
    end
    object lbLogin: TLabel
      Left = 1
      Top = 1
      Width = 70
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Dados de login'
    end
    object lbStatus: TLabel
      Left = 18
      Top = 302
      Width = 102
      Height = 13
      Caption = 'Status da conex'#227'o...'
    end
    object imgInfoOff: TImage
      Left = 127
      Top = 301
      Width = 21
      Height = 17
      Hint = 'Info desconectado'
      ParentShowHint = False
      Proportional = True
      ShowHint = True
    end
    object imgMdOff: TImage
      Left = 154
      Top = 301
      Width = 21
      Height = 17
      Hint = 'Market Data desconectado'
      ParentShowHint = False
      Proportional = True
      ShowHint = True
    end
    object imgRotOff: TImage
      Left = 182
      Top = 301
      Width = 20
      Height = 17
      Hint = 'Roteamento desconectado'
      ParentShowHint = False
      Proportional = True
      ShowHint = True
    end
    object lbLoginResult: TLabel
      Left = 18
      Top = 328
      Width = 63
      Height = 13
      Caption = 'lbLoginResult'
      Visible = False
    end
    object imgInfoOn: TImage
      Left = 127
      Top = 301
      Width = 21
      Height = 17
      Hint = 'Info conectado'
      ParentShowHint = False
      Proportional = True
      ShowHint = True
      Visible = False
    end
    object imgMdOn: TImage
      Left = 154
      Top = 301
      Width = 21
      Height = 17
      Hint = 'Market Data conectado'
      ParentShowHint = False
      Proportional = True
      ShowHint = True
      Visible = False
    end
    object imgRotOn: TImage
      Left = 182
      Top = 301
      Width = 20
      Height = 17
      Hint = 'Roteamento conectado'
      ParentShowHint = False
      Proportional = True
      ShowHint = True
      Visible = False
    end
    object edtUser: TEdit
      Left = 16
      Top = 64
      Width = 185
      Height = 21
      TabOrder = 0
      TextHint = 'Usu'#225'rio'
    end
    object edtPass: TEdit
      Left = 16
      Top = 120
      Width = 185
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
      TextHint = 'Senha'
    end
    object edtActCode: TEdit
      Left = 16
      Top = 176
      Width = 185
      Height = 21
      TabOrder = 2
      TextHint = 'C'#243'digo de Ativa'#231#227'o'
    end
    object btnInitialize: TButton
      Left = 16
      Top = 221
      Width = 185
      Height = 25
      Caption = 'Inicializar + Logar'
      TabOrder = 3
      OnClick = btnInitializeClick
    end
    object btnFinalize: TButton
      Left = 16
      Top = 260
      Width = 185
      Height = 25
      Caption = 'Finalizar + Deslogar'
      TabOrder = 4
      OnClick = btnFinalizeClick
    end
    object pnlFunc: TPanel
      Left = 1
      Top = 519
      Width = 223
      Height = 151
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 5
      object lbVersion: TLabel
        Left = 4
        Top = 134
        Width = 137
        Height = 13
        Caption = 'ProfitDLL version found: '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsUnderline]
        ParentColor = False
        ParentFont = False
      end
    end
  end
  object pnlRight: TPanel
    Left = 525
    Top = 0
    Width = 517
    Height = 671
    Align = alClient
    TabOrder = 1
    object lbCallbackTitle: TLabel
      Left = 1
      Top = 1
      Width = 104
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Retorno das callbacks'
    end
    object lbFuncTitle: TLabel
      Left = 1
      Top = 601
      Width = 147
      Height = 13
      Align = alBottom
      Alignment = taCenter
      Caption = 'Retorno das fun'#231#245'es expostas'
    end
    object mmUpdates: TMemo
      Left = 1
      Top = 32
      Width = 515
      Height = 569
      Align = alClient
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object mmFunc: TMemo
      Left = 1
      Top = 614
      Width = 515
      Height = 56
      Align = alBottom
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
    end
    object btnClearUpdates: TButton
      Left = 1
      Top = 14
      Width = 515
      Height = 18
      Align = alTop
      Caption = 'Limpar linhas'
      TabOrder = 2
      OnClick = btnClearUpdatesClick
    end
  end
  object pnlPC: TPanel
    Left = 225
    Top = 0
    Width = 300
    Height = 671
    Align = alLeft
    TabOrder = 2
    object lbFunc: TLabel
      Left = 1
      Top = 1
      Width = 298
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Fun'#231#245'es (v3.0.0.10)'
      ExplicitWidth = 99
    end
    object lblDeprecated: TLabel
      Left = 1
      Top = 36
      Width = 298
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'NewFunction'
      Visible = False
      WordWrap = True
      ExplicitWidth = 62
    end
    object pcType: TPageControl
      Left = 1
      Top = 49
      Width = 298
      Height = 596
      ActivePage = tabMd
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      object tabRot: TTabSheet
        Caption = 'tabRot'
        TabVisible = False
        object lbContaRot: TLabel
          Left = 90
          Top = 28
          Width = 29
          Height = 13
          Caption = 'Conta'
        end
        object lbBrokerIdRot: TLabel
          Left = 19
          Top = 28
          Width = 47
          Height = 13
          Caption = 'Corretora'
        end
        object lbPassRot: TLabel
          Left = 22
          Top = 74
          Width = 125
          Height = 13
          Caption = 'Senha de envio de ordens'
        end
        object lbTickerRot: TLabel
          Left = 22
          Top = 120
          Width = 28
          Height = 13
          Caption = 'Ticker'
        end
        object lbBolsaRot: TLabel
          Left = 110
          Top = 120
          Width = 25
          Height = 13
          Caption = 'Bolsa'
        end
        object lbPriceRot: TLabel
          Left = 22
          Top = 166
          Width = 27
          Height = 13
          Caption = 'Pre'#231'o'
        end
        object lbAmountRot: TLabel
          Left = 110
          Top = 166
          Width = 56
          Height = 13
          Caption = 'Quantidade'
        end
        object lbTitleRot: TLabel
          Left = 0
          Top = 0
          Width = 290
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'Dados Roteamento'
          ExplicitWidth = 92
        end
        object lbPriceStopRot: TLabel
          Left = 187
          Top = 166
          Width = 52
          Height = 13
          Caption = 'Pre'#231'o Stop'
        end
        object lbClOrdIdRot: TLabel
          Left = 22
          Top = 294
          Width = 109
          Height = 13
          Caption = 'Id da Ordem (ClOrdID)'
        end
        object bvRot: TBevel
          Left = 1
          Top = 386
          Width = 299
          Height = 7
          Shape = bsBottomLine
        end
        object lbDateStartRot: TLabel
          Left = 22
          Top = 399
          Width = 51
          Height = 13
          Caption = 'Data inicial'
        end
        object lbDateEndRot: TLabel
          Left = 160
          Top = 399
          Width = 46
          Height = 13
          Caption = 'Data final'
        end
        object lbProfitIdRot: TLabel
          Left = 21
          Top = 340
          Width = 135
          Height = 13
          Caption = 'Id Local da Ordem (ProfitID)'
        end
        object lblSubAccount: TLabel
          Left = 191
          Top = 28
          Width = 47
          Height = 13
          Caption = 'SubConta'
        end
        object lblStartSource: TLabel
          Left = 21
          Top = 445
          Width = 25
          Height = 13
          Caption = 'In'#237'cio'
        end
        object lblTotalCount: TLabel
          Left = 99
          Top = 445
          Width = 24
          Height = 13
          Caption = 'Total'
        end
        object lblPositionType: TLabel
          Left = 22
          Top = 247
          Width = 74
          Height = 13
          Caption = 'Tipo de Posi'#231#227'o'
        end
        object edtBrokerAccRot: TEdit
          Left = 90
          Top = 47
          Width = 95
          Height = 21
          TabOrder = 1
        end
        object edtBrokerIdRot: TEdit
          Left = 19
          Top = 47
          Width = 65
          Height = 21
          TabOrder = 0
        end
        object edtPassRot: TEdit
          Left = 19
          Top = 93
          Width = 153
          Height = 21
          PasswordChar = '*'
          TabOrder = 3
        end
        object edtTickerRot: TEdit
          Left = 19
          Top = 139
          Width = 62
          Height = 21
          TabOrder = 4
        end
        object cbBolsaRot: TComboBox
          Left = 107
          Top = 139
          Width = 41
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 5
          Text = 'B'
          Items.Strings = (
            'B'
            'F')
        end
        object edtPriceRot: TEdit
          Left = 19
          Top = 185
          Width = 65
          Height = 21
          TabOrder = 6
        end
        object edtAmountRot: TEdit
          Left = 107
          Top = 185
          Width = 54
          Height = 21
          TabOrder = 7
        end
        object edtPriceStopRot: TEdit
          Left = 187
          Top = 185
          Width = 65
          Height = 21
          TabOrder = 8
        end
        object edtClOrdIdRot: TEdit
          Left = 19
          Top = 313
          Width = 268
          Height = 21
          TabOrder = 12
        end
        object dateStartRot: TDateTimePicker
          Left = 19
          Top = 418
          Width = 126
          Height = 21
          Date = 44789.000000000000000000
          Time = 0.978157013887539500
          TabOrder = 14
        end
        object dateEndRot: TDateTimePicker
          Left = 158
          Top = 418
          Width = 129
          Height = 21
          Date = 44789.000000000000000000
          Time = 0.978157013887539500
          TabOrder = 15
        end
        object edtProfitIdRot: TEdit
          Left = 19
          Top = 359
          Width = 268
          Height = 21
          TabOrder = 13
        end
        object EdtSubAccountID: TEdit
          Left = 191
          Top = 47
          Width = 96
          Height = 21
          TabOrder = 2
        end
        object edtStartSource: TEdit
          Left = 19
          Top = 464
          Width = 65
          Height = 21
          TabOrder = 16
        end
        object edtTotalCount: TEdit
          Left = 90
          Top = 464
          Width = 65
          Height = 21
          TabOrder = 17
        end
        object cbOrderType: TComboBox
          Left = 19
          Top = 212
          Width = 110
          Height = 22
          AutoCloseUp = True
          Style = csOwnerDrawVariable
          ItemIndex = 0
          TabOrder = 9
          Text = 'Limite'
          OnChange = cbOrderTypeChange
          Items.Strings = (
            'Limite'
            'Stop'
            'Mercado')
        end
        object cbOrderSide: TComboBox
          Left = 143
          Top = 212
          Width = 112
          Height = 22
          AutoCloseUp = True
          Style = csOwnerDrawVariable
          ItemIndex = 0
          TabOrder = 10
          Text = 'Compra'
          OnChange = cbFunctionsChange
          Items.Strings = (
            'Compra'
            'Venda')
        end
        object cbPositionType: TComboBox
          Left = 19
          Top = 266
          Width = 110
          Height = 22
          AutoCloseUp = True
          Style = csOwnerDrawVariable
          ItemIndex = 0
          TabOrder = 11
          Text = 'Day Trade'
          OnChange = cbOrderTypeChange
          Items.Strings = (
            'Day Trade'
            'Consolidado')
        end
      end
      object tabMd: TTabSheet
        Caption = 'tabMd'
        ImageIndex = 1
        TabVisible = False
        object lbBolsaMd: TLabel
          Left = 135
          Top = 32
          Width = 25
          Height = 13
          Caption = 'Bolsa'
        end
        object lbTickerMd: TLabel
          Left = 3
          Top = 32
          Width = 28
          Height = 13
          Caption = 'Ticker'
        end
        object lbAgentIdMd: TLabel
          Left = 3
          Top = 200
          Width = 43
          Height = 13
          Caption = 'Agent ID'
        end
        object lbTitleMd: TLabel
          Left = 0
          Top = 0
          Width = 290
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'Dados Market Data'
          ExplicitWidth = 92
        end
        object bvMd: TBevel
          Left = 3
          Top = 78
          Width = 284
          Height = 7
          Shape = bsBottomLine
        end
        object lbDateStartMd: TLabel
          Left = 3
          Top = 238
          Width = 51
          Height = 13
          Caption = 'Data inicial'
        end
        object lbDateEndMd: TLabel
          Left = 3
          Top = 284
          Width = 46
          Height = 13
          Caption = 'Data final'
        end
        object Bevel1: TBevel
          Left = 5
          Top = 331
          Width = 284
          Height = 7
          Shape = bsBottomLine
        end
        object Bevel2: TBevel
          Left = 1
          Top = 225
          Width = 284
          Height = 7
          Shape = bsBottomLine
        end
        object Bevel3: TBevel
          Left = 3
          Top = 184
          Width = 284
          Height = 7
          Shape = bsBottomLine
        end
        object lblIntervalType: TLabel
          Left = 95
          Top = 91
          Width = 44
          Height = 13
          Caption = 'Intervalo'
        end
        object lblOffset: TLabel
          Left = 3
          Top = 91
          Width = 31
          Height = 13
          Caption = 'Offset'
        end
        object lblFactor: TLabel
          Left = 167
          Top = 91
          Width = 26
          Height = 13
          Caption = 'Fator'
        end
        object lblAdjustType: TLabel
          Left = 3
          Top = 138
          Width = 31
          Height = 13
          Caption = 'Ajuste'
        end
        object Bevel4: TBevel
          Left = 3
          Top = 19
          Width = 284
          Height = 7
          Shape = bsBottomLine
        end
        object edtTickerMd: TEdit
          Left = 3
          Top = 51
          Width = 126
          Height = 21
          TabOrder = 0
        end
        object cbBolsaMd: TComboBox
          Left = 135
          Top = 51
          Width = 66
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 1
          Text = 'B'
          Items.Strings = (
            'B'
            'F')
        end
        object edtAgentId: TSpinEdit
          Left = 52
          Top = 197
          Width = 69
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
        object dateStartMd: TDateTimePicker
          Left = 3
          Top = 257
          Width = 142
          Height = 21
          Date = 44790.000000000000000000
          Format = 'dd/MM/yyyy HH:mm:ss'
          Time = 0.002749872684944421
          TabOrder = 3
        end
        object dateEndMd: TDateTimePicker
          Left = 3
          Top = 303
          Width = 142
          Height = 21
          Date = 44790.000000000000000000
          Format = 'dd/MM/yyyy HH:mm:ss'
          Time = 0.002749872684944421
          TabOrder = 4
        end
        object edtBookPos: TEdit
          Left = 3
          Top = 344
          Width = 43
          Height = 21
          TabOrder = 5
          Text = '1'
        end
        object mmBookPos: TMemo
          Left = 3
          Top = 371
          Width = 284
          Height = 117
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 6
        end
        object btnBookPos: TButton
          Left = 52
          Top = 344
          Width = 130
          Height = 21
          Caption = 'Buscar oferta'
          TabOrder = 7
          OnClick = btnBookPosClick
        end
        object edtQuoteIDStart: TSpinEdit
          Left = 151
          Top = 256
          Width = 136
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 8
          Value = 0
        end
        object edtQuoteIDEnd: TSpinEdit
          Left = 153
          Top = 303
          Width = 136
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
        object cbIntervalType: TComboBox
          Left = 95
          Top = 110
          Width = 66
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 10
          Text = 'Trade'
          Items.Strings = (
            'Trade'
            'Minute'
            'Day'
            'Week'
            'Month'
            'Year'
            'Aggressor'
            'Lot'
            'Variation'
            'Inversion'
            'Quantity'
            'Renko'
            'Range'
            'Point Figure'
            'Kagi'
            'Price Action'
            'Variation Inversion'
            'Second'
            'Volume Profile')
        end
        object edtOffset: TSpinEdit
          Left = 3
          Top = 110
          Width = 86
          Height = 22
          MaxValue = 100000
          MinValue = 1
          TabOrder = 11
          Value = 1
        end
        object edtFactor: TSpinEdit
          Left = 167
          Top = 110
          Width = 86
          Height = 22
          MaxValue = 100000
          MinValue = 1
          TabOrder = 12
          Value = 1
        end
        object cbAdjustType: TComboBox
          Left = 3
          Top = 157
          Width = 158
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 13
          Text = 'Nenhum'
          Items.Strings = (
            'Nenhum'
            'Dividendos e Juros'
            'Splits e Agrupamentos'
            'Todos')
        end
        object cbBookSide: TComboBox
          Left = 188
          Top = 344
          Width = 99
          Height = 22
          AutoCloseUp = True
          Style = csOwnerDrawVariable
          ItemIndex = 0
          TabOrder = 14
          Text = 'Compra'
          OnChange = cbFunctionsChange
          Items.Strings = (
            'Compra'
            'Venda')
        end
      end
      object tabConfig: TTabSheet
        Caption = 'tabConfig'
        ImageIndex = 2
        TabVisible = False
        object lbTitleCfg: TLabel
          Left = 0
          Top = 0
          Width = 290
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'Fun'#231#245'es de configura'#231#245'es'
          ExplicitWidth = 125
        end
        object bvCfg: TBevel
          Left = 0
          Top = 13
          Width = 290
          Height = 12
          Align = alTop
          Shape = bsBottomLine
          ExplicitWidth = 193
        end
        object imgCfg: TImage
          Left = 56
          Top = 155
          Width = 57
          Height = 50
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000003D40000
            03940804000000E985B3630000000467414D410000B18F0BFC61050000000262
            4B474400FF878FCCBF0000000970485973000000600000006000F06B42CF0000
            000774494D4507E5031B0F0702E0F63A090000725E4944415478DAECDD077495
            D5B605E01902080A28F6DE4808010129A2085614455104C48A0836ACD8154505
            1B8ABD61014111116C28282A8A580051A47792D87B4505052959EF5C1ED7AB08
            2B39C93967ED323FC77BE38DF1EE3533FF5EFF9E39C939FBCF121091CFBE9165
            F8052BB014BF27FEF7626C848D511D95B1E99AFF6B1B6C92659D9088CA238B45
            4DE497DF65368AF0D9DA7F3EC7F212FEF35B609735FFEC9AF89FBCC43F1558DC
            445E6151137961A51460DA9A7F3E4CBC6E2EBB6A6888266BFEC9676513798145
            4DE4B4D5F23E5EC1EB98859529FE37D7C47E6893F86717D63591D358D4448EFA
            49C6631C46E3DB347F9DDD7108DAA235366261133989454DE49C5FE4690CC564
            1467F06B56473B74412BFE3A9CC8392C6A228714275E453F81E7F187D1D7DF01
            1D713A1AB0AC891CC2A2267244810CC293F8DA3A4642739C8ACEFC5817912358
            D4440E982EF7E029ACB68EF13735D01557627B96359139163591B189D20F2F5B
            8758AF8D701C7A218F654D648A454D6466950CC7ED98631D43958D8E8957D68D
            59D6446658D44446C6C9A5986D1DA254B2702C6E412D9635910916359181E972
            19DEB20E91944AE8869BB015CB9A28E358D44419F6A5DC88414EBD71ACB46AE2
            4A5C882A2C6BA28C62511365D072B909776199758C72D81DF7A22DAB9A288358
            D44419F39E9C8105D62152A013FAF397E04419C3A226CA883FE406DC9ED14341
            D3A9266EC559AC6AA28C60511365C058E98ECFAC43A4581B3C8C9D59D64469C7
            A2264AB3DFA407865887488B1AB89DAFAB89D28E454D9456D3E57814598748A3
            F6188CCD58D64469C4A2264AA327E46CAFDFE35D1ABBE069ECCDAA264A1B1635
            519AFC2667252A2C061BA11F7A208B654D94162C6AA2B408FD57DEEB3A068351
            93554D94062C6AA2341824E7628575880CAB85975187554D94722C6AA21413B9
            1ED75B8730511D4FA30DAB9A28C558D44429B55C4EC370EB10662AE23E9CC3AA
            264A291635510A7D2B47E343EB10C67AE06E54605913A50C8B9A2865E64ADBE0
            CE1F2B8B0E188A8D59D54429C2A2264A91F1D21EBF598770C4DE78059BB3AA89
            5282454D9412AF4987E08F3649465D8CC376AC6AA214605113A5C0183916CBAD
            4338A64EA2AA77605513951B8B9AA8DC9E91CE58691DC241BBE14DECC6AA262A
            27163551390D972E58651DC2513B27AA3A87554D542E2C6AA2727954BAA3D83A
            84C3B6C538D463551395038B9AA81C864837F01ED2ED8089D895554D54662C6A
            A2327B493AF097DEA5502B51D5DBB2AA89CA88454D544693E550FC6E1DC2130D
            F00E3663551395098B9AA84CE6C801586C1DC22307E2555461551395018B9AA8
            0C3E9696F8C63A84678EC24854645513258D454D94B41F12355D601DC243A760
            08B258D5444962511325E90FD90FD3AD4378AA37FAB0A88992C4A2264A8AC849
            18611DC25B59188EE359D5444961511325E546B9CE3A82D7AA62029AB0AA8992
            C0A2264AC228E9C073C8CA69174CC1D6AC6AA25263511395DA02D9874F9C4E81
            1678131BB1AA894A89454D544A3F4B337C641D22105DF1188B9AA89458D444A5
            B24A5AE32DEB1001E98F7359D544A5C2A2262A95ABE516EB0841A98409D89B55
            4D540A2C6AA25278475A61B57588C0D4C274D46055139588454D54A21F644F7C
            6D1D2240C763048B9AA8442C6AA21288B4C34BD62102F5384E6555139580454D
            54823BE532EB08C1DA04535187554DA4625113A9A6C9BE58611D2260F5F101AA
            B2AA89142C6A22C512698C22EB1081EB817B59D4440A163591A2BB0CB08E10BC
            2C8CC5A1AC6AA20D6251136DD05BD20ABC43D26F57CC41355635D106B0A88936
            E00F69C0234333E422DCCDA226DA001635D1065C28F75947884605BC8396AC6A
            A2F5625113ADD7FBD292679165501E66A20AAB9A683D58D444EBF1A734C67CEB
            1091B90A7D59D444EBC1A2265A8F9ED2CF3A42742A62329AB2AA89FE85454DF4
            2F33652FACB20E11A13D3115D9AC6AA275B0A889D6217220DEB50E11293EA59A
            E8DF58D444EB18269DAD2344AB260AB025AB9AE81F58D444FFF087E4E373EB10
            113B17FD59D444FFC0A226FA875ED2D73A42D4B2310D0D59D5447FC3A226FA9B
            8FA51E965B87885C0B4C4016AB9AE82F2C6AA2BF6927A3AD231086E3041635D1
            5F58D4447F1927875A47A0841DB1109BB0AA89D6625113ADB54A1A608175085A
            E33A5CCFA2265A8B454DB4D683729E75045AAB2A1661275635D11A2C6AA23596
            480EBEB70E5166B571101AA01E6AA21A8AF12BBEC01C4CC778FC661DACCC4EC3
            201635D11A2C6AA235AE919BAD2394492D9C898EC8596FA9AD9009188A67B0CC
            3A641964277ED068C0AA26028B9A688D2F250F7F5887485A0B5C83D6A850429D
            2D9601B8033F5A874D5A6B8C65511381454DB4463779DC3A42921AE236B42E75
            912D95FB700B965A874ED26B388C554DC4A22602664963145B8748C2C6B81C57
            A3729225F6B5F4C450EBE849A98B59A8C8AAA6E8B1A88970A88CB38E90841678
            12BB96B1BE9E95EE586CFD0D24E1519CCEA2A6E8B1A8297AAFCA11D6114A2D1B
            D7A257B95E657E219D3D7A88E7F628E0D127143D1635456EB5EC89B9D6214AA9
            3A86A25DB96B6B955C837ED6DF4AA9F5416F1635458E454D917B54CEB48E504A
            39188DFC1495D6A3722E565A7F43A5520D85D896554D51635153D4964A6D7C63
            1DA254F6C0586C9FC2C27A53DA6389F537552A67E1111635458D454D51EB23D7
            5B47289503310A35525C57EF495B2FDE58968D59A8C7AAA688B1A829625F275E
            4FFF6E1DA214F6C3AB69794BD54C69859FADBFB95238026358D41431163545EC
            0C19641DA114F6C558544B5351CD4854B50FAFAA5FC7A1AC6A8A168B9AA23557
            F6C46AEB10256A8671A89EC6929A2C87787078EA9E9856E251A944A1625153B4
            DAC86BD6114AB43BDEC336692EA831720C56597FA3257A1CA7B2A829522C6A8A
            D47869651DA1445B62126A67A09E06CA59D6DF6A89764001366655539458D414
            A562698C59D6214A5019E3D12243D57499DC69FDED96E8665CCDA2A628B1A829
            4A8FC969D6114AF408CECA5831154B5BBC6AFD0D9780479F50AC58D414A16592
            872FAC4394E06C3C94D1525A2CCD5064FD4D97E01C3CC8A2A608B1A8294237C9
            B5D6114AD01493927E8C6579CD94E6586EFD8DAB2A620EEAB0AA293A2C6A8ACE
            F7928BDFAC43A8AA615A46DE44B6AEFE72BEF5B75E82A3318A454DD161515374
            CE9647AC239460184E32AAA3136584F5375F827168C5AAA6C8B0A829320BA481
            E39F1AEE86C16655B458EAE32BEB0BA06A82293CFA8422C3A2A6C81C252F5B47
            50ED8039A8695844E3A435DCDE1586A2338B9AA2C2A2A6A8BC2D0759475065E1
            151C6E5C43AEFF6960472CE2D1271415163545A4589A619A750855A63F94B53E
            4BA43E3EB30EA1BA15579A5F25A2CC61515344864A17EB08AA6DB1009B395041
            AFCA11D61154D55198F613D089DCC1A2A6682C973A8EBF527C16C73A523FC7CA
            F3D6115417E03E47AE1451FAB1A8291AFDA4A77504D59178D999F2F95AF29DFE
            AC7925CC35F9A4399105163545E247C9C1AFD6211455301FBB39543D77C9A5D6
            1154ED31D2A1AB45944E2C6A8AC405F2807504D5D5B8D9A9E25929F5B1C83A84
            EA5DECE7D415234A17163545A140F6C04AEB108A6D50801A8ED5CE18696B1D41
            D50CEF23CBB16B46940E2C6A8A420779C13A82EA719CEA60E5B491D7AC23A886
            E30407AF1A51AAB1A8290293A585D3A76DED89694E1E8BE9FA71ABBB62213672
            F0BA11A5168B9A8227D212EF598750BD81431CAD9BB364A07504D5EDB8CCD12B
            47943A2C6A0ADE7039C93A82AA2D5E72B66CBE971C2CB10EA1D80C45D8C2D9AB
            47941A2C6A0ADC0AA98B8FAC4328B2310BF51CAE9AEBA58F7504D5C5B8CBE1AB
            47940A2C6A0ADC1D72B97504950BA77B6B96491EBEB00EA1A88CB9C875FA0A12
            95178B9A82B65872F0B37508453514625BC76B66909C611D41D509CF387E0589
            CA87454D41BB58EEB18EA0BA11D7385F32C5D21433AC43A826A0A5F35791A8EC
            58D414B04F241F7F5A87506C8F026CE241C58C9756D611547B63328F3EA180B1
            A82960C7C9B3D6115483D1CD937A394C5EB78EA072E7B96344A9C7A2A6607D20
            CD9D3EE6A401A623DB937A992D8DB1DA3A846277CCE7D127142C163505ABA54C
            B28EA01A8BD61E55CBE932D83A82EA6E5CE4D1D5244A068B9A02F59C74B28EA0
            3A1CAF7A552C5F4B6DFC6E1D42511345D8DCAB2B4A545A2C6A0AD24AA98742EB
            108A6CCC407DCF6AA5B7DC601D4175196EF7EC8A12950E8B9A82748F5C6C1D41
            7506067A572A4B13AFA9BFB10EA1A88CF9A8E5DD55252A198B9A02F48BE4E027
            EB108AAA28C08E1E56CA00E96E1D4175229EF2F0AA129584454D01BA5CEEB08E
            A0EA8D3E5E16CA6AD91373AD4328B23011FB7A796589342C6A0ACEA7928FE5D6
            21145BA308D53DAD9331D2D63A82AA3926F1E8130A0E8B9A8273920CB78EA01A
            80333DAE92D6F2867504D548B4F7F8EA12AD0F8B9A023345F671FA98937CCC46
            458FAB64963446B17508452DCC47658FAF2FD1BFB1A82930AD64BC7504D5181C
            E1798D749521D61154F7E37CCFAF30D13FB1A829282F4A7BEB08AA8330DEFB12
            F94A6AE30FEB108A2D51844DBDBFCA44FFC3A2A680AC9286986F1D42510153D0
            24800AE9257DAD23A87AE29600AE32D17FB1A829200FC805D61154A7E2F1200A
            6449E235F5B7D6211455B010BB0471A589FE83454DC15822B9F8CE3A84A26AA2
            3E760EA43E1E94F3AC23A83A636820579A88454D01B95A6EB18EA0EA859B8229
            8FD5D210F3AC4328B230054D83B9DA143B163505C2F5B7386D8522D408A83A46
            4B3BEB08AA03F07640579BE2C6A2A6407491A1D611540FE29CC08AE31079D33A
            826A348E0AEC8A53AC58D41404D78FE1C8C31C540AAC36664A135E73A20C6051
            53100E9571D61154A370748095D1598659475085F75B0C8A138B9A02F0B21C65
            1D4115EADF4BBF943CBE2F8028ED58D4E43DBE03D94E4FE9671D41750D6E0CF4
            CA534C58D4E4BD47E46CEB08AA93F164B065C1CFAE13A51F8B9A3CB7546AE31B
            EB108AD04FC9BA5F7A58475075C563015F7D8A038B9A3C779DDC681D4175256E
            0DBA285649032CB00EA108E57C758A198B9ABCF675E2F5F4EFD62114355184CD
            03AF8917A483750455084F2CA3B8B1A8C96BA7C963D61154F7A2470425B1BF4C
            B08EA07A056D2258050A178B9A3C365B1A63B57508C5EE5880CA1154C414D907
            2EEF24F9988D8A11AC03858A454D1E3B4C5EB78EA07A1E1D22A9871365847504
            D5009C19C94A508858D4E4ADB172B87504D53E780F5991D4C3A752077F5A8750
            6C8D22548F642D283C2C6AF254B134C50CEB108A2C4C408B88AAE172B9C33A82
            AA37FA44B41A14161635796A909C611D41753C4644550CBF480E7EB20EA1A88A
            02EC18D58A503858D4E4A56592872FAC43282A631E7222AB857BE462EB08AA33
            3030B215A150B0A8C94B37486FEB08AA4B706774A5B052EAA1D03A84A202A6A2
            5174AB422160519387BE975CFC661D42513351585B445809CFCA71D6115487E3
            D5085785FCC7A2260F759701D6115477E292480BA1A54CB28EA01A8BD691AE0C
            F98C454DDE59200DB0CA3A8462372CC04691D6C107D2DCE9A34F1A603AB2235D
            1BF2178B9ABC73A4BC621D413502C7475C05C7C9B3D6115483D12DE2D5213FB1
            A8C9336FCB41D61154CDF07E34C79CACCF2792EFF4D127DBA3009B44BC3EE423
            163579A5589A619A7508D504B48CBC062E91BBAD23A86EC0B591AF10F986454D
            5E19225DAD23A83AE0F9E84B60B1E4E067EB108A6A89D7D4DB45BF4AE4131635
            7964B9E4E173EB108A4A988BDAAC00DC21975B475075C7C35C25F2088B9A3CD2
            577A594750F5C0BD2C80841552171F598750646316EA71A5C81B2C6AF2C60F92
            8B5FAD4328364321B6E4F6BFC60839D13A82AA2D5EE24A913758D4E48DF3E441
            EB08AA7EB8829BFF5A222DF19E7508D51B3884AB459E6051932716497DACB40E
            A1D8118BB031B7FEBF4C96164E1F7DD210D35181EB455E605193278E9151D611
            544FE2646EFBFFD051465A47500D4117AE187981454D5E78570EB08EA06A84A9
            7C7DB68E8F251F2BAC43287640017F07425E6051930744F6C687D62154E3D08A
            5BFEBFF490FBAD23A8FAE22AAE1A7980454D1E784A4EB68EA03A1AA3B8E1AFC7
            CF92EBF4D127D551886DB872E43C1635398F9FCAF5573FE9691D41751E1EE0CA
            91F358D4E4BCDBE44AEB08AA73D19F9BFD062C973AF8CC3A84A262E287ACBA5C
            3D721C8B9A1CE7FEC9D185D8965BFD060D93CED61154EDF022578F1CC7A226C7
            5D28F7594750DD845EDCE81522CD30D53A84EA4D1CCC1524A7B1A8C9691F4B5D
            A79F6ECC8FF894EC1D39D03A828A1FAD23D7B1A8C969C7CAF3D611548FE3546E
            F1256A27A3AD23A886E124AE22398C454D0E7B5FF6E531940170FDF8D75DB100
            55B88EE42C163539ACA54CB28EA07A1D87727B2F153E5085A8EC58D4E4AC67E4
            78EB08AA2330869B7B29F111A54465C7A22647AD907A28B20EA1C8C64CECC1AD
            BDD4FA4A2FEB08AA0B710F57931CC5A22647DD25975A47509D8901DCD893B05C
            F2F0B975084525CC432E57949CC4A22627FD2239F8C93A84A21A0AB01DB7F5A4
            0C91AED611541DF11C57949CC4A226275D26775A4750F5416F6EEA492A966698
            661D4235012DB9AAE420163539E813C977FA98936D5088EADCD293F6B61C641D
            41D50CEF238BEB4ACE615193834E90A7AD23A81EC5E9DCCECBA4AD8CB18EA07A
            1AC77165C9392C6A72CE14D9C7E9634EF2311B15B99D97C942A98F55D62114BB
            610136E2DA926358D4E49CFD65827504D5AB389C5B79999D2D8F584750DD894B
            B8BAE41816353966A474B48EA03A186F72232F87EF2517BF598750D44421B6E0
            0A935358D4E49495B2070AAC43282AE04334E6365E2E37486FEB08AA4B702757
            989CC2A226A7DC2F3DAC23A8BA613037F1725A2679F8C23A84A232E62187AB4C
            0E6151934396482EBEB30EA1A88A45D8895B78B90D96D3AD23A88EC708AE3239
            84454D0EE929FDAC23A8AEC18DDCC053A058F6C274EB108A2C4C400BAE343983
            454DCEF852F2F0877508C5D628440D6EDF29315E5A594750ED83F778F4093983
            454DCE38459EB48EA07A086773EB4E9936F29A7504D573E8C8D52647B0A8C911
            33A5098AAD4328EA600E8F3949A105D2C0E9A34F76C70254E67A931358D4E488
            43E44DEB08AA97D096DB764A9D2183AC23A8EE450FAE383981454D4E78498EB6
            8EA03A006F73D34EB1AFA5367EB70EA1A889226CCE552707B0A8C901ABA521E6
            59875064610A9A72CB4EB93E72BD7504D515E8C7552707B0A8C9010FC9B9D611
            54A7E0096ED869B034F19AFA1BEB108ACA988F5A5C7932C7A226734B2517DF5A
            875054C142ECC2ED3A2D06CA59D61154276118579ECCB1A8C9DC3572B3750455
            4FDCC2CD3A4D564B23CCB10EA1C8C207D88BAB4FC658D464EC2BC973FA2D455B
            A2089B72AB4E9B57E508EB08AAFDF10E579F8CB1A8C9583779DC3A82EA7E9CCF
            8D3AAD5ACB1BD611542FA21D27804CB1A8C9D42C69ECF43127B5309FC75EA499
            EB33908739A8C41920432C6A32E5FAABA99168CF2D3AED5CFFADCA03388F5340
            8658D464C8F5BF4F36C7243E9A21035C7F9FC25628E4FB14C8108B9ACCB8FF8E
            DF89D897DB73465C2B375947505D8D9B39096486454D665CFF0CED0918CECD39
            43DCFF2CFD22ECCC6920232C6A32F27B626BE6A954F45F0FCB39D611545D3084
            D3404658D464C4F5739E2FC3EDDC9833C8F5F3DE2B600A9A7022C8048B9A4C7C
            97783DBDC43A84824F4ECA3CD79FA07620DEE244900916359938531EB58EA0BA
            1B177153CEB843659C7504D5CB389253410658D464608134C02AEB108ADDB000
            1B714BCEB899D2C4E9A34FEA600E2A722E28E358D464E00879D53A82EA1974E2
            766CA28B0CB58EA07A18DD391994712C6ACAB8B7E460EB08AABD3199C79C18F9
            4A6AE30FEB108AAD51881A9C0DCA3016356558B1EC85E9D6215413D0925BB199
            ABE456EB08AA6B7103A783328C454D19F6B874B38EA03A16CF722336B44472F1
            9D750845552CC24E9C10CA28163565D432A98D2FAD43282A632E72BDDC867F92
            8FF01B7EC1D2C4FF5D0D9BA1066A610B2FBF93FE72BE750455370CF6F2BA92BF
            58D494517DA5977504550FDCEBD526FC8BBC83F1988685F8693DFFDF2D51074D
            70300EF0EA91122BA57EE255ABBBB2311D0D3CBA9EE43F163565D0F7929B78D5
            E7AECD50E4CDABD0C532024FE203AC2EC57F361BFBA0338E474D4FBEB717A5BD
            7504556B8CF5E44A521858D49441E7CA43D61154B7E1722F36E069721B46E1CF
            24FF5B55D00E57A29117DFE101F2AE7504D56B38CC8BEB4861605153C62C94FA
            4E1F73B22B16A08AF3DBEF64B91165FF147A168EC0B5D8DBF9EFF243D91B2EEF
            4DF53103D9CE5F450A058B9A32E66879C93A82EA299CE8F8D6FBB35C8581E52E
            B02C74C61DD8DAF1EFF524196E1D41F5284E77FC0A523858D49421EFC881D611
            547BE103C78F397954AEC0E214FDBB364F547537A7BFDB4F251FCBAD4328B647
            013671FA0A523858D4941122CD30D53A84EA4D1CECF0B6BB54CE42AA5F619E8C
            8751CDE1EFF90AB9DD3A82AA0F7A3B7CF528242C6ACA8861D2D93A82AA1D5E74
            78D39D2F1DD2F281A57C8C441D67BFEF5F2467BD1F3A7345B5C46BEAED9CBD7A
            1412163565C072A983CFAC43282A6216EA3ABBE57E2847E0C734FDBB6B620C9A
            3BFB9DDF2B175947509D8901CE5E3B0A098B9A32E036B9D23A82EA5CF47776C3
            1D2B1DF17B1AFFFDD512AFAA0F75F4BB5F21F550641D42919DF801AF9EA3D78E
            42C2A2A6B4FB5172F0AB7508457514621B47B7DB77E5B0B4BFA5AA0A5EC77E8E
            7EFFCFCBB1D6115447608CA3578E42C2A2A6B4EB21F75B4750F5C5558E6EB673
            65FF94BDCF5BB329DE414347AFC17E32D13A82EA75677F1F41E16051539A154A
            3DACB40EA1D8098B50D5C9ADF65B6982AF33F4B576C434473F59FDBEECEBF4D1
            277B26AE5C0527AF1C8583454D69D6415EB08EA01A822E4E6EB3C57238DEC8E0
            D73B08E31C2D9CE3E519EB08AAC7D0D5C9EB46E16051535A4D96164EBF1E6A88
            E98ED6D38D725D86BFE22DE8E9E495F844F2933ED73C937640013676F2CA5128
            58D4944622FBE27DEB10AA7168E5E4163B53F6CAF8B9E815133FB4D477F26A5C
            22775B4750DD845E4E5E370A058B9AD268849C681D4175245E76728315391016
            4F8F6A99F8AA2E1EA3BA58721D3FFAA410DB3A78DD28142C6A4A9B1552171F59
            8750646326F670727B1D2CA71B7DE527708A9357E42EB9D43A82EA1C3CE8E475
            A330B0A8296DEE94CBAC23A8BAE3612737D73FA516BE32FADA3B267EB4AAECE0
            55E1D12714331635A589FBBFAE74F5A4E601D2DDF0AB0FC2694E5E95A7E504EB
            08AAA330DAC9EB46216051539AB8FE06A01B70AD931BEB6AC947A1E1D7AF8545
            C876F0CA88EC8749D62154AEBE3191FCC7A2A6B4F858EA3AFD911A779F263C5A
            DA192778096D9DBC3293A4A5750455134C71F4A37EE43B1635A585EB8754B8FA
            0B5EA0933C679CE0040C77F4DA1C2BCF5B47500D456747AF1CF98D454D69F081
            3477FA98930698EEE4AF77815F653B2C33CE5005DF625327AF8EEBBFA7D9118B
            78F409A5018B9AD2A0A5B8FDD7C4D77098A3DBE910E96A1D012EBF32BC50EEB3
            8EA0BA15573A7AE5C8672C6A4A39D71F4D7830DE747633ED2243AD232474C360
            47AFD062C9C1CFD621142E3F3295FCC5A2A6145B29F54CDFB55C920A988A46CE
            6EA5BBC8E7D6111276C667CE5EA1DBE44AEB08AA0B709FB3D78E7CC5A2A614BB
            4F2EB48EA072F7D522F051E2F5A21B3EC66E8E5EA5E5928F4FAD43282A612E6A
            3B7AEDC8572C6A4AA95F24173F5A875054C522ECE4EC36FA8274B08EB0D6281C
            EDEC557A4A4EB68EA06A8F91CE5E3BF2138B9A52EA0AB9DD3A82EA3A5CEFF026
            DA4F7A5A4758EB765CE6EC75126981C9D62154EF623F67AF1EF988454D29F4A9
            E463B97508C5D628440D87B7D0D3E431EB086B9D81810E5FA777E500EB08AA66
            78DFC9A79091AF58D494429D65987504D5C3E8EEF4F679A88CB38EF0DF2478DD
            E92B758C8CB28EA01A8E139CBE7EE4171635A5CC0C698A62EB108A3A98838A4E
            6F9F7BCB14EB086BED83C94E5FA945521F2BAD432876C5426CE4F415249FB0A8
            29655AC978EB08AA9771A4E35B673D996F1DE1BF4930D7F16B75BEF4B78EA072
            F9AFFCE41B1635A588FDC324742E1F73F25F6E7C8AFA3F5CFE24F5FFFB4172F0
            9B7508454D14620BC7AF21F982454D29B14A1AC2955783EB530153D0C4F96D73
            07F9DA3AC25ADBE32BE7AFD62D72B57504D545B8DBF96B487E6051534AF497F3
            AD23A8BA6088079B268B3A19CBA50E3EB30EA1A88479C875FE2A920F58D49402
            4B2417DF59875054C122ECECC196C9A24ECE50E9621D41D509CF787015C97D2C
            6A4A815ED2D73A82EA6ADCECC586C9A24E8EC85E98661D4235012D3DB88EE43A
            163595DB57521B7F5887506C8542479FAFBC2E1675B2DE9683AC23A8F6C6641E
            7D42E5C6A2A6723B559EB08EA0EA8F733DD92A59D4C93B4A5EB68EA07A069D3C
            B992E42E163595D32C69ECF431277998834A9E6C952CEAE42D94FA58651D42B1
            1B16F0E8132A27163595536B79C33A82EA45B4F3669B645197C539F2B07504D5
            DDB8C89B6B496E625153B98C91B6D61154FBE31D8F36491675597C2FB98E1F7D
            5284CDBDB99AE422163595C36AD91373AD4328B23009CD3DDA2259D46573935C
            6B1D4175196EF7E86A927B58D4540E03A4BB7504D54918E6D506C9A22E9B6592
            872FAC43282A633E6A79743DC9352C6A2AB3A5521BDF588750F8B73DB2A8CBEA
            3139CD3A82EA040CF7EA7A925B58D45466BDE506EB08AA2BD0CFB3CD91455D56
            C5B217A65B8750646122F6F5EA8A924B58D454465F275E4FFF6E1D42E1E35B78
            58D465F7961C6C1D41D51C9378F40995118B9ACAE80C19641D41750F2EF46E5B
            645197C711F2AA7504D548B4F7EE9A921B58D4542673A411565B8750EC8EF91E
            1E33C1A22E8F05D2C0E9A34F6A2566B2B27757955CC0A2A632395CC65A47503D
            878E1E6E892CEAF2394B065A4750DD870B3CBCAA648F454D65305E5A594750ED
            83F7BCFC7B208BBA7CBE971C2CB10EA1D812459E3C1E86DCC2A2A6A4B9FE0E5B
            60225A78B91DB2A8CBAB8F5C6F1D41D513B778795DC9168B9A9236584EB78EA0
            3A0E4F7BBA19B2A8CB6B99D4C697D6211455B010BB787965C9128B9A92E4FE29
            50F390E3E956C8A22EBF47E54CEB08AACE18EAE995253B2C6A4AD28D729D7504
            D5C5B8CBDB8D90455D7EABA511E658875064610A9A7A7A6DC90A8B9A92E2FA93
            8A364311B6F0761B6451A7C26BD2C63A82EA00BCEDEDB5251B2C6A4ACAD9F288
            7504D51DB8D4E34D90459D1A87C9EBD61154A37194C75797328F454D495828F5
            9D3E5262572CF4F09893FF6151A7C66C69ECF4713C7998834A1E5F5FCA341635
            25A1AD8CB18EA01A8E13BCDEFE58D4A9729A3C661D41F520CEF1FAFA5266B1A8
            A9D4DE9683AC23A89AE17D2F8F39F91F1675AAB8FEC898AD50841A5E5F61CA24
            16359552B134C334EB10AA77B19FE75B1F8B3A75AE931BAD23A87AE126CFAF30
            650E8B9A4AE90939D53A82AA3D467ABFF1B1A8536769E235F537D6211455B110
            3B7B7E8D295358D4542ACB250F9F5B875054C46CE47BBFEDB1A853E91139DB3A
            82AA2B1EF3FE1A5366B0A8A9546E91ABAD23A82EC07D016C7A2CEA545A2D0D31
            CF3A84A202A6A089F757993281454DA5F083E4E257EB108AEA28C436016C792C
            EAD47A598EB28EA03A08E303B8CA947E2C6A2A85F3A5BF7504D5ADB832880D8F
            459D6A87CA38EB08AA31382288EB4CE9C5A2A61215C81E58691D42B1231661E3
            20B63B1675AACD92C628B60EA1C8C76C540CE24A533AB1A8A944EDE545EB08AA
            A1E81CC856C7A24EBD53E509EB08AA013833902B4DE9C3A2A6124C961670794A
            F6C434540864AB6351A7DE57521B7F5887506C8D22540FE45A53BAB0A8492589
            9A9E6C1D42350EAD82D9E658D4E9D04BFA5A4750F5469F60AE35A5078B9A54C3
            E524EB08AAA3303AA04D8E459D0E4B2417DF59875054C522EC14CCD5A6746051
            936285D4C547D62114D998857A016D712CEAF4E82FE75B47509D8E4703BADA94
            7A2C6A52DC2E575847509D830783DAE058D4E9B14A1A62BE750845054C45A380
            AE37A51A8B9A3668B1E4E067EB108A6A28C4B6416D6F2CEA741925C75847501D
            8E5783BADE945A2C6ADAA08BE51EEB08AA1B714D609B1B8B3A7D0E9137AD23A8
            C6A27560579C5287454D1BF0B1D4C59FD621143B601136096C6B6351A7CF0C69
            EAF4D1270D301DD9815D734A1516356D402779CE3A82EA31740D6E5B6351A753
            6719661D413508A70577CD293558D4B45E1F4873A78F39698019C11C73F23F2C
            EA74FA526A63997508C5F62808EE7744941A2C6A5AAF9632C93A822ACCBFE8B1
            A8D3EB4AB9CD3A82EA065C1BE055A7F26351D37A3C2BC7594750B5C12B416E68
            2CEAF4FA4572F1A3750845B5C46BEAED02BCEE545E2C6AFA9715B2070AAD4328
            B23103F583DCCE58D4E9769F5C681D41D51D0F0779DDA97C58D4F42FF7C8C5D6
            1154676060A09B198B3ADD56267E082DB00EA1C8C64CEC11E495A7F26051D33A
            7E911CFC641D425135B1D1EE18E856C6A24EBF91D2D13A82EA48BC1CE895A7B2
            6351D33A2E973BAC23A8427ED6108B3A13F69709D611546FE09060AF3D950D8B
            9AFEE153A9E3F43127DBA030E0A7F7B2A833618AECE3F4470F1B627A801F3DA4
            F26051D33F9C2823AC23A806E28C80B7301675669C204F5B47500D419780AF3E
            258F454D7FE3FA6B8D7CCC46C580B7301675667C22F94EFFDE68071460E380AF
            3F258B454D7FD34AC65B4750BD8236416F5F2CEA4CB94CEEB48EA0BA1957077D
            FD29392C6AFACB0BD2C13A82EA208C0F7CF36251678AEB9F6DA88E426C13F40A
            503258D4B4D62A698005D621141530054D02DFBA58D49973B75C621D41751E1E
            087C05A8F458D4B4D6037281750455573C16FCC6C5A2CE1CD7CFDFAB8859A81B
            F81A5069B1A8698D25928BEFAC4328AA6221760E7EDB62516792EB27DAB7C38B
            C1AF01950E8B9AD6B84A6EB58EA0EA859B22D8B458D499E5FA33E2C6A15504AB
            4025635153C257521B7F5887506C8522D48860CB625167D6FBB2AFD31F476C84
            A93CFA84C0A2A635BAC850EB08AA07714E14DB158B3AD33AC973D61154C37052
            14EB403A163561A63441B17508451EE6A05214DB158B3AD33E96BA4E1F7DB223
            0A50358A95200D8B9A70A88CB38EA01A8DA322D9AA58D49977B1DC631D41D50F
            5744B212B4612CEAE8BD2C475947501D80B7A3D9A858D499B75872F0B37508C5
            6628C49691AC056D088B3A72ABA521E659875064610A9A46B34DB1A82DDC2197
            5B4750F5C0BDD1AC05AD1F8B3A720FCB39D611549D3134A24D8A456D6185D4C5
            47D6211495123F4AE746B31AB43E2CEAA82D955C7C6B1D4251050BB14B445B14
            8BDAC67039C93A82AA239E8B6835E8DF58D451BB566EB28EA0BA12B746B541B1
            A86D88B4C47BD6215413D032A2F5A075B1A823F6B5D4C6EFD621149BA3109B47
            B53DB1A8AD4C96164E1F7DD20CEF232BAA15A1BF635147EC3479CC3A82EA3E5C
            10D9D6C4A2B6D3415EB08EA01A81E3235B11FA1F1675B4664B63ACB60EA1D81D
            0B5039B2AD89456DE723A98B15D62114BB25EE878D225B13FA2F1675B40E93D7
            AD23A89E4787E8B62516B5A50BE401EB08AA3B7149746B42FF8F451DA9D7A48D
            750455734C8AF06F722C6A4B3F4A0E7EB50EA1A889426C11DDAAD07FB0A8A354
            2C4D31C33A84220B13B16F845B128BDAD6AD72957504D525B833C255211675A4
            06C919D61154C76344941B128BDAD672A983CFAC43282A631E72225C17625147
            6899E4E10BEB108A78B72316B5B527E514EB08AAE3F07494EB123B167584AE97
            3ED6115497E28E48372316B5359166986A1D4235112DA25C99B8B1A8A3F3BDE4
            6089750845CC6F996151DB7B470EB48EA0DA07EF45F836CBD8B1A8A373960CB4
            8EA0BA0B1747BB0DB1A85D70B4BC641D41F51C3A46BB36B1625147668134C02A
            EB108AB88F756051BB6091D4C74AEB108ADD313FE27B244E2CEAC81C29AF5847
            503D8DE322DE8258D46E38571EB28EA0BA071746BC3A31625147E52D39D83A82
            6A6F4C8EFAEF6F2C6A37FC2039F8CD3A84A2268A227B5C4DEC58D41129966698
            661D4215FBC3FC58D4AEB859AEB18EA0BA02FDA25E9FD8B0A8233244BA5A4750
            75C473916F3E2C6A572C933AF8DC3A84A232E6A356D42B14171675345CDF7A2A
            611E7223DF7A58D4EE70FDC7DA93302CF2158A098B3A1AAEFF32EF42DC13FDC6
            C3A27687EB7F28CAC224348F7C8DE2C1A28E84EB6F8FD90C85D832FA6D8745ED
            12D7DF7AB93FDE897E8D62C1A28EC479F2A07504553F5CC14D8745ED18D73FCC
            F822DA7195A2C0A28E82EB4738EC880254E596C3A2768CEBC703E5610E2A719D
            22C0A28E423B196D1D41350C2771BB018BDA3DDD65807504D503388FEB140116
            7504DE9503AC23A81A612A2A70BB018BDA3DDF4BAED3EFEDD80A85D8942B153C
            1675F044F6C687D62154E3D08A5BCD1A2C6AF7DC20BDAD23A8AE425FAE54F058
            D4C11B269DAD23A8DAE1456E346BB1A8DDB34CF2F085750845152CC2CE5CABC0
            B1A803B742F2F1B17508453666A32EB799B558D42E1A246758475075C110AE55
            E058D481BB4DAEB48EA03A17FDB9C9FC8545EDA262698A19D621141530054DB8
            5A416351076DB1E4E067EB108AEA28C0B6DC62FEC2A276D37869651D417520DE
            E26A058D451DB40BE53EEB08AA9B71353798BF6151BBEA70196B1D41F512DA72
            BD02C6A20ED8C7928F15D621143B245E4F6FCCEDE56F58D4AE9A238DB0DA3A84
            A20EE6A022572C582CEA80759491D611548FE3546E2DFFC0A276D7E932D83A82
            EA6174E78A058B451DACF7655FB8BCBA0D319DC79CAC8345EDAEAFA5367EB70E
            A1D81A85A8C1350B148B3A5022FB61927508D5EB3894DBCA3A58D42EEB2D3758
            47505D8B1BB86681625107EA6939C13A82EA088CE1A6F22F2C6A972D4DBCA6FE
            C63A84A22A166127AE5A9058D4415A21F550641D42918D99D8835BCABFB0A8DD
            3640BA5B475075C360AE5A9058D441BA4B2EB58EA03A0B8F7043590F16B5DB56
            CB9E986B1D4251011FA231D72D402CEA002D965CFC641D42510D05D88EDBC97A
            B0A85DF78A1C691D417530DEE4BA0588451DA04BE52EEB08AAEB711D3793F562
            51BBAFB5BC611D41F52A0EE7CA0587451D9C4F241F7F5A87506C9F783DBD09B7
            92F56251BB6F963446B17508453E66F3E893E0B0A88373823C6D1D41F5284EE7
            36B2012C6A1F749521D61154037106D72E302CEAC04C917D9C3EE6A42E66F1E7
            FD0D6251FBE02BA98D3FAC4328B64121AA73F582C2A20ECC7E32D13A82EA351C
            C62D648358D47EB8466EB68EA0EA83DE5CBDA0B0A88332523A5A4750F13DA93A
            16B51F964A2EBEB50EA1E0E72A42C3A20EC84AD9237183BA8B9FF22C098BDA17
            0FC9B9D61154676200D72F202CEA80DC27175A47509D8641DC3C542C6A5FAC96
            8698671D42918D19A8CF150C068B3A184B2407DF5B8750F024E292B1A8FD315A
            DA594750B5C12B5CC160B0A883D153FA594750F1D93E256351FBE41079D33A82
            8ACFA70B078B3A105F4A9ED31F19E1D3724B8345ED9399D2C4E9A34FF8C4F770
            B0A803D159865947503D8CEEDC324AC4A2F6CB29F2A47504D563E8CA550C028B
            3A08AEFF6C5F077378CC4929B0A8FDE2FAEFB176C0221ED71B041675105CFF6B
            D94B68CBEDA21458D4BEB94A6EB58EA0BA11D7701D03C0A20E80EBEF3F3D106F
            71B3281516B56F96482EBEB30EA1A886426CCB95F41E8BDA7BAE7FA2B302A6A0
            09B78A526151FBE77EE9611D41750E1EE44A7A8F45ED3DD7CF483A054F70A328
            2516B57F5649032CB00EA1C8C62CD4E35A7A8E45ED39D74F1DAE8285D885DB44
            29B1A87DF48274B08EA03A0AA3B9969E63517BCEF5E7F85C85BEDC244A8D45ED
            A7FD65827504D51B3884ABE93516B5D75C7F32EE5628C4A6DC224A8D45ED27D7
            9F02BF27A6F1E813AFB1A8BDD655865847503D80F3B83D248145EDAB13658475
            04D55074E67A7A8C45EDB159D2D8E9634E6A632E2A717B48028BDA579F4A1DFC
            691D42B123166163AEA8B758D41E6B2D6F584750BD8063B835248545EDAFCBE5
            0EEB08AA5BD0932BEA2D16B5B75E9123AD23A89A6312B2B835248545EDAF5F24
            073F598750544721B6E19A7A8A45EDA9D5B227E65A875064256ABA39B78524B1
            A87D768F5C6C1D41753EEEE79A7A8A45EDA98172967504D589788A9B42D258D4
            3E5B29F512AF5ADD5511B391CF55F5128BDA4B4BA536BEB10EA1A88CF9A8C52D
            21692C6ABF3D279DAC23A8DA632457D54B2C6A2FF591EBAD23A82EC76DDC10CA
            8045EDBB9632C93A82EA4D1CCC75F5108BDA43DF492E96588750D4441136E776
            50062C6ADF7D20CD9D3EFAA419DEE75B3C3DC4A2F6D099F2A87504D5DDB8885B
            4199B0A8FD779C3C6B1D41F5144EE4CA7A8745ED9D05D200ABAC432876C77C6C
            C4ADA04C58D4FEFB44F29D3EFA64572CE4FDE91D16B577DAC86BD61154CFE258
            6E0365C4A20EC12572B77504D5EDB88C6BEB1916B567DE9283AD23A8F6C664FE
            0DACCC58D421582CB94E1F7DB2198AB00557D72B2C6AAF14CB5E986E1D423501
            2DB90594198B3A0C77CA65D6115417E16EAEAE5758D45E794C4EB38EA0EA8467
            B80194038B3A0C2BA42E3EB20EA1A88479C8E5FA7A8445ED916592872FAC4328
            78FB97178B3A1423E444EB08AA63F12CD7D7232C6A8FDC24D75A4750F1176AE5
            C5A20E85484BBC671D42C53F52F98445ED8DEF2517BF598750F02D2AE5C7A20E
            C76469E1F4D1277CDBA74F58D4DE38471EB68EA0E2873ECA8F451D928E32D23A
            82EA1974E21A7B8245ED8945B287D3C79CF0188554605187E463C9C70AEB108A
            DDB080F7AC2758D49E385A5EB28EA0E2C184A9C0A20ECB85729F7504D55DB898
            ABEC0516B517DE9103AD23A878D47F6AB0A8C3B25872F0B37508051F9FE30B16
            B507449A61AA7508151F9E971A2CEAD0F4939ED6115497E176AEB30758D41E78
            524EB18EA03A062FF0664F0916756856483E3EB60EA1A88CF9A8C595761E8BDA
            79CBA50E3EB30EA1A88859A8CB5B3D2558D4E119269DAD23A84EC070AEB4F358
            D4CEBB55AEB28EA03A1FF7F3464F1116757844F6C687D621145998887DB9D68E
            63513BEE47C9C1AFD62114D551886D789BA7088B3A44EFCA01D61154CD31896F
            05751C8BDA7117C803D61154B7A0276FF194615187E91819651D413512EDB9DA
            4E63513BED23A9EBF491093BA0001BF3164F1916759816497DACB40EA1A885F9
            A8CCF576188BDA691DE405EB08AA27700A6FEF14625187EA3C79D03A82EA3E5C
            C0F576188BDA61AE1FEBBF27A6A1026FEF14625187EA07C975FABD269BA39047
            9F388C45ED2CF71F94F7060EE1AD9D522CEA70F5955ED6115457E256AEB8B358
            D4CE72FDD1F36DF1126FEC146351876BB9E4E173EB108A2A58885DB8E68E6251
            3B6A85D4C547D62114D998857ABCAD538C451DB227E454EB08AACE18CA357714
            8BDA5177C8E5D6115467E321DED429C7A20E59B134C334EB108A2C4C4153AEBA
            9358D44E72FDA93BD550886D794BA71C8B3A6C6FCB41D6115407E06DAEBA9358
            D44EBA44EEB68EA0BA01D7F2864E031675E8DACA18EB08AA51389AEBEE2016B5
            833E917CFC691D42B13D0AB0096FE7346051876EA1D4C72AEB108A3CCC4125AE
            BC7358D40E3A4E9EB58EA01A8C6EBC95D382451DBEB3E511EB08AA07710E57DE
            392C6AE77C20CD9D3EE6A401A6239BB7725AB0A8C3F7BDE4E237EB108AAD5084
            1A5C7BC7B0A89DB39F4CB48EA01A8BD6BC8DD384451D831BE53AEB08AA5EB889
            6BEF1816B5639E934ED6115487E355DEC469C3A28EC132C9C317D6211455B110
            3B73F59DC2A276CA4AA98742EB108A0A988A46BC85D386451D87C7E434EB08AA
            53F13857DF292C6AA7DC2B175947509D8E477903A7118B3A0EC5B217A65B8750
            54C01434E1FA3B8445ED905F24173F5A875054C522ECC4DB378D58D4B1182FAD
            AC23A80EC278AEBF4358D40EB9426EB78EA0EA8D3EBC79D38A451D8F36F29A75
            04D5181CC10970068BDA199F4A3E965B87506C8D2254E7AD9B562CEA782C9006
            4E1F7D928FD9A8C81970048BDA1927C970EB08AA013893B76D9AB1A86372A63C
            6A1D41F508CEE20C388245ED8819D214C5D62114FCF93A1358D431F94E72B1C4
            3A8482BF4373078BDA11AD64BC750415FF6295092CEAB8F491EBAD23A8F8AE14
            57B0A89DF0A2B4B78EA03A106FF186CD0016755C964A6D7C631D42C1CF79B882
            45ED8055D210F3AD4328F8A9CA4C6151C766A09C651D41C59313DCC0A276407F
            39DF3A828AE714650A8B3A36ABA511E6588750F02C4237B0A8CD2D915C7C671D
            42C1937F3387451D9F57E508EB08AA83F12627C11C8BDADCD5728B75043D1F6E
            E68D9A212CEA181D26AF5B4750F17979F658D4C6BE92DAF8C33A84622B146253
            DEA619C2A28ED16C69E4F44733F9047A7B2C6A63A7CA13D61154FD712E6FD18C
            6151C7A99B3C6E1D413508A7711A4CB1A84DCD92C64EFF2C9D8739A8C45B3463
            58D471FA4AF2F0BB7508C5F628C0269C07432C6A5387CA38EB08AA51389AB767
            06B1A86375ADDC641D41753DAEE33C1862511B1A236DAD23A8F6C73BBC39338A
            451DABA5928B6FAD4328AA255E536FC78930C3A236B35AF6C45CEB108A2C7C80
            BD786B66148B3A5E0FCB39D61154DDF13027C20C8BDACC2372B67504D5C97892
            376686B1A8E3B55A1A629E7508453666620FCE841116B511D74FF9AD8C05D89D
            B76586B1A863F6B21C651D4175245EE64C1861511BE92D375847505D817EBC29
            338E451D37D7DF5CFA3A0EE5549860519BF83AF17ADAE58F63D4441136E72D99
            712CEAB8CD94264E7F5CB321A6A302E7C2008BDAC4E932D83A82EA5EF4E0ED68
            80451DBB2E32D43A826A08BA702E0CB0A80DCC9146586D1D42B13B16A0326F47
            032CEAD8B97EA4F00E28C0C69C8C8C63511B385CC65A47503D878EBC154DB0A8
            C9F587F4DC8CAB391919C7A2CEB8F1D2CA3A826A1FBC872CDE8A2658D4E4FA63
            6FAB275E536FCBD9C830167586154B53CCB00EA1C8C204B4E06D6884454D407F
            39DF3A82EA5CF4E76C64188B3AC306CBE9D61154C7E169DE846658D404AC9286
            986F1D42918DD9A8CBE9C8281675462D933C7C611D425119F390C35BD00C8B9A
            FEE345696F1D41D50E2F723A328A459D5137486FEB08AA4B70276F40432C6AFA
            7FAD64BC7504D538B4E27C64108B3A83BE975CFC661D42511385D882B79F2116
            35FDBF19D2D4E9A34F1A612A8F3EC920167506759701D6115477E212DE7AA658
            D4F45F27CB53D611544FE2644E48C6B0A83366A1D4C72AEB108ADDB0001BF1D6
            33C5A2A6FFFA54F2B1DC3A84624714A02A67244358D419D356C65847508DC0F1
            BCED8CB1A8E97FAE90DBAD23A8FAE10ACE4886B0A833E46D39C83A82AA19DEE7
            3127E658D4F43FBF482E7EB40EA1D80C85D8925392112CEA8C28966698661D42
            35012D79CB996351D3DFDD2B17594750F5C0BD9C928C605167C41372AA750455
            073CCF1BCE012C6AFABB95522FF1AAD55D953017B5392719C0A2CE80E59287CF
            AD432878BBB982454DFFF4BC1C6B1D41C51FF13383459D017DA5977504157F81
            E50A1635AD6B3F99681D41C53F9A65028B3AED7E905CFC6A1D42511D45D89AB7
            9A1358D4B4AE29B20F5CDEA5F936D44C6051A7DDF9D2DF3A82EA565CC9DBCC11
            2C6AFAB7E3E519EB082A7EB033FD58D469B648EA63A57508C58E58848D799B39
            82454DFFF689E4E34FEB100A1E95947E2CEA343B4646594750F1204097B0A869
            7D2E95BBAC23A8EEC0A59C96B46251A7D5BB72807504D59E98C6A3F51DC2A2A6
            F5592CB9F8C93A84623314F1713E69C5A24E239116986C1D42C587D5B985454D
            EB77975C6A1D41C507E4A6178B3A8D9E9293AD23A88EC628DE5C4E6151D3FAAD
            907A8957ADEEAA8C79C8E1C4A40D8B3A6D56485D7C641D42918D59A8C75BCB29
            2C6ADA9067E478EB08AAE3F03427266D58D46973BB5C611D41750E1EE48DE518
            16356D584B99641D4135112D383369C2A24E93C592839FAD4328AAA110DBF2B6
            720C8B9A36EC7DD9D7E9A34FF6C17B3CFA244D58D4697291DC6B1D4175137AF1
            96720E8B9A34C7CAF3D61154CFA123A7262D58D469F1B1D475FA88821D50C063
            4E1CC4A2268DEBFBCAEE98CFA34FD282459D169DE439EB08AAC7D095B7938358
            D4A473FD3775F7E042CE4D1AB0A8D3C0F5BF2535C4741E73E2241635E95C7FEF
            4B4D1461734E4ECAB1A8D3C0F57767BE8E43792B3989454D2571FDD32497E336
            4E4ECAB1A853EE5939CE3A82AA0D5EE18DE428163595C4F5F3192A633E6A7176
            528C459D622B640F145A8750646306EAF33672148B9A4AE6FA89872761186727
            C558D42976B75C621D41752606F02672168B9A4AE6FA3304B23009CD393D29C5
            A24EA95F24C7E9A7DC544301B6E32DE42C16359586EB4FE5DB1FEF707A528A45
            9D5297C99DD611547DD09B3790C358D4543AEDE545EB08AA17700CE7278558D4
            29F4A9D471FA38826D5088EABC7D1CC6A2A6D229903DB0D23A84A236E6A21227
            286558D42974A28CB08EA01A883378EB388D454DA575BEF4B78EA07A00E77182
            5286459D3253641FA78F39C9C76C54E4ADE334163595D60F928B5FAD4328B642
            2136E50CA5088B3A65F69709D61154AFE270DE368E635153E9DD22575B47505D
            85BE9CA1146151A7C80BD2C13A82EA208CE74DE33C163595DE72A983CFAC4328
            AA602176E114A5048B3A255649032CB00EA1A8800FD198B78CF358D4948CA1D2
            C53A82EA143CC1294A0916754ADC2F3DAC23A8BA61306F180FB0A8291922CD30
            D53A84222BF102A109E7280558D429B04472F19D750845552CC24EBC5D3CC0A2
            A6E4BC23075A47501D88B7384729C0A24E81ABE456EB08AA6B70236F162FB0A8
            295947C9CBD611542FA12D27A9DC58D4E5F6A5E4E10FEB108AAD51881ABC55BC
            C0A2A6642D94FA58651D42510773F8B1D072635197DB29F2A47504D543389BB7
            892758D494BC73E461EB082AEE40E5C7A22EA799D204C5D621147998CB9F67BD
            C1A2A6E47D2FB9F8CD3A8482BFD32B3F1675391D2AE3AC23A846E328DE22DE60
            515359DC24D75A47505D8B1B384DE5C2A22E9797E468EB08AA03F0366F108FB0
            A8A92C96491D7C6E1D42C1CF9D94178BBA1C564B43CCB30EA1C8C21434E5EDE1
            11163595CDE3D2CD3A828A2739940F8BBA1C1E9673AC23A83A63286F0EAFB0A8
            A96C8A652F4CB70EA1E0D988E5C3A22EB3A5928B6FAD432878D2AE7F58D45456
            6FC9C1D611547CDA4079B0A8CBEC5AB9C93A82AA276EE18DE119163595DD11F2
            AA7504159FDF57762CEA32FA4AF2F0BB7508C59628E2D360BDC3A2A6B25B200D
            9C3EFA241FB3F951D132625197513779DC3A82EA7E9CCF5BC23B2C6A2A8FB364
            A07504D5409CC1A92A13167599CC96C6586D1D42510BF35199B7847758D4541E
            DF4B0E965887506C834254E75C95018BBA4C0E93D7AD23A846A23D6F070FB1A8
            A97CAE973ED61154BDD1877355062CEA32784DDA58475035C72464F176F0108B
            9ACA6799D4C697D621149B245E536FC7C94A1A8B3A69ABA511E6588750646122
            F6E5ADE025163595D7A372A67504D59918C0C94A1A8B3A69AEDF082760386F04
            4FB1A8A9BC8AA529665887506427D2D5E76C2589459D24D77FB55419F3518BB7
            81A758D4547EAEFF69AE0D5EE16C2589459D24D7DFAC7129EEE04DE02D1635A5
            82EB6F761D8BD69CAEA4B0A893E2FAC71F6AA2105BF016F0168B9A52C1F58F8F
            36C00C54E07C2581459D14D70F14B80B1773FC3DC6A2A6D4385D065B47503D86
            AE9CAF24B0A893E0FA117DBB610136E2F87B8C454DA9F1B5D476FA88E31DB008
            9B70C24A8D459D04D70FBD7F069D38FA5E635153AA5C27375A4750DD886B3861
            A5C6A22E35D71F23B73726F39813CFB1A8295596265E537F631D42510D85D896
            33564A2CEA522A966698661D4235012D39F69E635153EA3C22675B47509D8D87
            3863A5C4A22EA5C7A59B7504D5B1789643EF3D1635A5CE6AD91373AD4328B231
            0BF53865A5C2A22E956552079F5B875054C23CE472E4BDC7A2A6541A236DAD23
            A88EC2684E59A9B0A84BE566B9C63A82EA42DCC3810F008B9A52ABB5BC611D41
            F5060EE19C95028BBA147E901CFC661D42B1190AB125C73D002C6A4AAD59D218
            C5D621147B621A8F3E29051675299C2B0F594750DD86CB39EA41605153AA9D2A
            4F5847503D81533869256251976891D4C74AEB108A5DB1005538EA41605153AA
            7D25B5F1877508C50E28C0C69CB512B0A84BD44E465B47500DC3491CF340B0A8
            29F57A495FEB08AA5BD093B35602167509DE9103AD23A81A612AFFC6130C1635
            A5DE92C46BEA6FAD4328AAA310DB70DA542C6A9548B34411BAEC4D1CCC110F06
            8B9AD2E14139CF3A82EA7CDCCF6953B1A855C3A4B37504553BBCC8010F088B9A
            D261B534C43CEB108A8A9885BA9C37058B5AB15CEAE033EB100A8E776858D494
            1EA3A59D7504D5317881F3A660512BFA494FEB08AAF3F000873B282C6A4A9743
            E44DEB082AFE114FC3A2DEA09F25173F5B8750F02D18E1615153BACC90A64E1F
            7DD20CEFF3E97F1BC4A2DEA01E72BF7504555F5CC5B10E0C8B9AD2A7B30CB38E
            A07A0A2772E6368045BD011F4B3E56588750F0988010B1A8297DBE943CA78F3E
            E1D14D1BC6A2DE808E32D23A826A08BA70A483C3A2A674EA29FDAC23A87818F2
            86B0A8D76BB2B480CB57A621A6F3989300B1A8299D96480EBEB70EA1D80C45D8
            8273B71E2CEAF5106989F7AC43A8F870B830B1A829BDEE930BAD23A82EC2DD9C
            BBF56051AFC7D372827504D5917899C31C241635A5D74AD90305D6211495300F
            B99CBC7F6151FFCB0AA98722EB108A6CCCC41E1CE520B1A829DD464A47EB08AA
            63F12C27EF5F58D4FF72A75C661D41D51D0F739003C5A2A6F4DB5F265847504D
            404BCEDE3A58D4EB582CB9F8C93A84A21A0AB01DC738502C6A4ABF29B28FD36F
            95DD1B9379F4C93A58D4EBB854EEB28EA0BA1ED7718483C5A2A64C3851465847
            503D834E9CBE7F6051FFC327928F3FAD4328B64FBC9EDE84231C2C163565C2A7
            52C7E97D6E372CC0469CBFBF6151FFC3F1F28C7504D5209CC6F10D188B9A32E3
            32B9D33A82EA2E5CCCF9FB1B16F5DFB8FEB79BFA98816C8E6FC058D49419BF48
            8ED3EFC5A989421E7DF2372CEABFD94F265A4750BD86C338BA41635153A6DC2D
            975847505D8A3B38817F6151FFE57939D63A82EA60BCC9C10D1C8B9A326585EC
            9178D5EAAECA988F5A9CC1B558D46BAD947A4E8F6D054C45238E6DE058D49439
            CFCA71D6115427603867702D16F55AAE9F817B1A06716883C7A2A64C6A2993AC
            2328B23011FB720AD76051AFF18BE4E247EB108AAA58849D38B2C1635153267D
            20CD9D7EFB6C734CE2D1276BB0A8D7B8526EB38EA0BA0ED7735C23C0A2A6CCEA
            24CF5947503D8F0E9C43B0A8D7F8526A63997508C5D628440D8E6B0458D49459
            1F4B5DA78F3ED91D0B509993C8A2FE8FCE32CC3A82EA6174E7A84681454D9976
            B1DC631D41751F2EE024B2A88119D214C5D621147530071539AA51605153A62D
            961CFC6C1D42B1390AB179F4B3C8A2C621F2A67504D5CB3832FA318D058B9A32
            EF0EB9DC3A82EA4ADC1AFD2C465FD4A3A59D7504D581782BFA218D078B9A326F
            85D4C547D6211455B010BB443E8D9117F56A698879D621141530054D221FD198
            B0A8C9C20839D13A82EA643C19F934465ED40FCA79D611545D3024F2018D0B8B
            9A2C88B4C47BD621145989172C4DA39EC7A88B7A89D4C6B7D6211455B0083B47
            3D9EB16151938DC9D2C2E9A34F0EC0DB51CF63D445DD4BFA5A47505D85BE510F
            677C58D464A583BC601D41350A47473C911117F55789D7D37F5887506C85426C
            1AF168C688454D563E92BA58611D42918739A814ED4C465CD45D65887504D503
            382FDAB18C158B9AECF490FBAD23A8FAE3DC686732DAA29E258D9D3EE624EE9F
            1F63C5A2263B3F4A0E7EB50EA1D80A45D11EA51C6D51B79637AC23A85E44BB48
            4732662C6AB2D44F7A5A4750F5C24D914E65A445FD8A1C691D41B53FDE897420
            E3C6A2264BCBA50E3EB30EA1A88A85917E0E26CAA25E2D7B62AE7508451626A1
            7994E3183B1635D97A524EB18EA03A158F4739975116F500E96E1D4175128645
            398CC4A2265B22CD30D53A8422D6B31A232CEAA5521BDF58875054C67CD48A70
            1489454DF6DE9103AD23A8E27CFA418445DD47AEB78EA0BA1CB7453888F41F2C
            6AB2D74E465B47508DC111D1CD667445FD75E2F5F4EFD621143551C4A7AF468B
            454DF616497DACB40EA1C8C76C548C6C3AA32BEA3364907504D53DB830B211A4
            FF6151930BCE9587AC23A81EC159914D676445BD401A60957508C5EE988F8D22
            1B41FA1F1635B9E007C9C16FD621145BA330B2A34F222BEA36F29A7504D5B338
            36AAF1A37F6251931B6E966BAC23A8AEC3F551CD6754453D5E5A594750ED83F7
            9015D5F8D13FB1A8C90DCBA40E3EB70EA1A88A45D829A2098DA8A88BA5316659
            8750646122F68D68F4E8DF7694AFAC23ACB503BEE42C466D8874B58EA03A0D83
            229AD0888AFA3139CD3A82AA139E8968F0687D72A5C83AC25AB5B188D318B562
            698669D621141530158DA299D1688A7A99E4E10BEB108ACA988BDC68C68ED6AF
            B1CCB08EB056134CE53446EE6D39C83A82EA60BC19CD8C4653D437CA75D61154
            17E3AE68868E36647F99601D61AD38CF7FA27F3A525EB18EA07A0D874532A591
            14F577928B25D621143551882D221939DAB063E579EB086BF10F3104CC938658
            6D1D42D100D3911DC59C4652D4E7C8C3D6115477E0D228C68D7457C9ADD611D6
            8AF7C9BFF477DD65807504D5209C16C59C4651D40BA5BED3C79CEC8A853CE684
            E0D21B1E87A00B2792F0BDE43A7DF4C9F628C026114C6A14457DB4BC641D41F5
            144E8C60D4A86493655FEB086BBD8FBD3993947083F4B68EA0BA1ED74530A911
            14B5EB8F6D6B96D81479CC09FDC79F5213CBAC43246C8C9FF93B1E5AC3F5CFCB
            544BBCA6DE2EF8590DBEA85D7F103AF02EF60B7ECCA8B40E96B7AC2324B4C658
            CE24AD35584EB78EA03A0B8F043FADC117F550E9621D41D51E23831F322A3D37
            3E46780B7A722A69AD62690A573EDFBF3ED998893D029FD7C08B7AB9E4397D62
            6D25CC415EE02346C998298DAC2324CC097EE3A364BC2E875947501D813181CF
            6BE0457DAB5C651D417501EE0B7CC028590D648E71823D31835349FF70B88CB5
            8EA07A1D87063DB34117F58F92835FAD4328AAA310DB043D5E94BC7ED2D33801
            3FD54FEB9A2F0D9DFE886B434C478580A736E8A2EE21F75B4750F12F81F46F5F
            CBEEF8D3F0EB6F844FB12DE792D671BA0CB68EA00AFB93FF01177581EC8195D6
            21143B6211360E78B4A8ACCE9281865FFD6C3CC4A9A47FF95A6AE377EB108A1D
            5010F07E1A7051B79717AD23A886A273B06345E5F1B1E499FD9A311B0B91C3B9
            A4F5E82D37584750DD8CAB839DDC608B7AA2EC671D41D5181F06FD37152A8FAE
            32C4E82B9F8E473995B45E4B2517DF5A8750D44021B60E747A032D6A919678CF
            3A84EA0D1C12E84851F97D2775F08BC1D7AD91783D1DFE294F545603A4BB7504
            D5B9E81FE8F4065AD4C3E524EB08AAA3303AD081A2D4B8472E36F8AA0FE03CCE
            256DD06AD91373AD4328B2310BF5829CE0208BFA4FC9C727D621141513E35437
            C871A25459252DF14186BFE6BE783792A7FB5259BD22475A47501D8D51414E70
            90457D875C6E1D41C5F7D552C93E9746F839835FAF26A66357CE2595A0B5BC61
            1D41350EAD029CE2008B7AB1E46474834B563514F273AA540ACFCBB119FB5A59
            188963389554A259D218C5D621148D3035C0B7E90658D417CB3DD6115437E29A
            E0C688D2A38F5C9FA1AFC4A9A4D2B2FB4C42E93C8993839BE5E08AFA13C9373D
            D7A924DBA3009B043746942E17C80319F82A313C289052E52BA98D3FAC432842
            3C4A2AB8A23E4E9EB58EA01A8C6E818D10A5D36A3911E99EE8E3318C6F22A324
            5C23375B4750F5C31581CD736045FD813487CBDF51034CE7964849592DE7E191
            34FEFBBB61002A72262909AE1F7D521D45811D7D1254518BEC8749D6215463D1
            3AA8F1A14C10B90E37A7E507D02C5C873E9C484ADA4372AE750455680F100EAA
            A89F934ED6115487E3D5A0868732679474C3E214FF3B6BE05174E2445219AC96
            8698671D42510973513BA0D90EA8A857483D14598750646306EA07343A94591F
            CB09F83085FFBEBD31829F9BA6327B498EB68EA0EA80E7039AEE808ADAE6D0C5
            D23B0303031A1CCABC62791457E0D714FC9B36C5F5389FEF96A0723944DEB48E
            A07A17FB0533E1C114F52F92839FAC4328364101B60F666CC8CA3772359E2CD7
            43302BE114F4C5369C452AA769D2CCE9A34FF6C664640532E7C114F5E5728775
            04556FBE698752E433B90B03B0BC0CFFCDCA381ED72297934829718A3C691D41
            3502C70732EB8114F5A7925FA68D2B53B64521AA053232E482EFE4293C819949
            FC371A275E499FC857D294429F4B9ED3FBEE6E58808D8298F8408AFAE4C4B6E5
            B247705610E3426E992763311EEF60A9F29FA98E0370300E473E279052AEA7F4
            B38EA0BA03970631F74114F587B2B7D3C79CD4C32CBE7187D266952CC24214E0
            23FC865FD69476356C861AA885BC35FFF038134A975F25173F588750D4441136
            0F60FE8328EA5632DE3A82EA15B40960548888D6F5805C601D417531EE0A60F7
            0DA0A85F94F6D6115407617C00834244F46FABA4011658875054C63CE478BF03
            7B5FD4ABA421E65B875054C01434F17E4C8888D6EF05E9601D41751C9EF67E07
            F6BEA8FBCBF9D611545DF198F7434244B461AEFFF171225A78BE0B7B5ED44B24
            17DF59875054C542ECECF988101169A6C83E4EBF9D771FBCE7F9D1279E17F5D5
            728B7504552FDCE4F578101195EC24196E1D41F52C8EF57A27F6BAA8BF92DAF8
            C33A84622B14A186D7E341445432D78F9CDA1DF3BD3EFAC4EBA2EE2243AD23A8
            1EC4391E8F061151695D21B75B4750DD830B3DDE8D3D2EEA59D2D8E923E1F330
            07953C1E0D22A2D272FDB1487E1F7DE271511F2AE3AC23A846E1686FC7828828
            39AE3F68F872DCE6ED8EEC6D51BF2C475947501D80B7BD1D0A22A264AD947A28
            B40EA1A88CF9A8E5E9AEEC6951AF968698671D4291852968EAE948101195C573
            D2C93A82EA443CE5E9AEEC69513F22675B47509D8C273D1D0822A2B2DA4F265A
            47506461129A7BB9337B59D44BA536BEB10EA1A88285D8C5CB7120222ABB0FA4
            B9D3479F344F54B58F479F7859D4D7C98DD6115457E2560F478188A8BC8E9767
            AC23A85EC0311EEECE1E16F5D789D7D3BF5B87506C8E428F3F06404454769F48
            3EFEB40EA1A88DB91E7E6CD6C3A23E5D065B4750DD870BBC1B0322A2D4B844EE
            B68EA0BA1FE77BB7437B57D4B3A531565B8750EC8E05A8ECDD181011A5C662C9
            75FAE8932D51844D3DDBA3BD2BEAC3E475EB08AAE7D1C1B31120224AA53BE532
            EB08AAABD0D7B35DDAB3A21E2B875B4750F9FA9E4222A2545921F512AF5ADDE5
            DFE772BC2AEA62698A19D621145998887DBD5A7E22A2D47B5A4EB08EA03A054F
            78B5537B55D483E40CEB08AAE331C2ABC527224A0791FD30C93A84C2B7B3233D
            2AEA6592872FAC43282A631E723C5A7A22A274795FF675FAE813BF9EC6E05151
            DF20BDAD23A82EC19D1E2D3C11513A759491D611542FA1AD373BB63745FDBDE4
            E237EB108A9A28C416DE2C3B11517A7D2CF958611D4251077350D1933DDB9BA2
            EE2E03AC23A8EEC4259E2C391151265C28F75947503D84B33DD9B53D29EA05D2
            00ABAC432876C3026CE4C992131165C262C9C1CFD621145BA31035BCD8B73D29
            EA23E515EB08AAA7719C17CB4D449439B7C995D61154D7E0462F766E2F8AFA6D
            39C83A82AA19DEE731274444EB5821F9F8D83A84A22A1661270FF66E0F8ABA58
            9A619A7508D504B4F460A98988326D9874B68EA0EA86C11EECDE1E14F510E96A
            1D41D511CF79B0D044449927B2373EB40EA1A89048D7D8F91DDCF9A25E2E79F8
            DC3A84A212E621D7F9652622B2F1AE1C601D417510C63BBF833B5FD47DA59775
            04550FDCEBFC221311D9394646594750BD82368EEFE28E17F50F928B5FAD4328
            364321B6747C8989882C2D92FA58691D42918FD98E1F7DE278519F270F5A4750
            F5C3154E2F2F1191BDF3A5BF7504D5409CE1F44EEE7451BBFE73D88E284055A7
            979788C89EEBBF1BDD0685A8EEF05EEE7451BBFE978D2771B2C34B4B44E40AD7
            DF6DD41B7D1CDECD1D2E6AD7DF2BD8085351C1E1A525227285EB9FDFA98A02EC
            E8EC7EEE6C51BBFEE93B601C5A39BBAC44446E79424EB58EA03A03039DDDD19D
            2DEAA7E464EB08AAA331CAD9452522728DEB674C666306EA3BBAAB3B5AD42BA4
            2E3EB20EA1C8C62CD473744989885CE4FA531BDAE015477775478BDAF567AE9C
            8BFE8E2E281191AB8E9297AD23A8C6A2B5933BBB9345EDFA534CABA300DB3AB9
            9C4444EE5A28F5B1CA3A84A2C1FFB5771FE05195E9FBC7EFA18808225644D6C2
            4AA82A60615150145157C15E111BF6828ABAF68AABABD815B1ACA0D850B18B58
            1751D11FAC0504948E0D574541A9D279FE130CF9272139649299F3BC33F97E72
            D92ED4B9CF0CCF7BE74CE6BC4763543DC0B53DC8A2EE6DF77A478874B3AE0AF0
            A50480D09D6D0F7B4788F4A87A06B8BA0758D45F5B4B2DF50E11A151F27C7A83
            005F4A0008DD2F96A7F9DE21226C955CDFEB04B7BE0758D447D98BDE11220DD2
            C9C1BD8C00901DFE69D7794788CEA76B825BE1832BEAD1B68742CB54546B8D61
            9B1300A8A0C5D64C33BD4344A8AB69C17D0629B8A2EE681F7B4788F48EF60BEC
            2504806CF2989DEA1D21D2D97A30B0553EB0A21E62C77A478874908605F60202
            40765965BB698C778808E1ED931154512FB3569AEE1D2242757DA11D827AF900
            20FB8CB0CEDE112275D3D0A056FAA08AFA6EBBD83B42A433F570502F1E0064A7
            03ED2DEF0891DE55978056FB808A7AAE35D11CEF1011EA6AAA1A06F4D20140B6
            9A643B05BDF5491B7D1ED0C786032AEA7FD89DDE1122DDA0EB8379D90020BB9D
            6103BC23447A422706B3E20753D4DF588BA0B73909F3327800C84EB32C4F0BBC
            434408696BAB608AFA387BCE3B42A4013A2D90970C0072C10DD6C73B42A47FE9
            CA4056FD408AFA136B1FF436272D345E350279C90020172C4A9E53FFE41D22C2
            869AA60641ACFB8114F55E36D23B42A437F5F7205E2E00C81D03EC0CEF08917A
            A95F102B7F1045FD921DE91D2152670D0FE2C502805CB2D2DA6A827788083534
            4E2D0358FD0328EAE5B683A67A8788504D9F6AE7005E2A00C8356FDA41DE1122
            1DA6970358FD0328EA7E76817784483DF568002F1400E4A203EC1DEF089186AB
            B37B03B817F502CBD32CEF6721426D4DD1D6EE2F1300E4A6F1B6B3567A8788D0
            569FB96F7DE25ED457585FE704D1AED58DD4340064CCA9F69877844883D5BD6A
            17F5F7D65C8B7D9F81480D344D1B52D408D40AFB46533439F9C7F79AAB855AA4
            F99AA75AAAAB0DB551F2CF9BA8A99AA979F28FCDF85D8C60FDCF9AEA0FEF1011
            B6D324ADEF3A41CE457D923DE9FAF8EBF2A0CE6681437016DA48BD97FCFA52CB
            CAF95F6CA60EEA9CFC6AA504BFA3119C6BED26EF08916ED3A555B7A8C7D86E5A
            E579F4EBC0362708CDD7F6B4DED6275A5EC1FFBE41B2AC0FD7C1CEE7074071A1
            7F56A9BEA66B53C799712DEA2E36DCF1D1D76DA8BAB19C2110F3ED153DA9E169
            D9C16F231DA293B42F67D708C643768E77844817EA9EAA59D4AFDBC17EC75D0E
            7B6B04CB188230D1FAEAF9B47F9AA3A9CED7E99C5B23082BACB5267A8788B09E
            BE5213B759712BEA95C997E52BAFA32E87843ED1AE2C617037C16ED7E08C5DBE
            B285CED1C5AAC7EF74B80BFDD4ED283D5FF58A3AF4373A4ED0932C5E7036CEAE
            D1B08CDFAE66F36455F7E6CC1AEE3ADB08EF081112FA487B384D8953512FB43C
            FDEC73C4E5B2BE266B5B162E385A64FFD49D5A11D3A36DAFFBB9F10C9C8DB39D
            83FE78F1DF34CAE9731D4E457D8DDDECF2B8E575856E61D182A3A1D64BDFC7FC
            98DDF400BBF0C155E817EC3EA763AA4E51877E79FB669AAE8D58B0E0E4173B55
            C35C1EB99EEED269FCCE879B99D62CE82DB0B6D744ADE730212E45DDD306393C
            6AF9F5532F162B381969DDF53FC7C73F410FA90EBFFFE1E42ABBC53B42A4BB74
            51D528EAF1D636E89F4334D597AAC942050766F7E9D20A6F66922ECD35443B32
            017011FAD6271B6B9AC3D6270E45BDBFBD1BFB63A6E2251DCE2205070B92E7D2
            3E6F7997544703752C530017FDAD9777844897E88EDC2FEAD06F13BEBB3E66BF
            2638F8CDBA6AB477884209DDAE4B98033860EB93B5C55CD42BADAD26C47B8429
            F1BC520E55D9F7B6BFA6788728E172DDCA2CC0C1AB7698778448C7EAD9DC2EEA
            017646BCC797A2EE1ACCD284D84DB20334D33B44294ED123DC96060EF6B5F7BC
            234488FF842ED6A25E644DF5639C4797A25A9AA4C62C4B88D954EBA85FBD4394
            E1540DE0474188DDA7F6B78CEFC857191D3532778BFA06EB13E7B1A5EC1FBA9D
            250931FB2559D3D3BC4344B85A373115885D0F1BEC1D21D28B3A22C6B988B1A8
            67599E16C4776429DB58D3B5094B126235DFF6D658EF10EB708F2E642E10B31F
            AC69D05B9FFC559362DCFA24C6A23EC306C4F6581571B77AB31C2156CBAC9BC2
            BE58315F353DABA3990DC4EC72BBCD3B42A47B7541EE15F524DB29B61B0C5444
            E3E4F747B5588C10AB73ED41EF08E5B2BE46AB35D38158CDB53CCDF60E1121CE
            F760632BEA83ECCD981EA9628670CE8098BD6847794728B7A6FA4C1B322188D5
            7D76A1778448F15DC01853518FB0CEF11C4F05F9DDBE0C55D5F7D656BF798748
            414F3DCA842056CBAD55D01FB45C4F93F4D758A62296A25E65BB694C1C475361
            23D5914508315A6E9D92DF1C6697C7751253825885FEAE530F3D953B45FDB89D
            12C7B154D8917A810508B1BADE6EF48E90B2BA9AC8FDAA11B38EF6B177840809
            7DA25D639889188A7AB135D7F7993F920AABA9AF94C7F28318CDB01DB4C43B44
            051CAD214C0A62F589B50F7AEB93BDF4416E14F54D766DE68FA3127AEB6E161F
            C4AA9B857197ACD4BDA1039916C4EA387BCE3B42A4577548C66722E345FDAB35
            D1FC4C1F4525D4D77487BB8BA22A7BD98EF08E5061799AC0658C88D537D6424B
            BD434468969C899A199E898C1775E8578ADEA64B597610A3C5C965E73BEF1095
            F02F5DC9C4205697D85DDE1122F5D7B9D95DD4536C472DCFEC1154CA769AA4F5
            597610A3FBED7CEF0895B251F2DB8C8D9819C4E877CBD31CEF101136D7B40CCF
            44868BFA101B9AD1FF7F650D5677961CC468B935D5B7DE212AA9AF2E636A10AB
            BBEC12EF0891AED2CDD95BD41FD8DE99CC5E69ED349A6D4E10AB41D6D33B42A5
            35D037AACDDC2046CBAC95A67B8788B0BEA6689B0CCE44068BDAAC9D3ECB5CF2
            3418AECE2C378891D98EFACA3B441ADCAFF3981CC46A881DEB1D21D2C91A949D
            45FDB49D90B9DC6970A85E61B141AC5EB5C3BC23A4C5769AA16A4C0F6264B687
            467B8788502D795ADA36633391B1A25E62CD83FE6C6B0D8D534B961AC4EA507B
            CD3B429AFC47FB323D88D5E8645587BCF5C9DE1A917D45DDD7AEC854E6B4E8A5
            7E2C3488D56FD650CBBC43A44966DFE8034A7394BDE81D21D2EBEA9AA1A9C850
            51FF667941DF1968434D5303161AC4AABFF5F28E903675F4B3EA324188D5D7D6
            32E8AD4F9A6B826A64642A3254D41758BF8C3E2195C5A60D885F7BFBAF778434
            7A5AC7334388596FBBD73B42A4877566F614F5346B15F436275B6B0A97972066
            33AC897784B43A48C39821C46C4E728AE67A8788B0A5A665E49DA68C14F511F6
            72C69F90CA784227B2C420660FD939DE11D26A03FDC6AEDF88DDED7699778448
            D7A94F7614F528EB10F467F35A6B0C97962076C7DA10EF086936521D9923C46C
            99B5D40CEF10116A6B4A06EEDA9EF6A236EBA8FF8BE929A99877D585E5053133
            6BA859DE21D2EC465DCB242176CFD8F1DE11229DAA81E117F5B3D63DA6A7A362
            BA69288B0B6237D15A794748BB7DF41EB384D89975D028EF101132B1F5499A8B
            7AA9B5D4D7313E25A9AAAE716AC5E282D8E5D2A5596BACAFDFB9F71C1C7C689D
            BC2344DA5F6F875DD477DA3F627C3A5277961E6261818333ED11EF081930566D
            98273838DC5EF18E10E92D1D90D6C9486B51877ED7D0BA9AAA862C2C70D0C93E
            F48E9001CFEA58E6090EA6DA0E415F02DC52E3D2BAF5495A8BFA62BB3BF62724
            157CF8055EB6B45CFB28593E260A5ECEB7FBBD23441AA0D3C22CEA6FAC45D0DB
            BB6D953C9FAEC3B20207F3ACBE77848CE8A1A79828B8986D4D34CF3B4484F4F6
            4D1A8B3AF4EB4407EA541615B8F8D4DA7947C8885DF529330527B7DA95DE1122
            F5D175E11575E8B720DB4963549D45052E5EB0A3BD2364C466FA95998293C5D6
            5CDF7B87885057D3B4659AE6236D45BDA77DE4F68494C7DBDA9F25054E06DAE9
            DE1132623D2D65AAE0E6493BC93B42A433F5705845FDA21DE5F874ACDB017A8B
            05056EEEB5DEDE113264A9D663B2E0C4AC9D3EF30E11A1BABED00E69998FB414
            F5726B953CC90F5726768A01CAEF26BBD63B4286CCD6A64C16DC7C607B7B4788
            94AE7BCCA5A5A8433F5F384D03584CE0E80AEBEB1D2143BED176CC161C1D6243
            BD23447A47FBA56142D250D4F3AC49F2FBEA706DA0A96AC4620247BDACBF7784
            0C19AF1D992D389A643B69857788086DF5591AEED69886A2BEDC6EF37E2E2265
            E6FEA040F95D60FDBC2364C8576AC974C1D5B9F6A07784488374B27F51FF604D
            B5D8FB9988B085A6A91E4B095C5D65B77847C890EF3370EF5D2015BF5A13CDF7
            0E11A191A66A834A4E49A58BBA870DF67E1E223DAC335948E0EC16BBCA3B4286
            FCAEFACC179C85FE61CD9B74B56F518FB55DB5CAFB5988D042E3D3BA353A5011
            FDEC02EF0819B29CF982BBDCDFFAA49245DDC5867B3F079186E9209611B81B64
            3DBD2364446DFDC17C2100A14FD8B9EAEF57D4AFD9A1DEC71FA9B386B38C2000
            AFD8E1DE1132A2A17E64C2108055B68BBEF00E11A18626A8792566A51245BDC2
            5A6BA2F7F147A8A64FB40BCB080230C176F28E90117BEA43260C4118619DBD23
            443A44AFFA14F503769EF7B1473A5983584410842556572BBD4364005B09211C
            5DED0DEF0891FEA37D2B3C2D152EEA05D6543F7B1F7984F53545DBB08820108D
            ED5BEF0819D0579731630844E85B9FB4D1E715DEFAA4C2457DB5FDCBFBB8235D
            A59B5942108C03EC1DEF0819F08A0E65CA108C33ED11EF08919E528F788B3AF4
            6D4E36D774B639414072736FB2896AC19421183F257B69A1778808DB6AB2D6AF
            D0C454B0A84FB627BC8F39527F9DCB0282803C61277B4748BB8D3447D5993304
            A48FDDE01D21D2ADBA3CBEA21E673B07BDCD49334D504D16100464A66DE31D21
            ED0ED66B4C1982B2D89A69A67788081B6A9A1A54606A2A54D4FBDBBBDEC71B89
            9F9C213C4D6C86778434BB4B17316708CC403BDD3B42A4F3755F3C453DCCBA79
            1F6BA4BDF401CB078273860DF08E906663D58649436056D9AEC9DF99E1AAA92F
            D534E5B949B9A8575A9BE403852BA1FF6A37960F0467B0F5F08E90569BE8D734
            DC671748B7B7EC40EF08918ED08B992FEA47EC4CEFE38CD45D83593C10A05FAD
            91967B8748A3E3F534938620857E31E448754C7176522CEA85D6543F791F6584
            F53451DBB37C2048DD6C987784347A4307326908D278DB39E89D00DB69B41229
            4D4F8A457DBDDDE87D8C912E535F160F04EA393BCE3B42DA6CA1FF71834B04EB
            347BD43B42A467745CE68AFAC7E4F9F422EF238CB0B1A66B13160F046A8935D4
            5CEF1069D25B7733690856E85DB59D26AB560A139452519F6E03BD8F2FD2BDBA
            80C503010BFDFBFCF2FB8C3BD32168A1BFFB7B872EC94C514FB0B641BFEFDF44
            5F693D160F046CB4EDEE1D212DDA6A0C9386A02DB4BCA06F1B95DAFBBF2914F5
            DFED6DEF638BF4828E64F140E0F6B1F7BD23A4C1101DCDAC21700FDBD9DE1122
            5DA4BBD25FD4EFD9BEDEC715A9BDFE2FC5CFD101F17BC70EF08E50694D34993D
            BE11BCD0F7FC582F992EAF9C7354CEA25E65BB698CF77145FA481D583A9005DA
            D9A7DE112AE9319DC2AC210B84BE8BE6D11A92DEA27ECA4EF43EA6341D30E0EB
            653BC23B42A56CAB69DCF20659A28B0DF78E1021A1D16A57AE592A57512FB716
            0AF986026C7382EC61B647723CB3D7133A91594396186BBB067DA7C7FDF44EFA
            8AFA213BC7FB7822A5F24379C0DB58DB2DE8EB27A274D0483E0B822C728A3DEE
            1D21D27BDAA71CF3548EA25E6279FAC1FB6822D4D7746DCAD2812C729E3DE01D
            A142AAEB73B566D69045FE674DF5877788087BE8E3F414F51D76A9F7B144E74B
            E9C271C0DFEFD65CBF7887A800F62343F6B9DAFEE51D21D2EBEABACEA95A6751
            2FB0BF6AB6F7914468AC49296DC50684E0093BD93B42CA1AE92B6DC4AC21CBCC
            B7BCA0BF2D6EA331EBFC71D23A8BBA8FDDE07D1C919ED5B12C1DC84227D8D3DE
            1152524DEFAA33B3862CF4809DE71D21D2733AA67245FD7BF27C3AE4DB08A47E
            BB30200C0B6D574DF10E91821B752D9386ACB4D25AEB2BEF10119A26D345DF8B
            6E1D457D8DDDEC7D0C913ED49E2C1EC8529F5B072DF50E514E9D93E7D3D59835
            64A9D7EC50EF08919ED409152FEA85B6AD7EF33E820887EB25960E64B17E7681
            77847269A0B16AC8AC218B85BDCBFE4EFA22F2BDE1C8A2BEC72EF2CE1FA1A6BE
            5453160F64B5DE76AF778475DA40FFD1EE4C1AB2DA17B64BD05B9FBCA9BF57AC
            A85758137DE79D3EC2F9BA8FC503596E951DA7E7BD4344AAA9D7229710203B84
            FDF1CDCE1A5EB1A27EDA4EF0CE1E61434D5303960F64BD65D63579C61AAA8406
            AA2773861CF083350B7AEB93D1FA5B99931651D46DED0BEFE4116ED1152C1FC8
            09F36C6F853A6B7D751973861C7185F5F58E10E1583D9B7A51877DDFDCBF688A
            366001418E986B07EB23EF106B49E87676FD430E5960799AE51DA24CD593AD56
            D6CDA5CA2CEAFD2CDCB7E3D6FD617620BB2CB5E3F5927788626AE811EE3B8D1C
            13F67516BDD42FB5A29E603B79678EB0B33EE59A4EE498E5765AF21BD050D4D1
            8B3A8019438E596E3B68AA7788326DA01FB471A9535746515F60FDBC334728DF
            8DC180EC62D647FF0CE21292EDF4BC7665C690835EB623BC2344B84FE797BFA8
            175B23FDEE9DB84C07EB359610E4A81176BC7E76CED04D8F6B13660C396A2F1B
            E91DA14C3B6A7CF98BFA713BC53B6F99AA6B9C5AB1882067FD623D1C2FD7AAA1
            AB751D3F58420EFBC4DA6BDDB777F6324AED4B99BE528B7A4F0BEF13A86B9CAD
            07594490D356D8CDBAC56517F0161AC81E64C879DDED59EF0865EAA947CB57D4
            93AD65B0DF6FD4D5346DC942829C37C37AE9AD581FB1B62ED395DCDB1D55C0B7
            D63CD8DBE1D4D68FAABFD6149652D417D93DDE59CB7493AE6621411531D4CED3
            CC981EAB9BEE5363660B55C4A576877784323DA073D65DD44BEC2F9AE39DB40C
            8D34956D4E5085CCB7FB744FC6E7B183AE61376F5429BF5B9360EF0CD94663D7
            5DD4CF5A77EF9C657A945D8751E52CB4077567C6F653DA2759D29D992A543921
            DF1BF2D3B52E8E5CABA80FB757BC5396A1B5C6F0695454498B6DA006685C5AFF
            9FEBEB109DAF8E4C14AAA465D65233BC4394E112DD115DD40BAC81167BA72CC3
            3BDA8F450555D8447B428FA7E52AEB5D74A27A6833E60955D8F3768C7784326C
            ADEF9428369D258A3ADC5B5BFE5D6FB2ACA0CA5B61C3F596DED3840A5D995157
            7BA9B30E2B73EB7FA0EA30EBA051DE21CA50F26AEA12457D98BDEA9DB054D535
            563BB2B800057EB5111AA1319AAAB9EBFC77AB691B3553876445B7534DA60828
            302A59D5615E8A7C91EE2ABBA8E75B032DF14E58AAD33480050628C52C9BAC29
            FA4EF3B430F9352FF9552B79E6BCA1364EFE7963354D567453D5667A80521C6D
            2F78472855C937BF8B15F593769277BE52D5D1343564A90100A4D137D622D0AD
            4F3ED61E6515F52136D43B5DA9AED70DD4340020CD42DDE0EB42DD537A512FB0
            CD83FCDEA2A1A6AA2E450D0048B3399617E4BD221B69669137BF8B14F5AB7698
            77B6523DA2D3A969004006DC61977A4728D5176A5D5A51F7B2FEDEC94AD152E3
            559DA2060064C0526BAE6FBD4394E2365D5A5A51E7D974EF64A578458752D300
            800C79C24EF68E508A2E7A77EDA2FED61A7BE72A453B8D2EB1430B0000E9B3CA
            764EF306BDE9504B7354A7A0FD0A8BFA213BC73B5729DED33ED4340020835EB1
            C3BD2394E2CDC2BBDA1516F591F69277AAB5ECA777A86900404699FD4D9F7A87
            584B6FDD5DBCA857DAE6017E44FD03ED45510300322CC4AB9E5AE9CBE2453DCA
            F6F0CEB4963DF521350D00C838B3361AEF1D622D33F597D52D5850D477DA3FBC
            13ADE52D1D4051030062F0AC75F78EB096E7744CD1A23ECE9EF34E54421B8DA5
            A60100B15869CD34C33B440997E88EA245DDD8BEF54E54C2209D4C5103006272
            AFF5F68E5042478DFCFF45FD8B35F0CE53C216FA4EEB53D40080982CB0AD35CF
            3B4431B59379F2EF21BFBAA8875937EF3C2570BF2C0040BC2EB4FBBC23943046
            6DD714F5F576A3779A62AA27CFA71B51D40080184DB616DE114A784867AD29EA
            BFDBDBDE698AE9AAD7A9690040CC3ADAC7DE118AE9A947D714F56636C73B4D31
            2FE9708A1A0010B3C7EC54EF08C5FCB9E949B2A867D996DE598AD9423FACFEF1
            390000715A685B69817788226A6A51B20F9345FDA175F2CE52CC79BA9F9A0600
            3838C19EF68E50CC54E5E517F52376A6779262DE57278A1A00E020B45DBF87AA
            5B7E515F6A77782729624BFDA0EA143500C0C1526B10D4D5D477E892FCA23ED4
            5EF34E52C4B9EA4F4D03009CF4B0C1DE118A3843FFCE2FEAE636C53B4911AFAB
            2B450D0070F2949DE81DA1884E7A3F91586E75B4CC3B49A15A9AADBA143500C0
            C96C6BA055DE210A35D48F89C434CBF3CE51C4FE7A9B9A0600386A6FFFF58E50
            C43C253EB4BDBC531471AB2EA7A801008EAEB25BBC231431598917EC28EF1445
            8C54478A1A00E0E8753BD83B42111F28F1809DEB9DA2502DCDE5E696000057BF
            DB6601FD94FA7925FAD8F5DE290AB5D37FA9690080B390AE86BA5F89F3ACBF77
            8A42A7EB118A1A00E0EC187BDE3B42A1EB94383AA03877AB37450D0070766340
            EF359FA5C4DEF6BE778A42EFAA0B450D0070F6921DE91DA1D0E14AEC6813BC53
            149AAEED296A0080B32FACAD7784421D95C8B369DE290A24B458B5286A0080B3
            D9B6B9778442BB29B19D7DEB9DA2C096FA899A06000460035BEC1DA1406B25B6
            B21FBD5314D851E3296A004000B6B199DE110AB45062339BED9DA2C0EEFA3F8A
            1A0010809636C93B4281264AD4B3F9DE290AECA777286A004000DAD9A7DE110A
            6CAB44ED60DE87EFAAD7296A004000F6B48FBC231468A844755BE99DA200B7B8
            040084219C33EA4D95A8612BBC5314E8A4F7296A004000DAD838EF08053651A2
            BECDF54E5160177D46510300029067D3BD2314D85A8946F63FEF14051AEA478A
            1A001080BAB6C83B4281164A340BE6665ED5B45435A86A0080B37956DF3B42A1
            5D95D8C53EF74E5188BDBE0100FE42DAEBBB93129DEC03EF14855ED091143500
            C0D920EBE91DA1505725BADA30EF1485AED58D143500C0D945768F778442C728
            71AC3DE79DA2D05EFA80A2060038DBC5C678472874AA12BD03FABEA1867E557D
            AA1A00E0E857DB52ABBC4314BA52893BED12EF14453CA763286A0080A3907E42
            2DF55762881DE39DA28803F506450D0070B477401FB2965E5762B4B5F74E5144
            357DAD6DA96A008093AFAD89CC3B4411E394F8D1B6F24E51CC85BA87A2060038
            39D71EF48E50CCEF4AACB4DA5AE69DA3885A9AA6ADA96A008083EFADA9967A87
            28A2AE162412A6EDED6BEF24C59CA027296A00808313ED29EF08C5B4D0C4FCA2
            DEDFDEF54E52C2EBEA4A55030062F68675F58E50C2411A965FD497D9EDDE494A
            68A4B1DA9CAA0600C468B6B5D50FDE214AB852FFCA2FEAC1D6C33BC95A3A68B8
            6A51D5008098ACB0FD35C23BC45A86E8E8FCA29E68ADBC9394E2540D5082AA06
            00C4C0EC1C3DEC1DA21453D434BFA8575A3DFDE19DA514A7279FB46A54350020
            E32EB7DBBC2394A2AEE6257B30917F59777BFBAF779A529DA1075483AA060064
            D04ABB50FDBD43946A0F7D9CECC0D5457DB68578C29FAF8B866863AA1A009021
            0BAD875EF30E5186F374FF9AA2FEB79DE59DA64C791AAC5DA96A0040068CB7E3
            F5957788323DA2D3D714F574CBF34E13A1A6AED7E5BC050E0048AB5576B7AE0E
            6A1FB292A6A9C99AA2961ADBB7DE792235573F75A1AA01006932C67A69947788
            48DBEADBD5BD5750D467D800EF44EB905077F559FDBD05000095F19DF5D1E35A
            E51D631D4ED380A245FD9C1DE79DA81C6AA887AE561E650D00A8A06FED160D0A
            EA6654657946C7152DEAD9D620F8EF2DFE544D9D75A68E5075EA1A0090928FEC
            3EBDAC15DE31CA25A19FB545D1A296DADA17DEA952D058C7ABBB5A51D6008072
            986ACF68B0A67AC748411B8D2DE8B8C2A20E735796683BEA6075D5DF38BB0600
            946A957DA6617A5D63BC83A4EC52DD56B2A83FB576DEA92A685375D29EEAA0B6
            5CC20500586DA58DD347FA5823F4AB77940A1AA5F6258B5ACAB3E9DEB92A6583
            E419769BE4D70E6AA22DA96C00A8727E49F6D897FA42E3345E0BBDC3544A63CD
            28BC315591A2BECEFEE99D2C6DEA6A7B6DABADB465F2AB81EA69A3E4573DD54C
            FECA869C770340165B610B927F5EAE059AAB799AAF5FF49366E9477D97ACB605
            DEE1D226FF3ED46BFEBE48514FB616DEC9000080266887D28A5A6A63E3BCB301
            0050C5B5D0C422EFFD162BEABE7685773A0000AAB89B75555945FD9D6DAF95DE
            F90000A8C2129AA6EDCB2A6AE9307BD53B21000055D8817AA3D8879E4B14F508
            EBEC9D1000802AEC2D1D1055D4D9B695280000B9A4A926175E41FDA7B58AFA31
            3BD53B25000055D4833ABBC46E1F6B15F552DB56B3BC73020050056DAC99AAB3
            AEA296AEB71BBD93020050055DAE5BD7DA3DB394A29E65DB6B9177560000AA98
            5A9AA6ADCB53D4D23576B3775A0000AA988B74572977A328B5A8E725CFA9E778
            E70500A00AA9AB19DAA2BC452DDD6E9779270600A00AB941D7977A77C7328A7A
            8935D54CEFCC000054119B25CFA7EBA552D4D2003BC33B35000055C4DDEA9D28
            FD57CA2CEA15B6A3267BE70600A00AD84653552BD5A2963EB07D54F6AF020080
            F478498727CAFAB5445415F7B441DED90100C87147E8C544D9BF1A59D4BF594B
            B61305002083EA69A21A55B4A8A5C1D6C3FB080000C8610FE9AC44D4AF27D6F5
            53E8436CA8F731000090A3DAEB6355AB5C517F6FADB4D0FB380000C841EB69AC
            5A26A2FF9D7516B534D04EF73E12000072D01DBA24B1AE7FA71C452D9D6C4F78
            1F0B000039A6AB862A919EA25E64ED34D1FB780000C8215B6BAC365D674D97B3
            A8A5AF9255FD87F731010090236A6A843A94A3A6CB5DD4FCA41A0080F4B95317
            97ABA653286AE9247BD2FBB80000C80187E89572FC74FA4F2914F512EBA28FBD
            8F0D00802CD74A1FA97E396B3AA5A296E658074DF13E3E0000B2D8561AADADCB
            5DD32916B5F48DEDCEEEDF000054503D7DA8D629D474CA452D7D667B6B91F771
            020090856A6A98F64BA9A62B50D4D2303B4C2BBC8F1500802C93D0633A39C59A
            AE50514B03EC2CADF23E5E0000B24A5F5D96724D57B0A8F36F7F7992567A1F31
            000059E3265D5D819AAE70514BCFDA89BC010E0040392474977A57A8A62B51D4
            D2103B41CBBD8F1D0080C025748F2EA8604D57AAA8A5D7ED282DF53E7E000002
            96503F9D57E19AAE64514BAF59776ED6010040196AEADF3AA512355DE9A296C6
            D9C19AE9FD3C000010A07A7A460755AAA6D350D4D28F76A83EF37E2E000008CC
            F61AAA1695ACE9B414B5B4C84ED02BDECF07000001E9A097B579A56B3A4D452D
            99F5511FE7A7040080509CAA07B55E1A6A3A6D459DEF293B570BDC9E120000C2
            504BB755E272AC92D258D4D2B776BC46393C25000084A2999E51DBB4D5749A8B
            5A5A6137E99FEC030E00A8A24ED403AA9BC69A4E7B51E71B6E27E9C7D89E1200
            00C2502F59D23DD25AD2F93250D4D22C3B4DC362784A000008C51E7A4A8DD35E
            D3192AEA7C43ED5CFD90D1A7040080306CA43EEAA5EA19A8E90C16B534CFAE53
            7F6E860900C871DDF4A0FE929192CE97C1A2CE37C6CE62D7320040CE6A9C3C25
            3D3063259D2FC3452D2DB7BB75B3E667F8510000885B2D5DAC6BB441466B3A86
            A2CE37C76ED7BD5A12C323010010876A3A52B7EAAF192EE97CB11475BE997693
            06F2136B00400EE8A23BD43A8692CE175B51E79B64D7EB05C5F9880000A457FB
            E49974A7984A3A5FAC459D6F94F5D550F62E030064A1BD7479A5EF2F9DAAD88B
            3ADF0CBB4F03F487C32303005011D57490AED2EE3197743E97A2CE37DB06EA3E
            B61A0500046F43F5D4C5DAD6A1A4F3B91575BE25F6841EE13A6B0040B09AE90C
            9DAE8D9C4A3A9F6B51FF69923DAE419AE51D03008022EAE9509DA47D95702CE9
            7C011475BE953642FFD6AB5AE61D040050E555D3EEC98AEEA13ACE15FDA7408A
            FA4FBFDA906459BFAFE5DE410000555235B54F9E471FA76D82A8E83F0555D47F
            5A64EFE9790DD55CEF2000802A637D7554371DADAD02AAE83F0558D47F5A66EF
            27CFAEDFD174EF2000809CD64807E810ED97F13DBB2B2AD8A25EE3671BA98FF4
            B1C6B0A31900208D1A26CFA1BBA8835A055AD06B045FD46BCCB20FF5A146E94B
            2DF58E0200C85A35D442EDD429F915D2CFA1A3644D51AFB1C2BED757FA7CF5D7
            4FDE61000059A19E76542BB5D42EC9AFDA5952D06B645D5117F5934DD00C7D53
            F0F59B771C004030EAA971C1D7F6C98AF6DA552C1DB2BAA88B9B67F975FD83E6
            ACFE9AAD5F57FF951DC50120B7D5D6A6ABBF364B7EE5FF75ABD5F5BC69165773
            713954D4A55B6C4B344FABB4420B92FFF4C7EA9F70CFE58369009095EA2BA1F5
            5427F977755533F9F7F5552BD84F6BA7CBFF039C072B777038D0850000002574
            455874646174653A63726561746500323032312D30332D32355432303A30363A
            35382B30303A303081F83DA30000002574455874646174653A6D6F6469667900
            323031362D30342D31365430373A34393A34382B30303A3030C2900C3B000000
            0049454E44AE426082}
          Proportional = True
          Transparent = True
        end
        object mmDescCfg: TMemo
          Left = 0
          Top = 25
          Width = 290
          Height = 124
          Align = alTop
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Enabled = False
          Lines.Strings = (
            'As fun'#231#245'es de configura'#231#227'o alteram '
            'comportamentos da DLL, portanto por '
            'ser um exemplo de teste nem todas '
            'est'#227'o implementadas.'
            'Leia a documenta'#231#227'o e caso seja '
            'interessante implementar em sua '
            'solu'#231#227'o esteja ciente das altera'#231#245'es '
            'que as mesmas proporcionam '#224' '
            'experi'#234'ncia produto.')
          ReadOnly = True
          TabOrder = 0
        end
      end
    end
    object btnExecute: TButton
      Left = 1
      Top = 645
      Width = 298
      Height = 25
      Align = alBottom
      Caption = 'Executar fun'#231#227'o'
      TabOrder = 1
      OnClick = btnExecuteClick
    end
    object cbFunctions: TComboBox
      Left = 1
      Top = 14
      Width = 298
      Height = 22
      Align = alTop
      AutoCloseUp = True
      Style = csOwnerDrawVariable
      TabOrder = 2
      OnChange = cbFunctionsChange
    end
  end
  object imgList: TImageList
    Left = 81
    Top = 376
    Bitmap = {
      494C010102000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000E6E6E600E6E6E600E6E6E600E6E6
      E600FFFFFF000000FF000000FF000000FF000000FF000000FF000000FF00E6E6
      E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EEEEEE00EEEE
      EE00FFFFFF001375110013751100137511001375110013751100EEEEEE00FFFF
      FF00FFFFFF00EEEEEE00EEEEEE00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E6E6E600E6E6E600E6E6E6000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00EEEEEE00EEEEEE00FFFFFF001375
      1100137511001375110013751100137511001375110013751100137511001375
      1100EEEEEE00FFFFFF00FFFFFF00EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E6E6E600E6E6E6000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF00FFFFFF00FFFFFF00EEEEEE00EEEEEE00137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      110013751100FFFFFF00FFFFFF00EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E6E6E6000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00FFFFFF00FFFFFF00056D0300137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      11001375110013751100EEEEEE00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00E6E6E600FFFFFF0013751100137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      1100137511001375110013751100FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF0013751100137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      1100137511001375110013751100EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF001375110013751100137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      1100137511001375110013751100EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF001375110013751100137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      1100137511001375110013751100FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF001375110013751100137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      1100137511001375110013751100FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF001375110013751100137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      1100137511001375110013751100EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00EEEEEE0013751100137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      1100137511001375110013751100EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E6E6E6000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00FFFFFF00FFFFFF0013751100137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      1100137511001375110013751100FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00E6E6E600EEEEEE00EEEEEE00137511001375
      1100137511001375110013751100137511001375110013751100137511001375
      11001375110013751100FFFFFF00EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF00E6E6E600E6E6E600EEEEEE00EEEEEE00EEEEEE001375
      1100137511001375110013751100137511001375110013751100137511001375
      110013751100FFFFFF00FFFFFF00EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00E6E6E600E6E6E600E6E6E600FFFFFF00FFFFFF00EEEEEE00EEEE
      EE00137511001375110013751100137511001375110013751100137511001375
      1100FFFFFF00EEEEEE00EEEEEE00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E6E6E6000000FF000000FF000000FF000000FF000000FF000000FF00FFFF
      FF00E6E6E600E6E6E600E6E6E600E6E6E600FFFFFF00FFFFFF00EEEEEE00EEEE
      EE00FFFFFF00EEEEEE00056D03001375110013751100EEEEEE00EEEEEE00FFFF
      FF00FFFFFF00EEEEEE00EEEEEE00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
