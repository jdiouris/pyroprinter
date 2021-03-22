$fn=100;
rotate([90,0,0])
difference()
{
union()
    {
    cube([20,25,6]);
   cube([20,4,20]);  
       translate([0,0,20]) cube([20,25,6]);
        translate([0,0,20]) cube([20,25,6]);
        translate([-6,0,00]) cube([6,25,26]);
        translate([20,0,00]) cube([6,25,26]);
    }
    translate([10,14,-1]) cylinder(h=3,d=16+0.4); 
    translate([10,14,20+2]) cylinder(h=10,d=16+0.4);
    translate([10,14,-1]) cylinder(h=30,d=14+0.4); 
     translate([5,-1,12]) rotate([-90,0,0]) cylinder(h=10,d=3.6);
    translate([15,-1,12]) rotate([-90,0,0]) cylinder(h=10,d=3.6);
}

//translate([0,10,0])
//{
//  difference()
//{
//union()
//    {
//    cube([10,40,3]);  
//    translate([5,5,0]) cylinder(h=8,d=8);
//    }
//     translate([5,5,-1]) cylinder(h=10,d=5.4);
//    
//     translate([5,20,-1]) cylinder(h=10,d=3.6);
//    translate([5,30,-1]) cylinder(h=10,d=3.6);
//    
//}
//};