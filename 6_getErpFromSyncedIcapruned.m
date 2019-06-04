% Created by Zhenghan Qi 10/28/2011.
% This script needs to be run only after you have done getrejecttrials.m
% The program go through the rejectsummary matrix, and lable the trials
% with the detected artifact in EEGLAB by changing the value
% EEG.reject.rejmanual(trialtomark) from 0 to 1. Then the program sync the
% marker from EEGLAB to ERPLAB eventlist.Finally a new ERPset is generated
% by averaging within all the bins after rejecting the marked trials (averaging is not weighted).
%% parameters
insetdir='/Users/zqi/Dropbox/BILD/MMN/eeg/piloting';
outsetdir='/Users/zqi/Dropbox/BILD/MMN/eeg/piloting';
subnum={'008','003','004','005','006','007'};
% Paremeters end;
%%
for s = 1:length(subnum)
    dataFilename=[insetdir filesep subnum{s} '_elist_be_ar.set'];
    EEG = pop_loadset('filename',dataFilename);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    trialnumber=length(EEG.epoch);
    EEG.reject.rejmanual=repmat(0,[1,trialnumber]);
    for b=1:length(rejectsummary)
    if str2num(subnum{s})==rejectsummary(b,1)
        trialtomark=rejectsummary(b,3);
        EEG.reject.rejmanual(trialtomark)=1;
    end
    end
    pop_saveset(EEG,'filename',[outsetdir filesep subnum{s} 'elist_be_ar_ar.set']);
%     EEG=pop_sincroartifacts(EEG,2);
%     pop_saveset(EEG,'filename',[outsetdir filesep subnum{s} 'elist_be_ar_ar.set']);
    ERP = pop_averager(EEG,1,1,0);
    ERP = pop_binoperator( ERP, {'b13=(b1+b4+b5+b9)/4 label standard' 'b14=(b2+b6+b10+b12)/4 label big-deviant' 'b15=(b3+b7+b8+b11)/4 label small-deviant' }); 
    pop_savemyerp(ERP,'erpname',subnum{s},'filename',[outsetdir filesep subnum{s} '.erp']);
end