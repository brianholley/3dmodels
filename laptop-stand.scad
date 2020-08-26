computer_w = 235;
computer_h = 340;
computer_d = 15 + 2; // 2mm buffer

translate([0, -computer_h/2, 0]) {
//    cube([computer_w, computer_h, computer_d]);
}

step = 1;

width = 250; // of 340
height = 100; // of 235
thickness = 15;
base_h = 4;

difference() {
union() {
difference() {
    cos_curve(width, height, thickness);
    translate([0, -0.1, 0]) {
        cos_curve(width-thickness, height-thickness, thickness+0.2);
    }
}

translate([0, thickness + computer_d, 0]) {
    difference() {
        cos_curve(width, height, thickness);
        translate([0, -0.1, 0]) {
            cos_curve(width-thickness, height-thickness, thickness+0.2);
        }
    }
}

translate([-(width-thickness*0.6)/2, 0, 0]) {
    cube([width-thickness*0.6, thickness*2 + computer_d, base_h]);
}
}

union() {
    translate([-width, -thickness, -height*2]) {
        cube([width*2, thickness*10, height*2]);
    }
    translate([-width*0.3, thickness, -0.1]) {
        cube([width*0.6, computer_d, base_h+0.2]);
    }
}
}


module cos_curve(w, h, d) {
    rotate([-90, 0, 0]) {
        translate([-w, 0, 0]) {
            points = [ for (t=[0:step:360]) [w / 180 * t, h * cos(t)]];
            linear_extrude(height=d)
                polygon(points);
        }
    }
}