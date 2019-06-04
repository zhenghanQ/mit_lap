% This file searches all the epochs with detected artifact and creates a
% matrix called rejectsummary with four columns: 1. subjectid; 2. block; 3. epoch number; 4.
% artifact type (defined in processResults.m)
% Created by Zhenghan Qi
% Updated on 11/17/11

close all;
%% parameters
path('/Users/zqi/Dropbox/BILD/MMN/eeg/piloting',path)
insetdir='/Users/zqi/Dropbox/BILD/MMN/eeg/piloting';
outsetdir='/Users/zqi/Dropbox/BILD/MMN/eeg/piloting';
txtdir='/Users/zqi/Dropbox/BILD/MMN/eeg/piloting/txt';
subnum={'008','003','004','005','006','007'};
% Paremeters end;
%%
rejectsummary=[];
for s = 1:length(subnum)
    subid=[];
    rejectedtrial=[];
    rejectedtype=[];
    rejectedcond=[];
    dataFilename=[insetdir filesep subnum{s} '_elist_be_ar.set'];
    EEG = pop_loadset('filename',dataFilename);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    rejectedtrialblock=[];
    rejectedtypeblock=[];
    rejectedcondblock=[];
    subidblock=[];
    blockcolblock=[];
    rejectednumberblock=0;
    trialnumber=length(EEG.EVENTLIST.eventinfo);
        for n=1:trialnumber
            if EEG.EVENTLIST.eventinfo(1,n).flag ~= 0
                rejectedtrialblock=[rejectedtrialblock;EEG.EVENTLIST.eventinfo(1,n).bepoch];
                rejectedtypeblock=[rejectedtypeblock;EEG.EVENTLIST.eventinfo(1,n).flag];
                rejectedcondblock=[rejectedcondblock;EEG.EVENTLIST.eventinfo(1,n).code];
             end
        end
     rejectednumberblock=length(rejectedtrialblock);
     subidblock=repmat(str2num(subnum{s}),[rejectednumberblock,1]);
     subid=[subid;subidblock];
     rejectedtrial=[rejectedtrial;rejectedtrialblock];
     rejectedtype=[rejectedtype;rejectedtypeblock];
     rejectedcond=[rejectedcond;rejectedcondblock];
     rejectsubsummary=[subid rejectedtrial rejectedtype rejectedcond];
     rejectsummary=[rejectsummary;rejectsubsummary];
end
