include <constants.scad>
include <../scadhelpers/all.scad>
include <../scadhelpers/spiral.scad>
include <labyrinth_seal.scad>

module disc() {
  /*
  spiral_internal_diameter = exhaust_diameter - spiral_gap;
  spiral_external_diameter = disc_diameter - spiral_gap - disc_wall_thickness;

  spiral_loops_count = (spiral_external_diameter - spiral_internal_diameter) / 2 / (spiral_thickness + spiral_gap);
  spiral_angle = 360 * spiral_loops_count;

  union() {
    difference() {
      cylinder(h = spiral_height + disc_wall_thickness * 2, d = disc_diameter);

      tz(disc_wall_thickness)
      union() {
        my()
        spiral_2048(spiral_internal_diameter / 2, spiral_external_diameter / 2, spiral_angle, spiral_gap, spiral_height);

        rz(-spiral_angle)
        tx(-spiral_gap / 2 + spiral_external_diameter / 2)
        my()
        cube([spiral_gap, infinity, spiral_height]);
      }

      cylinder(h = infinity, d = exhaust_diameter, center = true);
    }

    tz(-disc_lock_height)
    disc_support(disc_height);

    tz(-disc_lock_height)
    disc_lock(disc_lock_height + tolerance, 0);

    tz(spiral_height + disc_wall_thickness * 2 - tolerance)
    disc_lock(disc_lock_height + tolerance, 0);

    tz(-disc_lock_height)
    difference() {
      cylinder(h = disc_lock_height + tolerance, d = disc_diameter);

      tz(-tolerance)
      cylinder(h = disc_lock_height + tolerance * 2, d = disc_diameter - support_thickness);
    }
  }
  */

  module nozzle_shell() {
    delta = pow(disc_nozzle_width_max, 2) / 2 / sqrt(pow(disc_diameter, 2) - pow(disc_nozzle_width_max, 2));

    tx(disc_diameter / 2 - delta)
    ry(90)
    mx()
    linear_extrude(disc_nozzle_length, scale=[1, disc_nozzle_width_min / disc_nozzle_width_max])
    ty(-disc_nozzle_width_max / 2)
    square([disc_main_height + disc_thickness * 2, disc_nozzle_width_max]);
  }

  module nozzle_hole() {
    delta = pow(disc_nozzle_width_max, 2) / 2 / sqrt(pow(disc_diameter, 2) - pow(disc_nozzle_width_max, 2));

    length_full = disc_nozzle_length + disc_diameter / 2 - delta; 
    length = length_full - disc_thickness;
    max_width = 
      (disc_nozzle_width_max - disc_nozzle_width_min)
      * length_full
      / disc_nozzle_length
      + disc_nozzle_width_min
      - disc_thickness * 2;
    min_width = 
      (disc_nozzle_width_max - disc_nozzle_width_min)
      * disc_thickness 
      / disc_nozzle_length
      + disc_nozzle_width_min
      - disc_thickness * 2;
    height = disc_main_height;

    tz(disc_thickness) {
      ry(90)
      mx()
      linear_extrude(length, scale=[1, min_width / max_width])
      ty(-max_width / 2)
      square([height, max_width]);

      tx(length - disc_nozzle_slot * cos(disc_nozzle_angle) - tolerance)
      rz(disc_nozzle_angle)
      tx(-disc_nozzle_slot / 2)
      cube([disc_nozzle_slot, disc_nozzle_width_max, height]);
    }
  }

  //!nozzle_hole();

  difference() {
    union() {
      difference() {
        cylinder(h = disc_height, d = disc_diameter);

        tz(disc_thickness)
        cylinder(h = disc_height, d = disc_inner_diameter);

        tz(-tolerance / 2)
        cylinder(h = disc_thickness + tolerance, d = bolt_diameter);
      }

      tz(disc_height - tolerance / 2)
      labyrinth_seal(labyrinth_seal_height + tolerance, 1);

      mirror_clone([1, 0, 0])
      nozzle_shell();
    }

    nozzle_hole();

    my()
    mx()
    nozzle_hole();
  }
}

//projection(cut = true)
//tz(-spiral_height / 2)
disc();
