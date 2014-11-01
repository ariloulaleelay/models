include <../scadhelpers/all.scad>

$fn = 64;

zero = 0.001;
infinite = 100000;


// model adjustable parameters
base_thickness = 3;
hole_tolerance = 0.3;

antiwrap_plate_diameter = 20;
antiwrap_plate_height = 1.5;

sphere_clearance = 0.7; 

// relative parts parameters
cube_hole_depth = 19;
cube_hole_width = 13;

round_hole_diameter = 30;
round_hole_width = 16;

rubber_holder_hole_width = 3;
rubber_holder_hole_depth = 3;
rubber_holder_hole_angle = 15;

flaslight_hole_diameter = 28 + hole_tolerance;

rod_external_diameter = 10;

default_bolt_diameter = 4;
default_bolt_cap_diameter = 6.87;
default_bolt_cap_length = 3.9;

default_nut_height = 3.1;
default_nut_ext_diameter = 7.85;
default_nut_small_diameter = 6.8;

// evaluated parameters
rod_holding_bolt_diameter = default_bolt_diameter;

sphere_diameter = max(
  flaslight_hole_diameter + base_thickness * 2,
  sqrt(sqr(cube_hole_depth) + sqr(cube_hole_width / 2)) * 2 + base_thickness * 2,
  round_hole_diameter + base_thickness * 2
);
rod_holders_placement_radius = sphere_diameter / 2 + base_thickness + rod_holding_bolt_diameter / 2; 

base_height = rod_external_diameter + base_thickness * 2;
base_external_diameter = 
  rod_holders_placement_radius * 2 
  + rod_holding_bolt_diameter 
  + base_thickness * 2; 



module abs_antiwrap_plates() {
  difference() {
    union() {
      for (i = [0 : 5]) {
        rz(360 / 6 * i)
        tx(base_external_diameter / 2 + antiwrap_plate_diameter / 2 * 0.5)
        tz(-base_height / 2)
        cylinder(h = antiwrap_plate_height, d = antiwrap_plate_diameter);
      }
    }
    cylinder(h = base_height + hole_tolerance, d = base_external_diameter - hole_tolerance, center = true);
  }
}

module internal_ring() {
  difference() {
    intersection() {
      cylinder(h = base_height, d = sphere_diameter + hole_tolerance, center = true);

      sphere(d = sphere_diameter);
    }

    cylinder(h = base_height + hole_tolerance, d = flaslight_hole_diameter + hole_tolerance, center = true);
    
    tx(cube_hole_depth / 2) 
    cube([cube_hole_depth, cube_hole_width, base_height + hole_tolerance], center = true);  

    intersection() {
      cylinder(h = base_height + hole_tolerance, d = round_hole_diameter + hole_tolerance, center = true);

      cube([round_hole_width + hole_tolerance, round_hole_diameter + hole_tolerance * 2, base_height + hole_tolerance], center = true);
    }

    ry(-90)
    cylinder(h = sphere_diameter + hole_tolerance, d = default_bolt_diameter);

    ry(-90)
    cylinder(h = round_hole_diameter / 2 + default_nut_height * hole_tolerance * 2, d = default_nut_ext_diameter + hole_tolerance * 2, $fn=6);

    ry(-90)
    tz(max(sphere_diameter / 2 - default_bolt_cap_length - hole_tolerance * 2,  round_hole_diameter / 2 + default_nut_height * hole_tolerance * 2))
    cylinder(h = sphere_diameter, d = default_bolt_cap_diameter + hole_tolerance * 2);
  }
}

module external_ring() {
  difference() {
    cylinder(h = base_height, d = base_external_diameter, center = true);

    sphere(d = sphere_diameter + sphere_clearance * 2);

    for (i = [0 : 7]) {

      rz(360 / 8 * i)
      ry(90)
      cylinder(h = base_external_diameter + hole_tolerance, d = rod_external_diameter + hole_tolerance);
    }

    for (i = [0 : 7]) {
      rz(360 / 8 * i)
      tx(rod_holders_placement_radius)
      cylinder(h = base_height + hole_tolerance, d = rod_holding_bolt_diameter + hole_tolerance, center = true);
    }

    for (i = [0 : 7]) {
      rz(360 / 8 * i + 360 / 16)
      {
        ry(90)
        cylinder(h = base_external_diameter + hole_tolerance, d = default_bolt_diameter);

        tx(rod_holders_placement_radius)
        cube([
            default_nut_height + hole_tolerance * 2,
            default_nut_small_diameter + hole_tolerance * 2,
            base_height + hole_tolerance
        ], center=true);
      }
    }
  }
}


union() {
  internal_ring();

  external_ring();

  abs_antiwrap_plates();
}
