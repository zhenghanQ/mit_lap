% Get subjectmean ERPSets
path('/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/erp/eng',path)
insetdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/erp/eng';
outsetdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/erp/eng';
txtdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/erp/eng';
subnum={'1053','1035','1037'};%'1021','1037','1041','1042','1045','1046','1047','1049', '1050','1052','1053','1054','1055','1056','1057','1058','1060','1061','1064'
%'1006','1010','1014','1015','1016','1019','1028','1022','1023','1024','102
%5','1027','1004','1021','1030','1032','1026','1035','1039','1029'
%[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% for each subject
for s = 1:length(subnum)  
    % Load data set
        dataFilename=[subnum{s} '_eng.erp'];
        ERP = pop_loaderp('filename', dataFilename, 'overwrite', 'off', 'pathname',insetdir,'Warning', 'on');                              
        ERP = pop_binoperator( ERP, {'b7=b2-b1 label SemN400' 'b8=b4-b3 label SynP600' });                                                                                                                                                                                                                                                                                                                   
        pop_savemyerp(ERP, 'erpname', [subnum{s} 'eng'], 'filename', [outsetdir filesep dataFilename]);
end