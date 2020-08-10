%% run script for plotting basecase, no innate immunity, and sterile infection

% load parameters

data_dictionary = get_data_dictionary();
p = data_dictionary.parameters; % obtain parameters
p_original = p;
%%% base case - no change to parameters 


%%%% [parameter struct, viral load, damaged cells]
% turn off Ab production
p.tau_Ab = 1e9; % antibody molecules/mL (set to initial value but neutralizing effect currently off in model)
p.k_Ab_V = 0; 
data_dictionary.parameters = p;
function_run_model(data_dictionary,1e6,0,1);



%%%% No innate immunity

p = p_original;
p.a_ifnb_i = 0;
p.a_ifnb_d = 0;
p.a_ifnb_dc = 0;
% virus and infected cell activation of DC and M1 turned off
p.k_v = 0.0; ...
p.k_I = 0.0; ...
p.k_dAT = 0.0; ...
p.a_Ab = 0;
p.k_N_IFNg = 0;
p.k_N_TNFa = 0;
p.k_N_GMCSF = 0;
p.k_N_IL17c = 0;
p.a_il6_i = 0;
p.a_tnf_i = 0;
% turn off Ab production
p.tau_Ab = 1e9;
p.k_Ab_V = 0; 

data_dictionary.parameters=p;

function_run_model(data_dictionary,1e6,0,2);


%%% Sterile Immune Response

p = p_original;
% turn off Ab production
p.tau_Ab = 1e9;
p.k_Ab_V = 0; 
function_run_model(data_dictionary,0,1.5e8,3);



%%% sustained inflammation
p = p_original;
% turn off Ab production
p.tau_Ab = 1e9;
p.k_Ab_V = 0; 
damage_sensitivity = 12; %Increase sensitivity of inflammatory cell death
p.k_damage_TNFa = p_original.k_damage_TNFa * damage_sensitivity;
p.k_damage_IL6 = p_original.k_damage_IL6 * damage_sensitivity;
p.k_damage_IL1b = p_original.k_damage_IL1b * damage_sensitivity;
p.k_damage_IFNg = p_original.k_damage_IFNg * damage_sensitivity;
data_dictionary.parameters=p;

function_run_model(data_dictionary,1e6,0,4);


% figure formating
figuremods();