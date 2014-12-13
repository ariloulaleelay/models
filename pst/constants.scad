$fn = 64;

infinity = 10000;

tolerance = 0.1;

exhaust_diameter = 15;
general_thickness = 1.54;

spiral_gap = 1.5;
spiral_thickness = 0.64;
spiral_height = 6;

disc_diameter = 50;
disc_gap = 1;
disc_wall_thickness = 1.2;

disc_lock_height = 2.4;
disc_lock_width = 1.2;
disc_lock_gap = 0.34;


intake_pipe_length = 30;
intake_pipe_thickness = 1.5;
intake_pipe_diameter_min = 7.8;
intake_pipe_diameter_max = 9;

shell_bolts_number = 8;
shell_thickness = general_thickness; 
shell_bolt_diameter = 4;

disc_height = spiral_height + disc_lock_height * 2 + disc_wall_thickness * 2;

shell_height = disc_height + disc_gap * 2 + shell_thickness;
shell_diameter = disc_diameter + disc_gap * 2 + shell_thickness * 2;
shell_internal_diameter = shell_diameter - shell_thickness * 2;
shell_bolt_extension_diameter = shell_bolt_diameter + shell_thickness * 2;

intake_internal_diameter_min = intake_pipe_diameter_min - intake_pipe_thickness * 2;
intake_internal_diameter_max = intake_pipe_diameter_max - intake_pipe_thickness * 2;

