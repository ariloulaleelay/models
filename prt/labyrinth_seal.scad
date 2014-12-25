include <constants.scad>
include <../scadhelpers/all.scad>

module labyrinth_seal(height, inner_diameter, outer_diameter, shift=0) {

  square_side = height * 2 / sqrt(2) + 0.000001;
  loops_count = floor((outer_diameter - inner_diameter) / height / 4); 

  module single_ring(radius) {
    rotate_extrude()
    tx(radius)
    rz(45)
    square([square_side, square_side], center=true);
  }

  intersection() {
    union() {
      for (i = [0 : loops_count]) {
        single_ring(inner_diameter / 2 + i * height * 2 + shift * height);
      }
    }
    ring(inner_diameter, outer_diameter, height + tolerance);
  }
}
