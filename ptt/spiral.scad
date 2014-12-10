include <constants.scad>
include <../scadhelpers/all.scad>
include <../scadhelpers/spiral.scad>

module spiral() {
  spiral_internal_diameter = disc_exhaust_diameter + disc_thickness;
  spiral_external_diameter = disc_diameter - disc_thickness;
  spiral_loops_count = (spiral_external_diameter - spiral_internal_diameter) / 2 / (disc_thickness + 1.5);

  difference() {
    union() {
      my()
      spiral_1024(spiral_internal_diameter / 2, spiral_external_diameter / 2, 360 * spiral_loops_count, disc_thickness, shell_height - disc_thickness);

      cylinder(h = disc_thickness, d = disc_diameter); 
    }

    cylinder(h = infinity, d = disc_exhaust_diameter, center = true);
  }
}

spiral();
