H=36;
Dtige=8+0.2;

W=15;
$fn=100;
epate=10;
Hpoulie=30;

difference()
{
    union()
    {
cube([W,W,H]);
        translate([-epate,0,0]) cube([W+2*epate,W,5]);
          translate([W/2,0,H]) rotate([-90,0,0]) cylinder(h=W, d=W);
       // translate([0,0,H]) cube([W/2,W,W/2]);
        
    }
    //translate([0,-1,H]) cube([W/2,W+10,1]);
    //translate([(W/2-Dtige/2)/2,W/2,H-20]) cylinder(h=100, d=3.4);
    
    translate([W/2,2,H]) rotate([-90,0,0]) cylinder(h=100, d=Dtige);
    
    translate([-epate/2,5,-1]) cylinder(h=100, d=3.4);
    translate([-epate/2,W-5,-1]) cylinder(h=100, d=3.4);
    translate([W+epate/2,5,-1]) cylinder(h=100, d=3.4);
    translate([W+epate/2,W-5,-1]) cylinder(h=100, d=3.4);
    
    translate([-1,W/2,Hpoulie]) rotate([0,90,0]) cylinder(h=100, d=3.4);
    translate([W-4,W/2,Hpoulie]) rotate([0,90,0]) cylinder(h=10, d=7, $fn=6);
}
