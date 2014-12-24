include <constants.scad>
include <../scadhelpers/all.scad>
include <spiral.scad>
include <bolt_support.scad>

module disc() {

  union() {
    difference() {
      ring(disc_inner_diameter, disc_diameter, disc_height); 

      tz(disc_thickness)
      rotate_clone([0, 0, 180]) 
      disc_spiral_128(
        disc_inner_diameter / 2 - disc_nozzle_channel_width / 2,
        disc_diameter / 2 + disc_nozzle_slot / 2,
        disc_nozzle_channel_width,
        disc_nozzle_slot,
        disc_main_height,
        disc_nozzle_angle,
        4 
      );
    }

    ring(disc_inner_diameter, support_thickness * 2 + disc_inner_diameter, disc_height);

    bolt_support(disc_thickness);
  }
}

//projection(cut = true)
//tz(-labyrinth_seal_height - disc_main_height / 2)
disc();
