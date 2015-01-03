include <constants.scad>
include <../scadhelpers/all.scad>

disc_base_bolt_position = disc_diameter / 2 + bolt_diameter / 2;

module disc_bolts_hole(height) {
  for (i = [0 : disc_bolts_number - 1]) {
    rz(i * 360 / disc_bolts_number)
    tx(disc_base_bolt_position)
    tz(-tolerance / 2)
    cylinder(h = height + tolerance, d = bolt_diameter);
  }
}

module disc_bolts(height) {
  cube_side = disc_bolt_extension_diameter / 2 + tolerance;
  disc_bolt_extension_diameter = bolt_diameter + general_thickness * 2;
  difference() {
    union() {
      for (i = [0 : disc_bolts_number - 1]) {
        rz(i * 360 / disc_bolts_number)
        tx(disc_base_bolt_position) {
          cylinder(h = height, d = disc_bolt_extension_diameter);

          tx(-disc_bolt_extension_diameter / 4 - tolerance / 2)
          tz(height / 2)
          cube([disc_bolt_extension_diameter / 2 + tolerance, disc_bolt_extension_diameter, height], center = true); 
        }
      }
    }
    disc_bolts_hole(height);
  }
}
