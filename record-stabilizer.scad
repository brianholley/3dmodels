r = 40;
base_h = 1;
wall = 2;
spindle_d = 7.4;

penny_w = 19.02;
penny_h = 1.42;
penny_weight = 2.5; // grams
weight_target = 300; // grams

stacks = 8;
stack_d = penny_w * 1.03;
stack_outer_d = stack_d + wall * 2;

pennies_per_stack = ceil(weight_target / stacks / penny_weight);
stack_size = ceil(pennies_per_stack * 1.2);

stack_h = stack_size * penny_h;

inner_d = (r - stack_outer_d)*2;
echo(inner_d);

union() {
    // Base
    difference() {
        cylinder(d=r*2, h=base_h, $fn=180);
        cylinder(d=spindle_d, h=base_h*2.1, center=true, $fn=180);
    }
    
    difference() {
        union() {
            // Outer wall
            translate([0, 0, base_h]) {
                difference() {
                    cylinder(d=r*2, h=stack_h, $fn=180);
                    translate([0, 0, -0.1]) {
                        cylinder(d=(r-stack_outer_d/2)*2, h=stack_h+0.2, $fn=180);
                    }
                }
            }
            
            // Stack walls
            for (i=[0:stacks]) {
                rotate([0, 0, 360 / stacks * i]) {
                    translate([r-stack_outer_d/2, 0, base_h]) {
                        cylinder(d=stack_outer_d, h=stack_h, $fn=180);
                    }
                }
            }
        }
    
        union() {
            // Stack cutouts
            for (i=[0:stacks]) {
                rotate([0, 0, 360 / stacks * i]) {
                    translate([r-stack_outer_d/2, 0, base_h-0.1]) {
                        
                        cylinder(d=stack_d, h=stack_h+0.2, $fn=180);
                    }
    
                }
            }
        }
    }
}
