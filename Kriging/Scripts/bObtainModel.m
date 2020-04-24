clc;
clear;
error=0.0001;
[dmodel2,initial_add_point,initial_add_value] = convex_eg1(error);
save dmodel2
