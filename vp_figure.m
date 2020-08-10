%% VP Figure
% load parameters
data_dictionary = get_data_dictionary();
p = data_dictionary.parameters; % obtain parameters
p_original = p;
%%% base case - no change to parameters 


%%%% [parameter struct, viral load, damaged cells]
% turn off Ab production
p.tau_Ab = 1e9;
p.k_Ab_V = 0; 
data_dictionary.parameters = p;
function_run_vpfigure(data_dictionary,1e6,0,1);

% load 'VP_parameters.mat'

mw = data_dictionary.mw;
T=T_sample;

% total index
total_vector = 1:n_vp;

success_array = setdiff(total_vector,err_vector);
state_array_success = state_array(:,:,[success_array]);


% calculate statistics

percentilehigh = prctile(state_array_success,80,3);
percentilelow = prctile(state_array_success,20,3);
std_state_array = std(state_array_success,[],3);
min_state_array =  min(state_array_success,[],3);
max_state_array = max(state_array_success,[],3);


	for species_index = 1:length(data_dictionary.initial_condition)
	  low.(data_dictionary.species_names(species_index,2)) = percentilelow(:,species_index);
	  high.(data_dictionary.species_names(species_index,2)) = percentilehigh(:,species_index);

	end

figure(101)
    set(gcf, 'Position',  [100, 100, 1200, 800])
	subplot(3,2,1)
	ylabel({'Viral Load'; '(RNA molecules/mL)'})
	xlabel('Days')
	hold on
	high.V(high.V<=1) = 1;
	low.V(low.V<=1) = 1;
	patch([T/24;flipud(T/24)]',[high.V;flipud(low.V)]', 'k','FaceAlpha',0.2)
	plot(T/24,low.V,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.V,'k','LineStyle','--','LineWidth',2)
	xlim([-5 50])
	ax = gca;
	ax.FontSize = 16;
	set(ax, 'YScale', 'log')
	ylim([1e4 1e12])
    yticks([1e2 1e4 1e6 1e8 1e10 1e12])


	subplot(3,2,2)
	ylabel('AT2 (#)')
	xlabel('Days')
	hold on
	patch([T/24;flipud(T/24)]',[high.AT2;flipud(low.AT2)]', 'k','FaceAlpha',0.2)
	plot(T/24,low.AT2,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.AT2,'k','LineStyle','--','LineWidth',2)
	xlim([-5 50])
	ax = gca;
	ax.FontSize = 16;
	set(ax, 'YScale', 'linear')


	subplot(3,2,3)
	ylabel('Infected (#)')
	xlabel('Days')
	hold on
	patch([T/24;flipud(T/24)]',[high.I;flipud(low.I)]', 'k','FaceAlpha',0.2)	
	plot(T/24,low.I,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.I,'k','LineStyle','--','LineWidth',2)
	xlim([-5 50])
	ax = gca;
	ax.FontSize = 16;
	set(ax, 'YScale', 'linear')
	legend('Nominal Response (U1)','20^{th}-80^{th} Percentile Interval')

	subplot(3,2,4)

	ylabel('Damaged AT2 (#)')
	xlabel('Days')
	hold on
	patch([T/24;flipud(T/24)]',[high.dAT2;flipud(low.dAT2)]', 'k','FaceAlpha',0.2)	
	plot(T/24,low.dAT2,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.dAT2,'k','LineStyle','--','LineWidth',2)
	xlim([-5 50])
	ax = gca;
	ax.FontSize = 16;


	subplot(3,2,5)

	ylabel({'Type I IFN';'Plasma(pg/ml)'})
	xlabel('Days')
    hold on
	patch([T/24;flipud(T/24)]',[high.IFNb_c*mw.ifnb;flipud(low.IFNb_c*mw.ifnb)]', 'k','FaceAlpha',0.2)	    
	plot(T/24,low.IFNb_c*mw.ifnb,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.IFNb_c*mw.ifnb,'k','LineStyle','--','LineWidth',2)
	xlim([-5 50])
	ax = gca;
	ax.FontSize = 16;

	subplot(3,2,6)
	ylabel('IL-6 Plasma (pg/ml)')
	xlabel('Days')
	hold on
	patch([T/24;flipud(T/24)]',[high.IL6_c*mw.il6;flipud(low.IL6_c*mw.il6)]', 'k','FaceAlpha',0.2)	
	plot(T/24,low.IL6_c*mw.il6,'k','LineStyle','--','LineWidth',2)
	plot(T/24,high.IL6_c*mw.il6,'k','LineStyle','--','LineWidth',2)
	xlim([-5 50])
	ax = gca;
	ax.FontSize = 16;
	

    function function_run_vpfigure(data_dictionary,virus_innoculation,IC_dAT,line_index)
        TSTART = 0;
        TSTOP = 1200*24; % ~21 days
        Ts = 0.1;

        TSIM = (TSTART:Ts:TSTOP);


        mw = data_dictionary.mw;


        [T,X] = SolveBalances(TSTART,TSTOP,Ts,data_dictionary);
        % data_dictionary.initialondition = X(end,:);
        data_dictionary.initial_condition = X(end,:);
        data_dictionary.initial_condition(1) = virus_innoculation; % load virus - 100/uL -> 2e5
        if IC_dAT ~= 0
            data_dictionary.initial_condition(5) = IC_dAT; % load virus - 100/uL -> 2e5
            data_dictionary.initial_condition(6) = IC_dAT; % load virus - 100/uL -> 2e5
        end
        % % 
        % % call solver
        TSTART = TSTOP;
        TSTOP2 = TSTOP+75*24+75*24;
        T2=0;
        [T2,X2] = SolveBalances(TSTART,TSTOP2,Ts,data_dictionary);
        % % 
        T_basal = T;
        X_basal = X;
        T_virus = [T_basal;T2];
        X_virus = [X_basal;X2];
        T = [T_virus-TSTOP];
        X = [X_virus];
        for species_index = 1:length(data_dictionary.initial_condition)
            s.(data_dictionary.species_names(species_index,2)) = X(:,species_index);
        end

        % Set colormap
        cmap =  [202  0       32
                0.2422*255    0.1504*255    0.6603*255
                217 95 2
                0 0 0]/255;
                
        % Normalization variables to normalize plots on figure
        dAT2maxn =  3.0177e+06;
        dAT1maxn = 2.2133e+06;
        Imaxn = 1.9772e+09;
        figure(101)
            subplot(3,2,1)
            ax = gca;
            ax.LineStyleOrder = {'-','-','-.','-.'};
            ax.LineStyleOrderIndex = line_index;
            ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
            plot(T/24,s.V,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
            ylabel('Viral Load (#)')
            xlabel('Days')
            hold on
            xlim([-5 50])
            set(gca, 'YScale', 'log')
            ylim([1e4 1e12])
            yticks([1e4 1e6 1e8 1e10 1e12])

            subplot(3,2,2)
            ax = gca;
            ax.LineStyleOrder = {'-','-','-.','-.'};
            ax.LineStyleOrderIndex = line_index;
            ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
            plot(T/24,s.AT2,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
            ylabel('AT2 (#)')
            xlabel('Days')
            hold on
            xlim([-5 50])
            set(gca, 'YScale', 'linear')
            ylim([0 3.1e10])

            subplot(3,2,3)
            ax = gca;
            ax.LineStyleOrder = {'-','-','-.','-.'};
            ax.LineStyleOrderIndex = line_index;
            ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
            plot(T/24,s.I,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
            ylabel('Infected (#)')
            xlabel('Days')
            hold on
            xlim([-5 50])
            set(gca, 'YScale', 'linear')
  

            subplot(3,2,4)
            ax = gca;
            ax.LineStyleOrder = {'-','-','-.','-.'};
            ax.LineStyleOrderIndex = line_index;
            ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
            plot(T/24,s.dAT2,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
            ylabel('Damaged AT2 (#)')
            xlabel('Days')
            hold on
            xlim([-5 50])
    

            subplot(3,2,5)
            ax = gca;
            ax.LineStyleOrder = {'-','-','-.','-.'};
            ax.LineStyleOrderIndex = line_index;
            ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
            plot(T/24,s.IFNb_c*mw.ifnb,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
            ylabel('Damaged AT1 (#)')
            xlabel('Days')
            hold on
            xlim([-5 50])
            set(gca, 'YScale', 'linear')
            ylim([0 3*1e2])

            subplot(3,2,6)
            ax = gca;
            ax.LineStyleOrder = {'-','-','-.','-.'};
            ax.LineStyleOrderIndex = line_index;
            ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
            plot(T/24,s.IL6_c*mw.il6,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
            ylabel('Damaged AT2 (#)')
            xlabel('Days')
            hold on
            xlim([-5 50])
            set(gca, 'YScale', 'linear')
            ylim([0 3*1e2])

    end