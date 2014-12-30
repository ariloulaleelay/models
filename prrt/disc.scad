include <all.scad>

module disc() {

  difference() {
    union() {
      cylinder(h = disc_height, d = disc_diameter);

      tz(disc_height)
      cylinder(h = disc_thickness, r1 = disc_diameter / 2, r2 = disc_diameter / 2 - disc_thickness);

      disc_bolts(disc_height);

      rotate_clone([0, 0, 180])
      tx(disc_diameter / 2)
      mx()
      cube([disc_nozzle_slot + disc_thickness * 2, disc_diameter / 2, disc_height]);
    }

    tz(disc_thickness)
    cylinder(h = disc_height + tolerance, d = disc_diameter - disc_thickness * 2);

    rotate_clone([0, 0, 180])
    tz(disc_thickness)
    tx(disc_diameter / 2 - disc_thickness)
    mx()
    cube([disc_nozzle_slot, disc_diameter / 2 + tolerance, disc_height - disc_thickness * 2]);
  }
}

//projection(cut = true)
//tz(-labyrinth_seal_height - disc_main_height / 2)
disc();
