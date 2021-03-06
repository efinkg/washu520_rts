realtime = 'Results_Load_NoLoad.xlsx';
time_1 = xlsread(realtime,'B6:B60000');
time_2 = xlsread(realtime,'D6:D60000');

%%
non_realtime = 'Results_Load_NoLoad_NonRealtime.xlsx';
non_realtime_time_1 = xlsread(non_realtime,'B6:B60000');
non_realtime_time_2 = xlsread(non_realtime,'D6:D60000');

%%
realtime_time_1 = abs(realtime_time_1-1);
realtime_time_2 = abs(realtime_time_2-1);

%%
realtime_cum_time_1 = cumsum(realtime_time_1);
realtime_cum_time_2 = cumsum(realtime_time_2);

%%
non_realtime_cum_time_1 = cumsum(non_realtime_time_1);
non_realtime_cum_time_2 = cumsum(non_realtime_time_2);
%%
figure(1)
clf
hold on
plot(realtime_time_1,'r')
plot(realtime_time_2,'b')
xlabel('Process number')
legend('Load','No Load')
ylabel('Latency in seconds')
title('Load vs No Load For Non Realtime')
hold off

%%
figure(2)
clf
hold on
plot(non_realtime_time_1,'r')
plot(non_realtime_time_2,'b')
xlabel('Process number')
legend('Load','No Load')
ylabel('Latency in seconds')
title('Load vs No Load For Realtime')
hold off
%%
figure(3)
clf
hold on
plot(non_realtime_time_1,'g')
plot(realtime_time_1,'k')
xlabel('Process number')
legend('Non Realtime','Realtime')
ylabel('Latency in seconds')
title('Realtime vs. Non Realtime Under Load')
hold off