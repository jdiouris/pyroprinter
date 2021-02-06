L=100;
W=75;
H=50;
e=3;
$fn=100;

module boite()
{
    difference()
    {
    cube([L+2*e,W+2*e,H]);
        translate([e,e,-1]) cube([L,W,H+10]);
    }
    translate([e,e,0]) cylinder(h=H,d=6);
    translate([L+e,e,0]) cylinder(h=H,d=6);
    translate([e,W+e,0]) cylinder(h=H,d=6);
    translate([L+e,W+e,0]) cylinder(h=H,d=6);
}


module ventilo()
{
    rotate([-90,0,0])
    {
    cylinder(h=10,d=37);
    xx=32;
    translate([xx/2,xx/2,0]) cylinder(h=10,d=3.4);
    translate([xx/2,-xx/2,0]) cylinder(h=10,d=3.4);
    translate([-xx/2,xx/2,0]) cylinder(h=10,d=3.4);
    translate([-xx/2,-xx/2,0]) cylinder(h=10,d=3.4);
    }
}

module cylhoriz(H,D)
{
    rotate([0,90,0]) cylinder(h=H,d=D);
}

module couvercle()
{
    difference()
    {
        cube([L+2*e,W+2*e,e]);
        translate([e,e,-1]) cylinder(h=10,d=3.5);
    translate([L+e,e,-1]) cylinder(h=10,d=3.5);
    translate([e,W+e,-1]) cylinder(h=10,d=3.5);
    translate([L+e,W+e,-1]) cylinder(h=10,d=3.5);
     translate([L/2+e-2*25+5,W/2+e-12.5,1.5]) linear_extrude(5)   text("GRBL", size=25, font = "Liberation Sans");
    }
    
}
module base()
{
difference()
{
    union()
    {
    boite();
     translate([0,0,-10])   cube([L+2*e,e,10]);
    }
    translate([e,e,1]) cylinder(h=H+10,d=4);
    translate([L+e,e,1]) cylinder(h=H+10,d=4);
    translate([e,W+e,1]) cylinder(h=H+10,d=4);
    translate([L+e,W+e,1]) cylinder(h=H+10,d=4);
    Wf=W-20;
    translate([-5,(W+2*e-Wf)/2,-0.1]) cube([10,Wf,25]);
    translate([L/2+e,-5,H/2+e/2]) ventilo();
    
    translate([-1,W/2+e,H-10]) cylhoriz(10,8.5);
    translate([L,W/2+e,(H/2)]) cylhoriz(10,40);
    
    translate([L/2+e,0,-5]) rotate([-90,0,0]) cylinder(h=10,d=4.1);
    translate([10,0,-5]) rotate([-90,0,0]) cylinder(h=10,d=4.1);
    translate([L+2*e-10,0,-5]) rotate([-90,0,0]) cylinder(h=10,d=4.1);
}
}

//translate([0,0,0]) couvercle();
base();


