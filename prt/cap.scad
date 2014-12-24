include <constants.scad>
include <../scadhelpers/all.scad>
include <labyrinth_seal.scad>
include <shell_bolts.scad>

module cap() {
  union() {
    shell_bolts(shell_thickness);

    ring(bolt_diameter, shell_diameter, shell_thickness);
  }
}

cap();
