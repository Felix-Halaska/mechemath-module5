%updates spring plotting object so that spring is plotted
%with ends located at points P1 and P2
function update_all_springs(spring_plot_struct, p_list_world, box_params)
    
    for i = 1:size(p_list_world, 2)
        update_spring_plot(spring_plot_struct, p_list_world(:,i), box_params.P_world(:,i));
    end
    
end
