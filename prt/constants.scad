$fn = 128;

infinity = 10000;

tolerance = 0.1;

bolt_diameter = 4;
general_thickness = 1.2;
bolt_support_thickness = 1.5;
disc_thickness = 1.2;
support_thickness = 0.4;

labyrinth_seal_height = 2.7;
labyrinth_seal_width = 1; 
labyrinth_seal_gap = 1;
labyrinth_seal_loops = 4;

intake_pipe_length = 20;
intake_pipe_thickness = 1.5;
intake_pipe_diameter_min = 7.8;
intake_pipe_diameter_max = 8.5;
intake_pipe_inner_diameter_min = intake_pipe_diameter_min - intake_pipe_thickness * 2;
intake_pipe_inner_diameter_max = intake_pipe_diameter_max - intake_pipe_thickness * 2;

shell_intake_inner_diameter = 15;
shell_intake_thickness = general_thickness;
shell_intake_outer_diameter = shell_intake_inner_diameter + labyrinth_seal_width * 2;
shell_diameter = 
  shell_intake_outer_diameter 
  + (labyrinth_seal_gap + labyrinth_seal_width * 2) * 2 * labyrinth_seal_loops;

shell_thickness = general_thickness; 
shell_intake_cone_height = 
  tan(75) * (shell_intake_inner_diameter - intake_pipe_inner_diameter_max) / 2;

disc_diameter = shell_diameter - labyrinth_seal_gap - labyrinth_seal_width * 2;
disc_inner_diameter = shell_intake_inner_diameter + labyrinth_seal_width * 2 + labyrinth_seal_gap;
disc_main_height = 5;
disc_height = disc_main_height + disc_thickness * 2;
disc_nozzle_length = 10;
disc_nozzle_channel_width = 4;
disc_nozzle_slot = 1.5;
disc_nozzle_angle = 15;
disc_nozzle_width = disc_nozzle_channel_width + disc_thickness * 2;
