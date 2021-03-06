include <constants.scad>
include <../scadhelpers/all.scad>
include <shell_bolts.scad>
include <disc_support.scad>

module cap() {

  module chamfer_hole() {
    side_size = shell_thickness * sqrt(2) + tolerance; 

    tz(shell_thickness * 2.8)
    rotate_extrude()
    tx(shell_internal_diameter / 2 - shell_thickness / 2)
    rz(-45)
    ty(-side_size / 2)
    square([side_size, side_size]);
  }


  union() {
    difference() {
      union() {
        cylinder(h = shell_thickness * 2, d = shell_diameter);


        shell_bolts(shell_thickness * 1.5);
      }

      tz(shell_thickness)
      cylinder(h = shell_thickness + tolerance, d = shell_internal_diameter);

      chamfer_hole();

      cylinder(h = infinity, d = shell_exhaust_diameter, center = true);
    }

    disc_support(shell_thickness);
  }
}

cap();
