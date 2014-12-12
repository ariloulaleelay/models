include <constants.scad>
include <../scadhelpers/all.scad>
include <../scadhelpers/spiral.scad>
include <disc_support.scad>

module spiral(fake=false) {
  spiral_thickness = 1;
  spiral_gap = 2;

  spiral_internal_diameter = disc_exhaust_diameter;
  spiral_external_diameter = disc_diameter - spiral_gap - shell_thickness;

  spiral_loops_count = (spiral_external_diameter - spiral_internal_diameter) / 2 / (spiral_thickness + spiral_gap);
  spiral_angle = 360 * spiral_loops_count;
  spiral_height = shell_height - shell_thickness;

  union() {
    difference() {
      cylinder(h = spiral_height, d = disc_diameter);

      union() {
        my()
        tz(-infinity / 2)
        spiral_2048(spiral_internal_diameter / 2, spiral_external_diameter / 2, spiral_angle, spiral_gap, infinity);

        rz(-spiral_angle)
        tx(-spiral_gap / 2 + spiral_external_diameter / 2)
        my()
        cube([spiral_gap, infinity, infinity]);
      }

      cylinder(h = infinity, d = disc_exhaust_diameter + shell_thickness * 3, center = true);
    }

    disc_support(spiral_height);

    difference() {
      union() {
        translate_clone([0, 0, spiral_height - disc_thickness])
        cylinder(h = disc_thickness, d = disc_diameter);
      }

      cylinder(h = infinity, d = disc_exhaust_diameter, center = true);
    }
  }
}

spiral();
