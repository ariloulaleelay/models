$fn = 128;

infinity = 10000;

tolerance = 0.1;

bolt_diameter = 4;
general_thickness = 1.8;
disc_thickness = 1.8;
support_thickness = 0.4;

seal_height = 2.4;

intake_pipe_length = 35;
intake_pipe_thickness = 1.5;
intake_pipe_diameter_min = 7.8;
intake_pipe_diameter_max = 8.5;
intake_pipe_inner_diameter_min = intake_pipe_diameter_min - intake_pipe_thickness * 2;
intake_pipe_inner_diameter_max = intake_pipe_diameter_max - intake_pipe_thickness * 2;

shell_intake_inner_diameter = intake_pipe_inner_diameter_max;
shell_intake_thickness = general_thickness;

shell_thickness = general_thickness; 

flow_square = pow((intake_pipe_diameter_max + intake_pipe_diameter_min)/4,2) * 3.1415926;

disc_diameter = 50;
shell_diameter = intake_pipe_diameter_max + 5 * 2;
disc_inner_diameter = intake_pipe_diameter_max + 2;
disc_main_height = sqrt(flow_square / 3);
disc_height = disc_main_height + disc_thickness * 2;
disc_nozzle_channel_width = disc_main_height * 2; 
disc_nozzle_slot = disc_main_height;
disc_nozzle_angle = 120;
disc_nozzle_width = disc_nozzle_channel_width + disc_thickness * 2;

disc_bolts_number = 6;

seal_inner_diameter = intake_pipe_diameter_max + 5;
seal_diameter = shell_diameter;
