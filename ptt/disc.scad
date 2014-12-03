include <constants.scad>
include <../scadhelpers/all.scad>

module disc() {
  module shaft_cross_hole() {
    intersection() {
      union() {
        rotate_clone([0, 0, 90])
        cube([infinity, shell_thickness + tolerance * 2, infinity], center = true);
      }

      cylinder(h = infinity, d = shell_exhaust_diameter - shaft_radial_gap * 2 + tolerance * 2, center = true);
    }
  }

  difference() {
    union() {
      cylinder(h = disc_thickness, d = disc_diameter, center = true); 

      cylinder(h = disc_thickness / 2 + disc_skirt_height, d = disc_exhaust_diameter + disc_skirt_width * 2); 
    }

    cylinder(h = disc_thickness + disc_skirt_height * 2 + tolerance, d = disc_exhaust_diameter, center = true);

    shaft_cross_hole();
  }
}

disc();
