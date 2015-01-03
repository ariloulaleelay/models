include <../scadhelpers/all.scad>

tolerance = 0.1;
$fn = 32;

bolt_diameter = 4;
bolt_length = 20;

thickness = 2.1;

motor_pin_diameter = 2.7;
motor_pin_length = 5;
motor_pin_width = 35;
motor_width = motor_pin_width + thickness;

fan_length = 10;
fan_hole_width = 45;
fan_width = fan_hole_width + thickness * 2 + bolt_diameter;

fan_elevation = bolt_length - fan_length + thickness;
motor_elevation = fan_elevation - thickness;

grid_width = thickness * 2;
grid_thickness = 1.2;

module adapter() {
  module grid() {
    height = motor_elevation - thickness * 2;
    width = grid_width;
    step_count = floor((motor_pin_width + thickness) / (width + grid_thickness));
    step = motor_pin_width / step_count;
    real_thickness = step - width;
    for (i = [0 : step_count - 1]) {
      tz(fan_elevation / 2 + thickness)
      tx(motor_pin_width / 2 - i * step - real_thickness / 2) 
      mx()
      cube([width, fan_width, height]);
    }
  }

  module bolt_support() {
    mirror_clone([0, 1, 0])
    mirror_clone([1, 0, 0])
    ty(fan_hole_width / 2)
    tx(fan_hole_width / 2)
    cylinder(d = bolt_diameter + thickness * 2, h = fan_elevation, center = true);
  }

  module motor_pins(height=motor_pin_length+tolerance) {
    mirror_clone([1, 1, 0])
    tz(fan_elevation / 2 + motor_elevation - tolerance)
    tx(motor_pin_width / 2)
    ty(motor_pin_width / 2)
    cylinder(d = motor_pin_diameter, h = height);
  }

  module motor_pins_hull() {
    mirror_clone([0, 1, 0])
    mirror_clone([1, 0, 0])
    tz(fan_elevation / 2 + motor_elevation - tolerance)
    tx(motor_pin_width / 2)
    ty(motor_pin_width / 2)
    cylinder(d = motor_pin_diameter, h = tolerance);
  }

  module shell() {
    difference() {
      hull() {
        bolt_support();

        motor_pins_hull();
        /*tz(fan_elevation / 2 + motor_elevation - tolerance / 2)
        cube([motor_width, motor_width, tolerance], center = true);
        */
      }

      hull() {
        cube([fan_width - thickness * 2, fan_width - thickness * 2, fan_elevation + tolerance], center=true);

        tz(fan_elevation / 2 + motor_elevation - tolerance / 2)
        cube([motor_width - thickness * 2, motor_width - thickness * 2, tolerance * 2], center = true);
      }

      grid();
    }
  }

  module bolt_holes() {
    mirror_clone([0, 1, 0])
    mirror_clone([1, 0, 0])
    ty(fan_hole_width / 2)
    tx(fan_hole_width / 2)
    cylinder(d = bolt_diameter, h = fan_elevation + tolerance, center = true);
  }


  difference() {
    union() {
      shell();
      bolt_support();
      motor_pins();
    }
    bolt_holes();
  }
}

adapter();
