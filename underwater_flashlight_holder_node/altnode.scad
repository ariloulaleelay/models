include <../scadhelpers/all.scad>

$fn = 64;

zero = 0.001;
infinite = 100000;

hole_tolerance = 0.3;


cube_hole_depth = 19;
cube_hole_width = 13;

round_hole_diameter = 30;
round_hole_width = 16;

rubber_holder_hole_width = 3;
rubber_holder_hole_depth = 3;
rubber_holder_hole_angle = 15;

rod_external_diameter = 10;
rod_holding_screw_diameter = 5;

base_height = rod_external_diameter + 6;
base_external_diameter = 60;
base_internal_diameter = 28 + hole_tolerance;

module base_ring() {
  difference() {
    cylinder(h = base_height, d = base_external_diameter, center = true);

    cylinder(h = base_height + hole_tolerance, d = base_internal_diameter + hole_tolerance, center = true);
    
    tx(cube_hole_depth / 2) 
    cube([cube_hole_depth, cube_hole_width, base_height + hole_tolerance], center = true);  

    intersection() {
      cylinder(h = base_height + hole_tolerance, d = round_hole_diameter + hole_tolerance, center = true);

      cube([round_hole_width + hole_tolerance, round_hole_diameter + hole_tolerance * 2, base_height + hole_tolerance], center = true);
    }


    mirror_clone([0, 1, 0])
    rz(rubber_holder_hole_angle)
    mx()
    tx(base_external_diameter - rubber_holder_hole_depth - hole_tolerance)
    cube([base_external_diameter + hole_tolerance, rubber_holder_hole_width + hole_tolerance, base_height + hole_tolerance], center = true); 

    for (i = [0 : 7]) {

      rz(360 / 8 * i)
      ry(90)
      cylinder(h = base_external_diameter + hole_tolerance, d = rod_external_diameter + hole_tolerance);
    }

    for (i = [1 : 7]) {
      rz(360 / 8 * i)
      tx((base_external_diameter * 0.5 + base_internal_diameter * 0.5) / 2)
      cylinder(h = base_height + hole_tolerance, d = rod_holding_screw_diameter + hole_tolerance, center = true);
    }
    tx((base_external_diameter * 0.67 + base_internal_diameter * 0.33) / 2)
    cylinder(h = base_height + hole_tolerance, d = rod_holding_screw_diameter + hole_tolerance, center = true);
  }
}


base_ring();
