function data_dictionary = get_data_dictionary(PARAMS)
    
 
	% important lung variables
	n_alveolar = 480e6; % 480 million alveolars per lung on average 274-790 million; coefficient of variation: 37% (https://www.researchgate.net/publication/9078564_The_Number_of_Alveoli_in_the_Human_Lung)
	size_alveolar = 4.2e6; %um^3, note 1 um^3 = 1e-15 L
	conversion_um3toL = 1e-15;
	vol_alv = n_alveolar*size_alveolar*conversion_um3toL;
	pulmonary_epithelial_cells = 5e10; % assumption, range used in other models
	AT1_total = 0.40 * pulmonary_epithelial_cells;
	AT2_total = 0.60 * pulmonary_epithelial_cells;

	% baseline concentrations of cells
	AT1_0 = AT1_total;%/vol_alv;
	AT2_0 = AT2_total;%/vol_alv;

	vol_alv_ml = vol_alv * 1000;
	vol_plasma = 5000; % mL

	% molecular weights g/mol. Da
	mw.il6 = 21000;
	mw.il2 = 15500;
	mw.il1b = 17500;
	mw.il10 = 18000;
	mw.il12 = 70000;
	mw.il17 = 35000;
	mw.tnfa = 25900;
	mw.ifnb = 20000;
	mw.ifng = 23000;
	mw.tgfb = 4760;
	mw.gmcsf = 25000; % 14 - 35kDa
	% molecular weights kDa
	mw.fer = 484; %kDa
	mw.spd = 43; %kDa
	mw.crp = 20; %kDa



	% variables from IBD model needed for parameters
	iDC = 1e7;
	M0 = 1e7;
	Th0 = 1e7;
	iCD4 = 300; % #/uL plasma naive T cells
	iCD8 = 200; % #/uL plasma naive T cells
	iMono = 500; % #/uL plasma monocytes
	iN = 2000; % immature N

% Read Parameters from Excel workbook and initialize data dictionary
   [param,pfield,~] = xlsread('Initialize.xlsx','Parameters');
    for ii = 1:length(pfield)
        k.(pfield{ii,1}) = param(ii);
    end
    
    [IC,sn,~] = xlsread('Initialize.xlsx','IC');
    species_list = strings(length(sn),1);
    [species_list{:}] = sn{:};
	n_params = length(pfield);
	n_species = length(IC);

	num_list_species = linspace(1,n_species,n_species)';
	species_names = [num_list_species species_list];

	num_list = linspace(1,n_params,n_params)';
	parameter_names = [num_list cell2mat(struct2cell(k))];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 	data_dictionary.parameters = k;
 	data_dictionary.initial_condition = IC;
 	data_dictionary.parameter_names = parameter_names;
 	data_dictionary.species_names = species_names;
 	data_dictionary.n_params = n_params;
 	data_dictionary.n_species = n_species;
 	data_dictionary.vol_plasma = vol_plasma;
 	data_dictionary.vol_alv_ml = vol_alv_ml;
 	data_dictionary.mw = mw;
 	data_dictionary.iCD4 = iCD4;
 	data_dictionary.iCD8 = iCD8;
 	data_dictionary.iMono = iMono;
 	data_dictionary.iN = iN;


end