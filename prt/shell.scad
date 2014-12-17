include <constants.scad>
include <../scadhelpers/all.scad>
include <shell_bolts.scad>
include <bolt_support.scad>
include <labyrinth_seal.scad>

module shell() {
  union() {
    labyrinth_seal(labyrinth_seal_height + tolerance);

    tz(labyrinth_seal_height)
    ring(shell_intake_inner_diameter, shell_diameter, shell_thickness);

    bolt_support(labyrinth_seal_height + shell_thickness);

    tz(labyrinth_seal_height + shell_thickness - tolerance / 2)
    difference() {
      cylinder(
        h = shell_intake_cone_height + tolerance, 
        r1 = (shell_intake_inner_diameter + intake_pipe_thickness) / 2, 
        r2 = intake_pipe_diameter_max / 2
      );

      tz(-tolerance / 2)
      cylinder(
        h = shell_intake_cone_height + tolerance * 2, 
        r1 = shell_intake_inner_diameter / 2, 
        r2 = intake_pipe_inner_diameter_max / 2
      );
    }

    tz(labyrinth_seal_height + shell_thickness + shell_intake_cone_height)
    difference() {
      cylinder(
        h = intake_pipe_length,
        r1 = intake_pipe_diameter_max / 2,
        r2 = intake_pipe_diameter_min / 2
      );

      tz(-tolerance / 2)
      cylinder(
        h = intake_pipe_length + tolerance,
        r1 = intake_pipe_inner_diameter_max / 2,
        r2 = intake_pipe_inner_diameter_min / 2
      );

    }
  }

}

shell();
