%define system parameters
    LW = 10; LH = 1; LG = 3;
    m = 1; Ic = (1/12)*(LH^2+LW^2);
    g = 1; k = 20; k_list = [.5*k,.5*k,2*k,5*k];
    l0 = 1.5*LG;
    Pbl_box = [-LW;-LH]/2;
    Pbr_box = [LW;-LH]/2;
    Ptl_box = [-LW;LH]/2;
    Ptr_box = [LW;LH]/2;
    boundary_pts = [Pbl_box,Pbr_box,Ptr_box,Ptl_box,Pbl_box];
    Pbl1_world = Pbl_box + [-LG;-LG];
    Pbl2_world = Pbl_box + [LG;-LG];
    Pbr1_world = Pbr_box + [0;-l0];
    Pbr2_world = Pbr_box + [l0;0];
    P_world = [Pbl1_world,Pbl2_world,Pbr1_world,Pbr2_world];
    P_box = [Pbl_box,Pbl_box,Pbr_box,Pbr_box];
    %define system parameters
    box_params = struct();
    box_params.m = m;
    box_params.I = Ic;
    box_params.g = g;
    box_params.k_list = k_list;
    box_params.l0_list = l0*ones(size(P_world,2));
    box_params.P_world = P_world;
    box_params.P_box = P_box;
    box_params.boundary_pts = boundary_pts;


dx0 = 1;
dy0 = 0;
dtheta0 = 0;
vx0 = 0;
vy0 = 0;
vtheta0 = 0;
%small number used to scale initial perturbation
epsilon = 0.1;

my_rate_func = @(t_in, V_in) box_rate_func(t_in,V_in,box_params);

t_in = 0;
root_rate_func = @(V_in) my_rate_func(t_in, V_in);


V0 = [dx0;dy0;dtheta0;vx0;vy0;vtheta0];
Veq = find_equilibrium(root_rate_func, V0);

V0 = Veq + epsilon*[dx0;dy0;dtheta0;vx0;vy0;vtheta0];


J_approx = j_approx(root_rate_func, Veq);

my_linear_rate = @(t_in,V_in) J_approx*(V_in-Veq);

tspan = [0 1];
%run the integration of nonlinear system
[tlist_nonlinear,Vlist_nonlinear] = ode45(my_rate_func, tspan, V0);
% your_integrator(my_rate_func,tspan,V0,...);
%run the integration of linear system
[tlist_linear,Vlist_linear] = ode45(my_linear_rate, tspan, V0);
% your_integrator(my_linear_rate,tspan,V0,...);


% f=figure();
% tcl = tiledlayout(3, 1);
% 
% nexttile(tcl);
% hold on
% 
% plot(tlist_linear, Vlist_linear(:, 1), 'k', LineWidth=5);
% plot(tlist_nonlinear, Vlist_nonlinear(:,1), 'r--', LineWidth=5);
% xlabel("Time (-)", Interpreter="latex", FontSize=14)
% ylabel("x position (-)", Interpreter="latex", FontSize=14)
% hold off;
% 
% nexttile(tcl);
% hold on
% plot(tlist_linear, Vlist_linear(:, 2), 'k', LineWidth=5);
% plot(tlist_nonlinear, Vlist_nonlinear(:,2), 'r--', LineWidth=5);
% xlabel("Time (-)", Interpreter="latex", FontSize=14)
% ylabel("y position (-)", Interpreter="latex", FontSize=14)
% hold off;
% 
% nexttile(tcl);
% hold on
% plot(tlist_linear, Vlist_linear(:, 3), 'k', LineWidth=5);
% plot(tlist_nonlinear, Vlist_nonlinear(:,3), 'r--', LineWidth=5);
% xlabel("Time (-)", Interpreter="latex", FontSize=14)
% ylabel("theta position (-)", Interpreter="latex", FontSize=14)
% hold off;
% 
% sgtitle("Linear vs. Nonlinear EOMs for Large Perturbation ($\epsilon$ = 2)", Interpreter='latex', FontSize=15)
% hl = legend(["Linearized EOMs" "Nonlinear EOMs"],Interpreter='latex', FontSize=15);
% hl.Layout.Tile = 'South';

% exportgraphics(f, 'plots/lin_nonlin_large.png', 'Resolution',300)
