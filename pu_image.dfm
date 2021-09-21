object pop_image: Tpop_image
  Left = 354
  Top = 195
  Width = 431
  Height = 342
  Cursor = crCross
  BorderIcons = [biSystemMenu, biMinimize]
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = True
  PopupMenu = PopupMenu1
  Position = poDefault
  PrintScale = poNone
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object img_box: TImage
    Left = 0
    Top = 0
    Width = 405
    Height = 277
    Stretch = True
    OnClick = img_boxClick
    OnMouseDown = img_boxMouseDown
    OnMouseMove = img_boxMouseMove
    OnMouseUp = img_boxMouseUp
  end
  object HorizScrollBar: TScrollBar
    Left = 0
    Top = 276
    Width = 405
    Height = 16
    PageSize = 0
    TabOrder = 0
    OnScroll = HorizScrollBarScroll
  end
  object VerticScrollBar: TScrollBar
    Left = 404
    Top = 0
    Width = 16
    Height = 277
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    OnScroll = VerticScrollBarScroll
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Images = ImageList1
    Left = 12
    Top = 4
    object Filtres1: TMenuItem
      Caption = '&Filtres'
      GroupIndex = 2
      object Gaussienne1: TMenuItem
        Caption = '&Gaussienne'
        OnClick = Gaussienne1Click
      end
      object MasqueFlou1: TMenuItem
        Caption = '&Masque Flou'
        ImageIndex = 7
        OnClick = MasqueFlou1Click
      end
      object Matriciel1: TMenuItem
        Caption = 'M&atriciel'
        OnClick = Matriciel1Click
      end
      object Passebas1: TMenuItem
        Caption = '&Passe bas'
        object TrsFort1: TMenuItem
          Caption = 'Tr'#233's Fort'
          OnClick = TrsFort1Click
        end
        object Fort1: TMenuItem
          Caption = 'Fort'
          OnClick = Fort1Click
        end
        object Faible1: TMenuItem
          Caption = 'Faible'
          OnClick = Faible1Click
        end
        object TrsFaible1: TMenuItem
          Caption = 'Tr'#233's Faible'
          OnClick = TrsFaible1Click
        end
      end
      object Passsehaut1: TMenuItem
        Caption = 'Passe &haut'
        object TrsFort2: TMenuItem
          Caption = 'Tr'#233's Fort'
          OnClick = TrsFort2Click
        end
        object Fort2: TMenuItem
          Caption = 'Fort'
          OnClick = Fort2Click
        end
        object Faible2: TMenuItem
          Caption = 'Faible'
          OnClick = Faible2Click
        end
        object TrsFaible2: TMenuItem
          Caption = 'Tr'#233's Faible'
          OnClick = TrsFaible2Click
        end
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object Mdian1: TMenuItem
        Caption = 'M'#233'&dian'
        OnClick = Mdian1Click
      end
      object Erosion1: TMenuItem
        Caption = 'Ero&sion'
        OnClick = Erosion1Click
      end
      object Dilatation1: TMenuItem
        Caption = '&Dilatation'
        OnClick = Dilatation1Click
      end
      object Fermeture1: TMenuItem
        Caption = '&Fermeture'
        OnClick = Fermeture1Click
      end
      object Ouverture1: TMenuItem
        Caption = 'O&uverture'
        OnClick = Ouverture1Click
      end
      object RankOrder1: TMenuItem
        Caption = 'Ra&nk Order'
        OnClick = RankOrder1Click
      end
      object Valeursextrmes1: TMenuItem
        Caption = '&Valeurs extr'#232'mes'
        OnClick = Valeursextrmes1Click
      end
      object PasseHautAdaptatif1: TMenuItem
        Caption = 'Passe Hau&t Adaptatif'
        OnClick = PasseHautAdaptatif1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object ExtraitOndelette1: TMenuItem
        Caption = '&Extrait plan d'#39'Ondelette'
        OnClick = ExtraitOndelette1Click
      end
      object ExtraitOndelettes1: TMenuItem
        Caption = 'Extrait &Ondelettes'
        OnClick = ExtraitOndelettes1Click
      end
      object Renforcementdondelettes1: TMenuItem
        Caption = '&Renforcement d'#39'ondelettes'
        OnClick = Renforcementdondelettes1Click
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object Gradient1: TMenuItem
        Caption = 'Gradient'
        object Driveversladroite1: TMenuItem
          Caption = 'Vers la droite'
          OnClick = Driveversladroite1Click
        end
        object Driveversladroite2: TMenuItem
          Caption = 'Vers la gauche'
          OnClick = Driveversladroite2Click
        end
        object Driveverslebas1: TMenuItem
          Caption = 'Vers le bas'
          OnClick = Driveverslebas1Click
        end
        object Driveverslehaut1: TMenuItem
          Caption = 'Vers le haut'
          OnClick = Driveverslehaut1Click
        end
      end
      object Normedugradient1: TMenuItem
        Caption = 'Norme du gradient'
        OnClick = Normedugradient1Click
      end
      object Extractiondecontour1: TMenuItem
        Caption = 'Extraction de contour'
        object Extractiondecontours1: TMenuItem
          Caption = 'Simplifi'#233'e'
          OnClick = Extractiondecontours1Click
        end
        object Simplifieavecfiltrage1: TMenuItem
          Caption = 'Simplifi'#233'e avec filtrage'
          OnClick = Simplifieavecfiltrage1Click
        end
      end
    end
    object Aritmthique1: TMenuItem
      Caption = '&Arithm'#233'tique'
      GroupIndex = 2
      object Ajouterconstante1: TMenuItem
        Caption = '&Ajouter constante'
        OnClick = Ajouterconstante1Click
      end
      object Multiplierconstante1: TMenuItem
        Caption = '&Multiplier constante'
        OnClick = Multiplierconstante1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object AjouterImage1: TMenuItem
        Caption = 'A&jouter Image'
        OnClick = AjouterImage1Click
      end
      object SoustraireImage1: TMenuItem
        Caption = 'S&oustraire Image'
        OnClick = SoustraireImage1Click
      end
      object Muli1: TMenuItem
        Caption = 'Mu&ltiplier Image'
        OnClick = Muli1Click
      end
      object DiviserImage1: TMenuItem
        Caption = '&Diviser Image'
        OnClick = DiviserImage1Click
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object Log1: TMenuItem
        Caption = '&Logarithme'
        ImageIndex = 8
        OnClick = Log1Click
      end
      object ValeurAbsolue1: TMenuItem
        Caption = '&Valeur Absolue'
        OnClick = ValeurAbsolue1Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object ClipMin1: TMenuItem
        Caption = '&Seuillage mininum'
        OnClick = ClipMin1Click
      end
      object Seuillagemaximum1: TMenuItem
        Caption = 'S&euillage maximum'
        OnClick = Seuillagemaximum1Click
      end
      object Binarisation1: TMenuItem
        Caption = '&Binarisation'
        OnClick = Binarisation1Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object FFT1: TMenuItem
        Caption = '&FFT Direct'
        OnClick = FFT1Click
      end
      object FFTInverse1: TMenuItem
        Caption = 'FFT I&nverse'
        OnClick = FFTInverse1Click
      end
      object N14: TMenuItem
        Caption = '-'
        OnClick = Ajouterconstante1Click
      end
      object Produitdintercorrlation1: TMenuItem
        Caption = '&Produit d'#39'intercorr'#233'lation'
        OnClick = Produitdintercorrlation1Click
      end
      object Produitdautocorrelation1: TMenuItem
        Caption = 'P&roduit d'#39'autocorrelation'
        OnClick = Produitdautocorrelation1Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object Conversiondetype1: TMenuItem
        Caption = '&Conversion de type'
        object EntiersversRels1: TMenuItem
          Caption = '&Entiers vers R'#233'els'
          OnClick = EntiersversRels1Click
        end
        object Relsversentiers1: TMenuItem
          Caption = '&R'#233'els vers entiers'
          OnClick = Relsversentiers1Click
        end
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object Cosmtique1: TMenuItem
        Caption = 'Cosm'#233'&tique'
        object Cicatriseruneligne2: TMenuItem
          Caption = 'Cicatriser une &ligne'
          OnClick = Cicatriseruneligne2Click
        end
        object Cicatriserunecolonne2: TMenuItem
          Caption = 'Cicatriser une &colonne'
          OnClick = Cicatriserunecolonne2Click
        end
        object Cicatriserunpixel1: TMenuItem
          Caption = 'Cicatriser un &pixel'
          OnClick = Cicatriserunpixel1Click
        end
        object N24: TMenuItem
          Caption = '-'
        end
        object Enregisterfichiercosmetique1: TMenuItem
          Caption = 'C&ommencer l'#39'enregistrement du script'
          OnClick = Enregisterfichiercosmetique1Click
        end
        object Appliquerunscript1: TMenuItem
          Caption = '&Appliquer un script'
          OnClick = Appliquerunscript1Click
        end
      end
    end
    object Gomtrie1: TMenuItem
      Caption = '&G'#233'om'#233'trie'
      GroupIndex = 2
      object Fenttrage1: TMenuItem
        Caption = '&Fen'#234'trage'
        ImageIndex = 3
        OnClick = Fenttrage1Click
      end
      object Translation1: TMenuItem
        Caption = '&Translation'
        OnClick = Translation1Click
      end
      object Rotation1: TMenuItem
        Caption = '&Rotation'
        OnClick = Rotation1Click
      end
      object outZoom1: TMenuItem
        Caption = '&Zoom'
        OnClick = outZoom1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MiroirHorizontal1: TMenuItem
        Caption = '&Miroir Horizontal'
        ImageIndex = 6
        OnClick = MiroirHorizontal1Click
      end
      object MiroirVertical1: TMenuItem
        Caption = 'Miroir &Vertical'
        ImageIndex = 5
        OnClick = MiroirVertical1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Rotation901: TMenuItem
        Caption = 'R&otation +90'#176
        ImageIndex = 4
        ShortCut = 16466
        OnClick = Rotation901Click
      end
      object Rotation902: TMenuItem
        Caption = 'Rot&ation -90'#176
        OnClick = Rotation902Click
      end
      object Rotation1801: TMenuItem
        Caption = 'Rotat&ion 180'#176
        OnClick = Rotation1801Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Dtourage1: TMenuItem
        Caption = '&D'#233'tourage'
        OnClick = Dtourage1Click
      end
      object Entourage1: TMenuItem
        Caption = '&Entourage'
        OnClick = Entourage1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Binninglogiciel1: TMenuItem
        Caption = '&Binning logiciel'
        OnClick = Binninglogiciel1Click
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object Compositage1: TMenuItem
        Caption = 'R&egistration stellaire'
        OnClick = Compositage1Click
      end
    end
    object Analyse1: TMenuItem
      Caption = 'A&nalyse'
      GroupIndex = 3
      object ProjectionTlescopique1: TMenuItem
        Caption = '&Projection gnomonique'
        OnClick = ProjectionTlescopique1Click
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object Statistiquesdunlot1: TMenuItem
        Caption = 'St&atistiques d'#39'un lot'
        OnClick = Statistiquesdunlot1Click
      end
      object Statistiques1: TMenuItem
        Caption = '&Statistiques'
        ImageIndex = 9
        ShortCut = 121
        OnClick = Statistiques1Click
      end
      object Statistiquesfentres1: TMenuItem
        Caption = 'S&tatistiques fen'#234'tr'#233'es'
        ShortCut = 123
        OnClick = Statistiquesfentres1Click
      end
      object Histogramme1: TMenuItem
        Caption = '&Histogramme'
        OnClick = Histogramme1Click
      end
      object Coupephotomtrique2: TMenuItem
        Caption = 'C&oupe photom'#233'trique'
        ShortCut = 16464
        OnClick = Coupephotomtrique2Click
      end
      object outBlink1: TMenuItem
        Caption = '&Blink'
        OnClick = outBlink1Click
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object Modliseunetoile1: TMenuItem
        Caption = '&Mod'#233'liser une '#233'toile'
        ShortCut = 16462
        OnClick = Modliseunetoile1Click
      end
      object Modlisetouteslestoiles1: TMenuItem
        Caption = 'Mod'#233'liser &toutes les '#233'toiles'
        OnClick = Modlisetouteslestoiles1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Photomtrie1: TMenuItem
        Caption = '&Photom'#233'trie'
        object Etalonnage1: TMenuItem
          Caption = '&Ajouter un '#233'talon'
          ShortCut = 16453
          OnClick = Etalonnage1Click
        end
        object Mesure1: TMenuItem
          Caption = '&Mesure'
          Enabled = False
          ShortCut = 16461
          OnClick = Mesure1Click
        end
        object Ajouterunesuppression1: TMenuItem
          Caption = 'Ajouter une &suppression'
          ShortCut = 49235
          OnClick = Ajouterunesuppression1Click
        end
        object Enleveruntalon1: TMenuItem
          Caption = '&Enlever un '#233'talon'
          ShortCut = 49221
          OnClick = Enleveruntalon1Click
        end
        object Rinitialiser1: TMenuItem
          Caption = '&R'#233'initialiser'
          OnClick = Rinitialiser1Click
        end
        object Confi1: TMenuItem
          Caption = '&Configuration'
          OnClick = Confi1Click
        end
      end
      object Astromtrie1: TMenuItem
        Caption = '&Astrom'#233'trie'
        object Etalonnage2: TMenuItem
          Caption = '&Calibration automatique'
          OnClick = Etalonnage2Click
        end
        object Mesure2: TMenuItem
          Caption = '&Mesure'
          Enabled = False
          ShortCut = 16449
          OnClick = Mesure2Click
        end
        object Toutmesurer1: TMenuItem
          Caption = '&Tout mesurer'
          Enabled = False
          OnClick = Toutmesurer1Click
        end
        object Rinitialiser2: TMenuItem
          Caption = '&R'#233'initialiser'
          OnClick = Rinitialiser2Click
        end
        object Configuration1: TMenuItem
          Caption = '&Configuration'
          OnClick = Configuration1Click
        end
      end
    end
    object ImageMenu: TMenuItem
      Caption = 'I&mage'
      GroupIndex = 3
      object Affichecible1: TMenuItem
        Caption = 'Affiche cible'
        ShortCut = 113
        OnClick = Affichecible1Click
      end
      object AjouterMarque1: TMenuItem
        Caption = 'Ajouter Marque'
        ShortCut = 119
        OnClick = AjouterMarque1Click
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object Dupliquer1: TMenuItem
        Caption = '&Dupliquer'
        OnClick = Dupliquer1Click
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object Isophotes1: TMenuItem
        Caption = '&Isophotes'
        OnClick = Isophotes1Click
      end
      object Rglerlesseuils1: TMenuItem
        Caption = '&R'#233'gler les seuils'
        ImageIndex = 2
        ShortCut = 114
        OnClick = Rglerlesseuils1Click
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object ZoomAvant1: TMenuItem
        Caption = '&Zoom Arri'#232're'
        ImageIndex = 0
        OnClick = ZoomAvant1Click
      end
      object ZoomArrire1: TMenuItem
        Caption = 'Zoo&m Avant'
        ImageIndex = 1
        OnClick = ZoomArrire1Click
      end
      object Zoom2: TMenuItem
        Caption = 'Zoom'
        object outN252: TMenuItem
          Caption = '&25 %'
          OnClick = outN252Click
        end
        object outN502: TMenuItem
          Caption = '&50 %'
          OnClick = outN502Click
        end
        object outN752: TMenuItem
          Caption = '&75 %'
          OnClick = outN752Click
        end
        object outN1002: TMenuItem
          Caption = '&100 %'
          OnClick = outN1002Click
        end
        object outN2002: TMenuItem
          Caption = '&200 %'
          OnClick = outN2002Click
        end
        object outN3002: TMenuItem
          Caption = '&300 %'
          OnClick = outN3002Click
        end
        object outN4002: TMenuItem
          Caption = '&400 %'
          OnClick = outN4002Click
        end
        object outN5002: TMenuItem
          Caption = '&500 %'
          OnClick = outN5002Click
        end
        object outN6002: TMenuItem
          Caption = '&600 %'
          OnClick = outN6002Click
        end
        object outN7002: TMenuItem
          Caption = '&700 %'
          OnClick = outN7002Click
        end
        object outN8002: TMenuItem
          Caption = '&800 %'
          OnClick = outN8002Click
        end
        object outN9002: TMenuItem
          Caption = '&900 %'
          OnClick = outN9002Click
        end
        object outN10002: TMenuItem
          Caption = '&1000 %'
          OnClick = outN10002Click
        end
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object Informations1: TMenuItem
        Caption = '&Informations'
        ImageIndex = 10
        ShortCut = 122
        OnClick = Informations1Click
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object AjouterplansRougeetVert1: TMenuItem
        Caption = 'I&nserer plans Vert et Bleu'
        OnClick = AjouterplansRougeetVert1Click
      end
      object Sparerlesplans1: TMenuItem
        Caption = '&S'#233'parer les plans'
        OnClick = Sparerlesplans1Click
      end
      object Ajouterunplan1: TMenuItem
        Caption = 'Ajouter des &plans'
        OnClick = Ajouterunplan1Click
      end
      object Supprimerunplan1: TMenuItem
        Caption = 'S&upprimer des plans'
        OnClick = Supprimerunplan1Click
      end
      object Extrairedesplans1: TMenuItem
        Caption = '&Extraire des plans'
        OnClick = Extrairedesplans1Click
      end
      object Permuter2plans1: TMenuItem
        Caption = 'Permu&ter 2 plans'
        OnClick = Permuter2plans1Click
      end
      object RV1: TMenuItem
        Caption = 'RVB -> Gris'
        OnClick = RV1Click
      end
      object CFABayerRGB1: TMenuItem
        Caption = 'CFA Bayer -> RGB'
        OnClick = CFABayerRGB1Click
      end
      object Balancedescouleurs1: TMenuItem
        Caption = 'Balance des couleurs'
        OnClick = Balancedescouleurs1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 44
    Top = 4
    object Creruneetoile1: TMenuItem
      Caption = 'Cr'#233'er &une '#233'toile'
      OnClick = Creruneetoile1Click
    end
    object Copierltoile1: TMenuItem
      Caption = '&Copier l'#39#233'toile'
      OnClick = Copierltoile1Click
    end
    object Couperltoile1: TMenuItem
      Caption = '&C&ouper l'#39#233'toile'
      OnClick = Couperltoile1Click
    end
    object CollerEtoile: TMenuItem
      Caption = 'Coll&er l'#39#233'toile'
      Enabled = False
      OnClick = CollerEtoileClick
    end
    object CollerEtoileIci: TMenuItem
      Caption = 'Coll&er l'#39#233'&toile ici'
      Enabled = False
      OnClick = CollerEtoileIciClick
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object Cicatriseruneligne1: TMenuItem
      Caption = 'Cic&atriser une ligne'
      OnClick = Cicatriseruneligne1Click
    end
    object Cicatriserunecolonne1: TMenuItem
      Caption = 'Cicatriser une colo&nne'
      OnClick = Cicatriserunecolonne1Click
    end
    object CicatriserPixel1: TMenuItem
      Caption = 'Cicatriser &Pixel'
      OnClick = CicatriserPixel1Click
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object Zoom1: TMenuItem
      Caption = 'Zoom'
      object outN251: TMenuItem
        Caption = '25 %'
        OnClick = outN251Click
      end
      object outN501: TMenuItem
        Caption = '50 %'
        OnClick = outN501Click
      end
      object outN751: TMenuItem
        Caption = '75 %'
        OnClick = outN751Click
      end
      object outN1001: TMenuItem
        Caption = '100 %'
        OnClick = outN1001Click
      end
      object outN2001: TMenuItem
        Caption = '200 %'
        OnClick = outN2001Click
      end
      object outN3001: TMenuItem
        Caption = '300 %'
        OnClick = outN3001Click
      end
      object outN4001: TMenuItem
        Caption = '400 %'
        OnClick = outN4001Click
      end
      object outN5001: TMenuItem
        Caption = '500 %'
        OnClick = outN5001Click
      end
      object outN6001: TMenuItem
        Caption = '600 %'
        OnClick = outN6001Click
      end
      object outN7001: TMenuItem
        Caption = '700%'
        OnClick = outN7001Click
      end
      object outN8001: TMenuItem
        Caption = '800 %'
        OnClick = outN8001Click
      end
      object outN9001: TMenuItem
        Caption = '900 %'
        OnClick = outN9001Click
      end
      object outN10001: TMenuItem
        Caption = '1000 %'
        OnClick = outN10001Click
      end
    end
    object Coupephotomtrique1: TMenuItem
      Caption = 'C&oupe photom'#233'trique'
    end
    object N27: TMenuItem
      Caption = '-'
    end
    object Fermer1: TMenuItem
      Caption = '&Fermer'
      OnClick = Fermer1Click
    end
  end
  object ImageList1: TImageList
    Left = 76
    Top = 4
    Bitmap = {
      494C01010B000E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      000000000000000000000000000000000000108F6F002F4F30001F8F6F004F6F
      60005F0F000000200F00A0AF4F002FCF6F00AF2F4F00A0AF60006F4F0F00A04F
      70009FCF40000F2F6F00108F6F002F4F30003F6040000F0F7000A02F6F007FCF
      6F0030600F00A04F7000407F700000C040000F2F6F00108F6F002FEF00007FCF
      6F001F8F6F004F6F60005FEF00007F805000906F7000302F60004F4F600060AF
      600090604000602F6F001F6F6F000000000000200F00A0AF4F002FCF6F00AF2F
      4F00A0AF60006F6F0000702F3000BFE000001F2F6000808F70004FEF6F0070CF
      00000FA02F00000000004F8050006FAF600070AF70004F8F70002FAF6F0030A0
      4F00202F6F000FCF6F008FE000001F2F600030EF6F00908F70003FE04F00706F
      4000602F6F001F6F6F003FA00F00A04F70009FCF40007F4F7000A04F30001F8F
      6F004F6F60005F0F000000200F00A0AF4F002FCF6F00AF2F4F00A0AF60006FAF
      000030EF6F00908F700090E000001F2F6000808F70004FEF6F0070CF000020C0
      40007F4F7000A0EF00007FCF6F001F8F6F004F6F60005FEF000050C040007F4F
      7000A04F30001F8F6F004F6F60005F0F000000200F00A0AF4F002FCF6F00AF2F
      4F00A0AF60006FEF0000302F60004F4F600060AF600090E000001F2F6000808F
      70004FEF6F0070CF000030C040000F2F6F00108F6F002FEF00007FCF6F001F8F
      6F004F6F60005FEF000060C040000F2F6F008FE000001F2F6000808F70004FEF
      6F0070CF00005F805000902FEF009F0F2000302F60004F4F600060AF60003FE0
      4F00706F4000602F6F001F6F6F003FE00F00A04F70009FCF40000F2F6F00108F
      6F002F2F30001F8F6F004F6F60005F0F0000000000004F8050006FAF600070AF
      70004F8F70002FAF6F005F0050000F6F70009F6F70002F0F6F000FAF7000A02F
      30003F6040000F0F7000A02F6F007FCF6F0030600F00802F60009F6F70002F0F
      200030006F000FAF7000A00F00004F8050006FAF600070AF70004F8F70002FAF
      6F0040805000906F700030EF6F00908F700090E000001F2F6000808F70004FEF
      6F0070CF00004F805000902FEF009F0F20006FAF600070AF70004F8F70002FAF
      6F002FC040007F4F7000A02F30003F6040000F0F7000A02F6F007FCF6F003080
      000030EF6F00908F70003FE04F00706F4000602F6F001F6F6F003F400F0030EF
      6F00908F70008F604000602F6F001F6F6F00000000004F8050006FAF600070AF
      70004F8F70002FAF6F003FC040000F2F6F00108F6F002F2F30003F6040000F0F
      7000A02F6F007FCF6F0030C00000302F60004F4F600060AF60003FE04F00706F
      4000602F6F001F6F6F003F800F00302F60004F4F600060AF60008F604000602F
      6F001F6F6F00000000004F8050006FAF600070AF70004F8F70002FAF6F005080
      5000906F7000302F60004F4F600060AF60004F6F60005FEF00007FA04F000F8F
      7000902F6F001F2F6F002F8F6F008F604000602F6F001F6F6F00000000004F80
      50006FAF600070AF70004F8F70002FAF6F004F0050000F6F70009FAF6000102F
      60009F2F30003F6040000F0F7000A02F6F007FCF6F0030400F00300050000F6F
      70009FAF6000004060000F6F700000200F00A0AF4F002FCF6F00AF2F4F00A0AF
      60006F0F0F00A04F70009FCF40007F4F7000A02F30003F6040000F0F7000A02F
      6F007FCF6F0030200F00A04F70004F7F700000C040007F4F7000A0EF00007FCF
      6F001F8F6F004F6F60005FEF00006F805000906F700030EF6F00908F70008F60
      4000602F6F001F6F6F00000000004F80500070AF60008F604000602F6F001F6F
      6F00000000004F8050006FAF600070AF70004F8F70002FAF6F005FA04F000F6F
      70008FAF70002FCF400060EF6F00AF2F30003F6040000F0F7000A02F6F007FCF
      6F0030800F0030A04F000F6F70008FAF70002F0F2000308F6F007FAF70003FE0
      4F00706F4000602F6F001F6F6F003F0010006F2F60009F2F7000AFAF6000308F
      6F007FAF70008F604000602F6F001F6F6F00000000004F8050006FAF600070AF
      70004F8F70002FAF6F0050A04F000F8F7000902F6F001F2F6F002F8F6F008FE0
      00001F2F6000808F70004FEF6F0070CF000050A04F0030206000A04F70004F6F
      60004FAF600060EF00007FCF6F001F8F6F00A02F300020804F002FCF6000A04F
      000060600000A0EF6F00804F0000200000004F8050006FAF600070AF70004F8F
      70002FAF6F0040C040004F8F6F00A04F70002F6F70008FE000001F2F6000808F
      70004FEF6F0070CF000040C02000302F6F00608F700090AF60009F4F0F003F4F
      70007FAF7000802F4F00708F60002F0F7F001040000000200F00A0AF4F002FCF
      6F00AF2F4F00A0AF60006F6F0F003F2F6000AF6F70009F2F6F002FCF6F0070AF
      60008FE000001F2F6000808F70004FEF6F0070CF00005FC020003F2F6000AF6F
      70009F2F6F002FCF6F0070AF60003FE04F00706F4000602F6F001F6F6F003F00
      10003F2F6000AF6F70009F2F6F002FCF6F0020EF00005060700010CF50002F4F
      7000A02F6F001F2F6000600F0F00802F60003FAF60009F2F6F00D0AF60001000
      0000408050000F4F60007F4F700020AF6000904F00000F000F007FCF6F009F6F
      600090EF6F00608F6F003FA01000B0AF6000908F70004F6F60009F6F600090EF
      6F00608F6F00102F6000906F50001F4F70007F8F6F00600F000000200F00A0AF
      4F000F2F6F0070AF4F002FCF6F00AF2F0F006F2F60004FCF6F006FAF600070AF
      70008F600F000FAF7000A0EF6F0040EF6F00A06F6F002F2F7F009FEF000040A0
      6F000FAF4F000FCF6F00AF2F600060CF00004FAF6F000FEF60002F6F70003F40
      0F004FAF6F000FEF60002F8F4F004F6F70000FC0000040AF60004FEF6000408F
      700010001000400050000FEF60002F6F50004F4F7F002F4F000000000F00A02F
      600010EF4F00908F60002F4F70001000000040E04F00706F50001F4F70007F8F
      6F0060EF0000A0004F007F4F70004F4F7F009F6F600090EF6F00608F6F00102F
      6000906F50001F4F70007F8F6F00600F000000400F00A06F50001F4F70007F8F
      6F00604F40000F4F70007FC050002F4F7000A02F6F001F6F50001F4F70007F8F
      6F00604F40000F4F700020804F002FCF6000A06F0000A03000001F8050007F0F
      7000100000002FE050004F8F6000A00F6F001000100030004F002F2F6F003F0F
      6F00A06F0000AF20000020604F004FCF6F0020EF6F00BFCF6F003F0010004FAF
      6F003FEF5F0010EF6F00C0AF4F007FAF70009FAF600020EF6F00BFCF6F005FE0
      4F0070AF4F007FAF70009FAF60006FEF6F00B0AF60003F0010004FAF6F003FEF
      5F0010EF6F00C0AF4F007FAF70009FAF60006FEF6F00B0AF60004FE04F0070AF
      4F007FAF70009FAF6000AF0F70003FC00F004FAF6F003FEF5F0010EF6F00C0AF
      4F007FAF70009FAF6000AF0F700000000000508050009F6F600090EF6F00608F
      6F00102F600090CF0F0040EF6F00902F6F00D06F50001F4F70007F8F6F00604F
      40000F4F700020804F002FCF6000A04F000000600000A0EF6F00806F0000A020
      00002FE050004F8F6000A00F6F001FA09000CF8F40007FEF7000700F0F007FCF
      6F0090AF60009F2F6F00D0AF60003F400F0030EF6F0090AF6F0090AF60009F2F
      6F00D0AF600030E04F00706F500040EF6F00BFEF000040C040007F4F70006F6F
      500040EF6F00BFAF0F00802F6F00C0AF6000606F700080AF6000902F4F00706F
      6000404F0000004F0F00A0AF6000C08F700040AF60004FEF6000408F700010A0
      0F0000C00000A02F4F006F2F60003FAF60003F206F006FEF6000FF4F60007F0F
      7F0020804F002FCF6000A04F000000600000A0EF6F00804F000000A00000BF2F
      6F00208F7000406F0000AF30000030004F002F2F6F003F0F6F00A06F0000AF20
      00005FE04F0070AF4F007FAF70009FAF60000000000000000000000000000000
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
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000080808000000000000000000000000000808080000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000008080
      8000000000000000000080808000FFFFFF008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00FFFFFF000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00808080000000
      000000000000FFFFFF0000000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000FFFFFF008080800000000000FFFFFF0000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      000000000000FFFFFF0080808000808080000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000808080000000FF000000
      FF00FFFFFF000000000000000000FFFFFF00808080000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      FF000000FF00FFFFFF000000000000000000FFFFFF0000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      80000000FF000000FF000000FF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000808080000000FF000000FF000000FF000000FF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      000000000000808080000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      80008080800080808000808080000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000FF000000FF00000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF00000000000000FF00000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000080808000808080008080
      800080808000808080008080800000000000000000000000FF00000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000FF00000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      FF00000000000000FF00000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000FF00000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      00000000FF000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000FF00000000000000FF000000
      0000000000000000000000000000000000000000000080808000808080008080
      800080808000808080008080800000000000000000000000FF00000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      80008080800080808000808080000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
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
      0000000000000000000000000000FF2020000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF2020000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF2020000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF202000FF20
      20000000000000000000FF6F6F00FF6F6F00FF6F6F00FF6F6F00000000000000
      0000FF2020000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF6F6F00FF6F6F00FFD08F00FFD08F00FFD08F00FF6F6F00FF6F6F000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000FFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000FFFF007F7F7F000000
      000000000000000000000000000000000000000000000000000000000000FF6F
      6F00FF6F6F00FFD0D000FFD0D000FFFFD000FFFFD000FFD0D000FFD08F00FF6F
      6F0000000000000000000000000000000000000000000000FF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      FF000000000000000000FFFFFF00000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00000000000000000000FFFF000000
      000000000000000000000000000000000000000000000000000000000000FF6F
      6F00FFD08F00FFFFD000FFFFFF00FFFFFF00FFFFFF00FFFFD000FFD0D000FF6F
      6F00FF6F6F00000000000000000000000000FFFFFF000000FF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000000000000000000007F7F7F000000
      0000FFFFFF0000000000FFFFFF00000000007F7F7F0000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF0000000000FFFFFF0000000000FFFFFF007F7F7F0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF6F
      6F00FFD08F00FFFFD000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFD0
      8F00FF6F6F00000000000000000000000000000000000000FF0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF000000000000000000000000000000
      FF00000000000000000000000000000000007F7F7F007F7F7F0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF00000000007F7F7F007F7F7F000000
      0000000000000000000000000000000000007F7F7F007F7F7F00FFFFFF000000
      0000FFFFFF000000FF00FFFFFF0000000000FFFFFF007F7F7F007F7F7F000000
      000000000000000000000000000000000000FF202000FF20200000000000FF6F
      6F00FFD0D000FFD0D000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFD0D000FFD0
      8F00FF6F6F0000000000FF202000FF202000000000000000FF00000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      FF0000000000000000000000000000000000000000007F7F7F00FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF007F7F7F00000000000000
      000000000000000000000000000000000000000000007F7F7F0000000000FFFF
      FF00000000000000FF0000000000FFFFFF00000000007F7F7F00000000000000
      000000000000000000000000000000000000000000000000000000000000FF6F
      6F00FFD0D000FFFFD000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFD0D000FFD0
      8F00FF6F6F00000000000000000000000000000000000000FF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000FFFFFF000000000000000000000000007F7F7F00000000000000
      FF000000FF000000FF000000FF000000FF00000000007F7F7F00000000000000
      000000000000000000000000000000000000000000007F7F7F00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007F7F7F00000000000000
      000000000000000000000000000000000000000000000000000000000000FF6F
      6F00FFD08F00FFD08F00FFFFD000FFFFFF00FFFFFF00FFFFFF00FFD08F00FF6F
      6F0000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      FF0000000000000000000000000000000000000000007F7F7F00FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF007F7F7F00000000000000
      000000000000000000000000000000000000000000007F7F7F0000000000FFFF
      FF00000000000000FF0000000000FFFFFF00000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF6F6F00FFD08F00FFD08F00FFD0D000FFD08F00FFD08F00FF6F6F00FF6F
      6F0000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000007F7F7F007F7F7F0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF00000000007F7F7F007F7F7F000000
      0000000000000000000000000000000000007F7F7F007F7F7F00FFFFFF000000
      0000FFFFFF000000FF00FFFFFF0000000000FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF6F6F00FF6F6F00FF6F6F00FF6F6F00FF6F6F00FF6F6F000000
      0000FF202000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000000000007F7F7F000000
      0000FFFFFF0000000000FFFFFF00000000007F7F7F0000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF0000000000FFFFFF0000000000FFFFFF007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000FF2020000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF202000FF20200000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF2020000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF2020000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF00000000000000FFFF0000FFFF000000F8
      FFFFFFFFFFFF0000000000F80000000000000000000000000000000000000000
      0000000000001F21000000000000000000000000000000000000000000000000
      EF7BEF7BEF7BEF7B000000000000EF7B00000000000000000000000000000000
      EF7BEF7BEF7BEF7B000000000000EF7BFFFFFFFFFFFFFFFF0001FFFFFE7F00F8
      0001F83FFE7F00000001E38FFFFFFFFF10A1CFCFFFFF00001001CFE7FE7F0000
      00119FE7FE7F1F2103A59FE7FE3F000008019FE7FF1F000002419FCFFF8F0000
      00018FDFFFCFEF7B0021C7BFFFE7EF7B0801E001E7E700000001F001E3C70000
      0001FFFFF00FEF7B0001FFFFF81FEF7BFFFFFEFFFFFFFFFFFFFFFEFFFFFF8001
      FFFFFEFFFFFF8001C000DEFFC37F8001DFE7D01FF3BF8001DFD3CEEFEBDF8001
      DFABC2F7EBDFFE01DF6BFEFFEFDFFE01DFDBFEFF00008001DFDFDE87EFDFFE01
      DFBFEEE7EF5FFE01DE7FF017EF5F8001D9FFFEF7F73F8001C7FFFEFFFB0F8001
      DFFFFEFFFFFF8001DFFFFEFFFFFFFFFFFFFDFFFDFEFFFFFFFFF8FFF8FEFF0001
      FFF1FFF1DFFF0001FFE3FFE3CC370001FFC7FFC7F01F0001E08FE08FE00F0401
      C01FC01FE0070601953F8A3FE00702012A9F111F20040801151F2A9FE0070681
      209F001FE00F0001151F2A9FF00F00012A9F111FF8170001953F8A3FDFF30001
      C07FC07FFEFF0001E0FFE0FFFEFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
