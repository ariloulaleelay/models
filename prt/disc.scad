include <all.scad>

module disc() {

  union() {
    difference() {
      ring(disc_inner_diameter, disc_diameter, disc_height); 

      union() {
        //tz(disc_height)
        //color("black")
        tz(disc_thickness)
        rotate_clone([0, 0, 180]) {
          extended_spiral_128(
            max(disc_inner_diameter / 2 - disc_nozzle_channel_width / 2, disc_nozzle_channel_width / 2),
            disc_diameter / 2 - disc_nozzle_slot / 2,
            disc_nozzle_channel_width,
            disc_nozzle_slot,
            disc_main_height,
            disc_nozzle_angle,
            1 
          );

          rz(disc_nozzle_angle)
          tx(disc_diameter / 2 - disc_nozzle_slot)
          ty(-tolerance)
          cube([disc_nozzle_slot, disc_diameter, disc_main_height]);
        }
      }
    }

    tz(disc_height - tolerance / 10)
    labyrinth_seal(labyrinth_seal_height, seal_inner_diameter, seal_diameter, 1);

    tz(tolerance / 10)
    mz() {
      labyrinth_seal(labyrinth_seal_height, seal_inner_diameter, seal_diameter, 1);

      ring_support(disc_inner_diameter, seal_inner_diameter, labyrinth_seal_height);
    }

    ring(disc_inner_diameter, support_thickness * 2 + disc_inner_diameter, disc_height);

    ring(disc_diameter - support_thickness * 2, disc_diameter, disc_height);

    //bolt_support(disc_thickness);
  }
}

//projection(cut = true)
//tz(-labyrinth_seal_height - disc_main_height / 2)
disc();
