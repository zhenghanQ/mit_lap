% This script runs independent component analysis on all the loaded .set
% files and saved the components in the original files.
% Created by Zhenghan Qi
% Updated on 11/17/2011.

% % PARAMETERS
path('/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/raw',path)
% The folder where you load the .ic files
setdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/raw';
% The parameters below depend on how you name your files: e.g. S18te1.ic.
% "1" is the block number.
% fileprefix='S';
subnum={'1045_mal1','1064_mal1','1042_mal2','1045_mal2','1050_mal2'};%1056,1060?
% subnum={'1021_eng','1021_mal1','1021_mal2','1004_eng','1004_mal1','1004_mal2','1030_eng','1030_mal1','1030_mal2',...
%     '1032_eng','1032_mal1','1032_mal2','1026_eng','1026_mal1','1026_mal2','1035_eng','1035_mal1','1035_mal2',...
%     '1039_eng','1039_mal1','1039_mal2','1029_eng','1029_mal1','1029_mal2','1045_eng','1045_mal1','1045_mal2','1046_eng','1046_mal1','1046_mal2','1047_eng','1047_mal1','1047_mal2','1050_eng','1050_mal1','1050_mal2','1042_eng','1042_mal1','1042_mal2'};

%session='te';
%blocknum=4;
n=length(subnum);

% % END PARAMETERS

% Loop through subjects
for s = 1:n    
    % Load data set
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    EEG = pop_loadset('filename',[setdir filesep subnum{s} '.set']);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    % Run ica
    EEG = pop_runica(EEG, 'icatype','runica','dataset',1,'options',{'extended' 1});
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
  
  
    % save current dataset
    EEG = pop_saveset( EEG, 'savemode','resave');
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end;