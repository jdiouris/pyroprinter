L=24.04*2+6;
e=4;
W=12;
$fn=100;

module gripGT2(H,zi)
{
    
    difference()
    {
        cube([9,12,H]);
        translate([-1,11/2-1,H-zi]) cube([12,2,zi+2]);
    }
    translate([0,11/2-1,H-zi]) cube([1,0.8,zi]);
    translate([2,11/2-1,H-zi]) cube([1,0.8,zi]);
    translate([4,11/2-1,H-zi]) cube([1,0.8,zi]);
    translate([6,11/2-1,H-zi]) cube([1,0.8,zi]);
    translate([8,11/2-1,H-zi]) cube([1,0.8,zi]);
    
    
    
}

//translate([0,Lbase/2-6+6.36,6]) gripGT2(12+3,7);
 //   translate([Wbase-9,Lbase/2-6+6.36,6]) gripGT2(12+3,7);
difference()
{
union()
{
    cube([L,W,e]);
    translate([10,W/2-6,0]) gripGT2(12+3,7);
    translate([L-19,W/2-6,0]) gripGT2(12+3,7);
}
    translate([5,W/2,-1]) cylinder(h=30,d=3.6);
    translate([L-5,W/2,-1]) cylinder(h=30,d=3.6);
}
