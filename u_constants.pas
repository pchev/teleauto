unit u_constants;

{
Copyright (C) Philippe Martinole

http://www.teleauto.org/
philippe.martinole@teleauto.org

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

{-------------------------------------------------------------------------------

                                  Constantes

-------------------------------------------------------------------------------}


interface

const
// 2.963 = 2.96a
  VersionNb          = 4.4;
  VersionTeleAuto    = 'Version 4.4'; //nolang

//  Directions
  diNord  = 0;
  diSud   = 1;
  diEst   = 2;
  diOuest = 3;         

  MinDouble=-1.7e308;
  MaxDouble=1.7e308;

  MinDistPointage=60; // en secondes d'arc

  // ArithmetiqueLot
  alSoustraction =0;
  alDivision     =1;

  // Cameras
  Aucune         =0;
  Hisis2214Bits  =1;
  Hisis2212Bits  =2;
  Audine400      =3;
  ST7            =4;
  ST8            =5;
  WebCam         =6;
  Plugin         =7;
  AudineObtu400  =8;
  STTrack        =9;
  Virtuelle      =10;
  Audine3200     =11;
  AudineObtu3200 =12;
  Audine1600     =13;
  AudineObtu1600 =14;
  ST9            =15;
  ST10           =16;

  MoveMini=0;

  NbStar=9096;               // Nombre d'etoiles dans le cataloque BSC
  NbNGC=7840;                // Nombre d'objets dans le cataloque NGC
  Sign_V3Cpa  =  $F5C7D1FA;  // Signature des fichiers CPA V3
  Sign_V4dCpa =  $07C1E1FD;  // Signature des fichiers CPA V4
  Sign_V4eCpa =  -155065859;

  MessierToNgc:Array[1..110] of Word =(
            1952, 7089, 5272, 6121, 5904, 6405, 6475, 6523, 6333, 6254, 6705,
            6218, 6205, 6402, 7078, 6611, 6618, 6613, 6273, 6514, 6531, 6656,
            6494, 6603, 4725, 6694, 6853, 6626, 6913, 7099, 224 ,  221,  598,
            1039, 2168, 1960, 2099, 1912, 7092, 4335, 2287, 1976, 1982, 2632,
            1432, 2437, 2422, 2548, 4472, 2323, 5194, 7654, 5024, 6715, 6809,
            6779, 6720, 4579, 4621, 4649, 4303, 6266, 5055, 4826, 3623, 3627,
            2682, 4590, 6637, 6681, 6838, 6981, 6994, 628 , 6864,  650, 1068,
            2068, 1904, 6093, 3031, 3034, 5236, 4374, 4382, 4406, 4486, 4501,
            4552, 4569, 4548, 6341, 2447, 4736, 3351, 3368, 3587, 4192, 4254,
            4321, 5457, 5457, 581 , 4594, 3379, 4258, 6171, 3556, 3992, 205      );

  // Modélisation d'étoile
  TGauss         = 1;
  TGaussEllipse  = 2;
  TMoffat        = 3;
  TMoffatEllipse = 4;
  
  LowPrecision   = 1;
  MeanPrecision  = 2;
  HighPrecision  = 3;

  LowSelect   = 1;
  MeanSelect  = 2;
  HighSelect  = 3;

  MaxArray       = 100; // Dimension maxi pour les matrices de calcul 20

  {matching}
  max_vote_array = 100;

  {MoonSun}
  AU=149597869;             (* astronomical unit in km *)
  mean_lunation=29.530589;  (* Mean length of a month *)
  earth_radius=6378.15;     (* Radius of the earth *)


{Script error messages - laisser la declaration de type ici}
const script_error_count = 20;

type t_script_status=record
     id:byte;
     desc:string;
end;

// Impossible a traduire pour l'instant PJ ?
const t_script_status_text:array[0..script_error_count] of t_script_status =(
(id:0;   desc:'Initialise'),                                               //nolang
(id:1;   desc:'OK'),                                                       //nolang
(id:2;   desc:'Slewing'),                                                  //nolang
(id:3;   desc:'Acquisition'),                                              //nolang
(id:4;   desc:'SetFilter'),                                                //nolang
(id:69;  desc:'Success'),                                                  //nolang
(id:70;  desc:'Problem during Slew'),                                      //nolang
(id:71;  desc:'Problem during Acquisition'),                               //nolang
(id:72;  desc:'No orbital elements for this asteroid'),                    //nolang
(id:73;  desc:'Problem during SetFilter'),                                 //nolang
(id:100; desc:'Rejected manually'),                                        //nolang
(id:100; desc:'Rejected - Object rises after Sunrise'),                    //nolang
(id:101; desc:'Rejected - Object sets too early'),                         //nolang
(id:102; desc:'Rejected - Object below horizon'),                          //nolang
(id:103; desc:'Rejected - Object out of Azimut limits'),                   //nolang
(id:104; desc:'Rejected - Object out of Altitude limits'),                 //nolang
(id:105; desc:'Rejected - Object too close to Moon'),                      //nolang
(id:106; desc:'Rejected - Moon is too bright'),                            //nolang
(id:107; desc:'Rejected - Telescope refuses command'),                     //nolang
(id:108; desc:'Rejected - Pointing after Sunrise'),                        //nolang
(id:109; desc:'Rejected - Pointing below profile')                         //nolang
);

starname_count = 189;

{etoiles brillantes - laisser dans cette unite please}
type TStarname =  record
        nom:string[20];     {nom propre}
        lettre:string[3] ;   {alpha, beta, blabla...}
        cons:string[3];     {constellation}
        SAO:integer;        {SAO #}
        ra:double;          {asc droite (heures)}
        dec:double;         {Dec (deg)}
end;

const
TStarName_matrix:array[1..starname_count] of TStarName =
(
(Nom:'ACAMAR';          Lettre:'The'; Cons:'Eri'; SAO:216113; RA:2.97119444444444; DEC:-40.3044444444444),    //nolang
(Nom:'ACHERNAR';        Lettre:'Alp'; Cons:'Eri'; SAO:232481; RA:1.62858333333333; DEC:-57.2366666666667),    //nolang
(Nom:'ACRUX';           Lettre:'Alp'; Cons:'Cru'; SAO:251904; RA:12.4433055555556; DEC:-63.0991666666667),    //nolang
(Nom:'ACUBENS';         Lettre:'Alp'; Cons:'Cnc'; SAO:98267;  RA:8.97477777777778; DEC:11.8577777777778),     //nolang
(Nom:'ADHAFERA';        Lettre:'Zet'; Cons:'Leo'; SAO:81265;  RA:10.2781666666667; DEC:23.4172222222222),     //nolang
(Nom:'ADHARA';          Lettre:'Eps'; Cons:'CMa'; SAO:172676; RA:6.97708333333333; DEC:-28.9722222222222),    //nolang
(Nom:'AL NASL';         Lettre:'Gam'; Cons:'Sgr'; SAO:209696; RA:18.0968055555556; DEC:-30.4241666666667),    //nolang
(Nom:'AL NAIR';         Lettre:'Alp'; Cons:'Gru'; SAO:230992; RA:22.1372222222222; DEC:-46.9611111111111),    //nolang
(Nom:'AL SUHAI';        Lettre:'Gam'; Cons:'Vel'; SAO:219504; RA:8.15888888888889; DEC:-47.3366666666667),    //nolang
(Nom:'ALBIREO';         Lettre:'Bet'; Cons:'Cyg'; SAO:87301;  RA:19.5120277777778; DEC:27.9597222222222),     //nolang
(Nom:'ALCHIBA';         Lettre:'Alp'; Cons:'Crv'; SAO:180505; RA:12.1402222222222; DEC:-24.7288888888889),    //nolang
(Nom:'ALCYONE';         Lettre:'Eta'; Cons:'Tau'; SAO:76199;  RA:3.79141666666667; DEC:24.105),               //nolang
(Nom:'ALDEBARAN';       Lettre:'Alp'; Cons:'Tau'; SAO:94027; RA:4.59866666666667; DEC:16.5091666666667),      //nolang
(Nom:'ALDERAMIN';       Lettre:'Alp'; Cons:'Cep'; SAO:19302; RA:21.3096666666667; DEC:62.5855555555556),      //nolang
(Nom:'ALFIRK';          Lettre:'Bet'; Cons:'Cep'; SAO:10057; RA:21.4776666666667; DEC:70.5608333333333),      //nolang
(Nom:'ALGENIB';         Lettre:'Gam'; Cons:'Peg'; SAO:91781; RA:0.220611111111111; DEC:15.1836111111111),     //nolang
(Nom:'ALGIEBA';         Lettre:'Gam'; Cons:'Leo'; SAO:81298; RA:10.3328611111111; DEC:19.8416666666667),      //nolang
(Nom:'ALGOL';           Lettre:'Bet'; Cons:'Per'; SAO:38592; RA:3.13613888888889;DEC:40.9555555555556),       //nolang
(Nom:'ALGORAB';         Lettre:'Del'; Cons:'Del'; SAO:157323; RA:12.49775; DEC:-16.5155555555556),            //nolang
(Nom:'ALHENA';          Lettre:'Gam'; Cons:'Gem'; SAO:95912; RA:6.62852777777778;DEC:16.3991666666667),       //nolang
(Nom:'ALIOTH';          Lettre:'Eps'; Cons:'UMa'; SAO:28553; RA:12.9004722222222;DEC:55.9597222222222),       //nolang
(Nom:'ALKAID';          Lettre:'Eta'; Cons:'UMa'; SAO:44752; RA:13.7923333333333;DEC:49.3133333333333),       //nolang
(Nom:'ALKALUROPS';      Lettre:'Mu '; Cons:'Boo'; SAO:64686;RA:15.4081666666667; DEC:37.3772222222222),       //nolang
(Nom:'ALKES';           Lettre:'Alp'; Cons:'Crt'; SAO:156375; RA:10.99625;DEC:-18.2988888888889),             //nolang
(Nom:'ALMAAZ';          Lettre:'Eps'; Cons:'Aur'; SAO:39955; RA:5.03280555555556;DEC:43.8233333333333),       //nolang
(Nom:'ALMACH';          Lettre:'Gam'; Cons:'And'; SAO:37734; RA:2.065;DEC:42.3297222222222),                  //nolang
(Nom:'ALNILAM';         Lettre:'Eps'; Cons:'Ori'; SAO:132346; RA:5.60355555555556; DEC:-1.20194444444444),    //nolang
(Nom:'ALNITAK';         Lettre:'Zet'; Cons:'Ori'; SAO:132444; RA:5.67933333333333; DEC:-1.94277777777778),    //nolang
(Nom:'ALPHARD';         Lettre:'Alp'; Cons:'Hya'; SAO:136871; RA:9.45977777777778; DEC:-8.65861111111111),    //nolang
(Nom:'ALPHECCA';        Lettre:'Alp'; Cons:'CrB'; SAO:83893; RA:15.5781388888889; DEC:26.7147222222222),      //nolang
(Nom:'ALPHERATZ-SIRRAH';Lettre:'Alp'; Cons:'And'; SAO:73765;RA:0.139805555555556; DEC:29.0905555555556),      //nolang
(Nom:'ALRESCHA';        Lettre:'Alp'; Cons:'Psc'; SAO:110291; RA:2.03411111111111; DEC:2.76361111111111),     //nolang
(Nom:'ALSHAIN';         Lettre:'Bet'; Cons:'Aql'; SAO:125235; RA:19.9218888888889; DEC:6.40666666666667),     //nolang
(Nom:'ALTAIR';          Lettre:'Alp'; Cons:'Aql'; SAO:125122; RA:19.8463888888889; DEC:8.86833333333333),     //nolang
(Nom:'ALTAIS';          Lettre:'Del'; Cons:'Dra'; SAO:18222;  RA:19.20925; DEC:67.6616666666667),             //nolang
(Nom:'ALTERF';          Lettre:'Lam'; Cons:'Leo'; SAO:80885;  RA:9.52866666666667; DEC:22.9680555555556),     //nolang
(Nom:'ALUDRA';          Lettre:'Eta'; Cons:'CMa'; SAO:173651; RA:7.40158333333333; DEC:-29.3030555555556),    //nolang
(Nom:'ALULA AUSTRALIS'; Lettre:'Xi '; Cons:'UMa'; SAO:62484;  RA:11.3030277777778; DEC:31.5291666666667),     //nolang
(Nom:'ALULA AUSTRALIS'; Lettre:'Xi '; Cons:'UMa'; SAO:62484;  RA:11.3030277777778; DEC:31.5291666666667),     //nolang
(Nom:'ALULA BOREALIS';  Lettre:'Nu '; Cons:'UMa'; SAO:62486;   RA:11.3079722222222; DEC:33.0941666666667),    //nolang
(Nom:'ALYA';            Lettre:'The'; Cons:'Ser'; SAO:124068; RA:18.937; DEC:4.20361111111111),               //nolang
(Nom:'ANCHA';           Lettre:'The'; Cons:'Aqr'; SAO:145991; RA:22.2805555555556; DEC:-7.78333333333333),    //nolang
(Nom:'ANTARES';         Lettre:'Alp'; Cons:'Sco'; SAO:184415; RA:16.4901111111111; DEC:-26.4319444444444),    //nolang
(Nom:'ARCTURUS';        Lettre:'Alp'; Cons:'Boo'; SAO:100944; RA:14.2610277777778; DEC:19.1825),              //nolang
(Nom:'ARKAB';           Lettre:'Bet'; Cons:'Sgr'; SAO:229646; RA:19.3773055555556; DEC:-44.4588888888889),    //nolang
(Nom:'ARNEB';           Lettre:'Alp'; Cons:'Lep'; SAO:150547; RA:5.5455; DEC:-17.8222222222222),              //nolang
(Nom:'ASCELLA';         Lettre:'Zet'; Cons:'Sgr'; SAO:187600; RA:19.0435277777778; DEC:-29.8802777777778),    //nolang
(Nom:'ASPIDISKE';       Lettre:'Iot'; Cons:'Car'; SAO:236808; RA:9.28483333333333; DEC:-59.2752777777778),    //nolang
(Nom:'ATIK';            Lettre:'Zet'; Cons:'Per'; SAO:56799; RA:3.90219444444444; DEC:31.8836111111111),      //nolang
(Nom:'ATLAS';           Lettre:'Tau'; Cons:'Tau'; SAO:76228; RA:3.81936111111111;DEC:24.0533333333333),       //nolang
(Nom:'ATRIA';           Lettre:'Alp'; Cons:'TrA'; SAO:253700; RA:16.8110833333333;DEC:-69.0277777777778),     //nolang
(Nom:'AVIOR';           Lettre:'Eps'; Cons:'Car'; SAO:235932; RA:8.37522222222222;DEC:-59.5097222222222),     //nolang
(Nom:'AZHA';            Lettre:'Eta'; Cons:'Eri'; SAO:130197; RA:2.94047222222222; DEC:-8.89805555555555),    //nolang
(Nom:'BATEN KAITOS';    Lettre:'Zet'; Cons:'Cet'; SAO:148059; RA:1.85766666666667; DEC:-10.335),              //nolang
(Nom:'BEID';            Lettre:'Omi'; Cons:'Eri'; SAO:131019; RA:4.19775; DEC:-6.8375),                       //nolang
(Nom:'BELLATRIX';       Lettre:'Gam'; Cons:'Ori'; SAO:112740; RA:5.41886111111111; DEC:6.34972222222222),     //nolang
(Nom:'BETELGEUSE';      Lettre:'Alp'; Cons:'Ori'; SAO:113271; RA:5.91952777777778; DEC:7.40694444444444),     //nolang
(Nom:'BIHAM';           Lettre:'The'; Cons:'Peg'; SAO:127340; RA:22.17; DEC:6.19777777777778),                //nolang
(Nom:'CANOPUS';         Lettre:'Alp'; Cons:'Car'; SAO:234480; RA:6.39919444444445; DEC:-52.6958333333333),    //nolang
(Nom:'CAPELLA';         Lettre:'Alp'; Cons:'Aur'; SAO:40186; RA:5.27816666666667; DEC:45.9980555555556),      //nolang
(Nom:'CAPH';            Lettre:'Bet'; Cons:'Cas'; SAO:21133; RA:0.152972222222222; DEC:59.1497222222222),     //nolang
(Nom:'CASTOR';          Lettre:'Alp'; Cons:'Gem'; SAO:60198; RA:7.57666666666667; DEC:31.8886111111111),      //nolang
(Nom:'CEBALRAI';        Lettre:'Bet'; Cons:'Oph'; SAO:122671; RA:17.7245555555556; DEC:4.56722222222222),     //nolang
(Nom:'CELAENO';         Lettre:'Tau'; Cons:'Tau'; SAO:76126; RA:3.74672222222222; DEC:24.2894444444444),      //nolang
(Nom:'CHARA';           Lettre:'Bet'; Cons:'CVn'; SAO:44230; RA:12.5623611111111; DEC:41.3575),               //nolang
(Nom:'CHERTAN';         Lettre:'The'; Cons:'Leo'; SAO:99512; RA:11.2373333333333; DEC:15.4294444444444),      //nolang
(Nom:'COR CAROLI';      Lettre:'Alp'; Cons:'CVn'; SAO:63257; RA:12.9338055555556; DEC:38.3183333333333),      //nolang
(Nom:'CURSA';           Lettre:'Bet'; Cons:'Eri'; SAO:131794; RA:5.13083333333333; DEC:-5.08638888888889),    //nolang
(Nom:'DENEB';           Lettre:'Alp'; Cons:'Cyg'; SAO:49941; RA:20.6905277777778;  DEC:45.2802777777778),     //nolang
(Nom:'DENEB ALGEDI';    Lettre:'Alp'; Cons:'Cap'; SAO:163427; RA:20.3009166666667; DEC:-12.5447222222222),    //nolang
(Nom:'DENEBOLA';        Lettre:'Bet'; Cons:'Leo'; SAO:99809; RA:11.8176666666667; DEC:14.5719444444444),      //nolang
(Nom:'DIPHDA';          Lettre:'Bet'; Cons:'Cet'; SAO:147420; RA:0.7265; DEC:-17.9866666666667),              //nolang
(Nom:'DENEB KAITOS';    Lettre:'Bet'; Cons:'Cet'; SAO:147420; RA:0.7265; DEC:-17.9866666666667),              //nolang
(Nom:'DSCHUBBA';        Lettre:'Del'; Cons:'Sco'; SAO:184014; RA:16.0055555555556; DEC:-22.6216666666667),    //nolang
(Nom:'DUBHE';           Lettre:'Alp'; Cons:'UMa'; SAO:15384; RA:11.0621388888889; DEC:61.7508333333333),      //nolang
(Nom:'EDASICH';         Lettre:'Iot'; Cons:'Dra'; SAO:29520; RA:15.4155; DEC:58.9661111111111),               //nolang
(Nom:'ELECTRA';         Lettre:'Tau'; Cons:'Tau'; SAO:76131; RA:3.74791666666667; DEC:24.1133333333333),      //nolang
(Nom:'ELNATH';          Lettre:'Bet'; Cons:'Tau'; SAO:77168; RA:5.43819444444444; DEC:28.6075),               //nolang
(Nom:'ELTANIN';         Lettre:'Gam'; Cons:'Dra'; SAO:30653; RA:17.9434444444444; DEC:51.4888888888889),      //nolang
(Nom:'ENIF';            Lettre:'Eps'; Cons:'Peg'; SAO:127029; RA:21.7364444444444; DEC:9.875),                //nolang
(Nom:'ERRAI';           Lettre:'Gam'; Cons:'Cep'; SAO:10818; RA:23.6557777777778; DEC:77.6325),               //nolang
(Nom:'FOMALHAUT';       Lettre:'Alp'; Cons:'PsA'; SAO:191524; RA:22.9608611111111; DEC:-29.6222222222222),    //nolang
(Nom:'FURUD';           Lettre:'Zet'; Cons:'CMa'; SAO:196698; RA:6.33855555555555; DEC:-30.0633333333333),    //nolang
(Nom:'GACRUX';          Lettre:'Gam'; Cons:'Cru'; SAO:240019; RA:12.5194166666667; DEC:-57.1133333333333),    //nolang
(Nom:'GIAUSAR';         Lettre:'Lam'; Cons:'Dra'; SAO:15532; RA:11.5233888888889; DEC:69.3311111111111),      //nolang
(Nom:'GIENAH';          Lettre:'Gam'; Cons:'Crv'; SAO:157176; RA:12.2634444444444; DEC:-17.5419444444444),    //nolang
(Nom:'GOMEISA';         Lettre:'Bet'; Cons:'CMi'; SAO:115456; RA:7.4525; DEC:8.28944444444444),               //nolang
(Nom:'GRAFFIAS';        Lettre:'Bet'; Cons:'Sco'; SAO:159682; RA:16.0906111111111; DEC:-19.8055555555556),    //nolang
(Nom:'GRUMIUM';         Lettre:'Xi '; Cons:'Dra'; SAO:30631; RA:17.8921388888889; DEC:56.8727777777778),      //nolang
(Nom:'HADAR';           Lettre:'Bet'; Cons:'Cen'; SAO:252582; RA:14.0637222222222; DEC:-60.3730555555556),    //nolang
(Nom:'HAMAL';           Lettre:'Alp'; Cons:'Ari'; SAO:75151; RA:2.11955555555556;  DEC:23.4625),              //nolang
(Nom:'HOMAM';           Lettre:'Zet'; Cons:'Peg'; SAO:108103; RA:22.6910277777778; DEC:10.8313888888889),     //nolang
(Nom:'IZAR';            Lettre:'Eps'; Cons:'Boo'; SAO:83500; RA:14.7497777777778;   DEC:27.075),              //nolang
(Nom:'MIRAK';           Lettre:'Eps'; Cons:'Boo'; SAO:83500; RA:14.7497777777778;  DEC:27.075),               //nolang
(Nom:'KAUS AUSTRALIS';  Lettre:'Eps'; Cons:'Sgr'; SAO:210091; RA:18.4028611111111; DEC:-34.3847222222222),    //nolang
(Nom:'KAUS BOREALIS';   Lettre:'Lam'; Cons:'Sgr'; SAO:186841;  RA:18.4661666666667; DEC:-25.4216666666667),   //nolang
(Nom:'KAUS MEDIA';      Lettre:'Del'; Cons:'Sgr'; SAO:186681; RA:18.3499166666667; DEC:-29.8280555555556),    //nolang
(Nom:'KEID';            Lettre:'Omi'; Cons:'Eri'; SAO:131063; RA:4.25452777777778; DEC:-7.65277777777778),    //nolang
(Nom:'KITALPHA';        Lettre:'Alp'; Cons:'Equ'; SAO:126662; RA:21.2637222222222; DEC:5.24777777777778),     //nolang
(Nom:'KOCHAB';          Lettre:'Bet'; Cons:'UMi'; SAO:8102; RA:14.8450833333333; DEC:74.1555555555556),       //nolang
(Nom:'KORNEPHOROS';     Lettre:'Bet'; Cons:'Her'; SAO:84411; RA:16.5036666666667; DEC:21.4897222222222),      //nolang
(Nom:'LESATH';          Lettre:'Ups'; Cons:'Sco'; SAO:208896; RA:17.5127222222222; DEC:-37.2958333333333),    //nolang
(Nom:'MAIA';            Lettre:'Tau'; Cons:'Tau'; SAO:76155; RA:3.76377777777778; DEC:24.3677777777778),      //nolang
(Nom:'MARFIK';          Lettre:'Lam'; Cons:'Oph'; SAO:121658; RA:16.5152222222222; DEC:1.98388888888889),     //nolang
(Nom:'MARKAB';          Lettre:'Alp'; Cons:'Peg'; SAO:108378; RA:23.0793611111111; DEC:15.2052777777778),     //nolang
(Nom:'MATAR';           Lettre:'Eta'; Cons:'Peg'; SAO:90734; RA:22.7166944444444; DEC:30.2213888888889),      //nolang
(Nom:'MEBSUTA';         Lettre:'Eps'; Cons:'Gem'; SAO:78682; RA:6.73219444444444; DEC:25.1311111111111),      //nolang
(Nom:'MEGREZ';          Lettre:'Del'; Cons:'UMa'; SAO:28315; RA:12.2571111111111; DEC:57.0325),               //nolang
(Nom:'MEISSA';          Lettre:'Lam'; Cons:'Ori'; SAO:112921; RA:5.58563888888889; DEC:9.93416666666667),     //nolang
(Nom:'MEKBUDA';         Lettre:'Zet'; Cons:'Gem'; SAO:79031; RA:7.06847222222222; DEC:20.5702777777778),      //nolang
(Nom:'MENKALINAM';      Lettre:'Bet'; Cons:'Aur'; SAO:40750; RA:5.99213888888889; DEC:44.9475),               //nolang
(Nom:'MENKAR';          Lettre:'Alp'; Cons:'Cet'; SAO:110920; RA:3.038; DEC:4.08972222222222),                //nolang
(Nom:'MENKENT';         Lettre:'The'; Cons:'Cen'; SAO:205188; RA:14.1113888888889; DEC:-36.37),               //nolang
(Nom:'MENKIB';          Lettre:'Xi '; Cons:'Per'; SAO:56856; RA:3.98275; DEC:35.7911111111111),               //nolang
(Nom:'MERAK';           Lettre:'Bet'; Cons:'UMa'; SAO:27876; RA:11.0306944444444; DEC:56.3825),               //nolang
(Nom:'MEROPE';          Lettre:'Tau'; Cons:'Tau'; SAO:76172; RA:3.77211111111111;DEC:23.9483333333333),       //nolang
(Nom:'MESARTHIM';       Lettre:'Gam'; Cons:'Ari'; SAO:92681;RA:1.89216666666667; DEC:19.2958333333333),       //nolang
(Nom:'MIAPLACIDUS';     Lettre:'Bet'; Cons:'Car'; SAO:250495; RA:9.22; DEC:-69.7172222222222),                //nolang
(Nom:'MIMOSA';          Lettre:'Bet'; Cons:'Cru'; SAO:240259;RA:12.7953333333333; DEC:-59.6886111111111),     //nolang
(Nom:'MIRA';            Lettre:'Omi'; Cons:'Cet'; SAO:129825; RA:2.32241666666667;DEC:-2.9775),               //nolang
(Nom:'MIRACH';          Lettre:'Bet'; Cons:'And'; SAO:54471; RA:1.16219444444444;DEC:35.6205555555556),       //nolang
(Nom:'ALGENIB';         Lettre:'Alp'; Cons:'Per'; SAO:38787;RA:3.40538888888889; DEC:49.8611111111111),       //nolang
(Nom:'MIRFAK';          Lettre:'Alp'; Cons:'Per'; SAO:38787; RA:3.40538888888889;DEC:49.8611111111111),       //nolang
(Nom:'MIRZAM';          Lettre:'Bet'; Cons:'CMa'; SAO:151428;RA:6.37833333333333; DEC:-17.9558333333333),     //nolang
(Nom:'MIZAR';           Lettre:'Zet'; Cons:'UMa'; SAO:28737; RA:13.39875; DEC:54.9252777777778),              //nolang
(Nom:'MUPHRID';         Lettre:'Eta'; Cons:'Boo'; SAO:100766; RA:13.9114166666667; DEC:18.3977777777778),     //nolang
(Nom:'MUSCIDA';         Lettre:'Omi'; Cons:'UMa'; SAO:14573; RA:8.50441666666667; DEC:60.7180555555556),      //nolang
(Nom:'NASHIRA';         Lettre:'Gam'; Cons:'Cap'; SAO:164560; RA:21.6681944444444; DEC:-16.6622222222222),    //nolang
(Nom:'NEKKAR';          Lettre:'Bet'; Cons:'Boo'; SAO:45337; RA:15.0324444444444; DEC:40.3905555555556),      //nolang
(Nom:'NIHAL';           Lettre:'Bet'; Cons:'Lep'; SAO:170457; RA:5.47075; DEC:-20.7594444444444),             //nolang
(Nom:'NUNKI';           Lettre:'Sig'; Cons:'Sgr'; SAO:187448; RA:18.9210833333333; DEC:-26.2966666666667),    //nolang
(Nom:'NUSAKAN';         Lettre:'Bet'; Cons:'CrB'; SAO:83831; RA:15.4638055555556; DEC:29.1058333333333),      //nolang
(Nom:'PEACOCK';         Lettre:'Alp'; Cons:'Pav'; SAO:246574; RA:20.4274722222222; DEC:-56.735),              //nolang
(Nom:'PHACT';           Lettre:'Alp'; Cons:'Col'; SAO:196059; RA:5.66080555555556; DEC:-34.0741666666667),    //nolang
(Nom:'PHECDA';          Lettre:'Gam'; Cons:'UMa'; SAO:28179; RA:11.8971666666667; DEC:53.6947222222222),      //nolang
(Nom:'PHERKAD';         Lettre:'Gam'; Cons:'UMi'; SAO:8220; RA:15.3454722222222;DEC:71.8338888888889),        //nolang
(Nom:'PLEIONE';         Lettre:'Tau'; Cons:'Tau'; SAO:76229; RA:3.81977777777778; DEC:24.1366666666667),      //nolang
(Nom:'POLARIS';         Lettre:'Alp'; Cons:'UMi'; SAO:308; RA:2.53019444444444; DEC:89.2641666666667),        //nolang
(Nom:'POLLUX';          Lettre:'Bet'; Cons:'Gem'; SAO:79666; RA:7.75525;DEC:28.0261111111111),                //nolang
(Nom:'PORRIMA';         Lettre:'Gam'; Cons:'Vir'; SAO:138917;   RA:12.6943333333333; DEC:-1.44944444444444),  //nolang
(Nom:'PROCYON';         Lettre:'Alp'; Cons:'CMi'; SAO:115756; RA:7.65502777777778; DEC:5.225),                //nolang
(Nom:'PROPUS';          Lettre:'Eta'; Cons:'Gem'; SAO:78135; RA:6.24794444444444;DEC:22.5066666666667),       //nolang
(Nom:'RASALAS';         Lettre:'Mu '; Cons:'Leo'; SAO:81064; RA:9.87938888888889; DEC:26.0069444444444),      //nolang
(Nom:'RASALGHETI';      Lettre:'Alp'; Cons:'Her'; SAO:102680; RA:17.2442222222222; DEC:14.39),                //nolang
(Nom:'RASALHAGUE';      Lettre:'Alp'; Cons:'Oph'; SAO:102932; RA:17.58225; DEC:12.56),                        //nolang
(Nom:'REGULUS';         Lettre:'Alp'; Cons:'Leo'; SAO:98967;RA:10.1395277777778; DEC:11.9672222222222),       //nolang
(Nom:'RIGEL';           Lettre:'Bet'; Cons:'Ori'; SAO:131907; RA:5.24230555555556;DEC:-8.20166666666667),     //nolang
(Nom:'RIGEL KENTAURUS'; Lettre:'Alp'; Cons:'Cen'; SAO:252838;RA:14.6599722222222; DEC:-60.8352777777778),     //nolang
(Nom:'RUCHBAH';         Lettre:'Del'; Cons:'Del'; SAO:22268;RA:1.43027777777778; DEC:60.2352777777778),       //nolang
(Nom:'RUKBAT';          Lettre:'Alp'; Cons:'Sgr'; SAO:229659;   RA:19.3981111111111; DEC:-40.6161111111111),  //nolang
(Nom:'SABIK';           Lettre:'Eta'; Cons:'Oph'; SAO:160332; RA:17.1729722222222; DEC:-15.7247222222222),    //nolang
(Nom:'SADACHBIA';       Lettre:'Gam'; Cons:'Aqr'; SAO:146044; RA:22.3609444444444; DEC:-1.38722222222222),    //nolang
(Nom:'SADALBARI';       Lettre:'Mu '; Cons:'Peg'; SAO:90816;RA:22.8333888888889; DEC:24.6016666666667),       //nolang
(Nom:'SADALMELIK';      Lettre:'Alp'; Cons:'Aqr'; SAO:145862; RA:22.0963888888889; DEC:-0.319722222222222),   //nolang
(Nom:'SADALSUUD';       Lettre:'Bet'; Cons:'Aqr'; SAO:145457; RA:21.5259722222222; DEC:-5.57111111111111),    //nolang
(Nom:'SADR';            Lettre:'Gam'; Cons:'Cyg'; SAO:49528; RA:20.3704722222222; DEC:40.2566666666667),      //nolang
(Nom:'SAIPH';           Lettre:'Kap'; Cons:'Ori'; SAO:132542; RA:5.79594444444444;DEC:-9.66972222222222),     //nolang
(Nom:'SARGAS';          Lettre:'The'; Cons:'Sco'; SAO:228201; RA:17.622; DEC:-42.9977777777778),              //nolang
(Nom:'SCHEAT';          Lettre:'Bet'; Cons:'Peg'; SAO:90981; RA:23.0629166666667;DEC:28.0827777777778),       //nolang
(Nom:'SCHEDAR';         Lettre:'Alp'; Cons:'Cas'; SAO:21609; RA:0.675138888888889; DEC:56.5372222222222),     //nolang
(Nom:'SEGINUS';         Lettre:'Gam'; Cons:'Boo'; SAO:64203; RA:14.5346388888889; DEC:38.3083333333333),      //nolang
(Nom:'SHAULA';          Lettre:'Lam'; Cons:'Sco'; SAO:208954; RA:17.5601388888889; DEC:-37.1038888888889),    //nolang
(Nom:'SHERATAN';        Lettre:'Bet'; Cons:'Ari'; SAO:75012; RA:1.91066666666667; DEC:20.8080555555556),      //nolang
(Nom:'SIRIUS';          Lettre:'Alp'; Cons:'CMa'; SAO:151881; RA:6.75247222222222; DEC:-16.7161111111111),    //nolang
(Nom:'SKAT';            Lettre:'Del'; Cons:'Del'; SAO:165375; RA:22.9108333333333;DEC:-15.8208333333333),     //nolang
(Nom:'SPICA';           Lettre:'Alp'; Cons:'Vir'; SAO:157923; RA:13.4198888888889; DEC:-11.1613888888889),    //nolang
(Nom:'STEROPE';         Lettre:'Tau'; Cons:'Tau'; SAO:76159;RA:3.76511111111111; DEC:24.5547222222222),       //nolang
(Nom:'SUHAIL';          Lettre:'Lam'; Cons:'Vel'; SAO:220878; RA:9.13327777777778; DEC:-43.4325),             //nolang
(Nom:'SULAFAT';         Lettre:'Gam'; Cons:'Lyr'; SAO:67663; RA:18.9823888888889; DEC:32.6894444444444),      //nolang
(Nom:'SYRMA';           Lettre:'Iot'; Cons:'Vir'; SAO:139824; RA:14.2669166666667; DEC:-6.00055555555556),    //nolang
(Nom:'TALITHA';         Lettre:'Iot'; Cons:'UMa'; SAO:42630;RA:8.98677777777778; DEC:48.0416666666667),       //nolang
(Nom:'TANIA AUSTRALIS'; Lettre:'Mu '; Cons:'UMa'; SAO:43310; RA:10.3721388888889; DEC:41.4994444444444),      //nolang
(Nom:'TANIA BOREALIS';  Lettre:'Lam'; Cons:'UMa'; SAO:43268; RA:10.2849444444444; DEC:42.9144444444444),      //nolang
(Nom:'TARAZED';         Lettre:'Gam'; Cons:'Aql'; SAO:105223; RA:19.771;DEC:10.6133333333333),                //nolang
(Nom:'TAYGETA';         Lettre:'Tau'; Cons:'Tau'; SAO:76140; RA:3.75347222222222; DEC:24.4672222222222),      //nolang
(Nom:'THUBAN';          Lettre:'Alp'; Cons:'Dra'; SAO:16273; RA:14.0731388888889;DEC:64.3758333333333),       //nolang
(Nom:'UNUKALHAI';       Lettre:'Alp'; Cons:'Ser'; SAO:121157;RA:15.7378055555556; DEC:6.42555555555556),      //nolang
(Nom:'VEGA';            Lettre:'Alp'; Cons:'Lyr'; SAO:67174; RA:18.6156388888889; DEC:38.7836111111111),      //nolang
(Nom:'VINDEMIATRIX';    Lettre:'Eps'; Cons:'Vir'; SAO:100384;  RA:13.0362777777778; DEC:10.9591666666667),    //nolang
(Nom:'WASAT';           Lettre:'Del'; Cons:'Gem'; SAO:79294; RA:7.33538888888889;DEC:21.9822222222222),       //nolang
(Nom:'WEZEN';           Lettre:'Del'; Cons:'Del'; SAO:173047; RA:7.13986111111111;DEC:-26.3933333333333),     //nolang
(Nom:'YED POSTERIOR';   Lettre:'Eps'; Cons:'Oph'; SAO:141086; RA:16.3053611111111; DEC:-4.6925),              //nolang
(Nom:'YED PRIOR';       Lettre:'Del'; Cons:'Oph'; SAO:141052;RA:16.2390833333333; DEC:-3.69444444444444),     //nolang
(Nom:'ZANIAH';          Lettre:'Eta'; Cons:'Vir'; SAO:138721;RA:12.3317777777778; DEC:-0.666944444444444),    //nolang
(Nom:'ZAURAK';          Lettre:'Gam'; Cons:'Eri'; SAO:149283; RA:3.96716666666667; DEC:-13.5086111111111),    //nolang
(Nom:'ZAVIJAVA';        Lettre:'Bet'; Cons:'Vir'; SAO:119076;RA:11.8449166666667; DEC:1.76472222222222),      //nolang
(Nom:'ZOSMA';           Lettre:'Del'; Cons:'Leo'; SAO:81727; RA:11.2351388888889;DEC:20.5236111111111),       //nolang
(Nom:'ZUBENELGENUBI';   Lettre:'Alp'; Cons:'Lib'; SAO:158840; RA:14.8479722222222; DEC:-16.0416666666667),    //nolang
(Nom:'ZUBENESCHAMALI';  Lettre:'Bet'; Cons:'Lib'; SAO:140430; RA:15.2834444444444; DEC:-9.38305555555556)     //nolang
);

const
DEGRAD = 1.74532925199e-2;
RADDEG = 57.2957795132;

{Refraction, Mel Bartels}
_OneRev = 2*PI;
_HalfRev = _OneRev/2;
_QtrRev = _OneRev/4;
_RadToDeg = 360/_OneRev;
_DegToRad = _OneRev/360.;
_RadToArcmin = 60*_RadToDeg;
_ArcminToRad = _DegToRad/60.;


{numerical recipes SVD}
mp=50;
np=50;
ndatap=50;
map=50;
tol=1e-5;

// Pointages dans les images
PointeOff            = 0;
PointeEtalon         = 1;
PointeMagnitude      = 2;
PointeEtoile         = 3;
PointeFenetrage      = 4;
PointeStatFenetre    = 5;
PointeGrouping       = 6; // obsauto
EnleveEtalon         = 7;
SupprimeEtalon       = 8;
PointeAstrometrie    = 9;
CoupePhoto           = 10;
PointeCicatLigne     = 11;
PointeCicatColonne   = 12;
PointeCicatPixel     = 13;
AjouteMarque         = 14;

// Forme des pointage
Off       = 0;
Reticule  = 1;
Rectangle = 2;
Ligne     = 3;

// Quadrant Coordinate III
// Impossible a traduire pour l'instant PJ ?
{------------
 return codes
-------------}
C3_ret_00 = 'OK';                                             //nolang
C3_ret_01 = 'Invalid Parameters';                             //nolang
C3_ret_02 = 'Unknown Command';                                //nolang
C3_ret_03 = 'Unit not tracking';                              //nolang
C3_ret_04 =' Slew below horizon';                             //nolang
C3_ret_05 = 'Slew might cause equipment damage';              //nolang
C3_ret_06 = 'Unit Slewing';                                   //nolang
C3_ret_07 = 'Unit in motion';                                 //nolang
C3_ret_08 =' Joystick or paddle enabled';                     //nolang
{Reponse a la commande D (status)}                            //nolang
C3_ret_09 = 'Initializing';                                   //nolang
C3_ret_10 = 'Tracking';                                       //nolang
C3_ret_11 = 'Slewing';                                        //nolang
C3_ret_12 = 'Stopped';                                        //nolang
{------------------------
longueur des strings lues
-------------------------}
len_R = 50;
len_X = 50;
len_S = 50;


{Protocole

A   : Set telescope altitude (AA = above pole AB = below pole
D   : Display current status
E   : Stop
H   : Read TIme
I   : Set Time  (I12:34:56:78)
KE  : Enable Joystick
KD  : Disable Joystick
REGL: Load User
PE  : Enable Paddle
PD  : Disable paddle
R   : Read position
S   : Set Position (SRA:12:34:56 DEC:+12:34:56)
T   : Start Track (TS TL TO TU)
X   : Slew (XRA:12:34:56 DEC:+12:34:56)
Z   : move at speed toto (Znnn)
?   : menu


cablage :
When wiring up a cable, please use only pins 2, 3, and 5.  Nothing
on any other pin.  Pin 2 goes to pin 3, pin 3 goes to pin 2, and pin 5 goes
to pin 5 (for a DB-9 to DB-9 cable).  You can verify communication with any
communication software (such as Hyperterminal).  Go into "direct" mode, set
for 9600, N, 8, 1, select correct Com port, flow control "off", and when you
turn on the Coordinate III, a message will come from the system.  You type a
"?" and the menu of commands will appear.

                                        Aim Controls, Inc. }


{MOshier - Corrections astrometriques}
gauss = 0.01720209895; {* constante de gravitation de Gauss (rGM) ua1.5/j }
tlight : double = 5.77551831e-3;

// calcul de rho sin phi et rho cos phi
desinpi = 4.26345151e-5;

// format de date FITS a la milliseconde
datetimeFITS = 'yyyy"-"mm"-"dd"T"hh":"nn":"ss"."zzz'; //nolang

const
  ColorName : array[1..3] of string = ('Red','Green','Blue'); //nolang

// keyword FITS reconnus
type Tfitsheader = record
            key : array[1..8] of char;
            val : array[1..72] of char;
            end;
     Tfitsheaderblock = array[1..36] of Tfitsheader;
     kwrec = record
             nom : string;   // keyword
             seq : byte;     // numero de sequence
             inf : byte;     // numero de sequence de ImgInfo
             pri : byte;     // priorite en cas de duplicata
             end;
const
 fitsnumkeyword = 68;
 fitsnuminf     = 35;
 fitskeyword : array[1..fitsnumkeyword] of kwrec  = (
               (nom:'BITPIX';   seq:1;  inf:1 ; pri:0),      //nolang
               (nom:'NAXIS';    seq:2;  inf:2 ; pri:0),      //nolang
               (nom:'NAXIS1';   seq:3;  inf:3 ; pri:0),      //nolang
               (nom:'NAXIS2';   seq:4;  inf:4 ; pri:0),      //nolang
               (nom:'NAXIS3';   seq:5;  inf:5 ; pri:0),      //nolang
               (nom:'DATE-OBS'; seq:6;  inf:6 ; pri:0),      //nolang
               (nom:'BZERO';    seq:7;  inf:7 ; pri:0),      //nolang
               (nom:'BSCALE';   seq:8;  inf:8 ; pri:0),      //nolang
               (nom:'OBSERVER'; seq:9;  inf:9 ; pri:0),      //nolang
               (nom:'EXPOSURE'; seq:10; inf:10; pri:0),      //nolang
               (nom:'TELESCOP'; seq:11; inf:11; pri:0),      //nolang
               (nom:'INSTRUME'; seq:12; inf:12; pri:0),      //nolang
               (nom:'CDELTM1';  seq:13; inf:13; pri:2),      //nolang
               (nom:'CDELTM2';  seq:14; inf:14; pri:2),      //nolang
               (nom:'BINX';     seq:15; inf:15; pri:0),      //nolang
               (nom:'BINY';     seq:16; inf:16; pri:0),      //nolang
               (nom:'CRVAL1';   seq:17; inf:17; pri:0),      //nolang
               (nom:'CRVAL2';   seq:18; inf:18; pri:0),      //nolang
               (nom:'FILTERS';  seq:19; inf:19; pri:0),      //nolang
               (nom:'MIRRORX';  seq:20; inf:20; pri:2),      //nolang
               (nom:'MIRORX';   seq:21; inf:20; pri:3),      //nolang
               (nom:'MIRRORY';  seq:22; inf:21; pri:2),      //nolang
               (nom:'MIRORY';   seq:23; inf:21; pri:3),      //nolang
               (nom:'FOCLEN';   seq:24; inf:22; pri:0),      //nolang
               (nom:'WINDOW';   seq:25; inf:0 ; pri:0),      //nolang
               (nom:'DATAMAX';  seq:26; inf:23; pri:0),      //nolang
               (nom:'DATAMIN';  seq:27; inf:24; pri:0),      //nolang
               (nom:'PLATE';    seq:28; inf:0 ; pri:0),      //nolang
               (nom:'COMMENT';  seq:29; inf:0 ; pri:0),      //nolang
               (nom:'RA';       seq:30; inf:17; pri:2),      //nolang
               (nom:'DEC';      seq:31; inf:18; pri:2),      //nolang
               (nom:'MIPS-HI';  seq:32; inf:23; pri:2),      //nolang
               (nom:'MIPS-LO';  seq:33; inf:24; pri:2),      //nolang
               (nom:'THRESH';   seq:34; inf:23; pri:3),      //nolang
               (nom:'THRESL';   seq:35; inf:24; pri:3),      //nolang
               (nom:'MIPS-X1';  seq:36; inf:25; pri:2),      //nolang
               (nom:'MIPS-Y1';  seq:37; inf:26; pri:2),      //nolang
               (nom:'MIPS-X2';  seq:38; inf:27; pri:2),      //nolang
               (nom:'MIPS-Y2';  seq:38; inf:28; pri:2),      //nolang
               (nom:'X1';       seq:40; inf:25; pri:0),      //nolang
               (nom:'Y1';       seq:41; inf:26; pri:0),      //nolang
               (nom:'X2';       seq:42; inf:27; pri:0),      //nolang
               (nom:'Y2';       seq:43; inf:28; pri:0),      //nolang
               (nom:'MIPS-BIX'; seq:44; inf:15; pri:2),      //nolang
               (nom:'MIPS-BIY'; seq:45; inf:16; pri:2),      //nolang
               (nom:'FOCAL';    seq:46; inf:22; pri:2),      //nolang
               (nom:'TIME-OBS'; seq:47; inf:33; pri:3),      //nolang
               (nom:'DIAMETER'; seq:48; inf:29; pri:0),      //nolang
               (nom:'TEMP';     seq:49; inf:30; pri:0),      //nolang
               (nom:'ORIENT';   seq:50; inf:31; pri:2),      //nolang
               (nom:'SEEING';   seq:51; inf:32; pri:0),      //nolang
               (nom:'UT';       seq:52; inf:33; pri:2),      //nolang
               (nom:'CROTA2';   seq:53; inf:31; pri:0),      //nolang
               (nom:'XPIXELSZ'; seq:54; inf:13; pri:3),      //nolang
               (nom:'YPIXELSZ'; seq:55; inf:14; pri:3),      //nolang
               (nom:'AMDX1';    seq:56; inf:22; pri:3),      //nolang
               (nom:'SUBSAMP';  seq:57; inf:13; pri:3),      //nolang
               (nom:'CDELT1';   seq:58; inf:13; pri:4),      //nolang
               (nom:'CDELT2';   seq:59; inf:14; pri:4),      //nolang
               (nom:'OBJCTRA';  seq:60; inf:17; pri:9),      //nolang
               (nom:'OBJCTDEC'; seq:61; inf:18; pri:9),      //nolang
               (nom:'GUIDERMS'; seq:62; inf:34; pri:0),      //nolang
               (nom:'OBSERVAT'; seq:63; inf:35; pri:0),      //nolang
               (nom:'FOCALLEN'; seq:64; inf:22; pri:4),      //nolang
               (nom:'APTDIA';   seq:65; inf:29; pri:1),      //nolang
               (nom:'XPIXSZ';   seq:66; inf:13; pri:5),      //nolang
               (nom:'YPIXSZ';   seq:67; inf:14; pri:5),      //nolang
               (nom:'CCD-TEMP'; seq:68; inf:30; pri:1)       //nolang
                                                     );
type  Tfitspriority = array[0..fitsnuminf] of byte;

type TConstellation = record
  abb:string;
  nom:string;
  ra:double;
  dec:double;
end;


const
TConst_matrix:array[1..88] of TConstellation =
(
(abb:'AND'; nom: 'Andromeda';    RA:1; DEC:40),                 //nolang
(abb:'ANT'; nom: 'Antlia'; RA: 10; DEC: -35),                   //nolang
(abb:'APS'; nom: 'Apodis'; RA: 16; DEC: -75),                   //nolang
(abb:'AQR'; nom: 'Aquarius'; RA: 23; DEC: -15),                 //nolang
(abb:'AQL'; nom: 'Aquila';    RA: 20; DEC: 5 ),                 //nolang
(abb:'ARA'; nom: 'Ara';    RA: 17; DEC: -55),                   //nolang
(abb:'ARI'; nom: 'Aries';    RA: 3; DEC: 20 ),                  //nolang
(abb:'AUR'; nom: 'Auriga';    RA: 6; DEC: 40  ),                //nolang
(abb:'BOO'; nom: 'Bootes';    RA: 15; DEC: 30 ),                //nolang
(abb:'CAE'; nom: 'Caelum';    RA: 5; DEC: -40 ),                //nolang
(abb:'CAM'; nom: 'Camelopardalis';    RA: 6; DEC: 70),          //nolang
(abb:'CNC'; nom: 'Cancri';    RA: 9; DEC: 20),                  //nolang
(abb:'CVN'; nom: 'Canes Venatici';    RA: 13; DEC: 40   ),      //nolang
(abb:'CMA'; nom: 'Canis Major';    RA: 7; DEC: -20 ),           //nolang
(abb:'CMI'; nom: 'Canis Minor';    RA: 8; DEC: 5  ),            //nolang
(abb:'CAP'; nom: 'Capricornus';    RA: 21; DEC: -20  ),         //nolang
(abb:'CAR'; nom: 'Carina';    RA: 09 ; DEC:-60     ),           //nolang
(abb:'CAS'; nom: 'Cassiopeia';    RA: 1 ; DEC:60   ),           //nolang
(abb:'CEN'; nom: 'Centaurus';    RA: 13 ; DEC:-50 ),            //nolang
(abb:'CEP'; nom: 'Cepheus';    RA: 22; DEC: 70     ),           //nolang
(abb:'CET'; nom: 'Cetus';    RA: 2 ; DEC:-10    ),              //nolang
(abb:'CHA'; nom: 'Chamaeleon';    RA: 11 ; DEC:-80 ),           //nolang
(abb:'CIR'; nom: 'Circinus';    RA: 15 ; DEC:-60 ),             //nolang
(abb:'COL'; nom: 'Columba';    RA: 6 -35   ),                   //nolang
(abb:'COM'; nom: 'Coma Berenices';    RA: 13 ; DEC:20 ),        //nolang
(abb:'CRA'; nom: 'Corona Austrina';    RA: 19 ; DEC:-40),       //nolang
(abb:'CRB'; nom: 'Corona Borealis';    RA: 16 ; DEC:30  ),      //nolang
(abb:'CRV'; nom: 'Corvus';    RA: 12; DEC: -20    ),            //nolang
(abb:'CRT'; nom: 'Crater';    RA: 11 ; DEC:-15    ),            //nolang
(abb:'CRU'; nom: 'Crux';    RA: 12 ; DEC:-60    ),              //nolang
(abb:'CYG'; nom: 'Cygnus';    RA: 21 ; DEC:40   ),              //nolang
(abb:'DEL'; nom: 'Delphinus';    RA: 21 ; DEC:10  ),            //nolang
(abb:'DOR'; nom: 'Dorado';    RA: 5 ; DEC:-65  ),               //nolang
(abb:'DRA'; nom: 'Draco';    RA: 17 ; DEC:65   ),               //nolang
(abb:'EQU'; nom: 'Equuleus';    RA: 21 ; DEC:10 ),              //nolang
(abb:'ERI'; nom: 'Eridanus';    RA: 3 ; DEC:-20 ),              //nolang
(abb:'FOR'; nom: 'Fornax';    RA: 3 ; DEC:-30  ),               //nolang
(abb:'GEM'; nom: 'Gemini';    RA: 7 ; DEC:20  ),                //nolang
(abb:'GRU'; nom: 'Grus';    RA: 22 ; DEC:-45    ),              //nolang
(abb:'HER'; nom: 'Hercules';    RA: 17 ; DEC:30  ),             //nolang
(abb:'HOR'; nom: 'Horologium';    RA: 3 ; DEC:-60   ),          //nolang
(abb:'HYA'; nom: 'Hydra';    RA: 10 ; DEC:-20 ),                //nolang
(abb:'HYI'; nom: 'Hydrus';    RA: 2 ; DEC:-75 ),                //nolang
(abb:'IND'; nom: 'Indus';    RA: 21 ; DEC:-55 ),                //nolang
(abb:'LAC'; nom: 'Lacerta';    RA: 22; DEC: 45 ),               //nolang
(abb:'LEO'; nom: 'Leo';    RA: 11 ; DEC:15  ),                  //nolang
(abb:'LMI'; nom: 'Leo Minor';    RA: 10; DEC: 35 ),             //nolang
(abb:'LEP'; nom: 'Lepus';    RA: 6 ; DEC:-20 ),                 //nolang
(abb:'LIB'; nom: 'Libra';    RA: 15 ; DEC:-15 ),                //nolang
(abb:'LUP'; nom: 'Lupus';    RA: 15 ; DEC:-45 ),                //nolang
(abb:'LYN'; nom: 'Lynx';    RA: 8 ; DEC:45  ),                  //nolang
(abb:'LYR'; nom: 'Lyra';    RA: 19; DEC: 40 ),                  //nolang
(abb:'MEN'; nom: 'Mensa';    RA: 5 ; DEC:-80 ),                 //nolang
(abb:'MIC'; nom: 'Microscopium';    RA: 21 ; DEC:-35 ),         //nolang
(abb:'MON'; nom: 'Monoceros';    RA: 7 ; DEC:-5 ),              //nolang
(abb:'MUS'; nom: 'Musca';    RA: 12 ; DEC:-70 ),                //nolang
(abb:'NOR'; nom: 'Norma';    RA: 16; DEC: -50 ),                //nolang
(abb:'OCT'; nom: 'Octans';    RA: 22 ; DEC:-85 ),               //nolang
(abb:'OPH'; nom: 'Ophiuchus';    RA: 17 ; DEC:0 ),              //nolang
(abb:'ORI'; nom: 'Orion';    RA: 5 ; DEC:5    ),                //nolang
(abb:'PAV'; nom: 'Pavo';    RA: 20 ; DEC:-65 ),                 //nolang
(abb:'PEG'; nom: 'Pegasus';    RA: 22 ; DEC:20),                //nolang
(abb:'PER'; nom: 'Perseus';    RA: 3 ; DEC:45 ),                //nolang
(abb:'PHE'; nom: 'Phoenix';    RA: 1 ; DEC:-50),                //nolang
(abb:'PIC'; nom: 'Pictor';    RA: 6 ; DEC:-55 ),                //nolang
(abb:'PSC'; nom: 'Pisces';    RA: 1 ; DEC:15),                  //nolang
(abb:'PSA'; nom: 'Piscis Austrinus';    RA: 22; DEC: -30),      //nolang
(abb:'PUP'; nom: 'Puppis';    RA: 8 ; DEC:-40),                 //nolang
(abb:'PYX'; nom: 'Pyxis';    RA: 9 ; DEC:-30 ),                 //nolang
(abb:'RET'; nom: 'Reticulum';    RA: 4 ; DEC:-60 ),             //nolang
(abb:'SGE'; nom: 'Sagitta';    RA: 20 ; DEC:10 ),               //nolang
(abb:'SGR'; nom: 'Sagittarius';    RA: 19 ; DEC:-25),           //nolang
(abb:'SCO'; nom: 'Scorpius';    RA: 17 ; DEC:-40 ),             //nolang
(abb:'SCL'; nom: 'Sculptor';    RA: 24 ; DEC:-30 ),             //nolang
(abb:'SCT'; nom: 'Scutum';    RA: 19 ; DEC:-10  ),              //nolang
(abb:'SER'; nom: 'Serpens';    RA: 17; DEC: 0  ),               //nolang
(abb:'SEX'; nom: 'Sextans';    RA: 10 ; DEC:0  ),               //nolang
(abb:'TAU'; nom: 'Taurus';    RA: 4 ; DEC:15   ),               //nolang
(abb:'TEL'; nom: 'Telescopium';    RA: 19 ; DEC:-50  ),         //nolang
(abb:'TRI'; nom: 'Triangulum';    RA: 2 ; DEC:30 ),             //nolang
(abb:'TRA'; nom: 'Triangulum Australe';    RA: 16 ; DEC:-65 ),  //nolang
(abb:'TUC'; nom: 'Tucana';    RA: 24 ; DEC:-65    ),            //nolang
(abb:'UMA'; nom: 'Ursa Major';    RA: 11 ; DEC:50 ),            //nolang
(abb:'UMI'; nom: 'Ursa Minor';    RA: 15; DEC: 70 ),            //nolang
(abb:'VEL'; nom: 'Vela';    RA: 9 ; DEC:-50    ),               //nolang
(abb:'VIR'; nom: 'Virgo';    RA: 13 ; DEC:0    ),               //nolang
(abb:'VOL'; nom: 'Volans';    RA: 8 ; DEC:-70  ),               //nolang
(abb:'VUL'; nom: 'Vulpecula';    RA: 20 ; DEC:25 )              //nolang
);
type Tconstbound = record
     mat:array[1..3] of double;
     ind:shortstring;
end;

const
myrec : array[1..357] of Tconstbound = (
(MAT:(0,24,88); IND:'UMi'),                                     //nolang
(MAT:(8,14.5,86.5); IND:'UMi'),                                 //nolang
(MAT:(21,23,86.1667); IND:'UMi'),                               //nolang
(MAT:(18,21,86); IND:'UMi'),                                    //nolang
(MAT:(0,8,85); IND:'Cep'),                                      //nolang
(MAT:(9.1667,10.6667,82); IND:'Cam'),                           //nolang
(MAT:(0,5,80); IND:'Cep'),                                      //nolang
(MAT:(10.6667,14.5,80); IND:'Cam'),                             //nolang
(MAT:(17.5,18,80); IND:'UMi'),                                  //nolang
(MAT:(20.1667,21,80); IND:'Dra'),                               //nolang
(MAT:(0,3.5083,77); IND:'Cep'),                                 //nolang
(MAT:(11.5,13.5833,77); IND:'Cam'),                             //nolang
(MAT:(16.5333,17.5,75); IND:'UMi'),                             //nolang
(MAT:(20.1667,20.6667,75); IND:('Cep')),                        //nolang
(MAT:(7.9667,9.1667,73.5); IND:('Cam')),                        //nolang
(MAT:(9.1667,11.3333,73.5); IND:('Dra')),                       //nolang
(MAT:(13,16.5333,70); IND:('UMi')),                             //nolang
(MAT:(3.1,3.4167,68); IND:('Cas')),                             //nolang
(MAT:(20.4167,20.6667,67); IND:('Dra')),                        //nolang
(MAT:(11.3333,12,66.5); IND:('Dra')),                           //nolang
(MAT:(0,0.3333,66); IND:('Cep')),                               //nolang
(MAT:(14,15.6667,66); IND:('UMi')),                             //nolang
(MAT:(23.5833,24,66); IND:('Cep')),                             //nolang
(MAT:(12,13.5,64); IND:('Dra')),                                //nolang
(MAT:(13.5,14.4167,63); IND:('Dra')),                           //nolang
(MAT:(23.1667,23.5833,63); IND:('Cep')),                        //nolang
(MAT:(6.1,7,62); IND:('Cam')),                                  //nolang
(MAT:(20,20.4167,61.5); IND:('Dra')),                           //nolang
(MAT:(20.5367,20.6,60.9167); IND:('Cep')),                      //nolang
(MAT:(7,7.9667,60); IND:('Cam')),                               //nolang
(MAT:(7.9667,8.4167,60); IND:('UMa')),                          //nolang
(MAT:(19.7667,20,59.5); IND:('Dra')),                           //nolang
(MAT:(20,20.5367,59.5); IND:('Cep')),                           //nolang
(MAT:(22.8667,23.1667,59.0833); IND:('Cep')),                   //nolang
(MAT:(0,2.4333,58.5); IND:('Cas')),                             //nolang
(MAT:(19.4167,19.7667,58); IND:('Dra')),                        //nolang
(MAT:(1.7,1.9083,57.5); IND:('Cas')),                           //nolang
(MAT:(2.4333,3.1,57); IND:('Cas')),                             //nolang
(MAT:(3.1,3.1667,57); IND:('Cam')),                             //nolang
(MAT:(22.3167,22.8667,56.25); IND:('Cep')),                     //nolang
(MAT:(5,6.1,56); IND:('Cam')),                                  //nolang
(MAT:(14.0333,14.4167,55.5); IND:('UMa')),                      //nolang
(MAT:(14.4167,19.4167,55.5); IND:('Dra')),                      //nolang
(MAT:(3.1667,3.3333,55); IND:('Cam')),                          //nolang
(MAT:(22.1333,22.3167,55); IND:('Cep')),                        //nolang
(MAT:(20.6,21.9667,54.8333); IND:('Cep')),                      //nolang
(MAT:(0,1.7,54); IND:('Cas')),                                  //nolang
(MAT:(6.1,6.5,54); IND:('Lyn')),                                //nolang
(MAT:(12.0833,13.5,53); IND:('UMa')),                           //nolang
(MAT:(15.25,15.75,53); IND:('Dra')),                            //nolang
(MAT:(21.9667,22.1333,52.75); IND:('Cep')),                     //nolang
(MAT:(3.3333,5,52.5); IND:('Cam')),                             //nolang
(MAT:(22.8667,23.3333,52.5); IND:('Cas')),                      //nolang
(MAT:(15.75,17,51.5); IND:('Dra')),                             //nolang
(MAT:(2.0417,2.5167,50.5); IND:('Per')),                        //nolang
(MAT:(17,18.2333,50.5); IND:('Dra')),                           //nolang
(MAT:(0,1.3667,50); IND:('Cas')),                               //nolang
(MAT:(1.3667,1.6667,50); IND:('Per')),                          //nolang
(MAT:(6.5,6.8,50); IND:('Lyn')),                                //nolang
(MAT:(23.3333,24,50); IND:('Cas')),                             //nolang
(MAT:(13.5,14.0333,48.5); IND:('UMa')),                         //nolang
(MAT:(0,1.1167,48); IND:('Cas')),                               //nolang
(MAT:(23.5833,24,48); IND:('Cas')),                             //nolang
(MAT:(18.175,18.2333,47.5); IND:('Her')),                       //nolang
(MAT:(18.2333,19.0833,47.5); IND:('Dra')),                      //nolang
(MAT:(19.0833,19.1667,47.5); IND:('Cyg')),                      //nolang
(MAT:(1.6667,2.0417,47); IND:('Per')),                          //nolang
(MAT:(8.4167,9.1667,47); IND:('UMa')),                          //nolang
(MAT:(0.1667,0.8667,46); IND:('Cas')),                          //nolang
(MAT:(12,12.0833,45); IND:('UMa')),                             //nolang
(MAT:(6.8,7.3667,44.5); IND:('Lyn')),                           //nolang
(MAT:(21.9083,21.9667,44); IND:('Cyg')),                        //nolang
(MAT:(21.875,21.9083,43.75); IND:('Cyg')),                      //nolang
(MAT:(19.1667,19.4,43.5); IND:('Cyg')),                         //nolang
(MAT:(9.1667,10.1667,42); IND:('UMa')),                         //nolang
(MAT:(10.1667,10.7833,40); IND:('UMa')),                        //nolang
(MAT:(15.4333,15.75,40); IND:('Boo')),                          //nolang
(MAT:(15.75,16.3333,40); IND:('Her')),                          //nolang
(MAT:(9.25,9.5833,39.75); IND:('Lyn')),                         //nolang
(MAT:(0,2.5167,36.75); IND:('And')),                            //nolang
(MAT:(2.5167,2.5667,36.75); IND:('Per')),                       //nolang
(MAT:(19.3583,19.4,36.5); IND:('Lyr')),                         //nolang
(MAT:(4.5,4.6917,36); IND:('Per')),                             //nolang
(MAT:(21.7333,21.875,36); IND:('Cyg')),                         //nolang
(MAT:(21.875,22,36); IND:('Lac')),                              //nolang
(MAT:(6.5333,7.3667,35.5); IND:('Aur')),                        //nolang
(MAT:(7.3667,7.75,35.5); IND:('Lyn')),                          //nolang
(MAT:(0,2,35); IND:('And')),                                    //nolang
(MAT:(22,22.8167,35); IND:('Lac')),                             //nolang
(MAT:(22.8167,22.8667,34.5); IND:('Lac')),                      //nolang
(MAT:(22.8667,23.5,34.5); IND:('And')),                         //nolang
(MAT:(2.5667,2.7167,34); IND:('Per')),                          //nolang
(MAT:(10.7833,11,34); IND:('UMa')),                             //nolang
(MAT:(12,12.3333,34); IND:('CVn')),                             //nolang
(MAT:(7.75,9.25,33.5); IND:('Lyn')),                            //nolang
(MAT:(9.25,9.8833,33.5); IND:('LMi')),                          //nolang
(MAT:(0.7167,1.4083,33); IND:('And')),                          //nolang
(MAT:(15.1833,15.4333,33); IND:('Boo')),                        //nolang
(MAT:(23.5,23.75,32.0833); IND:('And')),                        //nolang
(MAT:(12.3333,13.25,32); IND:('CVn')),                          //nolang
(MAT:(23.75,24,31.3333); IND:('And')),                          //nolang
(MAT:(13.9583,14.0333,30.75); IND:('CVn')),                     //nolang
(MAT:(2.4167,2.7167,30.6667); IND:('Tri')),                     //nolang
(MAT:(2.7167,4.5,30.6667); IND:('Per')),                        //nolang
(MAT:(4.5,4.75,30); IND:('Aur')),                               //nolang
(MAT:(18.175,19.3583,30); IND:('Lyr')),                         //nolang
(MAT:(11,12,29); IND:('UMa')),                                  //nolang
(MAT:(19.6667,20.9167,29); IND:('Cyg')),                        //nolang
(MAT:(4.75,5.8833,28.5); IND:('Aur')),                          //nolang
(MAT:(9.8833,10.5,28.5); IND:('LMi')),                          //nolang
(MAT:(13.25,13.9583,28.5); IND:('CVn')),                        //nolang
(MAT:(0,0.0667,28); IND:('And')),                               //nolang
(MAT:(1.4083,1.6667,28); IND:('Tri')),                          //nolang
(MAT:(5.8833,6.5333,28); IND:('Aur')),                          //nolang
(MAT:(7.8833,8,28); IND:('Gem')),                               //nolang
(MAT:(20.9167,21.7333,28); IND:('Cyg')),                        //nolang
(MAT:(19.2583,19.6667,27.5); IND:('Cyg')),                      //nolang
(MAT:(1.9167,2.4167,27.25); IND:('Tri')),                       //nolang
(MAT:(16.1667,16.3333,27); IND:('CrB')),                        //nolang
(MAT:(15.0833,15.1833,26); IND:('Boo')),                        //nolang
(MAT:(15.1833,16.1667,26); IND:('CrB')),                        //nolang
(MAT:(18.3667,18.8667,26); IND:('Lyr')),                        //nolang
(MAT:(10.75,11,25.5); IND:('LMi')),                             //nolang
(MAT:(18.8667,19.2583,25.5); IND:('Lyr')),                      //nolang
(MAT:(1.6667,1.9167,25); IND:('Tri')),                          //nolang
(MAT:(0.7167,0.85,23.75); IND:('Psc')),                         //nolang
(MAT:(10.5,10.75,23.5); IND:('LMi')),                           //nolang
(MAT:(21.25,21.4167,23.5); IND:('Vul')),                        //nolang
(MAT:(5.7,5.8833,22.8333); IND:('Tau')),                        //nolang
(MAT:(0.0667,0.1417,22); IND:('And')),                          //nolang
(MAT:(15.9167,16.0333,22); IND:('Ser')),                        //nolang
(MAT:(5.8833,6.2167,21.5); IND:('Gem')),                        //nolang
(MAT:(19.8333,20.25,21.25); IND:('Vul')),                       //nolang
(MAT:(18.8667,19.25,21.0833); IND:('Vul')),                     //nolang
(MAT:(0.1417,0.85,21); IND:('And')),                            //nolang
(MAT:(20.25,20.5667,20.5); IND:('Vul')),                        //nolang
(MAT:(7.8083,7.8833,20); IND:('Gem')),                          //nolang
(MAT:(20.5667,21.25,19.5); IND:('Vul')),                        //nolang
(MAT:(19.25,19.8333,19.1667); IND:('Vul')),                     //nolang
(MAT:(3.2833,3.3667,19); IND:('Ari')),                          //nolang
(MAT:(18.8667,19,18.5); IND:('Sge')),                           //nolang
(MAT:(5.7,5.7667,18); IND:('Ori')),                             //nolang
(MAT:(6.2167,6.3083,17.5); IND:('Gem')),                        //nolang
(MAT:(19,19.8333,16.1667); IND:('Sge')),                        //nolang
(MAT:(4.9667,5.3333,16); IND:('Tau')),                          //nolang
(MAT:(15.9167,16.0833,16); IND:('Her')),                        //nolang
(MAT:(19.8333,20.25,15.75); IND:('Sge')),                       //nolang
(MAT:(4.6167,4.9667,15.5); IND:('Tau')),                        //nolang
(MAT:(5.3333,5.6,15.5); IND:('Tau')),                           //nolang
(MAT:(12.8333,13.5,15); IND:('Com')),                           //nolang
(MAT:(17.25,18.25,14.3333); IND:('Her')),                       //nolang
(MAT:(11.8667,12.8333,14); IND:('Com')),                        //nolang
(MAT:(7.5,7.8083,13.5); IND:('Gem')),                           //nolang
(MAT:(16.75,17.25,12.8333); IND:('Her')),                       //nolang
(MAT:(0,0.1417,12.5); IND:('Peg')),                             //nolang
(MAT:(5.6,5.7667,12.5); IND:('Tau')),                           //nolang
(MAT:(7,7.5,12.5); IND:('Gem')),                                //nolang
(MAT:(21.1167,21.3333,12.5); IND:('Peg')),                      //nolang
(MAT:(6.3083,6.9333,12); IND:('Gem')),                          //nolang
(MAT:(18.25,18.8667,12); IND:('Her')),                          //nolang
(MAT:(20.875,21.05,11.8333); IND:('Del')),                      //nolang
(MAT:(21.05,21.1167,11.8333); IND:('Peg')),                     //nolang
(MAT:(11.5167,11.8667,11); IND:('Leo')),                        //nolang
(MAT:(6.2417,6.3083,10); IND:('Ori')),                          //nolang
(MAT:(6.9333,7,10); IND:('Gem')),                               //nolang
(MAT:(7.8083,7.925,10); IND:('Cnc')),                           //nolang
(MAT:(23.8333,24,10); IND:('Peg')),                             //nolang
(MAT:(1.6667,3.2833,9.9167); IND:('Ari')),                      //nolang
(MAT:(20.1417,20.3,8.5); IND:('Del')),                          //nolang
(MAT:(13.5,15.0833,8); IND:('Boo')),                            //nolang
(MAT:(22.75,23.8333,7.5); IND:('Peg')),                         //nolang
(MAT:(7.925,9.25,7); IND:('Cnc')),                              //nolang
(MAT:(9.25,10.75,7); IND:('Leo')),                              //nolang
(MAT:(18.25,18.6622,6.25); IND:('Oph')),                        //nolang
(MAT:(18.6622,18.8667,6.25); IND:('Aql')),                      //nolang
(MAT:(20.8333,20.875,6); IND:('Del')),                          //nolang
(MAT:(7,7.0167,5.5); IND:('CMi')),                              //nolang
(MAT:(18.25,18.425,4.5); IND:('Ser')),                          //nolang
(MAT:(16.0833,16.75,4); IND:('Her')),                           //nolang
(MAT:(18.25,18.425,3); IND:('Oph')),                            //nolang
(MAT:(21.4667,21.6667,2.75); IND:('Peg')),                      //nolang
(MAT:(0,2,2); IND:('Psc')),                                     //nolang
(MAT:(18.5833,18.8667,2); IND:('Ser')),                         //nolang
(MAT:(20.3,20.8333,2); IND:('Del')),                            //nolang
(MAT:(20.8333,21.3333,2); IND:('Equ')),                         //nolang
(MAT:(21.3333,21.4667,2); IND:('Peg')),                         //nolang
(MAT:(22,22.75,2); IND:('Peg')),                                //nolang
(MAT:(21.6667,22,1.75); IND:('Peg')),                           //nolang
(MAT:(7.0167,7.2,1.5); IND:('CMi')),                            //nolang
(MAT:(3.5833,4.6167,0); IND:('Tau')),                           //nolang
(MAT:(4.6167,4.6667,0); IND:('Ori')),                           //nolang
(MAT:(7.2,8.0833,0); IND:('CMi')),                              //nolang
(MAT:(14.6667,15.0833,0); IND:('Vir')),                         //nolang
(MAT:(17.8333,18.25,0); IND:('Oph')),                           //nolang
(MAT:(2.65,3.2833,-1.75); IND:('Cet')),                         //nolang
(MAT:(3.2833,3.5833,-1.75); IND:('Tau')),                       //nolang
(MAT:(15.0833,16.2667,-3.25); IND:('Ser')),                     //nolang
(MAT:(4.6667,5.0833,-4); IND:('Ori')),                          //nolang
(MAT:(5.8333,6.2417,-4); IND:('Ori')),                          //nolang
(MAT:(17.8333,17.9667,-4); IND:('Ser')),                        //nolang
(MAT:(18.25,18.5833,-4); IND:('Ser')),                          //nolang
(MAT:(18.5833,18.8667,-4); IND:('Aql')),                        //nolang
(MAT:(22.75,23.8333,-4); IND:('Psc')),                          //nolang
(MAT:(10.75,11.5167,-6); IND:('Leo')),                          //nolang
(MAT:(11.5167,11.8333,-6); IND:('Vir')),                        //nolang
(MAT:(0,0.3333,-7); IND:('Psc')),                               //nolang
(MAT:(23.8333,24,-7); IND:('Psc')),                             //nolang
(MAT:(14.25,14.6667,-8); IND:('Vir')),                          //nolang
(MAT:(15.9167,16.2667,-8); IND:('Oph')),                        //nolang
(MAT:(20,20.5333,-9); IND:('Aql')),                             //nolang
(MAT:(21.3333,21.8667,-9); IND:('Aqr')),                        //nolang
(MAT:(17.1667,17.9667,-10); IND:('Oph')),                       //nolang
(MAT:(5.8333,8.0833,-11); IND:('Mon')),                         //nolang
(MAT:(4.9167,5.0833,-11); IND:('Eri')),                         //nolang
(MAT:(5.0833,5.8333,-11); IND:('Ori')),                         //nolang
(MAT:(8.0833,8.3667,-11); IND:('Hya')),                         //nolang
(MAT:(9.5833,10.75,-11); IND:('Sex')),                          //nolang
(MAT:(11.8333,12.8333,-11); IND:('Vir')),                       //nolang
(MAT:(17.5833,17.6667,-11.6667); IND:('Oph')),                  //nolang
(MAT:(18.8667,20,-12.0333); IND:('Aql')),                       //nolang
(MAT:(4.8333,4.9167,-14.5); IND:('Eri')),                       //nolang
(MAT:(20.5333,21.3333,-15); IND:('Aqr')),                       //nolang
(MAT:(17.1667,18.25,-16); IND:('Ser')),                         //nolang
(MAT:(18.25,18.8667,-16); IND:('Sct')),                         //nolang
(MAT:(8.3667,8.5833,-17); IND:('Hya')),                         //nolang
(MAT:(16.2667,16.375,-18.25); IND:('Oph')),                     //nolang
(MAT:(8.5833,9.0833,-19); IND:('Hya')),                         //nolang
(MAT:(10.75,10.8333,-19); IND:('Crt')),                         //nolang
(MAT:(16.2667,16.375,-19.25); IND:('Oph')),                     //nolang
(MAT:(15.6667,15.9167,-20); IND:('Lib')),                       //nolang
(MAT:(12.5833,12.8333,-22); IND:('Crv')),                       //nolang
(MAT:(12.8333,14.25,-22); IND:('Vir')),                         //nolang
(MAT:(9.0833,9.75,-24); IND:('Hya')),                           //nolang
(MAT:(1.6667,2.65,-24.3833); IND:('Cet')),                      //nolang
(MAT:(2.65,3.75,-24.3833); IND:('Eri')),                        //nolang
(MAT:(10.8333,11.8333,-24.5); IND:('Crt')),                     //nolang
(MAT:(11.8333,12.5833,-24.5); IND:('Crv')),                     //nolang
(MAT:(14.25,14.9167,-24.5); IND:('Lib')),                       //nolang
(MAT:(16.2667,16.75,-24.5833); IND:('Oph')),                    //nolang
(MAT:(0,1.6667,-25.5); IND:('Cet')),                            //nolang
(MAT:(21.3333,21.8667,-25.5); IND:('Cap')),                     //nolang
(MAT:(21.8667,23.8333,-25.5); IND:('Aqr')),                     //nolang
(MAT:(23.8333,24,-25.5); IND:('Cet')),                          //nolang
(MAT:(9.75,10.25,-26.5); IND:('Hya')),                          //nolang
(MAT:(4.7,4.8333,-27.25); IND:('Eri')),                         //nolang
(MAT:(4.8333,6.1167,-27.25); IND:('Lep')),                      //nolang
(MAT:(20,21.3333,-28); IND:('Cap')),                            //nolang
(MAT:(10.25,10.5833,-29.1667); IND:('Hya')),                    //nolang
(MAT:(12.5833,14.9167,-29.5); IND:('Hya')),                     //nolang
(MAT:(14.9167,15.6667,-29.5); IND:('Lib')),                     //nolang
(MAT:(15.6667,16,-29.5); IND:('Sco')),                          //nolang
(MAT:(4.5833,4.7,-30); IND:('Eri')),                            //nolang
(MAT:(16.75,17.6,-30); IND:('Oph')),                            //nolang
(MAT:(17.6,17.8333,-30); IND:('Sgr')),                          //nolang
(MAT:(10.5833,10.8333,-31.1667); IND:('Hya')),                  //nolang
(MAT:(6.1167,7.3667,-33); IND:('CMa')),                         //nolang
(MAT:(12.25,12.5833,-33); IND:('Hya')),                         //nolang
(MAT:(10.8333,12.25,-35); IND:('Hya')),                         //nolang
(MAT:(3.5,3.75,-36); IND:('For')),                              //nolang
(MAT:(8.3667,9.3667,-36.75); IND:('Pyx')),                      //nolang
(MAT:(4.2667,4.5833,-37); IND:('Eri')),                         //nolang
(MAT:(17.8333,19.1667,-37); IND:('Sgr')),                       //nolang
(MAT:(21.3333,23,-37); IND:('PsA')),                            //nolang
(MAT:(23,23.3333,-37); IND:('Scl')),                            //nolang
(MAT:(3,3.5,-39.5833); IND:('For')),                            //nolang
(MAT:(9.3667,11,-39.75); IND:('Ant')),                          //nolang
(MAT:(0,1.6667,-40); IND:('Scl')),                              //nolang
(MAT:(1.6667,3,-40); IND:('For')),                              //nolang
(MAT:(3.8667,4.2667,-40); IND:('Eri')),                         //nolang
(MAT:(23.3333,24,-40); IND:('Scl')),                            //nolang
(MAT:(14.1667,14.9167,-42); IND:('Cen')),                       //nolang
(MAT:(15.6667,16,-42); IND:('Lup')),                            //nolang
(MAT:(16,16.4208,-42); IND:('Sco')),                            //nolang
(MAT:(4.8333,5,-43); IND:('Cae')),                              //nolang
(MAT:(5,6.5833,-43); IND:('Col')),                              //nolang
(MAT:(8,8.3667,-43); IND:('Pup')),                              //nolang
(MAT:(3.4167,3.8667,-44); IND:('Eri')),                         //nolang
(MAT:(16.4208,17.8333,-45.5); IND:('Sco')),                     //nolang
(MAT:(17.8333,19.1667,-45.5); IND:('CrA')),                     //nolang
(MAT:(19.1667,20.3333,-45.5); IND:('Sgr')),                     //nolang
(MAT:(20.3333,21.3333,-45.5); IND:('Mic')),                     //nolang
(MAT:(3,3.4167,-46); IND:('Eri')),                              //nolang
(MAT:(4.5,4.8333,-46.5); IND:('Cae')),                          //nolang
(MAT:(15.3333,15.6667,-48); IND:('Lup')),                       //nolang
(MAT:(0,2.3333,-48.1667); IND:('Phe')),                         //nolang
(MAT:(2.6667,3,-49); IND:('Eri')),                              //nolang
(MAT:(4.0833,4.2667,-49); IND:('Hor')),                         //nolang
(MAT:(4.2667,4.5,-49); IND:('Cae')),                            //nolang
(MAT:(21.3333,22,-50); IND:('Gru')),                            //nolang
(MAT:(6,8,-50.75); IND:('Pup')),                                //nolang
(MAT:(8,8.1667,-50.75); IND:('Vel')),                           //nolang
(MAT:(2.4167,2.6667,-51); IND:('Eri')),                         //nolang
(MAT:(3.8333,4.0833,-51); IND:('Hor')),                         //nolang
(MAT:(0,1.8333,-51.5); IND:('Phe')),                            //nolang
(MAT:(6,6.1667,-52.5); IND:('Car')),                            //nolang
(MAT:(8.1667,8.45,-53); IND:('Vel')),                           //nolang
(MAT:(3.5,3.8333,-53.1667); IND:('Hor')),                       //nolang
(MAT:(3.8333,4,-53.1667); IND:('Dor')),                         //nolang
(MAT:(0,1.5833,-53.5); IND:('Phe')),                            //nolang
(MAT:(2.1667,2.4167,-54); IND:('Eri')),                         //nolang
(MAT:(4.5,5,-54); IND:('Pic')),                                 //nolang
(MAT:(15.05,15.3333,-54); IND:('Lup')),                         //nolang
(MAT:(8.45,8.8333,-54.5); IND:('Vel')),                         //nolang
(MAT:(6.1667,6.5,-55); IND:('Car')),                            //nolang
(MAT:(11.8333,12.8333,-55); IND:('Cen')),                       //nolang
(MAT:(14.1667,15.05,-55); IND:('Lup')),                         //nolang
(MAT:(15.05,15.3333,-55); IND:('Nor')),                         //nolang
(MAT:(4,4.3333,-56.5); IND:('Dor')),                            //nolang
(MAT:(8.8333,11,-56.5); IND:('Vel')),                           //nolang
(MAT:(11,11.25,-56.5); IND:('Cen')),                            //nolang
(MAT:(17.5,18,-57); IND:('Ara')),                               //nolang
(MAT:(18,20.3333,-57); IND:('Tel')),                            //nolang
(MAT:(22,23.3333,-57); IND:('Gru')),                            //nolang
(MAT:(3.2,3.5,-57.5); IND:('Hor')),                             //nolang
(MAT:(5,5.5,-57.5); IND:('Pic')),                               //nolang
(MAT:(6.5,6.8333,-58); IND:('Car')),                            //nolang
(MAT:(0,1.3333,-58.5); IND:('Phe')),                            //nolang
(MAT:(1.3333,2.1667,-58.5); IND:('Eri')),                       //nolang
(MAT:(23.3333,24,-58.5); IND:('Phe')),                          //nolang
(MAT:(4.3333,4.5833,-59); IND:('Dor')),                         //nolang
(MAT:(15.3333,16.4208,-60); IND:('Nor')),                       //nolang
(MAT:(20.3333,21.3333,-60); IND:('Ind')),                       //nolang
(MAT:(5.5,6,-61); IND:('Pic')),                                 //nolang
(MAT:(15.1667,15.3333,-61); IND:('Cir')),                       //nolang
(MAT:(16.4208,16.5833,-61); IND:('Ara')),                       //nolang
(MAT:(14.9167,15.1667,-63.5833); IND:('Cir')),                  //nolang
(MAT:(16.5833,16.75,-63.5833); IND:('Ara')),                    //nolang
(MAT:(6,6.8333,-64); IND:('Pic')),                              //nolang
(MAT:(6.8333,9.0333,-64); IND:('Car')),                         //nolang
(MAT:(11.25,11.8333,-64); IND:('Cen')),                         //nolang
(MAT:(11.8333,12.8333,-64); IND:('Cru')),                       //nolang
(MAT:(12.8333,14.5333,-64); IND:('Cen')),                       //nolang
(MAT:(13.5,13.6667,-65); IND:('Cir')),                          //nolang
(MAT:(16.75,16.8333,-65); IND:('Ara')),                         //nolang
(MAT:(2.1667,3.2,-67.5); IND:('Hor')),                          //nolang
(MAT:(3.2,4.5833,-67.5); IND:('Ret')),                          //nolang
(MAT:(14.75,14.9167,-67.5); IND:('Cir')),                       //nolang
(MAT:(16.8333,17.5,-67.5); IND:('Ara')),                        //nolang
(MAT:(17.5,18,-67.5); IND:('Pav')),                             //nolang
(MAT:(22,23.3333,-67.5); IND:('Tuc')),                          //nolang
(MAT:(4.5833,6.5833,-70); IND:('Dor')),                         //nolang
(MAT:(13.6667,14.75,-70); IND:('Cir')),                         //nolang
(MAT:(14.75,17,-70); IND:('TrA')),                              //nolang
(MAT:(0,1.3333,-75); IND:('Tuc')),                              //nolang
(MAT:(3.5,4.5833,-75); IND:('Hyi')),                            //nolang
(MAT:(6.5833,9.0333,-75); IND:('Vol')),                         //nolang
(MAT:(9.0333,11.25,-75); IND:('Car')),                          //nolang
(MAT:(11.25,13.6667,-75); IND:('Mus')),                         //nolang
(MAT:(18,21.3333,-75); IND:('Pav')),                            //nolang
(MAT:(21.3333,23.3333,-75); IND:('Ind')),                       //nolang
(MAT:(23.3333,24,-75); IND:('Tuc')),                            //nolang
(MAT:(0.75,1.3333,-76); IND:('Tuc')),                           //nolang
(MAT:(0,3.5,-82.5); IND:('Hyi')),                               //nolang
(MAT:(7.6667,13.6667,-82.5); IND:('Cha')),                      //nolang
(MAT:(13.6667,18,-82.5); IND:('Aps')),                          //nolang
(MAT:(3.5,7.6667,-85); IND:('Men')),                            //nolang
(MAT:(0,24,-90); IND:('Oct')));                                 //nolang


const J2000=2451545.0 ;
      B1950=2433282.4235;
      B1875=2405890.5;


implementation


end.
