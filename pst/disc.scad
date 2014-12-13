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
      tz(-tolerance / 2)
      cylinder(h = spiral_height + tolerance, d = disc_diameter);

      union() {
        my()
        tz(-infinity / 2)
        spiral_2048(spiral_internal_diameter / 2, spiral_external_diameter / 2, spiral_angle, spiral_gap, infinity);

        rz(-spiral_angle)
        tx(-spiral_gap / 2 + spiral_external_diameter / 2)
        tz(-infinity / 2)
        my()
        cube([spiral_gap, infinity, infinity]);
      }

      cylinder(h = infinity, d = exhaust_diameter, center = true);
    }

    tz(-disc_lock_height - disc_wall_thickness)
    disc_support(spiral_height + disc_lock_height * 2 + disc_wall_thickness * 2);

    difference() {
      union() {
        translate_clone([0, 0, spiral_height + disc_wall_thickness])
        tz(-disc_wall_thickness)
        cylinder(h = disc_wall_thickness, d = disc_diameter);
      }

      cylinder(h = infinity, d = exhaust_diameter, center = true);
    }

    tz(-disc_wall_thickness - disc_lock_height)
    disc_lock(disc_lock_height + tolerance, 2);

    tz(spiral_height + disc_wall_thickness - tolerance)
    disc_lock(disc_lock_height + tolerance, 2);
  }
}

spiral();
