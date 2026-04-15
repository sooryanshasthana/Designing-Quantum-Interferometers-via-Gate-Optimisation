clc
clear

load("shadowscalingdata.mat")

avFvals = permute(mean(Fvals,1),[3,2,1]);
zvals = -log(avFvals);
mssms = 1:2:15;
angles = 9.4:0.2:10.4;
plotxvals = linspace(1,16,50);
heisenberg = plotxvals.^2;
sql = plotxvals;
figure
colr = get(gca,'ColorOrder');

tl=tiledlayout(2,3);
for ii=1:6
nexttile;
% semilogx(plotxvals,log(heisenberg), 'Color','#485696','LineWidth',1.5,'LineStyle','--')
plot(log(plotxvals),log(heisenberg), 'Color','b','LineWidth',1.5,'LineStyle','--')

hold on
ax = gca; % gca stands for "Get Current Axes"
ax.FontSize=14;

% semilogx(plotxvals,log(sql),'Color','#59D473','LineWidth',1.5,'LineStyle','--')
plot(log(plotxvals),log(sql),'Color','r','LineWidth',1.5,'LineStyle','--')

% afill=fill([plotxvals flip(plotxvals)],[log(sql) flip(log(heisenberg))],hex2rgb('#E8AEB7'));
% uistack(afill,"bottom")
plot(log(mssms(2:end)),-log(avFvals(2:end,ii)),'^','MarkerFaceColor','#F24C00','MarkerEdgeColor','#F24C00','MarkerSize',8)
title(angles(ii)+"-"+(angles(ii)+0.2))


% afill.FaceAlpha=0.1;
% afill.EdgeColor="none";
ticknos=[1 2 3 4 6 8];
xticks(log(mssms(ticknos)))
xticklabels(num2str(mssms(ticknos)'))
xlim(log([0.9,17]))
end


legend('Heisenberg','SQL','Experiment')
ylabel(tl,' $ -\log{\delta \theta^2}$ ', 'Interpreter','latex',FontSize=24)
xlabel(tl,'$n$','Interpreter','latex',FontSize=24)
