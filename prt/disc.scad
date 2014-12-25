include <constants.scad>
include <../scadhelpers/all.scad>
include <spiral.scad>
include <bolt_support.scad>
include <labyrinth_seal.scad>

module disc() {

  union() {
    difference() {
      ring(disc_inner_diameter, disc_diameter, disc_height); 

      union() {
        //tz(disc_height)
        //color("black")
        tz(disc_thickness)
        rotate_clone([0, 0, 180]) {
          disc_spiral_128(
            disc_inner_diameter / 2 - disc_nozzle_channel_width / 2,
            disc_diameter / 2 - disc_nozzle_slot / 2,
            disc_nozzle_channel_width,
            disc_nozzle_slot,
            disc_main_height,
            disc_nozzle_angle,
            6 
          );

          rz(disc_nozzle_angle)
          tx(disc_diameter / 2 - disc_nozzle_slot)
          cube([disc_nozzle_slot, disc_diameter, disc_main_height]);
        }
      }
    }

    tz(disc_height - tolerance / 10)
    labyrinth_seal(labyrinth_seal_height, disc_inner_diameter, disc_diameter, 1);

    tz(tolerance / 10)
    mz()
    labyrinth_seal(labyrinth_seal_height, disc_inner_diameter, disc_diameter, 1);

    ring(disc_inner_diameter, support_thickness * 2 + disc_inner_diameter, disc_height);

    //bolt_support(disc_thickness);
  }
}

//projection(cut = true)
//tz(-labyrinth_seal_height - disc_main_height / 2)
disc();
