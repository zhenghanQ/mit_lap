% epoch_to_file.m
% this script sliced preprocessed eeg data into epochs and save individual
% epochs into separate files. This is particularly handy for initiating a
% study design.
% updated by Zhenghan Qi on 12/11/2013

clear all;
close all;
%% parameters
path('/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data',path)
insetdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/work_dir/eng';
outsetdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/work_dir/eng/epochs';
filesuffix='*be_ar'; % change this to continous files instead of binned files.
subnum={'1006','1007', '1010', '1014', '1015', '1016', '1019', '1021', ...
    '1022', '1023', '1024', '1025', '1026', '1027', '1028', '1029', '1030', ...
    '1032', '1035', '1037', '1039', '1041', '1042', '1045', '1046', '1047', ...
    '1049', '1050', '1052', '1053', '1054', '1055', '1056', '1057', '1058', ...
    '1060','1061','1064'};%
epoch = {'B1(semg)', 'B2(semb)', 'B3(syng)', 'B4(synb)'};
epochname = {'semg', 'semb', 'syng', 'synb'};
epochstart = -1;
epochend = 3;
% Paremeters end;
%%
% for each subject
for ep = 1:length(epoch)
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    for s = 1:length(subnum)    
        % Load data set
        dataFilename=dir([insetdir filesep subnum{s} filesuffix '.set']);
        EEG = pop_loadset('filename',dataFilename.name);
        [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
        EEG = eeg_checkset(EEG);
        eeglab redraw;
        EEG = pop_rmdat( EEG, {epoch{ep}},[epochstart, epochend] ,0);
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
        % not able to save txt files
        pop_export(EEG,[outsetdir filesep epochname{ep} filesep subnum{s} '_' epochname{ep} '.txt'],'transpose','on','precision',4)
        ALLEEG = pop_delset( ALLEEG, [1] );
        % save eegset
        % pop_saveset(EEG,'filename',[outsetdir filesep epochname{ep} filesep subnum{s} '_' epochname{ep} '.set']);
    
    end
end
