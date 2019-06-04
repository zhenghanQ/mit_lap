% Get subjectmean ERPSets
path('/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/erp/eng',path)
insetdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/erp/eng';
outsetdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/erp/eng';
txtdir='/Users/zqi/Dropbox/GABLAB/MAL/EEG_day1/data/SAT/erp/eng';
subnum={'1053','1035','1037'};%'1004','1021','1030','1032','1026','1035','1039','1029','1006','1010','1014','1015','1016','1019','1028','1022','1023','1024','1025','1027','1021','1037','1041','1042','1045','1046','1047','1049', '1050','1052','1053','1054','1055','1056','1057','1058','1060','1061','1064'
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% for each subject
for s = 1:length(subnum)
        dataFilename=[subnum{s} '_eng.erp'];
        ERP = pop_loaderp('filename', dataFilename, 'overwrite', 'off', 'pathname',insetdir,'Warning', 'on'); 
        ERP = pop_erpchanoperator( ERP, {' ch35 = (ch12 + ch19 + ch13 + ch14 + ch18 + ch14 + ch18)/7 label posterior7',' ch36 = (ch5 + ch26 + ch8 + ch23 + ch9 + ch22 + ch13 + ch32)/8 label central8'});                                                                                                                                                                      
        ERP = pop_savemyerp(ERP, 'erpname', [subnum{s} 'eng'], 'filename', [outsetdir filesep dataFilename]);
end