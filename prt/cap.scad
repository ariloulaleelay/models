include <constants.scad>
include <../scadhelpers/all.scad>
include <labyrinth_seal.scad>
include <shell_bolts.scad>

module cap() {
  union() {
    shell_bolts(shell_thickness);

    //ring(bolt_diameter, shell_diameter, shell_thickness);

    cylinder(h = shell_thickness, d = shell_diameter);

    tz(shell_thickness + tolerance / 10)
    labyrinth_seal(labyrinth_seal_height, disc_inner_diameter, shell_diameter);
  }
}

cap();
