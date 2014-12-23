include <constants.scad>
include <../scadhelpers/all.scad>
include <../scadhelpers/spiral.scad>
include <labyrinth_seal.scad>

module disc() {

  union() {
    difference() {
      union() {
        tz(labyrinth_seal_height)
        cylinder(h = disc_height, d = disc_diameter);

        labyrinth_seal(labyrinth_seal_height + tolerance, 1);

        tz(labyrinth_seal_height + disc_height - tolerance / 2)
        labyrinth_seal(labyrinth_seal_height + tolerance, 1);
      }

      tz(-tolerance / 2)
      cylinder(h = disc_height + labyrinth_seal_height * 2 + tolerance, d = disc_inner_diameter);
        
      tz(labyrinth_seal_height + disc_thickness)
      rotate_clone([0, 0, 180]) 
      union() {
        extended_spiral_128(
          disc_inner_diameter / 4,
          disc_diameter / 2 - disc_nozzle_slot / 2,
          disc_inner_diameter / 2,
          disc_nozzle_slot,
          disc_main_height,
          disc_nozzle_angle,
          2 
        );

        rz(disc_nozzle_angle)
        tx(disc_diameter / 2 - disc_nozzle_slot)
        cube([disc_nozzle_slot, disc_diameter, disc_main_height]);
      }
    }

    difference() {
      cylinder(h = disc_height + labyrinth_seal_height * 2, d = disc_inner_diameter + support_thickness * 2);

      tz(-tolerance / 2)
      cylinder(h = disc_height + labyrinth_seal_height * 2 + tolerance, d = disc_inner_diameter); 
    }
  }
}

//projection(cut = true)
//tz(-labyrinth_seal_height - disc_main_height / 2)
disc();
