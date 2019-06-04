% removeica.m
% updated by Zhenghan Qi on 11/17/2011
% MANUALLY remove the eye-movement component and save the new dataset as _icapruned.set.

% first step: type the .set file name below, copy and the lines from 6 to 11 in the command window
setname='1045_mal1';
EEG = pop_loadset('filename',[setname '.set'],'filepath','/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/raw');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
% compare the eeg channel plot and ica component plot
pop_eegplot( EEG, 0, 1, 1);
pop_eegplot( EEG, 1, 1, 1);
% second step: carefully compare the two plots and choose the component
% that has the same temporal distribution of activity with the VEOG channel.
% Then enter the number of component to remove in the bracket below. [1]
% means you are removing the 1st component. Copy and paste the line 19-23
% in the command window.


EEG = pop_subcomp( EEG, [1 6], 1);
% save the icapruned dataset as a new file [ALLEEG EEG CURRENTSET] =
% pop_newset(ALLEEG, EEG, 1,'setname',[setname
% '_icapruned'],'savenew',[setname '_icapruned'],'gui','off');
EEG = pop_saveset( EEG, 'filename',[setname '_icapruned.set'],'filepath','/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/work_dir');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
