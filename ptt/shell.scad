include <constants.scad>
include <../scadhelpers/all.scad>

shell_base_bolt_position = shell_diameter / 2 + shell_thickness / 2;

module shell_base(height) {
  union() {
    cylinder(h = height, d = shell_diameter, center = true);
    for (i = [0 : 5]) {
      rz(i * 360 / 6)
      tx(shell_base_bolt_position)
      cylinder(h = height, d = shell_bolt_extension_diameter, center = true);
    }
  }
}

module shell() {

  module nozzle_hole() {
    cylinder(h = nozzle_cone_length, r1 = nozzle_cone_diameter_min / 2, r2 = nozzle_internal_diameter / 2);

    tz(nozzle_cone_length)
    cylinder(h = nozzle_length + tolerance, d = nozzle_internal_diameter);
  }

  module nozzle_transformation() {
    for (c = [0 : $children - 1]) {
      tx(shell_internal_diameter / 2 - tolerance)
      rz(-90)
      ry(90)
      child(c);
    }
  }

  difference() {
    union() {
      shell_base(shell_height);

      nozzle_transformation()
      cylinder(h = nozzle_length, d = nozzle_pipe_diameter);
    }

    tz(shell_thickness + tolerance / 2) 
    cylinder(h = shell_height + tolerance, d = shell_internal_diameter, center = true); 

    cylinder(h = shell_height + tolerance, d = shell_exhaust_diameter, center = true);

    nozzle_transformation()
    nozzle_hole();

    for (i = [0 : 5]) {
      rz(i * 360 / 6)
      tx(shell_base_bolt_position)
      cylinder(h = shell_height + tolerance, d = shell_bolt_diameter, center = true);
    }
  }
}

module cap() {
  difference() {
    shell_base(shell_thickness);

    for (i = [0 : 5]) {
      rz(i * 360 / 6)
      tx(shell_base_bolt_position)
      cylinder(h = shell_thickness + tolerance, d = shell_bolt_diameter + tolerance, center = true);
    }
  }
}

cap();
