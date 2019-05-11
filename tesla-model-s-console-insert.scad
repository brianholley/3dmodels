// Tesla model S center console insert holder
// v1.3
//
// Supports up to 104mm width of inserts, depending on depth
// 
// Current configuration:
// 1. Parking garage cardkey
// 2. Garage door opener

insert_1_width = 55.0;
insert_1_depth = 2.5;
insert_1_height = 81.0;
insert_1_height_exposed = 15.0;

insert_2_width = 47.0;
insert_2_depth = 17.0;
insert_2_height = 78.0;
insert_2_height_exposed = 28.0;

// These you'll want to set empirically based on how deep your two offsets are
insert_1_offset = -56.0;
insert_2_offset = 1.0;

holder_height = 100.0;


difference() {
    union() {
        // End circles
        SkewedCylinder(c1=[-64,0,0], r1=5, c2=[-5,0,holder_height], r2=5);
        SkewedCylinder(c1=[64,0,0], r1=5, c2=[5,0,holder_height], r2=5);
        
        // Narrow core
        translate([-60.5,-4,0]) {
            hull() {
                cube([121,8,1]);
                translate([-5, 0, holder_height-1]) {
                    cube([131,8,1]);
                }
            }
        }

        // Narrow-fat transition
        SkewedCylinder(c1=[-44,0,0], r1=9, c2=[-5,0,holder_height], r2=10);
        SkewedCylinder(c1=[44,0,0], r1=9, c2=[5,0,holder_height], r2=10);

        // Fat core
        translate([-44,-9,0]) {
            hull() {
                cube([88,18,1]);
                translate([-5, -1, holder_height-1]) {
                    cube([98,20,1]);
                }
            }
        }
    }
    
    // Insert 1
    translate([insert_1_offset,-insert_1_depth/2,holder_height-insert_1_height+insert_1_height_exposed]) {
        cube([insert_1_width, insert_1_depth, insert_1_height]);
    }
    
    // Insert 2
    translate([insert_2_offset,-insert_2_depth/2,holder_height-insert_2_height+insert_2_height_exposed]) {
        cube([insert_2_width, insert_2_depth, insert_2_height]);
    }
    
    // Style! (Cutouts from end circles to fat core)
    SkewedCylinder(c1=[-56.4,-7.1,-0.1], r1=5.5, c2=[-5.5,0,holder_height+0.2], r2=5);
    SkewedCylinder(c1=[-56.4,7.1,-0.1], r1=5.5, c2=[-5.5,0,holder_height+0.2], r2=5);
    SkewedCylinder(c1=[56.4,-7.1,-0.1], r1=5.5, c2=[5.5,0,holder_height+0.2], r2=5);
    SkewedCylinder(c1=[56.4,7.1,-0.1], r1=5.5, c2=[5.5,0,holder_height+0.2], r2=5);
}

module SkewedCylinder(c1=[0,0,0],r1,c2,r2)
{
    h = c2[2];
    offset = [c2[0], c2[1], h-0.1];
    translate(c1) {
        hull() {
            cylinder(r1=r1, r2=0, h=0.1);
            translate(offset) {
                cylinder(r1=0, r2=r2, h=0.1);
            }
        }
    }
}
