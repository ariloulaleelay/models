include <constants.scad>
include <../scadhelpers/all.scad>

module disc_support(height) {
  difference() {
    union() {
      for (i = [0 : 2]) {
        rz(i * 360 / 3)
        ty(-shell_thickness / 2)
        cube([shell_exhaust_diameter / 2 + tolerance, shell_thickness, height]);
      }

      cylinder(h = height, d = shell_bolt_diameter + shell_thickness * 2);
    }

    cylinder(h = infinity, d = shell_bolt_diameter + tolerance, center = true);
  }
}
