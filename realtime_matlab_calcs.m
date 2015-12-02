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
for i = 2:length(realtime_time_1)
    if realtime_time_1(i)>realtime_time_1(i-1)
        realtime_time_diffs_1(i) = (realtime_time_1(i)-realtime_time_1(i-1));
    else
        realtime_time_diffs_1(i) = (realtime_time_1(i)+0.001-realtime_time_1(i-1));
    end
end

for i = 2:length(realtime_time_2)
    if realtime_time_2(i)>realtime_time_2(i-1)
        realtime_time_diffs_2(i) = (realtime_time_2(i)-realtime_time_2(i-1));
    else
        realtime_time_diffs_2(i) = (realtime_time_2(i)+0.001-realtime_time_2(i-1));
    end
end

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
sorted_realtime_time_diffs_1 = round(sort(realtime_time_diffs_1),6);
sorted_realtime_time_diffs_2 = round(sort(realtime_time_diffs_2),6);

sorted_non_realtime_time_diffs_1 = round(sort(non_realtime_time_diffs_1),6);
sorted_non_realtime_time_diffs_2 = round(sort(non_realtime_time_diffs_2),6);

cumulative_sorted_realtime_time_diffs_1 = cumsum(sorted_realtime_time_diffs_1);
cumulative_sorted_realtime_time_diffs_2 = cumsum(sorted_realtime_time_diffs_2);

cumulative_sorted_non_realtime_time_diffs_1 = cumsum(sorted_non_realtime_time_diffs_1);
cumulative_sorted_non_realtime_time_diffs_2 = cumsum(sorted_non_realtime_time_diffs_2);

%%
%Counting
nrt_1_less = nnz(sorted_non_realtime_time_diffs_1<double(0.001));
nrt_1_equal = nnz(sorted_non_realtime_time_diffs_1==double(0.001));
nrt_1_greater = nnz(sorted_non_realtime_time_diffs_1>double(0.001));
total_count_nrt_1 = nrt_1_less + nrt_1_equal + nrt_1_greater;

nrt_1_less = round(nrt_1_less / total_count_nrt_1 * 100,3);
nrt_1_equal = round(nrt_1_equal / total_count_nrt_1 * 100,3);
nrt_1_greater = round(nrt_1_greater / total_count_nrt_1 * 100,3);

nrt_2_less = nnz(sorted_non_realtime_time_diffs_2<double(0.001));
nrt_2_equal = nnz(sorted_non_realtime_time_diffs_2==double(0.001));
nrt_2_greater = nnz(sorted_non_realtime_time_diffs_2>double(0.001));
total_count_nrt_2 = nrt_2_less + nrt_2_equal + nrt_2_greater;

nrt_2_less = round(nrt_2_less / total_count_nrt_2 * 100,3);
nrt_2_equal = round(nrt_2_equal / total_count_nrt_2 * 100,3);
nrt_2_greater = round(nrt_2_greater / total_count_nrt_2 * 100,3);

rt_1_less = nnz(sorted_realtime_time_diffs_1<double(0.001));
rt_1_equal = nnz(sorted_realtime_time_diffs_1==double(0.001));
rt_1_greater = nnz(sorted_realtime_time_diffs_1>double(0.001));
total_count_rt_1 = rt_1_less + rt_1_equal + rt_1_greater;

rt_1_less = round(rt_1_less / total_count_rt_1 * 100,3);
rt_1_equal = round(rt_1_equal / total_count_rt_1 * 100,3);
rt_1_greater = round(rt_1_greater / total_count_rt_1 * 100,3);

rt_2_less = nnz(sorted_realtime_time_diffs_2<0.001);
rt_2_equal = nnz(sorted_realtime_time_diffs_2==0.0010);
rt_2_greater = nnz(sorted_realtime_time_diffs_2>0.001);
total_count_rt_2 = rt_2_less + rt_2_equal + rt_2_greater;

rt_2_less = round(rt_2_less / total_count_rt_2 * 100,3);
rt_2_equal = round(rt_2_equal / total_count_rt_2 * 100,3);
rt_2_greater = round(rt_2_greater / total_count_rt_2 * 100,3);

table_labels = {'Value','Non RT, No Load','Non RT, Load','RT, No Load','RT, Load'};
value = {'Less than 1 milisecond';'Exactly 1 milisecond';'Greater than 1 milisecond'};
non_rt_1= [nrt_1_less;nrt_1_equal;nrt_1_greater];
non_rt_2 = [nrt_2_less;nrt_2_equal;nrt_2_greater];
rt_1 = [rt_1_less;rt_1_equal;rt_1_greater];
rt_2 = [rt_2_less;rt_2_equal;rt_2_greater];

table_compare = table({'Less than 1 milisecond';'Exactly 1 milisecond';'Greater than 1 milisecond'},...
[nrt_1_less;nrt_1_equal;nrt_1_greater],...
[nrt_2_less;nrt_2_equal;nrt_2_greater],...
[rt_1_less;rt_1_equal;rt_1_greater],...
[rt_2_less;rt_2_equal;rt_2_greater],...
'VariableNames',{'Value' 'Non_RT_No_Load' 'Non_RT_No' 'RT_No_Load' 'RT_Load'})
writetable(table_compare,'compare_table_001.csv','Delimiter',',')

%%
nrt_1_less = nnz(sorted_non_realtime_time_diffs_1<double(0.001005));
nrt_1_equal = nnz(sorted_non_realtime_time_diffs_1==double(0.001005));
nrt_1_greater = nnz(sorted_non_realtime_time_diffs_1>double(0.001005));
total_count_nrt_1 = nrt_1_less + nrt_1_equal + nrt_1_greater;

nrt_1_less = round(nrt_1_less / total_count_nrt_1 * 100,3);
nrt_1_equal = round(nrt_1_equal / total_count_nrt_1 * 100,3);
nrt_1_greater = round(nrt_1_greater / total_count_nrt_1 * 100,3);

nrt_2_less = nnz(sorted_non_realtime_time_diffs_2<double(0.001005));
nrt_2_equal = nnz(sorted_non_realtime_time_diffs_2==double(0.001005));
nrt_2_greater = nnz(sorted_non_realtime_time_diffs_2>double(0.001005));
total_count_nrt_2 = nrt_2_less + nrt_2_equal + nrt_2_greater;

nrt_2_less = round(nrt_2_less / total_count_nrt_2 * 100,3);
nrt_2_equal = round(nrt_2_equal / total_count_nrt_2 * 100,3);
nrt_2_greater = round(nrt_2_greater / total_count_nrt_2 * 100,3);

rt_1_less = nnz(sorted_realtime_time_diffs_1<double(0.001005));
rt_1_equal = nnz(sorted_realtime_time_diffs_1==double(0.001005));
rt_1_greater = nnz(sorted_realtime_time_diffs_1>double(0.001005));
total_count_rt_1 = rt_1_less + rt_1_equal + rt_1_greater;

rt_1_less = round(rt_1_less / total_count_rt_1 * 100,3);
rt_1_equal = round(rt_1_equal / total_count_rt_1 * 100,3);
rt_1_greater = round(rt_1_greater / total_count_rt_1 * 100,3);

rt_2_less = nnz(sorted_realtime_time_diffs_2<0.001005);
rt_2_equal = nnz(sorted_realtime_time_diffs_2==0.0010050);
rt_2_greater = nnz(sorted_realtime_time_diffs_2>0.001005);
total_count_rt_2 = rt_2_less + rt_2_equal + rt_2_greater;

rt_2_less = round(rt_2_less / total_count_rt_2 * 100,3);
rt_2_equal = round(rt_2_equal / total_count_rt_2 * 100,3);
rt_2_greater = round(rt_2_greater / total_count_rt_2 * 100,3);

table_labels = {'Value','Non RT, No Load','Non RT, Load','RT, No Load','RT, Load'};
value = {'Less than 1 milisecond';'Exactly 1 milisecond';'Greater than 1 milisecond'};
non_rt_1= [nrt_1_less;nrt_1_equal;nrt_1_greater];
non_rt_2 = [nrt_2_less;nrt_2_equal;nrt_2_greater];
rt_1 = [rt_1_less;rt_1_equal;rt_1_greater];
rt_2 = [rt_2_less;rt_2_equal;rt_2_greater];

table_compare = table({'Less than 1 milisecond, 5 nanoseconds';'Exactly 1 milisecond, 5 nanoseconds';'Greater than 1 milisecond, 5 nanoseconds'},...
[nrt_1_less;nrt_1_equal;nrt_1_greater],...
[nrt_2_less;nrt_2_equal;nrt_2_greater],...
[rt_1_less;rt_1_equal;rt_1_greater],...
[rt_2_less;rt_2_equal;rt_2_greater],...
'VariableNames',{'Value' 'Non_RT_No_Load' 'Non_RT_No' 'RT_No_Load' 'RT_Load'})
writetable(table_compare,'compare_table_001005.csv','Delimiter',',')

%%
figure(1)
clf
hold on
plot(non_realtime_time_diffs_1,'r')
plot(non_realtime_time_diffs_2,'b')
xlabel('Process number')
legend('Load','No Load')
ylabel('Execution Time in seconds')
title('Load vs No Load For Non Realtime')
hold off
print ('nonrealtime_autogen','-dpng')

figure(2)
clf
hold on
plot(realtime_time_diffs_1,'r')
plot(realtime_time_diffs_2,'b')
xlabel('Process number')
legend('Load','No Load')
ylabel('Execution Time in seconds')
title('Load vs No Load For Realtime')
hold off
print ('realtime_autogen','-dpng')

figure(3)
clf
hold on
plot(non_realtime_time_diffs_1,'g')
plot(realtime_time_diffs_1,'k')
xlabel('Process number')
legend('Non Realtime','Realtime')
ylabel('Execution Time in seconds')
title('Realtime vs. Non Realtime Under Load')
hold off
print ('rt_nonrt_load_autogen','-dpng')

figure(4)
clf
hold on
plot(non_realtime_time_diffs_2,'g')
plot(realtime_time_diffs_2,'k')
xlabel('Process number')
legend('Non RT','RT')
ylabel('Execution Time in seconds')
title('RT vs. Non RT No Load')
hold off
print ('rt_nonrt_noload_autogen','-dpng')

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
print ('cdf_nozoom_autogen','-dpng')

figure(6)
clf
hold on
cdfplot(non_realtime_time_diffs_1)
cdfplot(non_realtime_time_diffs_2)
cdfplot(realtime_time_diffs_1)
cdfplot(realtime_time_diffs_2)
xlabel('Diffs Less than or Equal To')
ylim([0.99,1])
legend('Non Realtime Under Load','Non Realtime Under No Load','Realtime Under Load','Realtime Under No Load')
ylabel('Probability')
title('Cumultive Diffs for Realtime vs. Non Realtime Under Load and No Load')
hold off
print ('cdf_partzoom_autogen','-dpng')


figure(7)
clf
hold on
cdfplot(non_realtime_time_diffs_1)
cdfplot(non_realtime_time_diffs_2)
cdfplot(realtime_time_diffs_1)
cdfplot(realtime_time_diffs_2)
xlabel('Diffs Less than or Equal To')
ylim([0.999,1])
xlim([0,0.002])
legend('Non Realtime Under Load','Non Realtime Under No Load','Realtime Under Load','Realtime Under No Load')
ylabel('Probability')
title('Zoomed In Cumultive Diffs for Realtime vs. Non Realtime Under Load and No Load')
hold off
print ('cdf_fullzoom_autogen','-dpng')

