r = 40;
base_h = 1;
wall = 2;
taper = 0.95;

penny_w = 19.02;
stack_d = penny_w * 1.03;
stack_outer_d = stack_d + wall * 2;

inner_d = (r - stack_outer_d)*2;
echo(inner_d);

union() {
    // Base
    cylinder(d=r*2, h=base_h*2, $fn=180);
    
    // Taper
    translate([0, 0, base_h*2]) {
        cylinder(d1=r*2, d2=r*2*taper, h=base_h*2, $fn=180);
    }
    
    // Fitting
    translate([0, 0, -base_h*4]) {
        difference() {
            cylinder(d=inner_d, h=base_h*4, $fn=180);
            cylinder(d=inner_d-wall*2, h=base_h*8, center=true, $fn=180);
            
        }
    }
}



