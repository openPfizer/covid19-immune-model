%% UNIT TEST 4
%% SAMPLE TIME IT TAKES FOR IMMUNE RESPONSE ACTIVATION AND ITS INTENSITY
% hr time units


% define simulation times
TSTART = 0;
TSTOP = 1200*24; % n days to hours
Ts = 0.01;
 
 
 
TSIM = (TSTART:Ts:TSTOP);
 
 
 
sample_distance = 100; % frequency of data point to save
T_reduced = TSIM(1:sample_distance:end);
%%%% sample range
km_samples = [ 0.01 0.05 0.1 0.5 1  5 10 50 100];
km_bc = find(km_samples == 1);
k_samples = [0.1 0.25 0.5 0.75 1 2.5 5 7.5 10 ];
k_bc  = find(k_samples == 1);

% get parameters and initial conditions
data_dictionary = get_data_dictionary();
p=data_dictionary.parameters;
mw = data_dictionary.mw;
p.tau_Ab = (TSTOP+150000)*24;
p.k_Ab_V = 0; 

% base case parameter that will be sampled
k_v = p.k_v;
k_I = p.k_I;
km_v = p.km_v;
km_I = p.km_I;

Vmax_array = zeros(length(km_samples),length(k_samples));
T_clearance_array = zeros(length(km_samples),length(k_samples));
AT2min_array = zeros(length(km_samples),length(k_samples));
V_array = zeros(length(T_reduced),length(km_samples),length(k_samples));
IL6_array = zeros(length(T_reduced),length(km_samples),length(k_samples));
TNFa_array = zeros(length(T_reduced),length(km_samples),length(k_samples));

% run to steady state
[T,X] = SolveBalances(TSTART,TSTOP,Ts,data_dictionary);
data_dictionary.initial_condition = X(end,:);
data_dictionary.initial_condition(1) = 1e6; % load virus
% % 
% % call solver
TSTOP = 150*24; % n days to hours

for km_index = 1:length(km_samples)
	for k_index = 1:length(k_samples)
		% update variables
		p.k_v = k_v * k_samples(k_index);
		p.k_I = k_I * k_samples(k_index);
		p.km_v = km_v * km_samples(km_index);
		p.km_I = km_I * km_samples(km_index);

		data_dictionary.parameters = p;


		[T,X] = SolveBalances(TSTART,TSTOP,Ts,data_dictionary);
		
		for species_index = 1:length(data_dictionary.initial_condition)
			  s.(data_dictionary.species_names(species_index,2)) = X(:,species_index);
		end

		Vmax_array(km_index,k_index) = max(s.V);
		AT2min_array(km_index,k_index) = min(s.AT2);
		V_array(1:length(T(1:sample_distance:end)),km_index,k_index) = s.V(1:sample_distance:end);
		IL6_array(1:length(T(1:sample_distance:end)),km_index,k_index) = s.IL6(1:sample_distance:end);
		TNFa_array(1:length(T(1:sample_distance:end)),km_index,k_index) = s.TNFa(1:sample_distance:end);
		IL6c_array(1:length(T(1:sample_distance:end)),km_index,k_index) = s.IL6_c(1:sample_distance:end);

		Vmax_index = find(s.V == max(s.V)); % index of max virus
		T_Vmax(km_index,k_index) = T(Vmax_index); % time at peak
 		if (~isempty(T(find(s.V(Vmax_index:end) <= max(s.V)/2,1)+Vmax_index)))
 			T_V_half(km_index,k_index) = T(find(s.V(Vmax_index:end) <= max(s.V)/2,1)+Vmax_index); % find first time point time where V >= Vmax from Tmax to end of simulation
        end
		BloodCRP_array(1:length(T(1:sample_distance:end)),km_index,k_index) = s.Blood_CRP(1:sample_distance:end);

		output = sprintf('km_index: %d k_index: %d time_end days: %d ',km_index, k_index, T(end)/24);
		disp(output)

	end

end


Km_axis = string(km_samples);
K_axis = string(k_samples );

scaled_Vmax_array = Vmax_array./Vmax_array(km_bc,k_bc);

%% time it took for virus to clear
t_2weeks = find(T_reduced >= 2*7*24,1); % find index where t = 2 weeks
t_50days = find(T_reduced >= 50*24,1);

for km_index = 1:length(km_samples)
	for k_index = 1:length(k_samples)

		IL6_max(km_index,k_index) = max(IL6_array(:,km_index,k_index));
		IL6_AUC(km_index,k_index) = trapz((IL6_array(:,km_index,k_index)));
		IL6_AUC_50days(km_index,k_index) = trapz((IL6_array(1:t_50days,km_index,k_index)));
		BloodCRP_max(km_index,k_index) = max(BloodCRP_array(:,km_index,k_index));

	
	end
end

% Tiled figure with 4 heatmaps
	vol_alv_ml = data_dictionary.vol_alv_ml;
	vol_plasma = data_dictionary.vol_plasma;
figure(411), 
    set(gcf, 'Position',  [100, 100, 1200, 800]);
	tl = tiledlayout(2,2);
	%Tile 1
	nexttile
	hm1 = heatmap(K_axis,Km_axis,scaled_Vmax_array);
	hm1.CellLabelColor = 'none';
	hm1.FontSize = 16;
	hm1.Title = 'Normalized Peak Viral Load';
	hm1.YDisplayLabels = {'100','20','10','2','1','0.2','0.1','0.02','0.01'};

	%Tile 2
	nexttile
	hm2 = heatmap(K_axis,Km_axis,T_V_half/24);
	hm2.CellLabelColor = 'none';
	hm2.FontSize = 16;
	hm2.Title = 'Viral t_1_/_2 from Peak Viral Load';
	hm2.YDisplayLabels = {'100','20','10','2','1','0.2','0.1','0.02','0.01'};

	%Tile 3
	nexttile
	hm3 = heatmap(K_axis,Km_axis,IL6_max/vol_alv_ml*mw.il6);
	hm3.CellLabelColor = 'none';
	hm3.FontSize = 16;
	hm3.Title = 'Maximal IL-6 Level';
	hm3.YDisplayLabels = {'100','20','10','2','1','0.2','0.1','0.02','0.01'};

	%Tile 4
	nexttile
	hm4 = heatmap(K_axis,Km_axis,BloodCRP_max*20/1000);
	hm4.CellLabelColor = 'none';
	hm4.FontSize = 16;
	hm4.Title = 'Maximal hsCRP Level';
	hm4.YDisplayLabels = {'100','20','10','2','1','0.2','0.1','0.02','0.01'};

	ylabel(tl, 'Sensitivity of Innate Immune Response (fold change)','FontSize',20)
	xlabel(tl, 'Strength of Innate Immune Response (fold change)','FontSize',20)

	% Insert textboxes on colorbars

	MyBox1 = annotation('textbox');
	MyBox1.String = 'days';
	MyBox1.BackgroundColor = 'w';
	MyBox1.LineStyle = 'none';
	MyBox1.FontSize = 16;
	set(MyBox1, 'Position',[835,940,45,35]/1000)

	MyBox2 = annotation('textbox');
	MyBox2.String = 'pg/mL';
	MyBox2.BackgroundColor = 'w';
	MyBox2.LineStyle = 'none';
	MyBox2.FontSize = 16;
	set(MyBox2, 'Position',[360,475,45,35]/1000)

	MyBox3 = annotation('textbox');
	MyBox3.String = 'mg/L';
	MyBox3.BackgroundColor = 'w';
	MyBox3.LineStyle = 'none';
	MyBox3.FontSize = 16;
	set(MyBox3, 'Position',[835,475,45,35]/1000)


	% Insert textboxes on nominal squares
	MyBox4 = annotation('textbox');
	set(MyBox4, 'Position',[210,735,31,35]/1000)
	set(MyBox4, 'LineWidth',2)
	MyBox5 = annotation('textbox');
	set(MyBox5, 'Position',[684,735,31,35]/1000)
	set(MyBox5, 'LineWidth',2)
	MyBox6 = annotation('textbox');
	set(MyBox6, 'Position',[210,265,31,35]/1000)
	set(MyBox6, 'LineWidth',2)
	MyBox7 = annotation('textbox');
	set(MyBox7, 'Position',[684,265,31,35]/1000)
	set(MyBox7, 'LineWidth',2)
