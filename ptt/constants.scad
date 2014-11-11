$fn = 64;

infinity = 10000;

tolerance = 0.1;

disc_diameter = 50;
disc_internal_diameter = 15;
disc_thickness = 2;
disc_radial_gap = 1;
disc_number = 4;
disc_gap = 1;

nozzle_cone_length = 10;
nozzle_length = 30;
nozzle_thickness = 1;
nozzle_pipe_diameter = 6;

shell_thickness = 3;
shell_bolt_diameter = 4;

shell_exhaust_diameter = disc_internal_diameter + 3;
shell_height = disc_number * (disc_thickness + disc_gap) + disc_gap + shell_thickness;
shell_diameter = disc_diameter + disc_radial_gap * 2 + shell_thickness;
shell_internal_diameter = disc_diameter + disc_radial_gap;
shell_bolt_extension_diameter = shell_bolt_diameter + shell_thickness * 2;

nozzle_internal_diameter = nozzle_pipe_diameter - nozzle_thickness * 2;
nozzle_cone_diameter_min = 1;
