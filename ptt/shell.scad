include <constants.scad>
include <../scadhelpers/all.scad>

shell_base_bolt_position = shell_diameter / 2 + shell_bolt_diameter / 2;

module shell_base(height) {
  cube_side = shell_bolt_extension_diameter / 2 + tolerance;
  union() {
    cylinder(h = height, d = shell_diameter, center = true);
    for (i = [0 : 5]) {
      rz(i * 360 / 6)
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
      hull() {
        ty(shell_thickness / 2)
        cube([nozzle_cone_diameter_min, shell_height - shell_thickness, tolerance], center = true);

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
    angle_tan = (nozzle_internal_diameter - nozzle_cone_diameter_min) / nozzle_cone_length;
    angle = atan(angle_tan);
    for (c = [0 : $children - 1]) {
      tx(shell_internal_diameter / 2 - tolerance)
      rz(-90 + angle + 5)
      ry(90)
      rz(90)
      child(c);
    }
  }

  module nozzle_shell() {
    union() {
      hull() {
        cube([nozzle_pipe_diameter, shell_height, tolerance], center = true);

        tz(nozzle_cone_length)
        ty(-shell_height / 2 + nozzle_pipe_diameter / 2)
        cylinder(h = tolerance, d = nozzle_pipe_diameter);
      }
      tz(nozzle_cone_length)
      ty(-shell_height / 2 + nozzle_pipe_diameter / 2)
      cylinder(h = nozzle_pipe_length, d = nozzle_pipe_diameter);
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
      cylinder(h = shell_thickness + tolerance, d = shell_bolt_diameter + tolerance * 1.5, center = true);
    }
  }
}

cap();
//shell();
