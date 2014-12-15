include <constants.scad>
include <../scadhelpers/all.scad>

module disc_lock(height, shift=1) {
  step_size = disc_lock_width * 2 + disc_lock_gap;
  ring_base_shift = exhaust_diameter / 2 + step_size / 2 * shift + disc_lock_width;

  lock_steps = ceil((shell_internal_diameter - ring_base_shift * 2 - disc_lock_width) / 2 / step_size);

  module ring(r1, r2) {
    difference() {
      cylinder(h = height, d = r1 * 2);

      tz(-tolerance / 2)
      cylinder(h = height + tolerance, d = r2 * 2);
    }
  }

  for (i = [0 : lock_steps - 1]) {
    ring(
      ring_base_shift + step_size * i, 
      ring_base_shift + step_size * i - disc_lock_width 
    );
  }
}
