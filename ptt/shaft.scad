include <constants.scad>
include <../scadhelpers/all.scad>

module shaft() {
  union() {
    cylinder(h = disc_thickness, d = disc_diameter * 0.75); 

    tz(disc_thickness)
    intersection() {
      union() {
        rotate_clone([0, 0, 90])
        tz(shell_height / 2)
        cube([infinity, shell_thickness, infinity ], center = true);
      }
      cylinder(h = shell_height + shell_thickness, d = shell_exhaust_diameter - shaft_radial_gap * 2);
    }
  }
}


shaft();
