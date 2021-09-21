object pop_main: Tpop_main
  Left = 328
  Top = 192
  Width = 688
  Height = 478
  Caption = 'TeleAuto'
  Color = clActiveBorder
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -8
  Font.Name = 'System'
  Font.Style = [fsBold]
  FormStyle = fsMDIForm
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object StatusBar1: TStatusBar
    Left = 0
    Top = 413
    Width = 680
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 680
    Height = 29
    Caption = 'ToolBar1'
    Images = ImageList3
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 0
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 2
      Caption = 'ToolButton2'
      ImageIndex = 1
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 46
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 54
      Top = 2
      Caption = 'ToolButton4'
      ImageIndex = 2
      OnClick = ToolButton4Click
    end
    object ToolButton5: TToolButton
      Left = 77
      Top = 2
      Caption = 'ToolButton5'
      ImageIndex = 5
      OnClick = ToolButton5Click
    end
    object ToolButton6: TToolButton
      Left = 100
      Top = 2
      Caption = 'ToolButton6'
      ImageIndex = 3
      OnClick = ToolButton6Click
    end
    object ToolButton7: TToolButton
      Left = 123
      Top = 2
      Caption = 'ToolButton7'
      ImageIndex = 4
      OnClick = ToolButton7Click
    end
    object ToolButton8: TToolButton
      Left = 146
      Top = 2
      Caption = 'ToolButton8'
      ImageIndex = 6
      OnClick = ToolButton8Click
    end
    object ToolButton9: TToolButton
      Left = 169
      Top = 2
      Caption = 'ToolButton9'
      ImageIndex = 12
      OnClick = ToolButton9Click
    end
    object ToolButton10: TToolButton
      Left = 192
      Top = 2
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object ToolButton11: TToolButton
      Left = 200
      Top = 2
      Caption = 'ToolButton11'
      ImageIndex = 7
      OnClick = ToolButton11Click
    end
    object ToolButton13: TToolButton
      Left = 223
      Top = 2
      Width = 8
      Caption = 'ToolButton13'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object ToolButton14: TToolButton
      Left = 231
      Top = 2
      Caption = 'ToolButton14'
      ImageIndex = 9
      OnClick = ToolButton14Click
    end
    object ToolButton15: TToolButton
      Left = 254
      Top = 2
      Width = 8
      Caption = 'ToolButton15'
      ImageIndex = 11
      Style = tbsSeparator
    end
    object ToolButton18: TToolButton
      Left = 262
      Top = 2
      Caption = 'ToolButton18'
      ImageIndex = 11
      OnClick = ToolButton18Click
    end
    object ToolButton19: TToolButton
      Left = 285
      Top = 2
      Width = 8
      Caption = 'ToolButton19'
      ImageIndex = 13
      Style = tbsSeparator
    end
    object ToolButton20: TToolButton
      Left = 293
      Top = 2
      Caption = 'ToolButton20'
      ImageIndex = 13
      OnClick = ToolButton20Click
    end
    object ToolButton21: TToolButton
      Left = 316
      Top = 2
      Caption = 'ToolButton21'
      ImageIndex = 14
      OnClick = ToolButton21Click
    end
    object ToolButton22: TToolButton
      Left = 339
      Top = 2
      Caption = 'ToolButton22'
      ImageIndex = 15
      OnClick = ToolButton22Click
    end
    object ToolButton23: TToolButton
      Left = 362
      Top = 2
      Width = 8
      Caption = 'ToolButton23'
      ImageIndex = 16
      Style = tbsSeparator
    end
    object ToolButton24: TToolButton
      Left = 370
      Top = 2
      Caption = 'ToolButton24'
      ImageIndex = 16
      OnClick = ToolButton24Click
    end
    object ToolButton25: TToolButton
      Left = 393
      Top = 2
      Caption = 'ToolButton25'
      ImageIndex = 17
      OnClick = ToolButton25Click
    end
    object ToolButton26: TToolButton
      Left = 416
      Top = 2
      Caption = 'ToolButton26'
      ImageIndex = 19
      OnClick = ToolButton26Click
    end
    object ToolButton27: TToolButton
      Left = 439
      Top = 2
      Caption = 'ToolButton27'
      ImageIndex = 18
      OnClick = ToolButton27Click
    end
    object ToolButton28: TToolButton
      Left = 462
      Top = 2
      Width = 8
      Caption = 'ToolButton28'
      ImageIndex = 20
      Style = tbsSeparator
    end
    object ToolButton29: TToolButton
      Left = 470
      Top = 2
      Caption = 'ToolButton29'
      ImageIndex = 20
      OnClick = ToolButton29Click
    end
    object ToolButton30: TToolButton
      Left = 493
      Top = 2
      Caption = 'ToolButton30'
      ImageIndex = 21
      OnClick = ToolButton30Click
    end
    object ToolButton31: TToolButton
      Left = 516
      Top = 2
      Width = 8
      Caption = 'ToolButton31'
      ImageIndex = 22
      Style = tbsSeparator
    end
    object ToolButton32: TToolButton
      Left = 524
      Top = 2
      Caption = 'ToolButton32'
      ImageIndex = 22
      OnClick = ToolButton32Click
    end
    object ToolButton33: TToolButton
      Left = 547
      Top = 2
      Caption = 'ToolButton33'
      ImageIndex = 24
      OnClick = ToolButton33Click
    end
    object ToolButton34: TToolButton
      Left = 570
      Top = 2
      Width = 8
      Caption = 'ToolButton34'
      ImageIndex = 24
      Style = tbsSeparator
    end
    object ToolButton35: TToolButton
      Left = 578
      Top = 2
      Caption = 'ToolButton35'
      ImageIndex = 23
      OnClick = ToolButton35Click
    end
  end
  object ToolBar2: TToolBar
    Left = 0
    Top = 29
    Width = 680
    Height = 29
    ButtonWidth = 26
    Caption = 'ToolBar2'
    Images = ImageList3
    TabOrder = 2
    object ToolButton36: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton36'
      ImageIndex = 13
      OnClick = ToolButton36Click
    end
    object ToolButton37: TToolButton
      Left = 26
      Top = 2
      Caption = 'ToolButton37'
      ImageIndex = 14
      OnClick = ToolButton37Click
    end
    object ToolButton38: TToolButton
      Left = 52
      Top = 2
      Caption = 'ToolButton38'
      ImageIndex = 25
      OnClick = ToolButton38Click
    end
    object ToolButton39: TToolButton
      Left = 78
      Top = 2
      Caption = 'ToolButton39'
      ImageIndex = 26
      OnClick = ToolButton39Click
    end
    object ToolButton40: TToolButton
      Left = 104
      Top = 2
      Caption = 'ToolButton40'
      ImageIndex = 28
      OnClick = ToolButton40Click
    end
    object ToolButton41: TToolButton
      Left = 130
      Top = 2
      Caption = 'ToolButton41'
      ImageIndex = 27
      OnClick = ToolButton41Click
    end
    object ToolButton42: TToolButton
      Left = 156
      Top = 2
      Caption = 'ToolButton42'
      ImageIndex = 29
      OnClick = ToolButton42Click
    end
    object ToolButton43: TToolButton
      Left = 182
      Top = 2
      Caption = 'ToolButton43'
      ImageIndex = 30
      OnClick = ToolButton43Click
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'Fichiers Pic Cpa Fits|*.pic;*.cpa;*.fit;*.fits'
    Options = []
    Left = 115
    Top = 92
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 81
    Top = 92
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Images = ImageList3
    Left = 48
    Top = 92
    object Fichier1: TMenuItem
      Caption = '&Fichier'
      object NouvelleImage1: TMenuItem
        Caption = 'N&ouvelle Image'
        OnClick = NouvelleImage1Click
      end
      object Nouvellecarteduciel1: TMenuItem
        Caption = '&Nouvelle carte du ciel'
        OnClick = Nouvellecarteduciel1Click
      end
      object Ouvrir1: TMenuItem
        Caption = '&Ouvrir image'
        ImageIndex = 0
        ShortCut = 16463
        OnClick = ToolButton1Click
      end
      object Ouvrirgraphe1: TMenuItem
        Caption = '&Ouvrir graphe'
        OnClick = Ouvrirgraphe1Click
      end
      object AcqurirTwain1: TMenuItem
        Caption = '&Acqu'#233'rir Twain'
        OnClick = AcqurirTwain1Click
      end
      object Sauver1: TMenuItem
        Caption = '&Sauver'
        ImageIndex = 1
        ShortCut = 16467
        OnClick = ToolButton2Click
      end
      object Sauversous1: TMenuItem
        Caption = 'S&auver sous'
        object outFits1: TMenuItem
          Caption = '&Fits entier'
          OnClick = outFits1Click
        end
        object Fitsvirgule1: TMenuItem
          Caption = 'Fi&ts virgule'
          OnClick = Fitsvirgule1Click
        end
        object outCpa1: TMenuItem
          Caption = '&Cpa Version 3'
          OnClick = outCpa1Click
        end
        object CpaVersoin4d1: TMenuItem
          Caption = 'Cp&a Version 4d'
          OnClick = CpaVersoin4d1Click
        end
        object outPic1: TMenuItem
          Caption = '&Pic'
          OnClick = outPic1Click
        end
        object outBmp1: TMenuItem
          Caption = '&Bmp'
          OnClick = outBmp1Click
        end
        object outJpeg1: TMenuItem
          Caption = '&Jpeg'
          OnClick = outJpeg1Click
        end
        object Texte1: TMenuItem
          Caption = '&Texte'
          OnClick = Texte1Click
        end
        object AdobePSD1: TMenuItem
          Caption = 'A&dobe PSD'
          OnClick = AdobePSD1Click
        end
      end
      object Sauver2: TMenuItem
        Caption = 'Sau&ver avec dessins sous'
        object Bmp1: TMenuItem
          Caption = '&Bmp'
          OnClick = Bmp1Click
        end
        object jpeg1: TMenuItem
          Caption = '&Jpeg'
          OnClick = jpeg1Click
        end
      end
      object Fermer1: TMenuItem
        Caption = '&Fermer'
        OnClick = Fermer1Click
      end
      object ToutFermer1: TMenuItem
        Caption = '&Tout Fermer'
        OnClick = ToutFermer1Click
      end
      object Chercher1: TMenuItem
        Caption = '&Chercher'
        OnClick = Chercher1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Lireunheader1: TMenuItem
        Caption = '&Lire un header'
        OnClick = Lireunheader1Click
      end
      object RapportGino1: TMenuItem
        Caption = '&Rapport Gino'
        OnClick = RapportGino1Click
      end
      object DownloaderDSS: TMenuItem
        Caption = 'I&mage DSS'
        OnClick = DownloaderDSSClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Changerlelanguage1: TMenuItem
        Caption = 'C&hanger le langage'
        OnClick = Changerlelanguage1Click
      end
      object Crerunnouveaulanguage1: TMenuItem
        Caption = 'C&r'#233'er un nouveau langage'
        OnClick = Crerunnouveaulanguage1Click
      end
      object Editiondunlanguage1: TMenuItem
        Caption = '&Edition d'#39'un langage'
        OnClick = Editiondunlanguage1Click
      end
      object Misejourdunlanguage1: TMenuItem
        Caption = 'Mise '#224' jo&ur d'#39'un langage'
        OnClick = Misejourdunlanguage1Click
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object Quitter1: TMenuItem
        Caption = '&Quitter'
        OnClick = Quitter1Click
      end
    end
    object Prtaitements1: TMenuItem
      Caption = '&Pr'#233'traitements'
      GroupIndex = 1
      object Prtraitement1: TMenuItem
        Caption = '&Pr'#233'traitements Automatiques'
        OnClick = Prtraitement1Click
      end
      object Prtraiterunlot1: TMenuItem
        Caption = 'P&r'#233'traiter un lot'
        OnClick = Prtraiterunlot1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Moyenneidentique1: TMenuItem
        Caption = 'Moyenne &identique'
        OnClick = Moyenneidentique1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Additiondunlot1: TMenuItem
        Caption = '&Addition d'#39'un lot'
        OnClick = Additiondunlot1Click
      end
      object Moyennedunlot1: TMenuItem
        Caption = '&Moyenne d'#39'un lot'
        OnClick = Moyennedunlot1Click
      end
      object Medianedunlot1: TMenuItem
        Caption = 'M'#233'&diane d'#39'un lot'
        OnClick = Medianedunlot1Click
      end
      object SigmaKappadunlot1: TMenuItem
        Caption = 'Si&gma Kappa d'#39'un lot'
        OnClick = SigmaKappadunlot1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Soustraireuneimageunlot1: TMenuItem
        Caption = '&Soustraire l'#39'image '#224' un lot (Noir)'
        OnClick = Soustraireuneimageunlot1Click
      end
      object Diviserunlotparuneimage1: TMenuItem
        Caption = '&Diviser un lot par l'#39'image (Flat)'
        OnClick = Diviserunlotparuneimage1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Compositageplantaire1: TMenuItem
        Caption = '&Recalage d'#39'un lot plan'#233'taire'
        OnClick = Compositageplantaire1Click
      end
      object Recalagedimages1: TMenuItem
        Caption = '&Recalage d'#39'images plan'#233'taires'
        OnClick = Recalagedimages1Click
      end
      object Recalagedunlot1: TMenuItem
        Caption = 'R&ecalage d'#39'un lot stellaire'
        OnClick = Recalagedunlot1Click
      end
      object RecalagedimagesstellairesRVB1: TMenuItem
        Caption = 'R&ecalage d'#39'images stellaires'
        OnClick = RecalagedimagesstellairesRVB1Click
      end
      object Registration1: TMenuItem
        Caption = 'Registration d'#39'un lot stellaire'
        OnClick = Registration1Click
      end
      object Registrationdimagesstellaires1: TMenuItem
        Caption = 'Registration d'#39'images stellaires'
        OnClick = Registrationdimagesstellaires1Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object BestofStellaire1: TMenuItem
        Caption = '&Best of Stellaire'
        OnClick = BestofStellaire1Click
      end
      object BestofPlantaire1: TMenuItem
        Caption = 'Best &of Plan'#233'taire (en test)'
        OnClick = BestofPlantaire1Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object Conversion1: TMenuItem
        Caption = 'Conversion au format'
        object Convertiondetypedefichiers1: TMenuItem
          Caption = 'S'#233'rie de fichiers'
          OnClick = Convertiondetypedefichiers1Click
        end
        object ConversionAVI: TMenuItem
          Caption = 'Vid'#233'o AVI'
          OnClick = ConversionAVIClick
        end
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object Gnrelistedepixelschauds1: TMenuItem
        Caption = '&G'#233'n'#233'rer liste de pixels chauds'
        OnClick = Gnrelistedepixelschauds1Click
      end
    end
    object Analyse1: TMenuItem
      Caption = '&Analyse'
      GroupIndex = 3
      object Statistiquesdunlot1: TMenuItem
        Caption = 'St&atistiques d'#39'un lot'
        OnClick = Statistiquesdunlot1Click
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object ProjectionTeleacopique1: TMenuItem
        Caption = '&Projection gnomonique'
        OnClick = ProjectionTeleacopique1Click
      end
    end
    object Outils1: TMenuItem
      Caption = '&Outils'
      GroupIndex = 4
      object Horloge1: TMenuItem
        Caption = '&Horloge'
        OnClick = Horloge1Click
      end
      object Spy1: TMenuItem
        Caption = 'Sp&y'
        OnClick = Spy1Click
      end
      object Astrometrie1: TMenuItem
        Caption = '&Astrom'#233'trie'
        Visible = False
      end
      object MecaniqueCeleste1: TMenuItem
        Caption = '&M'#233'canique C'#233'leste'
        object Covertionde1: TMenuItem
          Caption = '&Conversion de coordonn'#233'es'
          OnClick = Covertionde1Click
        end
        object Jourlulien1: TMenuItem
          Caption = '&Jour julien'
          OnClick = Jourlulien1Click
        end
      end
      object Asteroide1: TMenuItem
        Caption = 'A&st'#233'ro'#239'de'
        object CreerFichiertea1: TMenuItem
          Caption = 'Cr'#233'er Fichier .tea'
        end
        object PositionAsteroide1: TMenuItem
          Caption = 'Position Ast'#233'ro'#239'de'
        end
        object outVaisala1: TMenuItem
          Caption = 'Vaisala'
          OnClick = outVaisala1Click
        end
        object DetectionAutomatique1: TMenuItem
          Caption = 'Detection Automatique'
        end
      end
      object Occultations1: TMenuItem
        Caption = '&Occultations'
        OnClick = Occultations1Click
      end
      object Analysemonture1: TMenuItem
        Caption = 'A&nalyse monture'
        OnClick = Analysemonture1Click
      end
      object Miseaupointmanuelle1: TMenuItem
        Caption = 'Mis&e au point manuelle'
        OnClick = Miseaupointmanuelle1Click
      end
      object Crerunprofil1: TMenuItem
        Caption = '&Cr'#233'er un profil'
        OnClick = Crerunprofil1Click
      end
      object Observationrcurente1: TMenuItem
        Caption = 'Observation r'#233'curente'
        OnClick = Observationrcurente1Click
      end
      object Scripts1: TMenuItem
        Caption = 'Scripts'
        OnClick = Scripts1Click
      end
    end
    object Raquettes1: TMenuItem
      Caption = '&Raquettes'
      GroupIndex = 4
      object Tlescope1: TMenuItem
        Caption = '&T'#233'lescope'
        ImageIndex = 2
        ShortCut = 113
        OnClick = Tlescope1Click
      end
      object Miseaupoint1: TMenuItem
        Caption = '&Focuseur'
        ImageIndex = 5
        ShortCut = 114
        OnClick = Miseaupoint1Click
      end
      object Camra1: TMenuItem
        Caption = '&Cam'#233'ra principale'
        ImageIndex = 3
        ShortCut = 115
        OnClick = Camra1Click
      end
      object Camradesuivi1: TMenuItem
        Caption = 'Cam'#233'ra de &Guidage'
        ImageIndex = 4
        ShortCut = 116
        OnClick = Camradesuivi1Click
      end
      object Dome1: TMenuItem
        Caption = '&Dome'
        ImageIndex = 6
        ShortCut = 117
        OnClick = Dome1Click
      end
      object Serveurdheure1: TMenuItem
        Caption = '&Serveur d'#39'heure'
        ImageIndex = 12
        ShortCut = 118
        OnClick = Serveurdheure1Click
      end
      object History1: TMenuItem
        Caption = 'History'
        ShortCut = 123
        OnClick = History1Click
      end
    end
    object Systeme1: TMenuItem
      Caption = '&Syst'#232'me'
      GroupIndex = 4
      object ConnecterleTlescope1: TMenuItem
        Caption = '&Connecter le T'#233'lescope'
        OnClick = ConnecterleTlescope1Click
      end
      object ConnecterleFocuser1: TMenuItem
        Caption = 'C&onnecter le Focuseur'
        OnClick = ConnecterleFocuser1Click
      end
      object Connecterlacamra1: TMenuItem
        Caption = 'Conn&ecter la Cam'#233'ra principale'
        OnClick = Connecterlacamra1Click
      end
      object Connecterlacamradesuivi1: TMenuItem
        Caption = 'Connec&ter la Cam'#233'ra de guidage'
        OnClick = Connecterlacamradesuivi1Click
      end
      object ConnecterleDome1: TMenuItem
        Caption = 'Connecter le &Dome'
        OnClick = ConnecterleDome1Click
      end
      object ConnecterleServeurdheure1: TMenuItem
        Caption = 'Connecter le &Serveur d'#39'heure'
        OnClick = ConnecterleServeurdheure1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Configuration1: TMenuItem
        Caption = 'Co&nfiguration'
        ShortCut = 49219
        OnClick = Configuration1Click
      end
    end
    object Fenetre1: TMenuItem
      Caption = '&Fen'#234'tres'
      GroupIndex = 4
      object Cascade1: TMenuItem
        Caption = '&Cascade'
        GroupIndex = 4
        OnClick = Cascade1Click
      end
      object Mosaique1: TMenuItem
        Caption = '&Mosaique'
        GroupIndex = 4
        OnClick = Mosaique1Click
      end
      object Rorganiserlesiconnes1: TMenuItem
        Caption = '&R'#233'organiser les ic'#244'nes'
        GroupIndex = 4
        OnClick = Rorganiserlesiconnes1Click
      end
      object Toutrduire1: TMenuItem
        Caption = '&Tout r'#233'duire'
        GroupIndex = 4
        OnClick = Toutrduire1Click
      end
      object N10: TMenuItem
        Caption = '-'
        GroupIndex = 4
      end
      object Ajusterlimage1: TMenuItem
        Caption = '&Ajuster '#224' l'#39'image'
        GroupIndex = 4
        OnClick = Ajusterlimage1Click
      end
    end
    object Aide1: TMenuItem
      Caption = '&Aide'
      GroupIndex = 4
      object About1: TMenuItem
        Caption = '&A propos'
        GroupIndex = 7
        OnClick = About1Click
      end
    end
    object outCodage1: TMenuItem
      Caption = 'Codage'
      GroupIndex = 4
      object outMettreajourledico1: TMenuItem
        Caption = 'Lang / Cr'#233'er le dico de v'#233'rification'
        OnClick = outMettreajourledico1Click
      end
      object outMettreajourledicomodele1: TMenuItem
        Caption = 'Lang / Etape 1 / Cr'#233'er le dico mod'#232'le'
        OnClick = outMettreajourledicomodele1Click
      end
      object outLangMettrejourtouslesdicos1: TMenuItem
        Caption = 'Lang / Etape 2 / Mettre '#224' jour tous les dicos'
        OnClick = outLangMettrejourtouslesdicos1Click
      end
      object outMettreajourlessources1: TMenuItem
        Caption = 'Lang / Etape 3 / Mettre '#224' jour les sources'
        OnClick = outMettreajourlessources1Click
      end
      object LangCompleteravecunanciendico1: TMenuItem
        Caption = 'Lang / Completer avec un ancien dico'
        OnClick = LangCompleteravecunanciendico1Click
      end
      object outLangDetecterlesdoublons1: TMenuItem
        Caption = 'Lang / D'#233'tecter les doublons'
      end
      object outLangDtecterlesincohrencesaumodle1: TMenuItem
        Caption = 'Lang / D'#233'tecter les incoh'#233'rences entre langage et mod'#232'le'
        OnClick = outLangDtecterlesincohrencesaumodle1Click
      end
      object outLangRecherchedelangetnolang1: TMenuItem
        Caption = 'Lang / Recherche de lang( et nolang'
        OnClick = outLangRecherchedelangetnolang1Click
      end
      object LangTestersurunfichier1: TMenuItem
        Caption = 'Lang / Tester la cr'#233'ation d'#39'un dico sur un fichier'
        OnClick = LangTestersurunfichier1Click
      end
      object LangTesterlamisejourdessourcessurunfichier1: TMenuItem
        Caption = 'Lang / Tester la mise '#224' jour des sources sur un fichier'
        OnClick = LangTesterlamisejourdessourcessurunfichier1Click
      end
      object LangEnleverlesaccents1: TMenuItem
        Caption = 'Lang / Enlever les accents'
        OnClick = LangEnleverlesaccents1Click
      end
      object OutIntegrale1: TMenuItem
        Caption = 'Integrale'
        OnClick = OutIntegrale1Click
      end
      object OutCadre1: TMenuItem
        Caption = 'Image de test'
        OnClick = OutCadre1Click
      end
      object outTestMoindrescarrs1: TMenuItem
        Caption = 'Test Moindres carr'#233's degr'#233' 0'
        OnClick = outTestMoindrescarrs1Click
      end
      object outTestMoindrescarrsdegr01: TMenuItem
        Caption = 'Test Moindres carr'#233's degr'#233' 1'
        OnClick = outTestMoindrescarrsdegr01Click
      end
      object outTestSvdFitAstro1: TMenuItem
        Caption = 'Test SvdFitAstro'
        OnClick = outTestSvdFitAstro1Click
      end
      object outTestSvdFitAstrosurcasreel1: TMenuItem
        Caption = 'Test SvdFitAstro sur cas reel'
        OnClick = outTestSvdFitAstrosurcasreel1Click
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 128
    Top = 248
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 316
    Top = 92
  end
  object ImageList3: TImageList
    Left = 48
    Top = 136
    Bitmap = {
      494C01011F002200040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009000000001002000000000000090
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000084848400000000000000000000000000848484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000FF0000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000FF000000FF00000000008484
      8400000000000000000084848400FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000084848400848484008484
      84008484840084848400848484000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000FF000000FF00FFFFFF000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000084848400848484008484840084848400000000000000
      0000000000000000FF0000000000000000000000000084848400848484008484
      840084848400848484008484840000000000000000000000FF00000000000000
      FF00000000000000FF0000000000000000000000FF000000FF00848484000000
      000000000000FFFFFF0000000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000FF000000FF00000000000000
      000000000000FFFFFF008484840000000000FFFFFF0000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000848484000000000000000000FFFFFF00FFFFFF0000000000000000008484
      840000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      840000000000000000000000FF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000FF000000FF000000
      000000000000FFFFFF0084848400848484000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      840000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000084848400848484000000FF000000
      FF00FFFFFF000000000000000000FFFFFF00848484000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000848484000000000000000000FFFFFF00FFFFFF0000000000000000008484
      840000000000000000000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF00000000000000000000000000FFFFFF0000000000000000000000
      FF000000FF00FFFFFF000000000000000000FFFFFF0000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000008484840000000000000000000000000000000000848484000000
      0000000000000000FF0000000000000000000000000084848400848484008484
      840084848400848484008484840000000000000000000000FF00000000000000
      FF00000000000000FF0000000000000000000000000000000000848484008484
      84000000FF000000FF000000FF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000084848400848484008484840084848400000000000000
      0000000000000000FF0000000000000000000000000084848400848484008484
      84008484840084848400848484000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000848484000000FF000000FF000000FF000000FF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      000000000000848484000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000FF0000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000000000000000000000000000FF00000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      FF000000000000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      FF00000000000000FF00000000000000000000000000000000000000FF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF000000FF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      FF00000000000000FF00000000000000000000000000000000000000FF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      00000000FF00000000000000000000000000000000000000FF0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF00000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000FF00000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000FF00000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      00000000FF00000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF2121000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF2121000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF2121000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF00BDBDBD00FFFFFF00FFFFFF00FFFFFF00BDBDBD000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF212100FF21
      21000000000000000000FF6B6B00FF6B6B00FF6B6B00FF6B6B00000000000000
      0000FF21210000000000000000000000000000000000000000000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF6B6B00FF6B6B00FFD68C00FFD68C00FFD68C00FF6B6B00FF6B6B000000
      00000000000000000000000000000000000000000000000000000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFF
      FF000000FF000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      000000000000000000000000000000000000000000000000000000000000FF6B
      6B00FF6B6B00FFD6D600FFD6D600FFFFD600FFFFD600FFD6D600FFD68C00FF6B
      6B0000000000000000000000000000000000000000000000FF00BDBDBD00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00BDBDBD000000FF0000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      000000000000000000000000000000000000000000000000000000000000FF6B
      6B00FFD68C00FFFFD600FFFFFF00FFFFFF00FFFFFF00FFFFD600FFD6D600FF6B
      6B00FF6B6B00000000000000000000000000000000000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000FF00000000000000000000000000000000007B7B7B000000
      0000FFFFFF0000000000FFFFFF00000000007B7B7B0000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000FFFFFF0000000000FFFFFF007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF6B
      6B00FFD68C00FFFFD600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFD6
      8C00FF6B6B00000000000000000000000000000000000000FF00FFFFFF00FF00
      0000FFFFFF00FFFFFF00FFFFFF000000FF000000000000000000000000000000
      0000FFFFFF000000FF0000000000000000007B7B7B007B7B7B0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF00000000007B7B7B007B7B7B000000
      0000000000000000000000000000000000007B7B7B007B7B7B00FFFFFF000000
      0000FFFFFF000000FF00FFFFFF0000000000FFFFFF007B7B7B007B7B7B000000
      000000000000000000000000000000000000FF212100FF21210000000000FF6B
      6B00FFD6D600FFD6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFD6D600FFD6
      8C00FF6B6B0000000000FF212100FF212100000000000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000FF000000000000000000000000007B7B7B00FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF007B7B7B00000000000000
      000000000000000000000000000000000000000000007B7B7B0000000000FFFF
      FF00000000000000FF0000000000FFFFFF00000000007B7B7B00000000000000
      000000000000000000000000000000000000000000000000000000000000FF6B
      6B00FFD6D600FFFFD600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFD6D600FFD6
      8C00FF6B6B00000000000000000000000000000000000000FF00BDBDBD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00BDBDBD000000FF000000000000000000000000007B7B7B00000000000000
      FF000000FF000000FF000000FF000000FF00000000007B7B7B00000000000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007B7B7B00000000000000
      000000000000000000000000000000000000000000000000000000000000FF6B
      6B00FFD68C00FFD68C00FFFFD600FFFFFF00FFFFFF00FFFFFF00FFD68C00FF6B
      6B000000000000000000000000000000000000000000000000000000FF00FFFF
      FF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFF
      FF000000FF00000000000000000000000000000000007B7B7B00FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF007B7B7B00000000000000
      000000000000000000000000000000000000000000007B7B7B0000000000FFFF
      FF00000000000000FF0000000000FFFFFF00000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF6B6B00FFD68C00FFD68C00FFD6D600FFD68C00FFD68C00FF6B6B00FF6B
      6B000000000000000000000000000000000000000000000000000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF000000000000000000000000007B7B7B007B7B7B0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF00000000007B7B7B007B7B7B000000
      0000000000000000000000000000000000007B7B7B007B7B7B00FFFFFF000000
      0000FFFFFF000000FF00FFFFFF0000000000FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF6B6B00FF6B6B00FF6B6B00FF6B6B00FF6B6B00FF6B6B000000
      0000FF2121000000000000000000000000000000000000000000000000000000
      FF000000FF00BDBDBD00FFFFFF00FF000000FFFFFF00BDBDBD000000FF000000
      FF000000000000000000000000000000000000000000000000007B7B7B000000
      0000FFFFFF0000000000FFFFFF00000000007B7B7B0000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000FFFFFF0000000000FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000FF2121000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF212100FF21210000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF2121000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF2121000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000840000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFF0000FFFFFF00000000000000
      000000000000000000000000000000000000000000007B7B7B00000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFF0000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000840000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF000000000000007B000000000000FFFF0000FFFF
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF000000000000007B000000000000FFFF0000FFFF
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      00000000000000000000000000000000000000000000FFFF0000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000FF0000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF000000000000007B000000000000FFFF0000FFFF
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      00000000000000000000000000000000000000000000FFFF0000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF0000000000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF000000000000007B000000000000FFFF0000FFFF
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      000000000000FFFF00007B7B00000000000000000000FFFF0000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF00000000000000FF000000FF000000FF000000FF000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      000000000000FFFF00007B7B00000000000000000000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000FF000000FF000000FF000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      000000000000FFFF0000000000000000000000000000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF0000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      FF000000FF00000000000000FF007B7B7B0000000000000000000000FF000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      000000000000FFFF0000000000000000000000000000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000000000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000007B7B7B00000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000007B7B7B000000FF00000000000000FF000000
      FF000000FF0000000000000000000000000000000000000000007B7B00000000
      000000000000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      FF000000FF00000000000000FF000000000000000000000000000000FF000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      000000000000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000007B7B
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000FF000000FF000000FF000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      00000000000000000000000000000000000000000000FFFF0000000000007B7B
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      00000000000000000000000000000000000000000000FFFF0000000000007B7B
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B00007B7B
      00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00BDBDBD000000000000000000BDBDBD00BDBDBD00BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00BDBDBD000000000000000000BDBDBD00BDBDBD00BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000000000
      000000000000000000000000000000000000000000000000000000FFFF008484
      84000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000000000
      00000000000000000000000000000000000000000000000000008484840000FF
      FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000000000
      00000000000000000000000000000000000000000000000000008484840000FF
      FF008484840000FFFF008484840000FF0000FFFF000000FF00000000000000FF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF008484840000FFFF000000000000FF0000FFFF000000FF00000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000FFFF000000FF
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000007B7B
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF0000FFFF
      000000FF0000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000007B7B
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000FFFF0000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B0000FFFF
      00007B7B0000FFFF00007B7B0000FFFF00007B7B0000FFFF0000000000007B7B
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF0000FFFF
      000000FF0000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B00007B7B
      00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFF0000FFFFC001FFFF0000
      FFFFC001FFFF0000FF3FC001FFFF0000FC3FC001B4210000F03FC001B5AF0000
      C000C001A5AF00000000C001A52F0000C000C00195EF0000F03FC00195EF0000
      FC3FC001B5EF0000FF3FC001B4210000FFFFC001FFFF0000FFFFC001FFFF0000
      FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFC7FFEFFFFFFFE7FFC7FFEFFFFFF
      FE7FFC7FFC7FFFFFFFFFFC7FFC7FFFFFFFFFFC7FF83FFCFFFE7FFC7FF83FFC3F
      FE7FE00FF01FFC0FFE3FE00FF01F0003FF1FF01FE00F0000FF8FF01FE00F0003
      FFCFF83FFC7FFC0FFFE7F83FFC7FFC3FE7E7FC7FFC7FFCFFE3C7FC7FFC7FFFFF
      F00FFEFFFC7FFFFFF81FFEFFFC7FFFFFFFFFFFFFFFFFFFFF80010001FFFF8001
      80010001F83F800180010001E38F8001800110A1CFCF800180011001CFE783C1
      FE0100119FE78661FE0103A59FE78421800108019FE78421FE0102419FCF8661
      FE0100018FDF83C180010021C7BF800180010801E001800180010001F0018001
      80010001FFFF8001FFFF0001FFFFFFFFFFFFFFFFFFFFFEFF0001FFFFFFFFFEFF
      0001FFFFFFFFFEFF0001C000C37FDEFF0001DFE7F3BFD01F0401DFD3EBDFCEEF
      0601DFABEBDFC2F70201DF6BEFDFFEFF0801DFDB0000FEFF0681DFDFEFDFDE87
      0001DFBFEF5FEEE70001DE7FEF5FF0170001D9FFF73FFEF70001C7FFFB0FFEFF
      0001DFFFFFFFFEFFFFFFDFFFFFFFFEFFFFFFFFFDFFFDFEFFF83FFFF8FFF8FEFF
      E00FFFF1FFF1DFFFC007FFE3FFE3CC378003FFC7FFC7F01F8003E08FE08FE00F
      0001C01FC01FE0070001953F8A3FE00700012A9F111F20040001151F2A9FE007
      0001209F001FE00F8003151F2A9FF00F80032A9F111FF817C007953F8A3FDFF3
      E00FC07FC07FFEFFF83FE0FFE0FFFEFFFFFFFFFFFFFFFFFFFFFF83E0FFFFFFFF
      FFFF83E0FFFFFFFFFFFF83E0FFFFFFFFFFFF8360FFC9FFE7B935EE3BC7C9C1F3
      DD25EC1B83C9C3FBE925E0039800C7FBDBFFFC1F9800CBFBB9FFFE3F83FFDCF3
      FFFFFF7FC7FFFF07FFFFFC1FFFFFFFFFFFFFFC1FFFFFFFFFFFFFFC1FFFFFFFFF
      FFFFFC1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8001FFFF801F80018001FFFF
      801F80018001FEFF801F80018001FCFF801F80018001FDFF801F80018001F01F
      801F80018019F11F801FF0018019E09F801FF0038019C2078001F0078019E19F
      8001F00FC033F01F8001F00FC033F01F8001F00FE067EC7F8001F00FF0CFFEFF
      801FF00FF81FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8003FEFF801F
      C0070001FD7F801FC0030001FBBF801FC0030001F93F801FC0030001FD7F801F
      C0010001CD67801FC0010001A10B801FC00300017FFD801FC00B0001A10B8001
      F1030001CD678001FF830001FD7F8001FFC30001F93F8001FF830001FBBF8001
      FFFF0001FD7F801FFFFF8003FEFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object Twainy1: TTwainy
    Disable = True
    Form = Owner
    ShowUI = True
    OnChangeBitmap = Twainy1ChangeBitmap
    Left = 152
    Top = 92
  end
  object PBFolderDialog1: TPBFolderDialog
    Flags = [ShowPath, NewDialogStyle, ShowShared]
    Left = 264
    Top = 92
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 164
    Top = 248
  end
  object TimerGetPos: TTimer
    Enabled = False
    OnTimer = TimerGetPosTimer
    Left = 216
    Top = 248
  end
end
