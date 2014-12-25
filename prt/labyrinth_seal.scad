include <constants.scad>
include <../scadhelpers/all.scad>

module labyrinth_seal(height, inner_diameter, outer_diameter, shift=0) {

  angle = 60;
  triangle_side = height * tan(angle / 2) * 2;
  loops_count = floor((outer_diameter - inner_diameter) / triangle_side / 2); 

  module single_ring(radius) {
    rotate_extrude()
    polygon(points=[
      [radius - 0.01, 0],
      [radius + triangle_side + 0.01, 0],
      [radius + triangle_side / 2 + 0.01, height]
    ]);
  }

  intersection() {
    union() {
      for (i = [0 : loops_count]) {
        single_ring(inner_diameter / 2 + i * triangle_side + shift * triangle_side / 2);
      }
    }
    tz(-tolerance / 2)
    ring(inner_diameter, outer_diameter, height + tolerance);
  }
}
