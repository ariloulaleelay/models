include <constants.scad>
include <../scadhelpers/all.scad>
include <shell_bolts.scad>
include <disc_support.scad>

function alpha(i, min_i, max_i) = (i - min_i) / (max_i - min_i);

module shell() {

  module nozzle_transformation() {
    for (c = [0 : $children - 1]) {
      tx(shell_internal_diameter / 2 - nozzle_slot / 2)
      rx(90)
      child(c);
    }
  }

  module nozzle_hole() {
    ty((shell_height - shell_thickness) / 2 + shell_thickness)
    union() {

      tz(nozzle_cone_length / 4)
      cube([nozzle_slot, nozzle_slot_length, nozzle_cone_length / 2], center = true);

      hull() {
        tz(nozzle_cone_length / 2)
        cube([nozzle_slot, nozzle_slot_length, tolerance], center = true);

        tz(nozzle_cone_length)
        cylinder(h = tolerance, d = nozzle_internal_diameter_max);
      }

      tz(nozzle_cone_length)
      cylinder(
        h = nozzle_pipe_length + tolerance, 
        r1 = nozzle_internal_diameter_max / 2,
        r2 = nozzle_internal_diameter_min / 2
      );
    }
  }


  module nozzle_shell() {
    support_steps = ceil(nozzle_pipe_length / 4);
    support_thickness = 0.4;

    pipe_center = (shell_height - shell_thickness) / 2 + shell_thickness;

    union() {
      ty(shell_height / 2)
      tz(nozzle_cone_length / 2)
      cube([nozzle_pipe_diameter_max, shell_height, nozzle_cone_length], center = true);

      ty(pipe_center)
      tz(nozzle_cone_length - tolerance)
      cylinder(
        h = nozzle_pipe_length + tolerance, 
        r1 = nozzle_pipe_diameter_max / 2, 
        r2 = nozzle_pipe_diameter_min / 2
      );

      for (i = [1 : support_steps]) {
        tz(nozzle_cone_length + nozzle_pipe_length * i / support_steps - support_thickness / 2)
        ty(pipe_center / 2)
        cube(
          [
            nozzle_pipe_diameter_min * alpha(i, 1, support_steps) 
              + nozzle_pipe_diameter_max * (1.0 - alpha(i, 1, support_steps)), 
            pipe_center, 
            support_thickness
          ], 
          center = true
        );
      }

      tz(nozzle_cone_length)
      tx(-nozzle_pipe_diameter_max / 2)
      cube([nozzle_pipe_diameter_max, support_thickness, nozzle_pipe_length]);
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
        union() {
          difference() {
            cylinder(h = shell_height + shell_thickness, d = shell_diameter);
            chamfer_hole();
          }

          shell_bolts(shell_height);

          nozzle_transformation()
          nozzle_shell();
        }

        tz(-tolerance)
        cylinder(h = infinity, d = shell_exhaust_diameter);

        nozzle_transformation()
        nozzle_hole();
        shell_bolts_hole();
      }

      disc_support(shell_height);
    }

    tz(shell_thickness + tolerance / 2) 
    cylinder(h = infinity, d = shell_internal_diameter); 
  }
}

shell();
