include <constants.scad>

module disc() {
  difference() {
    cylinder(h = disc_thickness, d = disc_diameter, center = true); 

    cylinder(h = disc_thickness + tolerance, d = disc_internal_diameter, center = true);
  }
}

disc();
