% processResults_icaprunedonly.m
% updated by Zhenghan Qi on 10/11/2011
% Re-reference the data in _icapruned.set, create event list and extract
% epochs.
% Notice: if there is pause in the data recording, there might be problems
% in loading the bin list. You may want to use the ERPLAB menu interface to
% handle the datafile separately.

clear all;
close all;
%% parameters
path('/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data',path)
insetdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/work_dir';
outsetdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/work_dir';
txtdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/txt';
filesuffix='_Eng';
subnum={'1053'};%'1021', '1037','1041','1042','1045','1046','1047','1049','1050','1052','1053','1054','1055','1056','1057','1058','1060','1061','1064'
%blocknum=4;
epochstart = -200;
epochend = 1500;
% Paremeters end;
%%
% load channel files only necessary if need to re-referencing.
% load('chanopsFrontalCentral.mat');
%chanopsAvgMastoid={' ch1=ch1-0.5*ch10 label VEOG' ' ch2=ch2-0.5*ch10 label HEOG' ' ch3=ch3-0.5*ch10 label FZ'   ' ch4=ch4-0.5*ch10 label CZ'   ' ch5=ch5-0.5*ch10 label PZ'   ' ch6=ch6-0.5*ch10 label F7'   ' ch7=ch7-0.5*ch10 label F8'   ' ch8=ch8-0.5*ch10 label T5'   ' ch9=ch9-0.5*ch10 label T6'   ' ch11=ch11-0.5*ch10 label T3'   ' ch12=ch12-0.5*ch10 label T4'   ' ch13=ch13-0.5*ch10 label F3'   ' ch14=ch14-0.5*ch10 label F4'   ' ch15=ch15-0.5*ch10 label C3'   ' ch16=ch16-0.5*ch10 label C4'   ' ch17=ch17-0.5*ch10 label AF3'   ' ch18=ch18-0.5*ch10 label AF4'   ' ch19=ch19-0.5*ch10 label FC3'   ' ch20=ch20-0.5*ch10 label FC4'   ' ch21=ch21-0.5*ch10 label CP3'   ' ch22=ch22-0.5*ch10 label CP4'   ' ch23=ch23-0.5*ch10 label FT7'   ' ch24=ch24-0.5*ch10 label FT8'   ' ch25=ch25-0.5*ch10 label P3'   ' ch26=ch26-0.5*ch10 label P4'   ' ch27=ch27-0.5*ch10 label PO7'   ' ch28=ch28-0.5*ch10 label PO8'   ' ch29=ch29-0.5*ch10 label P5'   ' ch30=ch29-0.5*ch10 label P6'   ' ch31=ch31-0.5*ch10 label OZ' };

% for each subject
for s = 1:length(subnum)    
    % Load data set
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    
    dataFilename=[insetdir filesep subnum{s} filesuffix '_icapruned.set'];
    EEG = pop_loadset('filename',dataFilename);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    % re-reference
    %EEG = pop_eegchanoperator(EEG,chanopsAvgMastoid);

    % load new channels
    %EEG = pop_eegchanoperator(EEG,chanopsFrontalCentral);

    % load bin list
    %EEG = pop_creabasiceventlist(EEG,[txtdir filesep subnum{s} filesuffix '_icapruned_eventlist.txt']);
    EEG = pop_editeventlist(EEG,'/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/scripts/SAT/eventlist_Eng.txt',[txtdir subnum{s} filesuffix '_icapruned_eventlist.txt'],{'boundary'}, {-99});

    % bin epochs
    EEG = pop_epochbin(EEG,[epochstart epochend],[-100 0]);
    
    % artifact rejection
    EEG = pop_artmwppth(EEG,[-100 1500],150,200,50,[1:32],1);
    
    % save eegset
    pop_saveset(EEG,'filename',[outsetdir filesep subnum{s} filesuffix '_icapruned_elist_be_ar.set']);
end


