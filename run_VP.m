%% run preliminary VP
%% assume uniform distribution, lhs sampling

n_vp = 1000;
n_freq = 50; % sampling frequency so we dont save all data points
% load data dictionary and obtain parameters
data_dictionary = get_data_dictionary();
p_org = data_dictionary.parameters;


% parameters to vary
perturbation_name_vector = [
"A_V"
"k_int"
"b_V"
"k_V_innate"
"f_int"
"k_v"
"k_I"
"k_dAT"
"km_v"
"km_I"
"km_dAT"
"k_kill"
"km_kill"
"k_damage_cyt"
];

for parameter_index = 1:length(perturbation_name_vector)
	parameters(parameter_index,1) = p_org.(perturbation_name_vector(parameter_index));
end

rng('default')
s = rng;
lhs_samples_raw = lhsdesign(1000,15);
% convert lhs samples that are 0-1 to 20% above and below parameter set
%% mean around 1, LB and UB at 0.8 and 1.2
% parameters - 20% above and below base case parameters
% virus innoculation - 1 order or magnitude above and below base case (1e5 - 1e7 with 1e6 being base case);
lhs_samples(:,1:5) = lhs_samples_raw(:,1:5) + 0.5;
lhs_samples(:,6:length(perturbation_name_vector)+1) = 10.^(lhs_samples_raw(:,6:length(perturbation_name_vector)+1)*2 -1 );

% initialize state arrays
n_time_points = length(0:0.1:(100*24)/n_freq); % tstart : tstep: tstop divided by sampling frequency- every 50 points
state_array = zeros(n_time_points,49,n_vp);

err_vector = [];

for sample_index = 1:n_vp

	tmp_parameters = p_org;

	% update parameters to perturbed parameters
	for parameter_index = 1:length(perturbation_name_vector)
		tmp_parameters.(perturbation_name_vector(parameter_index)) = p_org.(perturbation_name_vector(parameter_index))*lhs_samples(sample_index,parameter_index);
	end

	virus_innoculation = 1e6*lhs_samples(sample_index,length(perturbation_name_vector)+1); % varying virus innoculation
	data_dictionary.parameters = tmp_parameters;

	[T,X] = function_run_model_noplots(data_dictionary,virus_innoculation,0);

	T_sample = T(1:n_freq:end); %% only append 1 to index the size of T instead of all just incase there is an intergration error
	size_sample = length(T(1:n_freq:end));
	state_array(1:size_sample,:, sample_index) = X(1:n_freq:end,:);

	if size_sample < n_time_points
		err_vector = [err_vector;sample_index];
	end
	output = sprintf('sample number: %d',sample_index);
	disp(output)
end

% save VP_parameters.mat 
