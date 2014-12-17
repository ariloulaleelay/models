$fn = 128;

infinity = 10000;

tolerance = 0.1;

exhaust_diameter = 15;
general_thickness = 1.5;
support_thickness = 0.4;

spiral_gap = 1.5;
spiral_thickness = 1.2;
spiral_height = 5;

disc_diameter = 50;
disc_gap = 0.6;
disc_wall_thickness = 0.9;

disc_lock_height = 3;
disc_lock_width = 1.2; 
disc_lock_gap = 1.2;

intake_pipe_length = 50;
intake_pipe_thickness = 1.5;
intake_pipe_diameter_min = 7.8;
intake_pipe_diameter_max = 9.5;
intake_nozzle_length = 20;

shell_bolts_number = 5;
shell_thickness = general_thickness; 
shell_bolt_diameter = 4;

shell_nozzle_gap = 2;
shell_nozzle_slot = spiral_gap;
shell_nozzle_count = 6;

intake_nozzle_slot = shell_nozzle_gap;

disc_height = spiral_height + disc_lock_height * 2 + disc_wall_thickness * 2;

shell_height = disc_height + disc_gap * 2 + shell_thickness;
shell_internal_diameter = disc_diameter + disc_gap * 2;
shell_diameter = shell_internal_diameter + shell_thickness * 4 + shell_nozzle_gap * 2;
shell_bolt_extension_diameter = shell_bolt_diameter + shell_thickness * 2;

intake_internal_diameter_min = intake_pipe_diameter_min - intake_pipe_thickness * 2;
intake_internal_diameter_max = intake_pipe_diameter_max - intake_pipe_thickness * 2;

shell_nozzle_width = intake_internal_diameter_max;
shell_nozzle_depth = sqrt(
  pow(shell_internal_diameter / 2 + shell_thickness, 2)
  - pow(shell_internal_diameter / 2 - shell_nozzle_slot, 2)
) + tolerance;
