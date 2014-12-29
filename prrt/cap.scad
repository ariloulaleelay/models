include <all.scad>

module cap() {
  union() {
    shell_bolts(shell_thickness);

    //ring(bolt_diameter, shell_diameter, shell_thickness);

    cylinder(h = shell_thickness, d = shell_diameter);

    tz(shell_thickness + tolerance / 10)
    labyrinth_seal(labyrinth_seal_height, seal_inner_diameter, seal_diameter);

    tz(shell_thickness - tolerance)
    cylinder(h = disc_height + tolerance + labyrinth_seal_height * 2, r1 = disc_inner_diameter / 4, r2 = tolerance);
  }
}

cap();
