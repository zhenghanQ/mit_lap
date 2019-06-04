% Get subjectmean ERPSets
path('/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/erp/eng',path)
insetdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/erp/eng';
outsetdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/erp/eng';
txtdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/txt';
subnum={'1006','1010','1014','1015','1016','1019','1028','1022','1023','1024','1025','1027'};%,02','03','05','06','07','08','09','10','11','13','14'

% for each subject
for s = 1:length(subnum)  
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    % Load data set
    for block=1:3
        dataFilename=[outsetdir filesep 'S' subnum{s} 'tr' num2str(block) 'icapruned_elist_be_ar_ar.set'];
        EEG = pop_loadset('filename',dataFilename);
        [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
        EEG = eeg_checkset( EEG );
    end
    nset=size(ALLEEG);
    ERP = pop_averager(ALLEEG,[1:nset(2)],1,0);
    pop_savemyerp(ERP,'erpname',[subnum{s} 'trall'],'filename',[outsetdir filesep 'S' subnum{s} 'trall.erp']);
end

for s = 1:length(subnum)  
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    % Load data set
    for block=1:2
        dataFilename=[outsetdir filesep 'S' subnum{s} 'tr' num2str(block) 'icapruned_elist_be_ar_ar.set'];
        EEG = pop_loadset('filename',dataFilename);
        [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
        EEG = eeg_checkset( EEG );
    end
    nset=size(ALLEEG);
    ERP = pop_averager(ALLEEG,[1:nset(2)],1,0);
    pop_savemyerp(ERP,'erpname',[subnum{s} 'trfirsthalf'],'filename',[outsetdir filesep 'S' subnum{s} 'trfirsthalf.erp']);
end

for s = 1:length(subnum)  
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    % Load data set
    for block=3:4
        dataFilename=[outsetdir filesep 'S' subnum{s} 'tr' num2str(block) 'icapruned_elist_be_ar_ar.set'];
        EEG = pop_loadset('filename',dataFilename);
        [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
        EEG = eeg_checkset( EEG );
    end
    nset=size(ALLEEG);
    ERP = pop_averager(ALLEEG,[1:nset(2)],1,0);
    pop_savemyerp(ERP,'erpname',[subnum{s} 'tr2ndhalf'],'filename',[outsetdir filesep 'S' subnum{s} 'tr2ndhalf.erp']);
end

