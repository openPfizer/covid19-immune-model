% load data

mw = data_dictionary.mw;
T=T_sample;

% total index
total_vector = 1:n_vp;

%err_index2 = find(state_array(25,1,:)>0)
success_array = setdiff(total_vector,err_vector);
state_array_success = state_array(:,:,[success_array]);


% calculate statistics

% mean_state_array = median(state_array_success,3);
percentile90 = prctile(state_array_success,75,3);
percentile10 = prctile(state_array_success,25,3);
std_state_array = std(state_array_success,[],3);
%lb_state_array = mean_state_array - std_state_array;
min_state_array =  min(state_array_success,[],3);
max_state_array = max(state_array_success,[],3);


	for species_index = 1:length(data_dictionary.initial_condition)
	  s.(data_dictionary.species_names(species_index,2)) = mean_state_array(:,species_index);
	  low.(data_dictionary.species_names(species_index,2)) = percentile10(:,species_index);
	  high.(data_dictionary.species_names(species_index,2)) = percentile90(:,species_index);

	end

	figure(1)
    set(gcf, 'Position',  [100, 100, 1200, 800])
	subplot(3,2,1)	
	ylabel('Viral Load (#)')
	xlabel('Days')
	hold on
	high.V(high.V<=1) = 1;
	low.V(low.V<=1) = 1;
	patch([T/24;flipud(T/24)]'',[high.V;flipud(low.V)]', 'k','FaceAlpha',0.2)
	plot(T/24,low.V,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.V,'k','LineStyle','--','LineWidth',2)
	xlim([-5 75])
	ax = gca;
	ax.FontSize = 16;
	set(ax, 'YScale', 'log')
	ylim([1e4 1e12])
    yticks([1e2 1e4 1e6 1e8 1e10 1e12])

	subplot(3,2,2)
	ylabel('AT2 (#)')
	xlabel('Days')
	hold on
	patch([T/24;flipud(T/24)]'',[high.AT2;flipud(low.AT2)]', 'k','FaceAlpha',0.2)
	plot(T/24,low.AT2,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.AT2,'k','LineStyle','--','LineWidth',2)
	xlim([-5 75])
	ax = gca;
	ax.FontSize = 16;
	set(ax, 'YScale', 'linear')


	subplot(3,2,3)	
	ylabel('Infected (#)')
	xlabel('Days')
	hold on
	patch([T/24;flipud(T/24)]'',[high.I;flipud(low.I)]', 'k','FaceAlpha',0.2)	
	plot(T/24,low.I,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.I,'k','LineStyle','--','LineWidth',2)
	xlim([-5 75])
	ax = gca;
	ax.FontSize = 16;
	set(ax, 'YScale', 'linear')	
	legend('Median Trajectory','80% Interval')

	subplot(3,2,4)
	plot(T/24, s.AT1,'LineWidth',2,'Color',[0.2422    0.1504   0.6603])
	ylabel('AT1 (#)')
	xlabel('Days')
	hold on
	plot(T/24,low.AT1,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.AT1,'k','LineStyle','--','LineWidth',2)
	xlim([-5 75])
	ax = gca;
	ax.FontSize = 16;
	set(ax, 'YScale', 'linear')	

	subplot(3,2,5)
	plot(T/24, s.dAT1,'LineWidth',2,'Color',[0.2422    0.1504   0.6603])
	ylabel('Damaged AT1 (#)')
	xlabel('Days')
	hold on
	plot(T/24,low.dAT1,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.dAT1,'k','LineStyle','--','LineWidth',2)
	xlim([-5 75])
	ax = gca;
	ax.FontSize = 16;	

	subplot(3,2,6)
	plot(T/24, s.dAT2,'LineWidth',2,'Color',[0.2422    0.1504   0.6603])
	ylabel('Damaged AT2 (#)')
	xlabel('Days')
	hold on
	patch([T/24;flipud(T/24)]'',[high.dAT2;flipud(low.dAT2)]', 'k','FaceAlpha',0.2)	
	plot(T/24,low.dAT2,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.dAT2,'k','LineStyle','--','LineWidth',2)
	xlim([-5 75])
	ax = gca;
	ax.FontSize = 16;	

	vol_alv_ml = data_dictionary.vol_alv_ml;
	vol_plasma = data_dictionary.vol_plasma;
	% convert total cell count to #/uL
	cell2conclung = 1/vol_alv_ml/1000; % cells --> cells/uL
	cell2concplasma = 1/1000; % cells/mL --> cells/uL
	billioncellsperL2cellsperuL = 1e9/1e6;

	figure(3)
	subplot(2,4,1)
	hold on
	xlim([-5 75])
	ylabel('IL6 plasma (pg/mL) ')
	xlabel('Days')
	hold on


	subplot(2,4,2)
	ylabel('IFNb plasma  (pg/ml)')
	xlabel('Days')
	hold on
	xlim([-5 75])

	subplot(2,4,3)
	hold on
	xlim([-5 75])
	ylabel('IFNg plasma  (pg/ml)')
	xlabel('Days')
	hold on

	subplot(2,4,4)
	hold on
	ylabel('IL10 plasma  (pg/ml)')
	xlabel('Days')
	hold on
	xlim([-5 75])

	subplot(2,4,5)
	hold on
	xlim([-5 75])
	ylabel('IL6 lung (pg/mL) ')
	xlabel('Days')
	hold on


	subplot(2,4,6)
	ylabel('IFNb lung  (pg/ml)')
	xlabel('Days')
	hold on
	xlim([-5 75])

	subplot(2,4,7)
	hold on
	xlim([-5 75])
	ylabel('IFNg lung  (pg/ml)')
	xlabel('Days')
	hold on

	subplot(2,4,8)
	hold on
	ylabel('IL10 lung  (pg/ml)')
	xlabel('Days')
	hold on
	xlim([-5 75])



	figure(5)
	subplot(2,4,1)
	hold on 
	shadedErrorBar(T/24,s.M1_c/1000,'lineprops','k-','transparent',1)
	ylabel('pDC plasma (#/\muL)')
	xlabel('Days')
	hold on
	xlim([-5 75])

	subplot(2,4,2)
	hold on
	ylabel('N plasma (#/\muL)')
	xlabel('Days')
	hold on
	xlim([-5 75])

	subplot(2,4,3)
	hold on
	ylabel('CD4 plasma (#/\muL)')
	xlabel('Days')
	hold on
	xlim([-5 75])

	subplot(2,4,4)
	hold on
	ylabel('CTL plasma (#/\muL)')
	xlabel('Days')
	hold on
	xlim([-5 75])

	subplot(2,4,5)
	hold on 
	shadedErrorBar(T/24,s.M1_c/1000,'lineprops','k-','transparent',1)
	ylabel('pDC lung (#/\muL)')
	xlabel('Days')
	hold on
	xlim([-5 75])

	subplot(2,4,6)
	hold on
	ylabel('N lung (#/\muL)')
	xlabel('Days')
	hold on
	xlim([-5 75])

	subplot(2,4,7)
	hold on
	ylabel('CD4 lung (#/\muL)')
	xlabel('Days')
	hold on
	xlim([-5 75])

	subplot(2,4,8)
	hold on
	ylabel('CTL lung (#/\muL)')
	xlabel('Days')
	hold on
	xlim([-5 75])


