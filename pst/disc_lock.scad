include <constants.scad>
include <../scadhelpers/all.scad>

module disc_lock(height, shift=1) {
  lock_steps = ceil((shell_internal_diameter - exhaust_diameter) / 2 / (disc_lock_width * 2));

  module ring(r1, r2) {
    difference() {
      cylinder(h = height, d = r1 * 2);

      tz(-tolerance / 2)
      cylinder(h = height + tolerance, d = r2 * 2);
    }
  }

  for (i = [0 : lock_steps - 1]) {
    ring(
      exhaust_diameter / 2 + disc_lock_width * 2 * i - disc_lock_gap / 2 + disc_lock_width * shift, 
      exhaust_diameter / 2 + disc_lock_width * 2 * i + disc_lock_gap / 2 + disc_lock_width * shift - disc_lock_width 
    );
  }
}
