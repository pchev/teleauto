// UBezier unit : Bezier curves and smothing algorithm
//                Courbes de Bézier et algorithme de lissage
// Jean-Yves Queinec    j.y.q@wanadoo.fr
//  Keywords : Bezier curves
//             Smoothing algorithm with smooth factor
//             Bezier curves : split, tangent, interpolation
//             de Casteljau

Unit u_bezier;

interface
   uses windows, forms, classes, graphics, dialogs, u_lang;

    // hand made polybezier
    Procedure DrawBezier(ZZ: array of Tpoint; NB: integer; Cancan: Tcanvas;
                         Bmode: integer;     // various drawings
                         acolor1, acolor2: tcolor;     // drawing colors
                         var Blength: integer; var Brect: Trect); // results

    Function  Bcalcul(P1,C1,C2,P2: Tpoint; t: single): Tpoint;
     // smooth algorithm, algorithme de lissage
    procedure Lissage(var ZZ: Array of Tpoint; NB: integer; acoef: integer);
    procedure DeCasteljau(ZZ: array of Tpoint; NB: integer;
                          cancan: Tcanvas; L1color, L2color, L3color: tcolor;
                          curpt: integer; tt : single);
    Function TangentBezier( ZZ: array of Tpoint; NB: integer;
                            curpt: integer; tt: single): single;
    Function Nearbezier(ZZ: array of tpoint; NB : integer;
                        ax, ay: integer; tolerance: integer;
                        var acutpoint: integer; var aparam: single): boolean;
    Procedure Binterpol(Z1, Z2: array of Tpoint; NB: integer; k: single;
                        var Z3: array of Tpoint);

    // utility functions
    Function Egalpoints(pt1, pt2 : tpoint): boolean;  // test if points are equal
    Function Interpol(p1, p2 : Tpoint; p : single): Tpoint; // 2 points interpolation
    Function Arctangente(ax, ay : integer) : single;  // compute angle in radians
    Function Distance(x1, y1, x2, y2 : integer): integer;

implementation

// ** Drawbezier function replaces the API Windows Polybezier function.
//    Gives control on each curve drawing step : Example of use
//    - Draw a bezier curve with several  colors
//    - Test a click on a bezier curve. Split a curve in two
//    - Compute the bounding rectangle of a bezier curve
//    - Define a complex trajectory for a sprite (current sample)
//  n is the number of points in ZZ array.  Must be curve_points * 3 + 1
//  Bmode is the kind of function to execute
//      Bmode = 0  compute only var parameters
//      Bmode = 1  draw with lines
//      Bmode = 2  draw points (shows intervals impact on drawing
//                               and clic test accuracy)
//      Bmode = 3  gradient colored curve from acolor1 to acolor2
//                 For B-splines (NB > 4) Blength must have been already
//                 computed by a previous drawbezier call with Bmode = 0
//      Bmode = 4  a sprite sample
//  stepsdiv is used to divide the length of the bounding curve segments for
//      each simple curve, to obtain the wanted drawing accuracy. For example
//      stepsdiv = 8 or 4
//  The function DrawBezier always returns 2 "var" results
//      Brect is the Bezier curve bounding rectangle.
//      Blength is the Bezier curve length in pixels.

// ** La procédure Drawbezier remplace la fonction API Windows Polybezier
//    Donne le controle à chaque étape du tracé : Exemples d'utilisation
//    - Dessiner une courbe de Bézier avec plusieurs couleurs
//    - Tester un clic de souris sur une courbe de Bézier. Couper la courbe en 2
//    - Calculer le rectangle délimitant une courbe de Bézier (dans Brect)
//    - Calculer la longueur de la courbe de Bézier en pixels (dans Blength)
//  NB est le nombre de points du tableau ZZ, soit Points_courbe * 3 + 1

Procedure DrawBezier(ZZ: array of Tpoint; NB: integer; Cancan: Tcanvas;
                         Bmode : integer;     // various drawings
                         acolor1, acolor2: tcolor;     // drawing colors
                         var Blength: integer; var Brect: Trect); // results
var
  i : integer;
  j : integer;
  intervals : integer; // number of tt parameter steps, nombre intervalles tt
  sintervals : single; // convert tt steps, intervalle en réel
  tt       : single;   // current parametric variable of Bezier's equations 0..1
                       // paramêtre variable des équations de Bézier 0..1
  deltatt  : single;   // increment value for tt parameter, incrément de tt
  apt0, apt1 : Tpoint;  // points to draw a line, points pour tracer une ligne
  R1,G1,B1 : integer;   // separate acolor1 colors
  dR, dG, dB  : single;  // delta colors
  savelength  : single;
  curlength   : single;
begin
  if NB mod 3 <> 1 then showmessage(lang('Incorrect number of points (nx3)+1'));
  NB := NB-1;
  cancan.pen.style   := pssolid;
  cancan.pen.color   := acolor1;
  cancan.brush.color := acolor2;
  if Bmode = 2 then cancan.brush.color := acolor2;
  if Bmode = 3 then
  begin
    R1 := getRvalue(colortorgb(acolor1));   // for gradient colors computation
    G1 := getGvalue(colortorgb(acolor1));
    B1 := getBvalue(colortorgb(acolor1));
    dR := getRvalue(colortorgb(acolor2)) - R1;
    dG := getGvalue(colortorgb(acolor2)) - G1;
    dB := getBvalue(colortorgb(acolor2)) - B1;
    savelength := Blength;
    if savelength < 8.0 then savelength := 8.0;
  end;
  Brect := rect(9999, 9999, -9999, -9999); // starts with dummy bounds
  apt0.x := ZZ[0].x;
  apt0.y := ZZ[0].y;
  cancan.moveto(apt0.x, apt0.y);
  Blength := 0;
  For i := 1 to NB do  // warning : 1 to skip ZZ[0] point, Saute le point ZZ[0]
  begin
    IF i mod 3 = 0 then
    begin
      tt := 0;
      Intervals := (distance(ZZ[i-3].x, ZZ[i-3].y, ZZ[i-2].x, ZZ[i-2].y) +
                    distance(ZZ[i-2].x, ZZ[i-2].y, ZZ[i-1].x, ZZ[i-1].y) +
                    distance(ZZ[i-1].x, ZZ[i-1].y, ZZ[i].x, ZZ[i].y)) div 8;
      If intervals < 1 then intervals := 1;  //avoid divide by zero
      sintervals := intervals;
      deltatt  := 1 / sintervals;
      For j := 0 to intervals-1 do
      begin
        tt := tt+deltatt;
        apt1 := Bcalcul(ZZ[i-3], ZZ[i-2], ZZ[i-1], ZZ[i], tt);
        // if point not equal to previous point
        // si le point est différent du précédent
        if Not ((apt1.x = apt0.x) and (apt1.y = apt0.y)) then
        begin
          case Bmode of
       // 0  length and bonding rectangle always computed
          1 : begin                                // lines , lignes
                Cancan.lineto(apt1.x, apt1.y);
              end;
          2 : cancan.pixels[apt1.x, apt1.y] := acolor1;  // dots, pointillés
          3 : begin // gradient colored curve - dégradé de couleurs
                if NB = 3 then  // simple curve
                begin
                  cancan.pen.color := RGB(R1+ round(dR*tt),
                                          G1+ round(dG*tt),
                                          B1+ round(dB*tt));
                end
                else   // polybezier
                begin
                  curlength := blength;
                  curlength := curlength/savelength;
                  cancan.pen.color := RGB(R1+ round(dR*curlength),
                                          G1+ round(dG*curlength),
                                          B1+ round(dB*curlength));
                end;
                Cancan.lineto(apt1.x, apt1.y);
              end;
          4 : begin                                     // sprite
                cancan.Ellipse(apt1.x-4, apt1.y-4, apt1.x+4, apt1.y+4);
                sleep(10);     // rules speed, règle la vitesse
                // processmessages allows image1 to execute paint messages
                // sans processmessages pas d'afichage dans image1 avant la fin
                application.processmessages;
              end;
          end; // case
          // bounding rectangle
          if apt1.x < Brect.left then Brect.left := apt1.x
          else if apt1.x > Brect.right then Brect.right := apt1.x;
          if apt1.y < Brect.top then Brect.top := apt1.y
          else if apt1.y > Brect.bottom then Brect.bottom := apt1.y;
          // curve length
          blength := blength + distance(apt0.x, apt0.y, apt1.x, apt1.y);
          apt0 := apt1;   // memorize for next step
        end;
      end; // For j
    end;  // if i mod 3
  end;  // for i
end;

// Bezier Theory : The 2 Bezier's Equations   Les 2 équations de Bézier.
//----------------------------------------------------------------------
//  Parametric equations (t varying from  0.0 to 1.0)   ^  means power
//  Equations paramétriques (t variant de 0.0 à  1.0)   ^  signifie puissance

//  Bx(t) = (1-t)^3*P1x + 3*(1-t)^2*t*PC1x + 3*(1-t)*t^2 PC2x + t^3*P2x
//  By(t) = (1-t)^3*P1y + 3*(1-t)^2*t*PC1y + 3*(1-t)*t^2 PC2y + t^3*P2y

//  For each curve element 4 points are mandatory
//  4 points pbligatoires pour chaque élément de courbe
//    Start   Point      P1   (début)
//    Control Point      C1   tangent in P1
//    Control Point      C2   tangent in P2
//    End     Point      P2   (fin)
// t parameter vary from 0.0 to 1.0
// when t = 0  result is  B.x = P1.x,  By= P1.y
// when t = 1  result is  B.x = P2.x,  By= P2.y;

Function Bcalcul(P1,C1,C2,P2: Tpoint; t: single): Tpoint;
var
  t2,  //   t^2
  t3,  //   t^3
  r1, r2, r3, r4 : single;   // working storage
begin
  t2 := t * t;
  t3 := t * t2;
 // formula  (1-t)^3  = 1 - 3*t + 3*t^2 - t^3
  r1 := (1 - 3*t + 3*t2 -   t3)*P1.x;
  r2 := (    3*t - 6*t2 + 3*t3)*C1.x;
  r3 := (          3*t2 - 3*t3)*C2.x;
  r4 := (                   t3)*P2.x;
  Result.x := round(r1 + r2 + r3 + r4);
  r1 := (1 - 3*t + 3*t2 -   t3)*P1.y;
  r2 := (    3*t - 6*t2 + 3*t3)*C1.y;
  r3 := (          3*t2 - 3*t3)*C2.y;
  r4 := (                   t3)*P2.y;
  Result.y := round(r1 + r2 + r3 + r4);
end;

//---------------- Bezier Smooth algorithm
// Computes Bezier control points in ZZ point array.
// Acoef is the smoothing factor (in percent) : 0 -> straight lines
// Takes care of points 0 and NB2 when they are equal (closed curve)

// Lissage de segments par courbe de Bézier
// Calcule les points de contrôle de la courbe de Bézier dans le tableau ZZ.
// Acoef est le facteur de lissage en %.  0 -> lignes droites
// Tient compte des points 0 et NB confondus (courbe fermée)
procedure Lissage(var ZZ: Array of Tpoint; NB: integer; acoef: integer);
var
  i, j : integer;
  NB1 : integer;

  Function sym(a, b : integer): integer;  // symmmetry point #b / a , symétrie
  begin                                   // symétrie point n°b par rapport à a
    result := a - ((b-a)*acoef) div 100;
  end;

  Function mil(a, b : integer): integer;  // middle of segment points #a and #b
  begin                                   // milieu du segment points nøa et b
    result := (a+b) div 2;
  end;

 // computes a control point based on 2 points ZZ[n-1] et [ZZn+1].
 // Calcule un point de contrôle en fonction de 2 points ZZ[n-1] et [ZZn+1].
  Function ctrlpt(pt, pt1, pt2 : tpoint): tpoint;
  begin
    result.x := mil(mil(pt.x, pt1.x), mil(sym(pt.x, pt2.x), pt.x));
    result.y := mil(mil(pt.y, pt1.y), mil(sym(pt.y, pt2.y), pt.y));
  end;

begin
  if NB mod 3 <> 1 then showmessage(lang('Incorrect number of points (nx3)+1'));
  dec(NB);
  // Control points computation. Calcul des points de contrôle
  NB1 := NB div 3;
  For j := 1 to NB1-1 do  // points of the curve (edges) excluding end points
  begin                   // les points de la courbe excepté les extrémités
    i := j*3;
    ZZ[i-1] := ctrlpt(ZZ[i], ZZ[i-3], ZZ[i+3]); // prior control point précédent
    ZZ[i+1] := ctrlpt(ZZ[i], ZZ[i+3], ZZ[i-3]); // next control point  suivant
  end;
  IF egalpoints(ZZ[0], ZZ[NB]) then // closed curve, courbe fermée
  begin
    ZZ[0+1]   := ctrlpt(ZZ[0], ZZ[3], ZZ[NB-3]);
    ZZ[NB-1] := ctrlpt(ZZ[NB], ZZ[NB-3], ZZ[3]);
  end
  else
  begin                    // open curve , courbe ouverte
    ZZ[1]     := ZZ[0];    // "right" control point from #0 start point edge
                           // point de contrôle "à froite" de l'extrémité n°0
    ZZ[NB-1] := ZZ[NB];  // "left" control point from #NB2 end point
                           // point de contrôle "à gauche" de l'extrémité n°NB2
  end;
end;

// Geometrial bezier one step building (DeCasteljau)
procedure DeCasteljau(ZZ: array of Tpoint; NB: integer;
                      cancan: Tcanvas; L1color, L2color, L3color: tcolor;
                      curpt: integer; tt : single);
var
  p12, p01, p23, t1, t2, t3 : Tpoint;
begin
  if NB mod 3 <> 1 then showmessage(lang('Incorrect number of points (nx3)+1'));
  dec(NB);
  if (curpt < 0) or (curpt > NB) then exit;
  if curpt mod 3 <> 0 then exit;   // curve point only, not control point
  if (tt < 0.0) or (tt > 1.0) then exit; // parameter interval check
  with cancan do
  begin
    p01 := interpol(ZZ[curpt+1], ZZ[curpt], tt);
    p12 := interpol(ZZ[curpt+2], ZZ[curpt+1], tt);
    p23 := interpol(ZZ[curpt+3], ZZ[curpt+2], tt);
    t1  := interpol(p12, p01, tt);
    t2  := interpol(p23, p12, tt);
    pen.color := L1color;
    moveto(ZZ[curpt+1].x, ZZ[curpt+1].y);
    lineto(ZZ[curpt+2].x, ZZ[curpt+2].y);
    pen.color := L2color;
    moveto(p01.x, p01.y); lineto(p12.x, p12.y);
    moveto(p23.x, p23.y); lineto(p12.x, p12.y);
    pen.color := L3color;
    moveto(t1.x, t1.y); lineto(t2.x, t2.y);
    t3 := Bcalcul(ZZ[curpt+0], ZZ[curpt+1], ZZ[curpt+2], ZZ[curpt+3], tt);
    ellipse(p12.x-1, p12.y-1, p12.x+1, p12.y+1);
    ellipse(p01.x-1, p01.y-1, p01.x+1, p01.y+1);
    ellipse(p23.x-1, p23.y-1, p23.x+1, p23.y+1);
    ellipse(t1.x-1, t1.y-1, t1.x+1, t1.y+1);
    ellipse(t2.x-1, t2.y-1, t2.x+1, t2.y+1);
    ellipse(t3.x-2, t3.y-2, t3.x+2, t3.y+2);
  end;
end;

Function TangentBezier( ZZ: array of Tpoint; NB: integer;
                        curpt: integer; tt: single): single;
var
  p12, p01, p23, t1, t2 : Tpoint;
begin
  result := 0.0;
  if NB mod 3 <> 1 then showmessage(lang('Incorrect number of points (nx3)+1'));
  dec(NB);
  if (curpt < 0) or (curpt > NB) then exit;
  if curpt mod 3 <> 0 then exit;   // curve point only, not control point
  if (tt < 0.0) or (tt > 1.0) then exit; // parameter interval check
  p01 := interpol(ZZ[curpt+1], ZZ[curpt], tt);
  p12 := interpol(ZZ[curpt+2], ZZ[curpt+1], tt);
  p23 := interpol(ZZ[curpt+3], ZZ[curpt+2], tt);
  t1  := interpol(p12, p01, tt);
  t2  := interpol(p23, p12, tt);
  result := arctangente(t2.x - t1.x, t2.y - t1.y);
end;

// Tests is a point is near a bezier curve.
// If true - the Bezier curve point is stored into  ax and ay
//         - the Bezier curve start point number ist stored into apoint
//         - the Bezier parameter t is stored into aparam;
// Tolerance is the number of pixels to be near the curve.
// Notice : Not optimized, a binary search should be better
Function Nearbezier(ZZ: array of tpoint; NB : integer;
                    ax, ay: integer; tolerance: integer;
                    var acutpoint: integer; var aparam: single): boolean;
var
  i : integer;
  j : integer;
  aTpoint  : Tpoint;
  intervals  : integer;   { nunber of segments }
  sintervals : single;    { convert into single }
  tt       : single;      { paranetric variable for Bezier curve}
  deltatt  : single;      { incrément for tt parameter }
  apt1 : Tpoint;          { points of the curve }
  aRect : trect;
begin
  result := false;
  if NB mod 3 <> 1 then showmessage(lang('Incorrect number of points (nx3)+1'));
  dec(NB);
  arect := rect(ax-tolerance, ay-tolerance, ax+tolerance, ay+tolerance);
  For i := 1 to NB  do
  begin
    IF i mod 3 = 0 then
    begin
      tt := 0;
      Intervals := (distance(ZZ[i-3].x, ZZ[i-3].y, ZZ[i-2].x, ZZ[i-2].y) +
                    distance(ZZ[i-2].x, ZZ[i-2].y, ZZ[i-1].x, ZZ[i-1].y) +
                    distance(ZZ[i-1].x, ZZ[i-1].y, ZZ[i].x, ZZ[i].y)) div 8;
      If intervals < 1 then intervals := 1;  //avoid divide by zero
      sintervals := intervals;
      deltatt  := 1 / sintervals;
      For j := 0 to intervals-1 do
      begin
        tt := tt+deltatt;
        aTpoint := Bcalcul(ZZ[i-3], ZZ[i-2], ZZ[i-1], ZZ[i], tt);
        apt1.x := round(aTpoint.x);
        apt1.y := round(aTpoint.y);
        if ptinrect(arect, apt1) then
        begin
          result := true;
          acutpoint  := i-3;
          aparam := tt;
          exit;
        end;
      end;
     end;
  end;
end;

Procedure Binterpol(Z1, Z2: array of Tpoint; NB: integer; k: single;
                    var Z3: array of Tpoint);
var
  i : integer;
begin
  if NB mod 3 <> 1 then showmessage(lang('Incorrect number of points (nx3)+1'));
  dec(NB);
  for i := 0 to NB do Z3[i] := interpol(Z2[i], Z1[i], k);
end;

//--------------- Utilities

Function Egalpoints(pt1, pt2 : tpoint): boolean;  // equal points
begin
  IF (pt1.x = pt2.x) AND (pt1.y = Pt2.y) then result := true
  else result := false;
end;

// p range between 0.0 and 1.0
Function interpol(p1, p2 : Tpoint; p : single): Tpoint;
var
  x1, x2, y1, y2 : single;
begin
  x1 := p1.x;
  y1 := p1.y;
  x2 := p2.x;
  y2 := p2.y;
  result.x := round(x1*p+x2*(1-p));
  result.y := round(y1*p+y2*(1-p));
end;

Function Arctangente(ax, ay : integer) : single;
var
  symetrie : boolean;
  wx, wy : single;
begin
  if ax < 0 then symetrie := true else symetrie := false;
  wx :=  abs(ax);
  wy := -ay;
  IF wx < 0.001 then   // avoid divide by zero
  begin
    if wy < 0 then result := pi+pi/2 else result := pi/2;
  end
  else
  begin
    result := arctan(wy / wx);
    IF symetrie then result := pi - result;
  end;
end;

// Distance of 2 points, distance de deux points;
Function Distance(x1, y1, x2, y2 : integer): integer;
// Hypothenuse a = sqrt(b*b+c*c) using Newton's formula to compute a
// square root in 12 loops
//  sqrt(a) --> Xo = (1+a)/2 and Xn+1 = (Xn=+a/Xn)/2
//  3 times faster than j := trunc(sqrt(sqr(xr)+sqr(yr)));
// Hypothénuse a := sqrt(b*b+c*c) en utilisant la formule de Newton
// pour le calcul de la racine carrée (12 itérations suffisent)
//   sqrt(a) -->  Xo = (1+a)/2 et Xn+1 = (Xn+a/Xn)/2
// C'est 3 fois plus rapide que  j := trunc(sqrt(sqr(xr)+sqr(yr)));
var
  i : Integer;
  a, r0, r1 : Integer;
begin
  r0 := x2-x1;
  r1 := y2-y1;
  a := r0*r0 + r1*r1;
  r1 := (1+a) DIV 2;
  FOR i := 1 TO 12 DO
  begin
    r0 := r1;
    IF r0 > 0 then r1 := (r0+(a div r0)) div 2;
  end;
  Result:= r1;
end;

end.
