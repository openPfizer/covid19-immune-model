% Drive file
% hr time units


% define simulation times
function [T,X] = function_run_model_noplots(data_dictionary,virus_inoculation,IC_dAT)
	
	TSTART = 0;
	TSTOP = 500*24; % n days to hours
	Ts = 0.1;

	TSIM = (TSTART:Ts:TSTOP);

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
	TSTOP2 = TSTOP+75*24;
	T2=0;
	 [T2,X2] = SolveBalances(TSTART,TSTOP2,Ts,data_dictionary);
	% % 

	
	T_basal = T((TSTOP-25*24)/Ts:end);
	X_basal = X((TSTOP-25*24)/Ts:end,:);
	T_virus = [T_basal;T2];
	X_virus = [X_basal;X2];
	T = [T_virus-TSTOP];
	X = [X_virus];


end