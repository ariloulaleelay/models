include <constants.scad>
include <../scadhelpers/all.scad>
include <../scadhelpers/spiral.scad>

module spiral(fake=false) {
  spiral_thickness = 0.62;
  spiral_internal_diameter = disc_exhaust_diameter + spiral_thickness;
  main_diameter = disc_diameter - shell_thickness * 2;

  spiral_external_diameter = main_diameter - spiral_thickness;
  spiral_loops_count = (spiral_external_diameter - spiral_internal_diameter) / 2 / (spiral_thickness + 0.6);
  spiral_height = shell_height - shell_thickness;


  difference() {
    union() {
      my()
      spiral_1024(spiral_internal_diameter / 2, spiral_external_diameter / 2, 360 * spiral_loops_count, spiral_thickness, shell_height - shell_thickness);

      translate_clone([0, 0, spiral_height - disc_thickness])
      cylinder(h = disc_thickness, d = main_diameter); 

      if (fake) {
        rz(-360 * spiral_loops_count) 
        ty(-disc_thickness / 2)
        cube([spiral_external_diameter / 2, disc_thickness, spiral_height]);
      }

      tz(spiral_height - tolerance)
      cylinder(h = shell_thickness + tolerance, d = shell_exhaust_diameter - shaft_radial_gap); 
    }

    cylinder(h = infinity, d = disc_exhaust_diameter, center = true);
  }
}

spiral();
