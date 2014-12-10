$fn = 64;

infinity = 10000;

tolerance = 0.1;

disc_diameter = 50;
disc_skirt_width = 2;
disc_skirt_height = 0;
disc_exhaust_diameter = 15;
disc_thickness = 1.5;
disc_radial_gap = 1.5;
disc_number = 5;
disc_gap = 0.4;

nozzle_cone_length = 30;
nozzle_pipe_length = 25;
nozzle_thickness = 2;
nozzle_pipe_diameter = 7.8;
nozzle_slot = 0.5;
nozzle_top_cover = 1;

shell_bolts_number = 8;
shell_thickness = 1.8;
shell_bolt_diameter = 4;
shell_exhaust_diameter = disc_exhaust_diameter + 4;

shell_height = disc_number * (disc_thickness + max(disc_skirt_height, disc_gap)) + disc_gap + shell_thickness;
shell_diameter = disc_diameter + disc_radial_gap * 2 + shell_thickness;
shell_internal_diameter = disc_diameter + disc_radial_gap;
shell_bolt_extension_diameter = shell_bolt_diameter + shell_thickness * 2;

nozzle_internal_diameter = nozzle_pipe_diameter - nozzle_thickness * 2;
nozzle_slot_length = shell_height - shell_thickness - nozzle_top_cover;

shaft_radial_gap = 0.6; 
