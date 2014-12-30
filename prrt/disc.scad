include <all.scad>

module disc() {

  module ring_sector(d1, d2, h, angle) {

    difference() { 
      ring(d1, d2, h);

      rz(angle)
      tx(-d2 / 2 - tolerance / 2)
      tz(-tolerance / 2)
      cube([d2 + tolerance, d2 + tolerance, h + tolerance]);

      my()
      tx(-d2 / 2 - tolerance / 2)
      tz(-tolerance / 2)
      cube([d2 + tolerance, d2 + tolerance, h + tolerance]);
    }

  }

  difference() {
    union() {
      cylinder(h = disc_height, d = disc_diameter);

      tz(disc_height)
      cylinder(h = disc_thickness, r1 = disc_diameter / 2, r2 = disc_diameter / 2 - disc_thickness);

      disc_bolts(disc_height);

      tx(disc_diameter / 2)
      mx()
      cube([disc_nozzle_slot + disc_thickness * 2, disc_diameter / 2, disc_height]);

      ty(disc_diameter / 2 - tolerance / 10)
      ring_sector(disc_diameter - disc_height * 2, disc_diameter, disc_height, 120);
    }

    tz(disc_thickness)
    cylinder(h = disc_height + tolerance, d = disc_diameter - disc_thickness * 2);

    tz(disc_thickness)
    tx(disc_diameter / 2 - disc_thickness)
    mx()
    cube([disc_nozzle_slot, disc_diameter / 2 + tolerance, disc_height - disc_thickness * 2]);

    ty(disc_diameter / 2 - tolerance / 10)
    tz(disc_thickness)
    ring_sector(disc_diameter - disc_height * 2 + disc_thickness * 2, disc_diameter - disc_thickness * 2, disc_height - disc_thickness * 2, 125);
  }
}

//projection(cut = true)
//tz(-labyrinth_seal_height - disc_main_height / 2)
disc();
