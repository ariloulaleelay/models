include <constants.scad>
include <../scadhelpers/all.scad>
include <../scadhelpers/spiral.scad>
include <labyrinth_seal.scad>

module disc() {

  nozzle_to_disc_delta = 
    pow(disc_nozzle_width, 2) 
    / 2 
    / sqrt(pow(disc_diameter, 2) - pow(disc_nozzle_width, 2));

  module nozzle_projection(width, length, noz_width, noz_length, angle) {
    p1 = [0, width / 2];
    p2 = tp2d(p1, length);
    p3 = tp2d(rp2d([noz_length, 0], 90 + angle), length, width / 2);
    p3_1 = tp2d(rp2d([noz_length, -(width - noz_width) / 2], 90 + angle), length, width / 2);
    p4 = tp2d(rp2d([noz_length, -width], 90 + angle), length, width / 2);
    p4_1 = tp2d(rp2d([noz_length, -(width + noz_width) / 2], 90 + angle), length, width / 2);
    p5 = [(p4[1] - width / 2) * tan(angle) + p4[0], width / 2];
    p6 = [p5[0] - width * tan(angle / 2), -width / 2];
    p7 = [0, -width / 2];
  
    polygon(points=[
      p1,
      p2,
      p3_1,
      p4_1,
      p5,
      p6,
      p7
    ]);
  }

  module nozzle_hole_projection(width, length, noz_width, noz_length, angle, thickness) {
    t = thickness;
    p1 = [0, width / 2 - t];
    p2 = tp2d(p1, length + t + t * tan(angle));
    p3 = tp2d(rp2d([noz_length, -t], 90 + angle), length, width / 2);
    p3_1 = tp2d(rp2d([noz_length + tolerance, -(width - noz_width) / 2 - t], 90 + angle), length, width / 2);
    p4 = tp2d(rp2d([noz_length, -width + t], 90 + angle), length, width / 2);
    p4_1 = tp2d(rp2d([noz_length + tolerance, -(width + noz_width) / 2 + t], 90 + angle), length, width / 2);
    p5 = [(p4[1] - width / 2) * tan(angle) + p4[0], width / 2];
    p6 = [p5[0] - (width - 2 * t) * tan(angle / 2), -width / 2 + t];
    p7 = [0, -width / 2 + t];
  
    polygon(points=[
      p1,
      p2,
      p3_1,
      p4_1,
      p5,
      p6,
      p7
    ]);

  }

  module nozzle_shell() {
    tx(disc_diameter / 2 - tolerance - nozzle_to_disc_delta)
    linear_extrude(disc_main_height + disc_thickness * 2)
    nozzle_projection(
      disc_nozzle_width, 
      disc_nozzle_length + nozzle_to_disc_delta + tolerance, 
      disc_nozzle_slot + disc_thickness * 2, 
      disc_nozzle_length * 0.75, 
      disc_nozzle_angle
    );
  }

  //!nozzle_shell();

  module nozzle_hole() {
    tz(disc_thickness)
    linear_extrude(disc_main_height)
    nozzle_hole_projection(
      disc_nozzle_width, 
      disc_nozzle_length + disc_diameter / 2,
      disc_nozzle_slot + disc_thickness * 2, 
      disc_nozzle_length * 0.75, 
      disc_nozzle_angle,
      disc_thickness
    );
  }

  //!nozzle_hole();

  difference() {
    union() {
      labyrinth_seal(labyrinth_seal_height + tolerance, 1);

      tz(labyrinth_seal_height) 
      difference() {
        cylinder(h = disc_height, d = disc_diameter);

        tz(-tolerance / 2)
        cylinder(h = disc_height + tolerance, d = disc_inner_diameter);
      }


      tz(labyrinth_seal_height + disc_height - tolerance / 2)
      labyrinth_seal(labyrinth_seal_height + tolerance, 1);

      tz(labyrinth_seal_height) {
        nozzle_shell();
        
        my()
        mx()
        nozzle_shell();
      }
    }

    tz(labyrinth_seal_height) {
      nozzle_hole();

      my()
      mx()
      nozzle_hole();
    }
  }
}

//projection(cut = true)
//tz(-spiral_height / 2)
disc();
