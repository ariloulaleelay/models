include <all.scad>

module cap() {
  difference() {
    union() {
      disc_bolts(disc_thickness);

      cylinder(h = disc_thickness * 2, d = disc_diameter);
    }

    tz(disc_thickness)
    cylinder(h = disc_thickness + tolerance, r1 = disc_diameter / 2 - disc_thickness, r2 = disc_diameter / 2);

    tz(-tolerance / 2)
    cylinder(h = disc_thickness * 2 + tolerance, d = intake_pipe_diameter_max + 2);
  }
}

cap();
