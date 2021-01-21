Dbearing=15+0.4;
Lbearing=24+0.2;

Wbearings=42;
Wbase=2*Lbearing+6;
Lbase=48;
Hbase=17;
Dtige=8+0.1;
detiges=40;
$fn=100;

wvismot=31;

module anneau(d1,w,H)
{
    difference()
    {
        cylinder(h=H, d=d1);
        translate([0,0,-1]) cylinder(h=H+2,d=d1-w);
    }
}

difference()
{
    union()
    {
    cube([Wbase,Lbase,Hbase]);
    translate([0,Lbase-20,-3.9]) cube([Wbase,20,4]);    
    }
    translate([-1,6+Dbearing/2,8]) rotate([0,90,0]) cylinder(h=100,d=Dbearing-4);
    
    translate([2,6+Dbearing/2,8]) rotate([0,90,0]) cylinder(h=Lbearing,d=Dbearing);
    
    translate([28,6+Dbearing/2,8]) rotate([0,90,0]) cylinder(h=Lbearing,d=Dbearing);
    translate([0,0,-0.1]) cube([100,28,8]);
    
    translate([Lbearing/2,6+Dbearing/2,8]) rotate([0,90,0]) anneau(Dbearing+6,4,6);
    translate([Wbase-Lbearing/2-4,6+Dbearing/2,8]) rotate([0,90,0]) anneau(Dbearing+6,4,6);
    
    translate([(Wbase-detiges)/2,Lbase-20.1,6]) rotate([-90,0,0]) cylinder(h=100,d=Dtige);
    translate([(Wbase-detiges)/2+detiges,Lbase-20.1,6]) rotate([-90,0,0]) cylinder(h=100,d=Dtige);
  //  translate([Wbase/2-26/2,32,-4])  cylinder(h=100,d=3.5);
   //  translate([Wbase/2+26/2,32,-4])  cylinder(h=100,d=3.5);
    
    translate([(Wbase-detiges)/2,Lbase-20.1,-4]) cube([1,25, 10]);
    translate([(Wbase-detiges)/2+detiges,Lbase-20.1,-4]) cube([1,25, 10]);
    
    translate([(Wbase-26)/2,Lbase-13,-4]) cube([26,30, 8]);
    
    translate([-1,Lbase-8,0]) rotate([0,90,0]) cylinder(h=100,d=3.6);
    translate([(Wbase-26)/2-2,Lbase-8,0])
     rotate([0,90,0])  cylinder(h=3,r=5.5/2/cos(180/6) + 0.2,$fn=6);
     translate([(Wbase-26)/2+26-1,Lbase-8,0])
     rotate([0,90,0])  cylinder(h=3,r=5.5/2/cos(180/6) + 0.2,$fn=6);
     
    translate([Wbase/2-5,Lbase-7,0]) cylinder(h=100,d=3.6);
     translate([Wbase/2+5,Lbase-7,0]) cylinder(h=100,d=3.6);
     translate([Wbase/2-5,Lbase-7,Hbase-4]) cylinder(h=10,d=6);
     translate([Wbase/2+5,Lbase-7,Hbase-4]) cylinder(h=10,d=6);
     
     // Vis support moteur
     translate([Wbase/2,Lbase/2-5,0])
     {
    translate([-wvismot/2,-wvismot/2,0]) cylinder(h=100,d=3.6);
     translate([+wvismot/2,-wvismot/2,0]) cylinder(h=100,d=3.6);
         translate([-wvismot/2,wvismot/2,0]) cylinder(h=100,d=3.6);
     translate([+wvismot/2,wvismot/2,0]) cylinder(h=100,d=3.6);
     }
}

//translate([0,0,-7]) cube([6,6,15]);