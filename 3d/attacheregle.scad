W=29;
L=12;
e=5;
H=10;
$fn=100;
module base()
{
difference()
{
union()
{
cube([L,W+20,3]);
    translate([0,10,0]) cube([L,W,H]);
}
translate([L/2,5,-1]) cylinder(h=20,d=3.4);
translate([L/2,W+20-5,-1]) cylinder(h=20,d=3.4);
translate([L/2,W/2+10,-1]) cylinder(h=20,d=5.4);
translate([L/2,W/2+10,-1]) cylinder(h=5,d=10.2,$fn=6);
}
}

module attache()
{
  difference()
{
union()
{
cube([30,W+10,H+1.6+2]);

}
translate([30-5,W/2+5-10,-1]) cylinder(h=20,d=3.4);
translate([30-5,W/2+5+10,-1]) cylinder(h=20,d=3.4);
translate([0,(W+10-29)/2,H]) cube([15,29,1.6]);
translate([30-10,-1,5]) cube([20,50,10]);
}  
}

module attachemilieu()
{
 difference(){
      union() {
        cube([40,10,5]);
        translate([15,0,0])cube([25,10,H+5]);
       
      }
       translate([20,0,H]) cube([15,10,1.6]);
      
      translate([25,-1,H]) cube([30,35,10]);
      translate([3,5-1.8,-1]) cube([10,3.6,10]);
//    translate([L/2,5,-1]) cylinder(h=10,d=3.4);
//    translate([L/2,W+20-5,-1]) cylinder(h=10,d=3.4);
//    translate([L/2,W/2+10,-1]) cylinder(h=10,d=5.4);
//    translate([L/2,W/2+10,-1]) cylinder(h=5,d=10.2,$fn=6);
 }
}

//rotate([0,-90,0]) 
//attache();
//base();
attachemilieu();
