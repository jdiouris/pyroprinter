wvis=31;
W=42;
dmot=35;
P=38-13;
$fn=100;

module roundedCube(L,W,H,D)
{
    translate([D/2,0,0]) cube([L-D,W,H]);
    translate([0,D/2,0]) cube([L,W-D,H]);
    translate([D/2,D/2,0]) cylinder(h=H,d=D);
    translate([L-D/2,D/2,0]) cylinder(h=H,d=D);
    translate([L-D/2,W-D/2,0]) cylinder(h=H,d=D);
    translate([D/2,W-D/2,0]) cylinder(h=H,d=D);
}

module coin(W,P,H)
{
    cube([8,P,H]);
    translate([8,0,H/2])  rotate([-90,0,0]) cylinder(h=P,d=H);
}

rotate([0,-90,0]) 
difference()
{
    roundedCube(W,W,P,5);
    ew=(W-wvis)/2;
    translate([ew,ew,-1]) cylinder(h=100,d=3.4);
     translate([W-ew,ew,-1]) cylinder(h=100,d=3.4);
     translate([W-ew,W-ew,-1]) cylinder(h=100,d=3.4);
     translate([ew,W-ew,-1]) cylinder(h=100,d=3.4);
    translate([W/2,W/2,-1]) cylinder(h=100,d=dmot);
    
    translate([0,0,ew]) coin(10,10,P-2*ew);
     translate([0,W-10,ew]) coin(10,10,P-2*ew);
    //translate([W-ew,ew,5]) cylinder(h=P-10,d=15);
    // translate([W-ew,W-ew,5]) cylinder(h=P-10,d=15);
    // translate([ew,W-ew,P/2]) cube([12,12,P-10],center=true);
      translate([W-ew-4,-1,5]) cube([100,50,P-10]);
  //  translate([5,-1,P/2]) scale([1,1,1]) rotate([-90,0,0]) cylinder(h=10,d=P-10);
      translate([W-ew-4,W/2-25/2,-1]) cube([100,25,10]);
    
}