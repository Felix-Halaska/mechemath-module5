%updates spring plotting object so that spring is plotted
%with ends located at points P1 and P2
function update_all_springs(spring_plots, p_list_world, box_params)
    
    num_springs = size(p_list_world,2);

    for n = 1:num_springs
        update_spring_plot(spring_plots{n}, p_list_world(:,n), box_params.P_world(:,n));
    end
end

% %updates spring plotting object so that spring is plotted
% %with ends located at points P1 and P2
% function update_all_springs(spring_plot_struct, p_list_world, box_params)
% 
%     for i = 1:size(p_list_world, 2)
%         update_spring_plot(spring_plot_struct, p_list_world(:,i), box_params.P_world(:,i));
%     end
% 
% end
