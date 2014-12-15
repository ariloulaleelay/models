include <constants.scad>
include <../scadhelpers/all.scad>
include <../scadhelpers/spiral.scad>
include <disc_support.scad>
include <disc_lock.scad>

module spiral(fake=false) {
  spiral_internal_diameter = exhaust_diameter - spiral_gap;
  spiral_external_diameter = disc_diameter - spiral_gap - disc_wall_thickness;

  spiral_loops_count = (spiral_external_diameter - spiral_internal_diameter) / 2 / (spiral_thickness + spiral_gap);
  spiral_angle = 360 * spiral_loops_count;

  union() {
    difference() {
      cylinder(h = spiral_height + disc_wall_thickness * 2, d = disc_diameter);

      tz(disc_wall_thickness)
      union() {
        my()
        spiral_2048(spiral_internal_diameter / 2, spiral_external_diameter / 2, spiral_angle, spiral_gap, spiral_height);

        tz(spiral_height)
        rz(-spiral_angle)
        tx(-spiral_gap / 2 + spiral_external_diameter / 2)
        mz()
        my()
        cube([spiral_gap, spiral_height, infinity]);
      }

      tz(disc_wall_thickness)
      cylinder(h = infinity, d = exhaust_diameter);
    }

    disc_support(spiral_height + disc_lock_height + disc_wall_thickness * 2);

    tz(spiral_height + disc_wall_thickness * 2 - tolerance)
    disc_lock(disc_lock_height + tolerance, 0);
  }
}

spiral();
