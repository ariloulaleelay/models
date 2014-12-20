include <constants.scad>
include <../scadhelpers/all.scad>
include <shell_bolts.scad>
include <labyrinth_seal.scad>

module cap() {
  union() {
    labyrinth_seal(labyrinth_seal_height + shell_thickness);

    difference() {
      cylinder(d = shell_diameter, h = shell_thickness);

      tz(-tolerance / 2)
      cylinder(d = bolt_diameter, h = shell_thickness + tolerance);
    }
  }
}

cap();
