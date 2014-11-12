include <constants.scad>

module disc() {
  difference() {
    union() {
      cylinder(h = disc_thickness, d = disc_diameter, center = true); 

      cylinder(h = disc_thickness / 2 + disc_skirt_height, d = disc_exhaust_diameter + disc_skirt_width * 2); 
    }

    cylinder(h = disc_thickness + disc_skirt_height * 2 + tolerance, d = disc_exhaust_diameter, center = true);
  }
}

disc();
