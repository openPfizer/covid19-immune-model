function [position,isterminal,direction] = covidEventsFcn(t,x)
    position = x(1) - 1e2; % The value that we want to be zero
    isterminal = 1;  % Halt integration 
    direction = -1;   % locates only zeros where the event function is increasing
end