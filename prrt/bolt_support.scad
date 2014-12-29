include <constants.scad>
include <../scadhelpers/all.scad>

module bolt_support(height) {
  difference() {
    union() {
      for (i = [0 : 2]) {
        rz(i * 360 / 3)
        ty(-shell_thickness / 2)
        cube([shell_intake_inner_diameter / 2 + tolerance, bolt_support_thickness, height]);
      }

      cylinder(h = height, d = bolt_diameter + bolt_support_thickness * 2);
    }

    tz(-tolerance / 2)
    cylinder(h = height + tolerance, d = bolt_diameter);
  }
}
