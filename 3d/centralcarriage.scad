Dbearing=15+0.4;
Lbearing=24+0.2;

Wbearings=40;
Wbase=2*Lbearing+6;
Lbase=70;
Hbase=10;
$fn=100;

module anneau(d1,w,H)
{
    difference()
    {
        cylinder(h=H, d=d1);
        translate([0,0,-1]) cylinder(h=H+2,d=d1-w);
    }
}

module gripGT2(H,zi)
{
    
    difference()
    {
        cube([9,11,H]);
        translate([-1,11/2-1,H-zi]) cube([12,2,zi+2]);
    }
    translate([0,11/2-1,H-zi]) cube([1,0.8,zi]);
    translate([2,11/2-1,H-zi]) cube([1,0.8,zi]);
    translate([4,11/2-1,H-zi]) cube([1,0.8,zi]);
    translate([6,11/2-1,H-zi]) cube([1,0.8,zi]);
    translate([8,11/2-1,H-zi]) cube([1,0.8,zi]);
    
    
    
}

module main()
{
difference()
{
    cube([Wbase,Lbase,Hbase ]);
    translate([-1,Lbase/2-Wbearings/2,0]) 
    {
        rotate([0,90,0]) cylinder(h=100,d=Dbearing-4);
    }
    translate([2,Lbase/2-Wbearings/2,0]) 
    {
        rotate([0,90,0]) cylinder(h=Lbearing,d=Dbearing);
    }
    translate([4+Lbearing,Lbase/2-Wbearings/2,0]) 
    {
        rotate([0,90,0]) cylinder(h=Lbearing,d=Dbearing);
    }
    
    translate([-1,Lbase/2+Wbearings/2,0]) 
    {
        rotate([0,90,0]) cylinder(h=100,d=Dbearing-4);
    }
    
     translate([2,Lbase/2+Wbearings/2,0]) 
    {
        rotate([0,90,0]) cylinder(h=Lbearing,d=Dbearing);
    }
    translate([4+Lbearing,Lbase/2+Wbearings/2,0]) 
    {
        rotate([0,90,0]) cylinder(h=Lbearing,d=Dbearing);
    }
    
     translate([Lbearing/2+2-3,Lbase/2-Wbearings/2,0]) 
    {
        rotate([0,90,0]) anneau(Dbearing+6,4,6);
    }
       translate([Lbearing/2+2-3,Lbase/2+Wbearings/2,0]) 
    {
        rotate([0,90,0]) anneau(Dbearing+6,4,6);
    }
    
     translate([Wbase-Lbearing/2-2-3,Lbase/2-Wbearings/2,0]) 
    {
        rotate([0,90,0]) anneau(Dbearing+6,4,6);
    }
       translate([Wbase-Lbearing/2-2-3,Lbase/2+Wbearings/2,0]) 
    {
        rotate([0,90,0]) anneau(Dbearing+6,4,6);
    }

// Vis 
    translate([-1,Lbase/2-5,5]) 
     rotate([0,90,0]) cylinder(h=10,d=1.5);
     translate([-1,Lbase/2+5,5]) 
     rotate([0,90,0]) cylinder(h=10,d=1.5);
    translate([Wbase-9,Lbase/2-5,5]) 
     rotate([0,90,0]) cylinder(h=10,d=1.5);
     translate([Wbase-9,Lbase/2+5,5]) 
     rotate([0,90,0]) cylinder(h=10,d=1.5);
    // autre
    
    translate([Wbase/2-5,4,-1]) cylinder(h=30,d=3.6);
     translate([Wbase/2+5,4,-1]) cylinder(h=30,d=3.6);
    translate([Wbase/2-5,Lbase-4,-1]) cylinder(h=30,d=3.6);
     translate([Wbase/2+5,Lbase-4,-1]) cylinder(h=30,d=3.6);
}

translate([0,Lbase/2,10]) gripGT2(12+3,7);
    translate([Wbase-9,Lbase/2,10]) gripGT2(12+3,7);

}
main();
