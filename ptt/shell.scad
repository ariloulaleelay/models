include <constants.scad>
include <../scadhelpers/all.scad>

shell_base_bolt_position = shell_diameter / 2 + shell_bolt_diameter / 2;

module shell_base(height) {
  cube_side = shell_bolt_extension_diameter / 2 + tolerance;
  union() {
    cylinder(h = height, d = shell_diameter, center = true);
    for (i = [0 : shell_bolts_number - 1]) {
      rz(i * 360 / shell_bolts_number)
      tx(shell_base_bolt_position) {
        cylinder(h = height, d = shell_bolt_extension_diameter, center = true);

        tx(-shell_bolt_extension_diameter / 4 - tolerance / 2)
        cube([shell_bolt_extension_diameter / 2 + tolerance, shell_bolt_extension_diameter, height], center = true); 
      }
    }
  }
}

module shell() {

  module nozzle_hole() {
    union() {

      tz(nozzle_cone_length / 4)
      tx(-nozzle_cone_diameter_min / 2)
      ty(shell_thickness / 2)
      cube([nozzle_cone_diameter_min, shell_height - shell_thickness - nozzle_top_cover, nozzle_cone_length / 2], center = true);

      hull() {
        tz(nozzle_cone_length / 2)
        tx(-nozzle_cone_diameter_min / 2)
        ty(shell_thickness / 2)
        cube([nozzle_cone_diameter_min, shell_height - shell_thickness - nozzle_top_cover, tolerance], center = true);

        tz(nozzle_cone_length)
        ty(-shell_height / 2 + nozzle_pipe_diameter / 2)
        cylinder(h = tolerance, d = nozzle_internal_diameter);
      }
      tz(nozzle_cone_length)
      ty(-shell_height / 2 + nozzle_pipe_diameter / 2)
      cylinder(h = nozzle_pipe_length + tolerance, d = nozzle_internal_diameter);
    }
  }

  module nozzle_transformation() {
    for (c = [0 : $children - 1]) {
      tx(shell_internal_diameter / 2)
      rz(-90)
      ry(90)
      rz(90)
      child(c);
    }
  }

  module nozzle_shell() {
    union() {
      tz(nozzle_cone_length / 2)
      cube([nozzle_pipe_diameter, shell_height, nozzle_cone_length], center = true);

      tz(nozzle_cone_length - tolerance)
      ty(-shell_height / 2 + nozzle_pipe_diameter / 2)
      cylinder(h = nozzle_pipe_length + tolerance, d = nozzle_pipe_diameter);
    }
  }

  difference() {
    union() {
      shell_base(shell_height);

      nozzle_transformation()
      nozzle_shell();
    }

    tz(shell_thickness + tolerance / 2) 
    cylinder(h = shell_height + tolerance, d = shell_internal_diameter, center = true); 

    cylinder(h = shell_height + tolerance, d = shell_exhaust_diameter, center = true);

    nozzle_transformation()
    nozzle_hole();

    for (i = [0 : shell_bolts_number - 1]) {
      rz(i * 360 / shell_bolts_number)
      tx(shell_base_bolt_position)
      cylinder(h = shell_height + tolerance, d = shell_bolt_diameter, center = true);
    }
  }
}

module cap() {
  difference() {
    shell_base(shell_thickness);

    for (i = [0 : shell_bolts_number - 1]) {
      rz(i * 360 / shell_bolts_number)
      tx(shell_base_bolt_position)
      cylinder(h = shell_thickness + tolerance, d = shell_bolt_diameter + tolerance * 1.5, center = true);
    }

    cylinder(h = shell_thickness + tolerance, d = shell_exhaust_diameter, center = true);
  }
}

cap();
//shell();
