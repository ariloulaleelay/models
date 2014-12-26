$fn = 128;

infinity = 10000;

tolerance = 0.1;

bolt_diameter = 4;
general_thickness = 1.8;
bolt_support_thickness = 2.1;
disc_thickness = 1.2;
support_thickness = 0.4;

labyrinth_seal_height = 2.4;

intake_pipe_length = 20;
intake_pipe_thickness = 1.5;
intake_pipe_diameter_min = 7.8;
intake_pipe_diameter_max = 8.5;
intake_pipe_inner_diameter_min = intake_pipe_diameter_min - intake_pipe_thickness * 2;
intake_pipe_inner_diameter_max = intake_pipe_diameter_max - intake_pipe_thickness * 2;

shell_bolts_number = 6;
shell_intake_inner_diameter = 20;
shell_intake_thickness = general_thickness;

shell_thickness = general_thickness; 
shell_intake_cone_height = 
  tan(60) * (shell_intake_inner_diameter - intake_pipe_inner_diameter_max) / 2;

flow_square = pow((intake_pipe_diameter_max + intake_pipe_diameter_min)/4,2) * 3.1415926;

disc_diameter = 55;
shell_diameter = disc_diameter + bolt_diameter;
disc_inner_diameter = 20;
disc_main_height = sqrt(flow_square / 2);
disc_height = disc_main_height + disc_thickness * 2;
disc_nozzle_channel_width = disc_main_height * 2; 
disc_nozzle_slot = disc_main_height;
disc_nozzle_angle = 120;
disc_nozzle_width = disc_nozzle_channel_width + disc_thickness * 2;

seal_inner_diameter = (disc_diameter + disc_inner_diameter) / 2;
seal_diameter = disc_diameter;
