realtime = 'Results_Load_NoLoad.xlsx';
realtime_time_1 = xlsread(realtime,'A6:A60000');
realtime_time_2 = xlsread(realtime,'C6:C60000');

%%
non_realtime = 'Results_Load_NoLoad_NonRealtime.xlsx';
non_realtime_time_1 = xlsread(non_realtime,'A6:A60000');
non_realtime_time_2 = xlsread(non_realtime,'C6:C60000');

%%
realtime_time_diffs_1 = abs(diff(realtime_time_1));
realtime_time_diffs_2 = abs(diff(realtime_time_2));

%%
hold on
plot(realtime_time_diffs_1)
plot(realtime_time_diffs_2)

%%
for i = 2:length(non_realtime_time_1)
    if non_realtime_time_1(i)>non_realtime_time_1(i-1)
        non_realtime_time_diffs_1(i) = (non_realtime_time_1(i)-non_realtime_time_1(i-1))/1000000;
    else
        non_realtime_time_diffs_1(i) = (non_realtime_time_1(i)+1000000-non_realtime_time_1(i-1))/1000000;
    end
end

for i = 2:length(non_realtime_time_2)
    if non_realtime_time_2(i)>non_realtime_time_2(i-1)
        non_realtime_time_diffs_2(i) = (non_realtime_time_2(i)-non_realtime_time_2(i-1))/1000000;
    else
        non_realtime_time_diffs_2(i) = (non_realtime_time_2(i)+1000000-non_realtime_time_2(i-1))/1000000;
    end
end

%%
%Cumulative
sorted_realtime_time_diffs_1 = sort(realtime_time_diffs_1)
sorted_realtime_time_diffs_2 = sort(realtime_time_diffs_2)

sorted_non_realtime_time_diffs_1 = sort(realtime_time_diffs_1)
sorted_non_realtime_time_diffs_2 = sort(realtime_time_diffs_2)

cumulative_sorted_realtime_time_diffs_1 = cumsum(sorted_realtime_time_diffs_1)
cumulative_sorted_realtime_time_diffs_2 = cumsum(sorted_realtime_time_diffs_2)

cumulative_sorted_non_realtime_time_diffs_1 = cumsum(sorted_non_realtime_time_diffs_1)
cumulative_sorted_non_realtime_time_diffs_2 = cumsum(sorted_non_realtime_time_diffs_2)

%%
figure(1)
clf
hold on
plot(non_realtime_time_diffs_1,'r')
plot(non_realtime_time_diffs_2,'b')
xlabel('Process number')
legend('Load','No Load')
ylabel('Latency in seconds')
title('Load vs No Load For Non Realtime')
hold off

%%
figure(2)
clf
hold on
plot(realtime_time_diffs_1,'r')
plot(realtime_time_diffs_2,'b')
xlabel('Process number')
legend('Load','No Load')
ylabel('Latency in seconds')
title('Load vs No Load For Realtime')
hold off

%%
figure(3)
clf
hold on
plot(non_realtime_time_diffs_1,'g')
plot(realtime_time_diffs_1,'k')
xlabel('Process number')
legend('Non Realtime','Realtime')
ylabel('Latency in seconds')
title('Realtime vs. Non Realtime Under Load')
hold off
%%
figure(4)
clf
hold on
plot(non_realtime_time_diffs_2,'g')
plot(realtime_time_diffs_2,'k')
xlabel('Process number')
legend('Non Realtime','Realtime')
ylabel('Latency in seconds')
title('Realtime vs. Non Realtime Under No Load')
hold off

%%
figure(5)
clf
hold on
cdfplot(non_realtime_time_diffs_1)
cdfplot(non_realtime_time_diffs_2)
cdfplot(realtime_time_diffs_1)
cdfplot(realtime_time_diffs_2)
xlabel('Diffs Less than or Equal To')
ylim([0.9,1])
legend('Non Realtime Under Load','Non Realtime Under No Load','Realtime Under Load','Realtime Under No Load')
ylabel('Probability')
title('Cumultive Diffs for Realtime vs. Non Realtime Under Load and No Load')
hold off

figure(6)
clf
hold on
cdfplot(non_realtime_time_diffs_1)
cdfplot(non_realtime_time_diffs_2)
cdfplot(realtime_time_diffs_1)
cdfplot(realtime_time_diffs_2)
xlabel('Diffs Less than or Equal To')
ylim([0.999,1])
legend('Non Realtime Under Load','Non Realtime Under No Load','Realtime Under Load','Realtime Under No Load')
ylabel('Probability')
title('Zoomed In Cumultive Diffs for Realtime vs. Non Realtime Under Load and No Load')
hold off


