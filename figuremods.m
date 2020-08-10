
figure(1)
    set(gcf, 'Position',  [100, 100, 1200, 800])
    subplot(3,2,1)
    xlim([-5 50])
    grid on
    ax = gca;
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ylim([1e2 1e12])
    yticks([1e2 1e4 1e6 1e8 1e10 1e12])
    ax.FontSize = 16;

    subplot(3,2,4)
    xlim([-5 50])
    ax = gca;
    grid on
    ax.FontSize = 16;
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ylim([0 1])
    ylabel({'AT2', '(normalized to','initial baseline)'})

    subplot(3,2,2)
    xlim([-5 50])
    ylim([1e-2 1e1+10])
    yticks([1e-2 1e-1 1e0 1e1 1e2])
    ax = gca;
    set(ax, 'YScale', 'log')
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;
    legend('Nominal Response (U1)', 'No Innate Response (U2)', 'Sterile Inflammatory Response (U3)','Sustained inflammation (U4)')
    ylabel({'Infected', '(normalized to peak', 'nominal response)'})

    subplot(3,2,3)
    xlim([-5 50])
    ax = gca;
    grid on
    ax.FontSize = 16;
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ylim([0.75 1])
    ylabel({'AT1', '(normalized to','initial baseline)'})

    subplot(3,2,5)
    xlim([-5 50])
    ylim([1e-2 1e2])
    yticks([1e-2 1e-1 1e0 1e1 1e2])
    ax = gca;
    set(ax, 'YScale', 'log')
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;
    ylabel({'Damaged AT1', '(normalized to peak', 'nominal response)'})

    subplot(3,2,6)
    xlim([-5 50])
    ylim([1e-2 1e2])
    yticks([1e-2 1e-1 1e0 1e1 1e2])
    ax = gca;
    set(ax, 'YScale', 'log')
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;
    ylabel({'Damaged AT2', '(normalized to peak', 'nominal response)'})

figure(3)
    set(gcf, 'Position',  [100, 100, 1600, 800])
    subplot(2,4,1)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    set(ax, 'YScale','log')
    ylim([1e0 2*1e2])
    yticks([1e0 1e1 1e2])
    
    subplot(2,4,2)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    set(ax, 'YScale','log')
    ylim([1e0 2*1e2])
    yticks([1e0 1e1 1e2])
    
    subplot(2,4,3)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    set(ax, 'YScale','log')
    ylim([1e0 2*1e2])
    yticks([1e0 1e1 1e2])

    subplot(2,4,4)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    set(ax, 'YScale','log')
    ylim([1e0 2*1e2])
    yticks([1e0 1e1 1e2])
    
    subplot(2,4,5)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    set(ax, 'YScale', 'log')
    ylim([1e0 1e4-3000])
    yticks([1e0 1e1 1e2 1e3])

    subplot(2,4,6)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    set(ax, 'YScale', 'log')
    ylim([1e0 1e4+5000])
    yticks([1e0 1e1 1e2 1e3])

    subplot(2,4,7)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    set(ax, 'YScale', 'log')
    ylim([1e0 1e4])
    yticks([1e0 1e1 1e2 1e3])

    subplot(2,4,8)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    set(ax, 'YScale', 'log')
    ylim([1e0 1e4-3000])
    yticks([1e0 1e1 1e2 1e3])

figure(4)
    set(gcf, 'Position',  [100, 100, 1600, 800])
    subplot(3,4,1)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;

    subplot(3,4,2)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,3)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,4)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,5)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,6)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,7)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,8)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,9)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,10)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,11)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;

figure(5)
    set(gcf, 'Position',  [100, 100, 1600, 800])
    subplot(2,4,1)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(2,4,2)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(2,4,3)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(2,4,4)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(2,4,5)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(2,4,6)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(2,4,7)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(2,4,8)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;


figure(6)
    set(gcf, 'Position',  [100, 100, 1200, 800])
    subplot(3,3,1)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,2)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,3)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,4)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,5)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,6)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,7)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,8)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,9)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;



figure(7)
    set(gcf, 'Position',  [100, 100, 1200, 800])
    subplot(3,3,1)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,2)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,3)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,4)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,5)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,6)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,7)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,8)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    subplot(3,3,9)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid', 'off')
    set(ax, 'YMinorGrid', 'off')
    ax.FontSize = 16;

    figure(8)
    set(gcf, 'Position',  [100, 100, 1600, 800])
    subplot(3,4,1)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;

    subplot(3,4,2)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,3)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,4)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,5)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,6)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,7)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,8)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,9)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,10)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(3,4,11)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;



figure(11)
    set(gcf, 'Position',  [100, 100, 800, 800])
    subplot(2,2,1)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;

    subplot(2,2,2)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;
    
    subplot(2,2,3)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;

    subplot(2,2,4)
    xlim([-5 50])
    ax = gca;
    grid on
    set(ax, 'XMinorGrid','off')
    set(ax, 'YMinorGrid','off')
    ax.FontSize = 16;

