include <all.scad>

module shell() {
  union() {
    ring(shell_intake_inner_diameter, shell_diameter, shell_thickness);

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

    tz(shell_thickness - tolerance / 10)
    labyrinth_seal(seal_height, seal_inner_diameter, seal_diameter);
  }

}

shell();
