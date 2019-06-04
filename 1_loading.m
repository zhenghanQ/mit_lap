% load EEG set and add channel locations
% Parameters
path('/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/raw',path)
% The folder where you load the .ic files
setdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/raw';
% The parameters below depend on how you name your files: e.g. S18te1.ic.
% "1" is the block number.
% fileprefix='S';
subnum={'1037_eng','1037_mal1','1037_mal2'};
n=length(subnum);
eeglab;

for s=1:n
    dataFilename=[setdir filesep subnum{s} '.bdf'];
    EEG = pop_biosig(dataFilename,'ref',[35 36] ,'memorymapped','on');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname',subnum{s},'gui','off'); 
    EEG = eeg_checkset( EEG );
    EEG = pop_select( EEG,'nochannel',{'EXG5' 'EXG6' 'EXG7' 'EXG8'});
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
    EEG=pop_chanedit(EEG, 'lookup','/Users/zqi/Documents/MATLAB/eeglab12_0_0_0b/plugins/dipfit2.2/standard_BESA/standard-10-5-cap385.elp','load',{'/Users/zqi/Dropbox/BILD/MMN/eeg/biosemi_36.locs' 'filetype' 'autodetect'},'changefield',{35 'datachan' 0},'changefield',{36 'datachan' 0});
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = eeg_checkset( EEG );
    
    %filter the EEG set with 40 Hz as low pass and 0.1 as high pass filters.
    EEG = pop_eegfilt( EEG, 0.1, 40, [], [0], 0, 0, 'fir1', 0);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = pop_saveset( EEG, 'filename',[subnum{s} '.set'],'filepath',setdir);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end;
