include <constants.scad>
include <../scadhelpers/all.scad>
include <shell_bolts.scad>

module shell() {

  module nozzle_transformation() {
    for (c = [0 : $children - 1]) {
      tx(shell_internal_diameter / 2 - nozzle_slot / 2)
      rx(90)
      child(c);
    }
  }

  module nozzle_hole() {
    ty(nozzle_slot_length / 2 + shell_thickness)
    union() {

      tz(nozzle_cone_length / 4)
      cube([nozzle_slot, nozzle_slot_length, nozzle_cone_length / 2], center = true);

      hull() {
        tz(nozzle_cone_length / 2)
        cube([nozzle_slot, nozzle_slot_length, tolerance], center = true);

        tz(nozzle_cone_length)
        cylinder(h = tolerance, d = nozzle_internal_diameter);
      }
      tz(nozzle_cone_length)
      cylinder(h = nozzle_pipe_length + tolerance, d = nozzle_internal_diameter);
    }
  }


  module nozzle_shell() {
    support_steps = ceil(nozzle_pipe_length / 4);

    ty(shell_height / 2)
    union() {
      tz(nozzle_cone_length / 2)
      cube([nozzle_pipe_diameter, shell_height, nozzle_cone_length], center = true);

      ty((shell_height - nozzle_slot_length) / 4)
      tz(nozzle_cone_length - tolerance)
      cylinder(h = nozzle_pipe_length + tolerance, d = nozzle_pipe_diameter);

      for (i = [1 : support_steps]) {
        ty(-shell_height / 4)
        tz(nozzle_cone_length + nozzle_pipe_length * i / support_steps - 0.3)
        cube([nozzle_pipe_diameter, shell_height / 2, 0.6], center = true);
      }
    }
  }

  module chamfer_hole() {
    side_size = shell_thickness * sqrt(2) + tolerance; 

    tz(shell_height + shell_thickness / 2)
    rotate_extrude()
    tx(shell_diameter / 2 - shell_thickness / 2)
    rz(45)
    ty(-side_size / 2)
    square([side_size, side_size]);
  }

  difference() {
    union() {
      difference() {
        cylinder(h = shell_height + shell_thickness, d = shell_diameter);
        chamfer_hole();
      }

      shell_bolts(shell_height);

      nozzle_transformation()
      nozzle_shell();
    }

    tz(shell_thickness + tolerance / 2) 
    cylinder(h = infinity, d = shell_internal_diameter); 

    tz(-tolerance)
    cylinder(h = infinity, d = shell_exhaust_diameter);

    nozzle_transformation()
    nozzle_hole();
    
    shell_bolts_hole();
  }
}

shell();
