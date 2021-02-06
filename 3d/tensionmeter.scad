$fn=100;
dv=3.5;
difference()
{
union()
{
cube([10,10,25]);
cube([20,10,5]);
}
translate([15,5,-1]) cylinder(h=10,d=3.5);
translate([-1,5-dv/2,10]) cube([20,dv,30]);
}