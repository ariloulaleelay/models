include <constants.scad>
include <../scadhelpers/all.scad>
include <shell_bolts.scad>
include <disc_support.scad>
include <disc_lock.scad>

function alpha(i, min_i, max_i) = (i - min_i) / (max_i - min_i);

module shell() {

  intake_elevation = (shell_height - shell_thickness) / 2 + shell_thickness;

  module intake_transformation() {
    for (c = [0 : $children - 1]) {
      //rz(360 / shell_bolts_number / 2)
      tx(shell_internal_diameter / 2 + shell_thickness + shell_nozzle_gap)
      tz(intake_elevation)
      //rz(90)
      rx(90)
      child(c);
    }
  }

  module intake_hole() {
    tz(intake_nozzle_length / 4)
    tx(-intake_nozzle_slot / 2)
    cube([intake_nozzle_slot, intake_internal_diameter_max, intake_nozzle_length / 2], center = true);

    hull() {
      tz(intake_nozzle_length / 2)
      tx(-intake_nozzle_slot / 2)
      cube([intake_nozzle_slot, intake_internal_diameter_max, tolerance], center = true);

      tz(intake_nozzle_length)
      cylinder(
        h = intake_pipe_length - intake_nozzle_length + tolerance,
        r1 = intake_internal_diameter_max / 2,
        r2 = intake_internal_diameter_min / 2
      );
    }
  }
  //!intake_hole();

  module intake_shell() {
    support_steps = ceil(intake_pipe_length / 4);
    support_thickness = 0.4;

    union() {
      cylinder(
        h = intake_pipe_length, 
        r1 = intake_pipe_diameter_max / 2, 
        r2 = intake_pipe_diameter_min / 2
      );

      for (i = [1 : support_steps]) {
        tz(intake_pipe_length * i / support_steps - support_thickness / 2)
        ty(-intake_elevation / 2)
        cube(
          [
            intake_pipe_diameter_min * alpha(i, 1, support_steps) 
              + intake_pipe_diameter_max * (1.0 - alpha(i, 1, support_steps)), 
            intake_elevation, 
            support_thickness
          ], 
          center = true
        );
      }

      tx(-intake_pipe_diameter_max / 2)
      ty(-intake_elevation)
      cube([intake_pipe_diameter_max, support_thickness, intake_pipe_length]);
    }
  }


  module ring_nozzle_hole() {
    union() {
      difference() {
        cylinder(h = shell_nozzle_width, d = shell_diameter - shell_thickness * 2);

        cylinder(h = infinity, d = shell_internal_diameter + shell_thickness * 2, center = true);
      }

      for (i = [0: shell_nozzle_count - 1]) {
        rz(360 * i / shell_nozzle_count)
        tx(shell_internal_diameter / 2)
        mx()
        my()
        cube([shell_nozzle_slot, shell_nozzle_depth, shell_nozzle_width]);
      }
    }
  }

/*  !tz(0) {
    tz(intake_elevation - shell_nozzle_width / 2)
    ring_nozzle_hole();

    intake_transformation()
    intake_hole();
  }
*/

  module chamfer_hole() {
    side_size = shell_thickness * sqrt(2) + tolerance; 

    tz(shell_height - shell_thickness / 2)
    rotate_extrude()
    tx(shell_diameter / 2 - shell_thickness / 2)
    rz(45)
    ty(-side_size / 2)
    square([side_size, side_size]);
  }

  union() {
    difference() {
      union() {
        difference() {
          union() {
            difference() {
              cylinder(h = shell_height, d = shell_diameter);
              chamfer_hole();
            }

            shell_bolts(shell_height - shell_thickness);

            intake_transformation()
            intake_shell();
          }

          tz(-tolerance)
          cylinder(h = infinity, d = exhaust_diameter);

          intake_transformation()
          intake_hole();

          tz(intake_elevation - shell_nozzle_width / 2)
          ring_nozzle_hole();

          shell_bolts_hole();
        }

        disc_support(shell_height);
      }

      tz(shell_thickness) 
      cylinder(h = infinity, d = shell_internal_diameter); 
    }
    
    disc_lock(shell_thickness + disc_lock_height);
  }
}

//projection(cut = true)
//tz(-(shell_height - shell_thickness) / 2 - shell_thickness)
shell();
