% Drive file
% hr time units

TSTART = 0;
TSTOP = 1200*24; % ~n days to h
Ts = 0.1;

TSIM = (TSTART:Ts:TSTOP);
virus_inoculation = 1e6; % (viral mRNA/mL)

data_dictionary = get_data_dictionary();
mw = data_dictionary.mw;

% run to steady state
[T,X] = SolveBalances(TSTART,TSTOP,Ts,data_dictionary);
data_dictionary.initial_condition = X(end,:);
% add virus
data_dictionary.initial_condition(1) = virus_inoculation; % load virus - 100/uL -> 2e5


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