%% script to generate all the figures from manuscript
figname2 = ["Figure 7","Figure 6", "Figure S1","Figure S3","Figure S5","Figure S4","Figure 5","Figure S2","Figure 4","Figure 3"];

run run_unit_test_script.m


run run_parameter_sweep.m

run run_VP.m
run vp_figure.m


h =  findobj('type','figure');
for ii = 1:length(h)
    figno(ii) = strcat("-f",num2str(h(ii).Number));
    print(figno(ii),figname2(ii),'-dpng');
    
end
close all

exit