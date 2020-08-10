% Drive file
% hr time units


% define simulation times
function function_run_model(data_dictionary,virus_inoculation,IC_dAT,line_index)
	TSTART = 0;
	TSTOP = 1200*24; % n days to hours
	Ts = 0.1;

	TSIM = (TSTART:Ts:TSTOP);


	mw = data_dictionary.mw;


	[T,X] = SolveBalances(TSTART,TSTOP,Ts,data_dictionary);
	data_dictionary.initial_condition = X(end,:);
	data_dictionary.initial_condition(1) = virus_inoculation; % load virus 
	if IC_dAT ~= 0
		data_dictionary.initial_condition(5) = IC_dAT; % load virus  
		data_dictionary.initial_condition(6) = IC_dAT; % load virus 
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
			  
	% Normalization variables
	dAT2maxn =  3.0177e+06;
	dAT1maxn = 2.2133e+06;
	Imaxn = 1.9772e+09;
	figure(1)
		subplot(3,2,1)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.V,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel({'Viral Load'; '(RNA molecules/mL)'})
		xlabel('Days')
		hold on
		xlim([-25 75])
		set(gca, 'YScale', 'log')
		ylim([1e4 1e12])
		yticks([1e4 1e6 1e8 1e10 1e12])

		subplot(3,2,4)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.AT2/s.AT2(1),'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('AT2 (#)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		set(gca, 'YScale', 'linear')

		subplot(3,2,2)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.I/Imaxn,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Infected (#)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		set(gca, 'YScale', 'linear')

		subplot(3,2,3)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.AT1/s.AT1(1),'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('AT1 (#)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		set(gca, 'YScale', 'linear')

		subplot(3,2,5)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.dAT1/dAT1maxn,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Damaged AT1 (#)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		set(gca, 'YScale', 'log')
		ylim([1e2 1e11])
		yticks([1e2 1e4 1e6 1e8 1e10])

		subplot(3,2,6)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.dAT2/dAT2maxn,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Damaged AT2 (#)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		set(gca, 'YScale', 'log')
		ylim([1e2 1e11])
		yticks([1e2 1e4 1e6 1e8 1e10])

	figure(4)
		subplot(3,4,1)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL6_c*mw.il6,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		xlim([-25 75])
		ylabel('IL6 plasma (pg/mL) ')
		xlabel('Days')

		subplot(3,4,2)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.TNFa_c*mw.tnfa,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('TNFa plasma  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,3)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL12_c*mw.il2,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('IL12 plasma (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,4)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IFNb_c*mw.ifnb,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('IFNb plasma  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,5)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IFNg_c*mw.ifng,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		xlim([-25 75])
		ylabel('IFNg plasma  (pg/ml)')
		xlabel('Days')
		hold on

		subplot(3,4,6)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL10_c*mw.il10,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('IL10 plasma  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,7)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL17_c*mw.il17,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('IL17 plasma  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,8)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL2_c*mw.il2,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('IL2 plasma  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,9)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL1b_c*mw.il1b,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('IL1b plasma  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,10)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.TGFb_c*mw.tgfb,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('TGFb plasma  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,11)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.GMCSF_c*mw.gmcsf,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('GMCSF plasma  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

	vol_alv_ml = data_dictionary.vol_alv_ml;
	vol_plasma = data_dictionary.vol_plasma;
	% convert total cell count to #/uL
	%% data is in billion cells / L
	cell2conclung = 1/vol_alv_ml/1000; % cells --> cells/uL
	cell2concplasma = 1/1000; % cells/mL --> cells/uL
	billioncellsperL2cellsperuL = 1e9/1e6;

	figure(6)
		subplot(3,3,1)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.pDC_c/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on 
		ylabel('pDC plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,2)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.M1_c/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('M1 plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,3)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.N_c/1000+data_dictionary.iN,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('N plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,4)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Th1_c/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Th1 plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,5)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Th17_c/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Th17 plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,6)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.CTL_c/1000+data_dictionary.iCD8,'LineWidth',2.5,'Color',ax.ColorOrder	(line_index,:))
		hold on
		ylabel('CTL plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,7)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Treg_c/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Treg plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,8)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Th1_c/1000+s.Th17_c/1000+s.Treg_c/1000 + data_dictionary.iCD4,'LineWidth',2.5,	'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('CD4 plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,9)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Th1_c/1000+s.Th17_c/1000+s.Treg_c/1000+s.CTL_c/1000+data_dictionary.iCD4	+data_dictionary.iCD4,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('CD3 plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])



	figure(3)
		subplot(2,4,1)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL6_c*mw.il6,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		xlim([-25 75])
		ylabel('IL6 plasma (pg/mL) ')
		xlabel('Days')
		hold on

		subplot(2,4,2)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IFNb_c*mw.ifnb,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Type I IFN plasma  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(2,4,3)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IFNg_c*mw.ifng,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		xlim([-25 75])
		ylabel('IFN\gamma plasma  (pg/ml)')
		xlabel('Days')
		hold on

		subplot(2,4,4)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL10_c*mw.il10,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('IL10 plasma  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(2,4,5)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL6/vol_alv_ml*mw.il6,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		xlim([-25 75])
		ylabel('IL6 lung (pg/mL) ')
		xlabel('Days')
		hold on

		subplot(2,4,6)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IFNb/vol_alv_ml*mw.ifnb,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Type I IFN lung  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(2,4,7)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IFNg/vol_alv_ml*mw.ifng,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		xlim([-25 75])
		ylabel('IFN\gamma lung  (pg/ml)')
		xlabel('Days')
		hold on

		subplot(2,4,8)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL10/vol_alv_ml*mw.il10,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('IL10 lung  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

	figure(5)
		subplot(2,4,1)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.pDC_c/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on 
		ylabel('Total DC plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		ylim([0 180])

		subplot(2,4,2)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.N_c/1000+data_dictionary.iN,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('Total N plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		ylim([0 3200])

		subplot(2,4,3)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Th1_c/1000+s.Th17_c/1000+s.Treg_c/1000 + data_dictionary.iCD4,'LineWidth',2.5,	'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel({'Total CD4+';'T cells plasma (#/\muL)'})
		xlabel('Days')
		hold on
		xlim([-25 75])
		ylim([0 1000])

		subplot(2,4,4)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.CTL_c/1000+data_dictionary.iCD8,'LineWidth',2.5,'Color',ax.ColorOrder	(line_index,:))
		hold on
		ylabel('Total CTL plasma (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		ylim([0 1000])

		subplot(2,4,5)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.pDC/vol_alv_ml/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on 
		ylabel('Activated DC lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		ylim([0 180])

		subplot(2,4,6)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.N/vol_alv_ml/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('Activated N lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		ylim([0 3200])

		subplot(2,4,7)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Th1/vol_alv_ml/1000+s.Th17/vol_alv_ml/1000+s.Treg/vol_alv_ml/1000 ,'LineWidth',	2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel({'Activated CD4+';' T cells lung (#/\muL)'})
		xlabel('Days')
		hold on
		xlim([-25 75])
		ylim([0 1000])

		subplot(2,4,8)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.CTL/vol_alv_ml/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('Activated CTL lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])
		ylim([0 1000])



figure(7)
		subplot(3,3,1)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.pDC/vol_alv_ml/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on 
		ylabel('pDC lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,2)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.M1/vol_alv_ml/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('M1 lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,3)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.N/vol_alv_ml/1000+data_dictionary.iN,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('N lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,4)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Th1/vol_alv_ml/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Th1 lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,5)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Th17/vol_alv_ml/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Th17 lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,6)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.CTL/vol_alv_ml/1000+data_dictionary.iCD8,'LineWidth',2.5,'Color',ax.ColorOrder	(line_index,:))
		hold on
		ylabel('CTL lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,7)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Treg/vol_alv_ml/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('Treg lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,8)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Th1/vol_alv_ml/1000+s.Th17/vol_alv_ml/1000+s.Treg/vol_alv_ml/1000 + data_dictionary.iCD4,'LineWidth',2.5,	'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('CD4 lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,3,9)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.Th1/vol_alv_ml/1000+s.Th17/vol_alv_ml/1000+s.Treg/vol_alv_ml/1000+s.CTL/vol_alv_ml/1000+data_dictionary.iCD4	+data_dictionary.iCD4,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('CD3 lung (#/\muL)')
		xlabel('Days')
		hold on
		xlim([-25 75])

figure(8)
		subplot(3,4,1)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL6/vol_alv_ml*mw.il6,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		xlim([-25 75])
		ylabel('IL6 lung (pg/mL) ')
		xlabel('Days')

		subplot(3,4,2)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.TNFa/vol_alv_ml*mw.tnfa,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('TNFa lung  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,3)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL12/vol_alv_ml*mw.il2,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('IL12 lung (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,4)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IFNb/vol_alv_ml*mw.ifnb,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('IFNb lung  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,5)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IFNg/vol_alv_ml*mw.ifng,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		xlim([-25 75])
		ylabel('IFNg lung  (pg/ml)')
		xlabel('Days')
		hold on

		subplot(3,4,6)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL10/vol_alv_ml*mw.il10,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('IL10 lung  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,7)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL17/vol_alv_ml*mw.il17,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('IL17 lung  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,8)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL2/vol_alv_ml*mw.il2,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('IL2 lung  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,9)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.IL1b/vol_alv_ml*mw.il1b,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('IL1b lung  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,10)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.TGFb/vol_alv_ml*mw.tgfb,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('TGFb lung  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

		subplot(3,4,11)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.GMCSF/vol_alv_ml*mw.gmcsf,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		ylabel('GMCSF lung  (pg/ml)')
		xlabel('Days')
		hold on
		xlim([-25 75])

	figure(11)
		subplot(2,2,1)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24, s.Blood_CRP*mw.crp/1000,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:)) % s.Blood_CRP*mw.crp/1000 to convert to mg/L units
		hold on
		ylabel('Blood CRP mg/L')
		xlabel('Days')
		xlim([-25 75])

		subplot(2,2,2)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.FER_c*mw.fer,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('Ferritin plasma ug/L')
		xlabel('Days')
		xlim([-25 75])

		subplot(2,2,3)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.SPD*mw.spd/vol_alv_ml,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:)) 
		hold on
		ylabel('Surfactant Protein D lung ng/mL ')
		xlabel('Days')
		xlim([-25 75])
	
		subplot(2,2,4)
		ax = gca;
		ax.LineStyleOrder = {'-','-','-.','-.'};
		ax.LineStyleOrderIndex = line_index;
		ax.ColorOrder = [cmap(2,:);cmap(3,:);cmap(4,:);cmap(1,:)];
		plot(T/24,s.SPD_c*mw.spd,'LineWidth',2.5,'Color',ax.ColorOrder(line_index,:))
		hold on
		ylabel('Surfactant Protein D plasma ng/mL')
		xlabel('Days')
		xlim([-25 75])
end