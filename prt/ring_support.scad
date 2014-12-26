include <../scadhelpers/all.scad>
include <constants.scad>

module ring_support(inner_diameter, outer_diameter, height, gap=3) {
  loops_count = ceil((outer_diameter - inner_diameter) / ((gap + support_thickness) * 2));

  step = (outer_diameter - inner_diameter) / loops_count;

  union() {
    for (i = [0 : loops_count]) {
      ring(inner_diameter + step * i, inner_diameter + step * i + support_thickness, height); 
    }
  }
}
