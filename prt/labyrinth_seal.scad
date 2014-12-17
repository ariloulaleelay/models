include <constants.scad>
include <../scadhelpers/all.scad>

module labyrinth_seal(height, shift=0) {
  step_size = labyrinth_seal_width * 4 + labyrinth_seal_gap * 2;
  ring_base_shift = shell_intake_outer_diameter + shift * (labyrinth_seal_width * 2 + labyrinth_seal_gap);

  for (i = [0 : labyrinth_seal_loops - shift]) {
    ring(
      ring_base_shift + step_size * i - labyrinth_seal_width * 2,
      ring_base_shift + step_size * i, 
      height
    );
  }
}
