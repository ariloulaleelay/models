include <constants.scad>
include <../scadhelpers/all.scad>

shell_base_bolt_position = shell_diameter / 2 + bolt_diameter / 2;

module shell_bolts_hole(height) {
  for (i = [0 : shell_bolts_number - 1]) {
    rz(i * 360 / shell_bolts_number)
    tx(shell_base_bolt_position)
    tz(-tolerance / 2)
    cylinder(h = height + tolerance, d = bolt_diameter);
  }
}

module shell_bolts(height) {
  shell_bolt_extension_diameter = bolt_diameter + general_thickness * 2;
  cube_side = shell_bolt_extension_diameter / 2 + tolerance;
  difference() {
    union() {
      for (i = [0 : shell_bolts_number - 1]) {
        rz(i * 360 / shell_bolts_number)
        tx(shell_base_bolt_position) {
          cylinder(h = height, d = shell_bolt_extension_diameter);

          tx(-shell_bolt_extension_diameter / 4 - tolerance / 2)
          tz(height / 2)
          cube([shell_bolt_extension_diameter / 2 + tolerance, shell_bolt_extension_diameter, height], center = true); 
        }
      }
    }
    shell_bolts_hole(height);
  }
}
