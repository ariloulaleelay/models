include <constants.scad>
include <../scadhelpers/all.scad>

module disc_lock(height, shift=1) {
  lock_steps = ceil((shell_internal_diameter - exhaust_diameter) / (disc_lock_width * 2));

  module ring(d1, d2) {
    difference() {
      cylinder(h = height, d = d1);

      tz(-tolerance / 2)
      cylinder(h = height + tolerance, d = d2);
    }
  }

  for (i = [1 : lock_steps]) {
    ring(
      exhaust_diameter + disc_lock_width * 2 * i - disc_lock_gap / 2 + disc_lock_width * shift, 
      exhaust_diameter + disc_lock_width * 2 * i - disc_lock_width + disc_lock_gap / 2 + disc_lock_width * shift
    );
  }
}
