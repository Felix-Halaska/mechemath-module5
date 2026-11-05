%Computes the linear and angular acceleration of the box
%given its current position and orientation
%INPUTS:
%x: current x position of the box
%y: current y position of the box
%theta: current orientation of the box
%box_params: a struct containing the parameters that describe the system
%Fields:
%box_params.m: mass of the box
%box_params.I: moment of inertia w/respect to centroid
%box_params.g: acceleration due to gravity
%box_params.k_list: list of spring stiffnesses
%box_params.l0_list: list of spring natural lengths
%box_params.P_world: 2 x n list of static mounting
% points for the spring (in the world frame)
%box_params.P_box: 2 x n list of mounting points
% for the spring (in the box frame)
%
%OUTPUTS
%ax: x acceleration of the box
%ay: y acceleration of the box
%atheta: angular acceleration of the box
function [ax,ay,atheta] = compute_accel(x,y,theta,box_params)
    force = [];
    moment = [];
    Plist_world = compute_rbt(x,y,theta,box_params.P_box);

    for i = 1:length(box_params.k_list)
        force = [force, compute_spring_force(box_params.k_list(i), box_params.l0_list(i), box_params.P_world(:,i), Plist_world(:,i))];
        moment = [moment, (Plist_world(1,i)-x) * force(2,i) - (Plist_world(2,i)-y)*force(1,i)];
    end
    a_translation = [0;-box_params.g] + 1/box_params.m * sum(force,2);
    ax = a_translation(1,:);
    ay = a_translation(2,:);
    atheta = 1/box_params.I * sum(moment,2);
end