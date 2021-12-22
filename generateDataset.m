clc
clear all
close all
warning off
format longG

% CHANGE THE PATHS AS PER EACH DATASET STRUCTURE. 
for i = 1:27
    path = 'C:\cancer\imRAG\CoNSeP\Train\';
    
    load([path 'Labels\train_' num2str(i) '.mat']);
    d1 = inst_centroid;
        
    img = imread([path '\Images\train_' num2str(i) '.png']);
    img2 = img;
    
    [r1,c1,~] = size(img);
    
    r1 = r1;
    c1 = c1;
    
    % types
    % 1: others
    % 2: inflammatory
    % 3: epithelial
    % 4: fibroblast

    inst_centroid_pred = [];
    inst_type_pred = [];
 
    [row1,~] = size(d1);
   
    inst_type(inst_type == 4) = 3; % 3 and 4 are combined in original paper as epithelial
    inst_type(inst_type == 6) = 4; % 5, 6, and 7 are combined as fibroblast
	inst_type(inst_type == 7) = 4; % UPDATE: using 4 to represent fibroblast to make it consistent with CRCHisto
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    number = convertStringsToChars(replace(sprintf("%2.d",i),' ', '0'));
    outPath = ['data2\MOT17Det\train\MOT17-' number];
    
    index = 1;
    scale = 1;
    
    if exist(outPath, 'dir') == false
        [status, msg, msgID] = mkdir(outPath);
    end
    
    if exist([outPath '\img1'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath '\img1']);
    end
    
%     if exist([outPath '\det'], 'dir') == false
%         [status, msg, msgID] = mkdir([outPath '\det']);
%     end
    
    if exist([outPath '\gt'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath '\gt']);
    end
    
    r1 = r1 * scale;
    c1 = c1 * scale;
    
    frames = row1; %max(max(max(row1,row2),row3),row4);
    for k = 1:frames
        fileName = convertStringsToChars(replace(sprintf("%6.d",k),' ', '0'));
        imwrite(img,[outPath '\img1\' fileName '.jpg'] ,'JPEG');
    end
    
    fileID = fopen([outPath '\seqinfo.ini'],'at');
	fprintf(fileID,'%s\n',"[Sequence]");
    fprintf(fileID,'%s\n',['name=MOT17-' number]);
    fprintf(fileID,'%s\n',"imDir=img1");
    fprintf(fileID,'%s\n',['frameRate=' num2str(1)]);
    fprintf(fileID,'%s\n',['seqLength=' num2str(frames)]);
    fprintf(fileID,'%s\n',['imWidth=' num2str(r1)]);
    fprintf(fileID,'%s\n',['imHeight=' num2str(c1)]);
    fprintf(fileID,'%s\n',"imExt=.jpg");
    fclose(fileID);
    
    fileID = fopen([outPath '\gt\gt.txt'],'at');
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 1
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x1))); % left
            fprintf(fileID,'%s,',num2str(round(y1))); % top
            fprintf(fileID,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            i1 = i1 + 1;
        end
    end
    
    i1 = 1;
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 2
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x1))); % left
            fprintf(fileID,'%s,',num2str(round(y1))); % top
            fprintf(fileID,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            i1 = i1 + 1;
        end
    end
    
    i1 = 1;
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 3
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x1))); % left
            fprintf(fileID,'%s,',num2str(round(y1))); % top
            fprintf(fileID,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            i1 = i1 + 1;
        end
    end
    
    i1 = 1;
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 4
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x1))); % left
            fprintf(fileID,'%s,',num2str(round(y1))); % top
            fprintf(fileID,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            i1 = i1 + 1;
        end
    end
    
    fclose(fileID);
    
end

for i = 1:14
    path = 'C:\cancer\imRAG\CoNSeP\Test\';
    
    load([path 'Labels\test_' num2str(i) '.mat']);
    d1 = inst_centroid;
        
    img = imread([path '\Images\test_' num2str(i) '.png']);
    img2 = img;
    
    [r1,c1,~] = size(img);
    
    r1 = r1;
    c1 = c1;
    
    % types
    % 1: others
    % 2: inflammatory
    % 3: epithelial
    % 4: fibroblast

    inst_centroid_pred = [];
    inst_type_pred = [];
 
    [row1,~] = size(d1);
   
    inst_type(inst_type == 4) = 3; % 3 and 4 are combined in original paper as epithelial
    inst_type(inst_type == 6) = 4; % 5, 6, and 7 are combined as fibroblast
	inst_type(inst_type == 7) = 4; % UPDATE: using 4 to represent fibroblast to make it consistent with CRCHisto
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    number = convertStringsToChars(replace(sprintf("%2.d",i),' ', '0'));
    outPath = ['data2\MOT17Det\test\MOT17-' number];
    
    index = 1;
    scale = 1;
    
    if exist([outPath '\img1'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath '\img1']);
    end
    
    if exist([outPath '\gt'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath '\gt']);
    end
    
    r1 = r1 * scale;
    c1 = c1 * scale;
    
    [row1,~] = size(d1);
    
    frames = row1;%max(max(max(row1,row2),row3),row4);
    for k = 1:frames
        fileName = convertStringsToChars(replace(sprintf("%6.d",k),' ', '0'));
        imwrite(img,[outPath '\img1\' fileName '.jpg'] ,'JPEG');
    end
    
    fileID = fopen([outPath '\seqinfo.ini'],'at');
	fprintf(fileID,'%s\n',"[Sequence]");
    fprintf(fileID,'%s\n',['name=MOT17-' number]);
    fprintf(fileID,'%s\n',"imDir=img1");
    fprintf(fileID,'%s\n',['frameRate=' num2str(1)]);
    fprintf(fileID,'%s\n',['seqLength=' num2str(frames)]);
    fprintf(fileID,'%s\n',['imWidth=' num2str(r1)]);
    fprintf(fileID,'%s\n',['imHeight=' num2str(c1)]);
    fprintf(fileID,'%s\n',"imExt=.jpg");
    fclose(fileID);

    fileID = fopen([outPath '\gt\gt.txt'],'at');
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 1
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x1))); % left
            fprintf(fileID,'%s,',num2str(round(y1))); % top
            fprintf(fileID,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            i1 = i1 + 1;
        end
    end
    
    i1 = 1;
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 2
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x1))); % left
            fprintf(fileID,'%s,',num2str(round(y1))); % top
            fprintf(fileID,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            i1 = i1 + 1;
        end
    end
    
    i1 = 1;
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 3
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x1))); % left
            fprintf(fileID,'%s,',num2str(round(y1))); % top
            fprintf(fileID,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            i1 = i1 + 1;
        end
    end
    
    i1 = 1;
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 4
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x1))); % left
            fprintf(fileID,'%s,',num2str(round(y1))); % top
            fprintf(fileID,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            i1 = i1 + 1;
        end
    end
    
    fclose(fileID);
end

for i = 1:27
    path = 'C:\cancer\imRAG\CoNSeP\Train\';
    
    load([path 'Labels\train_' num2str(i) '.mat']);
    d1 = inst_centroid;
        
    img = imread([path '\Images\train_' num2str(i) '.png']);
    img2 = img;
    
    [r1,c1,~] = size(img);
    
    % types
    % 1: others
    % 2: inflammatory
    % 3: epithelial
    % 4: fibroblast

    inst_centroid_pred = [];
    inst_type_pred = [];
 
    [row1,~] = size(d1);
   
    inst_type(inst_type == 4) = 3; % 3 and 4 are combined in original paper as epithelial
    inst_type(inst_type == 6) = 4; % 5, 6, and 7 are combined as fibroblast
	inst_type(inst_type == 7) = 4; % UPDATE: using 4 to represent fibroblast to make it consistent with CRCHisto
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    number = convertStringsToChars(replace(sprintf("%2.d",i),' ', '0'));
    outPath = ['data2\MOT17Labels\train\MOT17-' number '-DPM'];
    outPath2 = ['data2\MOT17Labels\train\MOT17-' number '-FRCNN'];
    outPath3 = ['data2\MOT17Labels\train\MOT17-' number '-SDP'];
    
    index = 1;
    scale = 1;
    
    if exist(outPath, 'dir') == false
        [status, msg, msgID] = mkdir(outPath);
    end
    
    if exist(outPath2, 'dir') == false
        [status, msg, msgID] = mkdir(outPath2);
    end
    
    if exist(outPath3, 'dir') == false
        [status, msg, msgID] = mkdir(outPath3);
    end
     
    if exist([outPath '\det'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath '\det']);
    end
    
    if exist([outPath2 '\det'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath2 '\det']);
    end
    
    if exist([outPath3 '\det'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath3 '\det']);
    end
    
    if exist([outPath '\gt'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath '\gt']);
    end
    
    if exist([outPath2 '\gt'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath2 '\gt']);
    end
    
    if exist([outPath3 '\gt'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath3 '\gt']);
    end
    
    
    r1 = r1 * scale;
    c1 = c1 * scale;
    
    frames = row1; %max(max(max(row1,row2),row3),row4);
 
    fileID = fopen([outPath '\seqinfo.ini'],'at');
	fprintf(fileID,'%s\n',"[Sequence]");
    fprintf(fileID,'%s\n',['name=MOT17-' number]);
    fprintf(fileID,'%s\n',"imDir=img1");
    fprintf(fileID,'%s\n',['frameRate=' num2str(1)]);
    fprintf(fileID,'%s\n',['seqLength=' num2str(frames)]);
    fprintf(fileID,'%s\n',['imWidth=' num2str(r1)]);
    fprintf(fileID,'%s\n',['imHeight=' num2str(c1)]);
    fprintf(fileID,'%s\n',"imExt=.jpg");
    fclose(fileID);
    
    fileID = fopen([outPath2 '\seqinfo.ini'],'at');
	fprintf(fileID,'%s\n',"[Sequence]");
    fprintf(fileID,'%s\n',['name=MOT17-' number]);
    fprintf(fileID,'%s\n',"imDir=img1");
    fprintf(fileID,'%s\n',['frameRate=' num2str(1)]);
    fprintf(fileID,'%s\n',['seqLength=' num2str(frames)]);
    fprintf(fileID,'%s\n',['imWidth=' num2str(r1)]);
    fprintf(fileID,'%s\n',['imHeight=' num2str(c1)]);
    fprintf(fileID,'%s\n',"imExt=.jpg");
    fclose(fileID);
    
    fileID = fopen([outPath3 '\seqinfo.ini'],'at');
	fprintf(fileID,'%s\n',"[Sequence]");
    fprintf(fileID,'%s\n',['name=MOT17-' number]);
    fprintf(fileID,'%s\n',"imDir=img1");
    fprintf(fileID,'%s\n',['frameRate=' num2str(1)]);
    fprintf(fileID,'%s\n',['seqLength=' num2str(frames)]);
    fprintf(fileID,'%s\n',['imWidth=' num2str(r1)]);
    fprintf(fileID,'%s\n',['imHeight=' num2str(c1)]);
    fprintf(fileID,'%s\n',"imExt=.jpg");
    fclose(fileID);
    
    fileID2 = fopen([outPath '\det\tracktor_prepr_det.txt'],'at');%
    fclose(fileID2);
    
    fileID3 = fopen([outPath2 '\det\tracktor_prepr_det.txt'],'at');
    fclose(fileID3);
    
    fileID4 = fopen([outPath3 '\det\tracktor_prepr_det.txt'],'at');
    fclose(fileID4);
    
    fileID5 = fopen([outPath '\det\frcnn_prepr_det.txt'],'at');%
    fclose(fileID5);
    
    fileID6 = fopen([outPath2 '\det\frcnn_prepr_det.txt'],'at');
    fclose(fileID6);
    
    fileID7 = fopen([outPath3 '\det\frcnn_prepr_det.txt'],'at');
    fclose(fileID7);
    
    fileID8 = fopen([outPath '\det\det.txt'],'at');%
    fclose(fileID8);
    
    fileID9 = fopen([outPath2 '\det\det.txt'],'at');
    fclose(fileID9);
    
    fileID10 = fopen([outPath3 '\det\det.txt'],'at');
    fclose(fileID10);
    
    fileID = fopen([outPath '\gt\gt.txt'],'at');
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 1
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);

            i1 = i1 + 1;
        end
    end
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 2
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);

            i1 = i1 + 1;
        end
    end
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 3
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);

            i1 = i1 + 1;
        end
    end
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 4
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);

            i1 = i1 + 1;
        end
    end
    
    fclose(fileID);
    
    fileID = fopen([outPath2 '\gt\gt.txt'],'at');
       
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 1
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);

            i1 = i1 + 1;
        end
    end
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 2
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            
            i1 = i1 + 1;
        end
    end
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 3
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            
            i1 = i1 + 1;
        end
    end
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 4
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            
            i1 = i1 + 1;
        end
    end
    
    fclose(fileID);
    
    fileID = fopen([outPath3 '\gt\gt.txt'],'at');
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 1
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);

            i1 = i1 + 1;
        end
    end
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 2
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            
            i1 = i1 + 1;
        end
    end
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 3
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            
            i1 = i1 + 1;
        end
    end
    
    i1 = 1;    
    for k = 1:row1 
        detection = d1;

        x = detection(k,1);
        y = detection(k,2);

        threshold = 17 * scale;

        x1 = x-threshold;
        y1 = y-threshold;

        x2 = x+threshold;
        y2 = y+threshold;

        if x1 < 0
            x1 = 1;
        end

        if y1 < 0
            y1 = 1;
        end

        if x2 >= c1
            x2 = c1-1;
        end

        if y2 >= r1
            y2 = r1-1;
        end

        if inst_type(k) == 4
            fprintf(fileID,'%s,',num2str(i1));
            fprintf(fileID,'%s,',num2str(inst_type(k)));
            fprintf(fileID,'%s,',num2str(round(x-threshold))); % left
            fprintf(fileID,'%s,',num2str(round(y-threshold))); % top
            fprintf(fileID,'%s,',num2str(round(length(x-threshold:x+threshold)))); % width
            fprintf(fileID,'%s,',num2str(round(length(y-threshold:y+threshold)))); % height
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d,',1);
            fprintf(fileID,'%d\n',1);
            
            i1 = i1 + 1;
        end
    end
    
    fclose(fileID);
    
end

for i = 1:14
    path = 'C:\cancer\imRAG\CoNSeP\Test\';
    
    load([path 'Labels\test_' num2str(i) '.mat']);
    d1 = inst_centroid;
        
    img = imread([path '\Images\test_' num2str(i) '.png']);
    img2 = img;
    
    [r1,c1,~] = size(img);
    
    % types
    % 1: others
    % 2: inflammatory
    % 3: epithelial
    % 4: fibroblast

    inst_centroid_pred = [];
    inst_type_pred = [];
 
    [row1,~] = size(d1);
   
    inst_type(inst_type == 4) = 3; % 3 and 4 are combined in original paper as epithelial
    inst_type(inst_type == 6) = 4; % 5, 6, and 7 are combined as fibroblast
	inst_type(inst_type == 7) = 4; % UPDATE: using 4 to represent fibroblast to make it consistent with CRCHisto
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    number = convertStringsToChars(replace(sprintf("%2.d",i),' ', '0'));
    outPath = ['data2\MOT17Labels\test\MOT17-' number '-DPM'];
    outPath2 = ['data2\MOT17Labels\test\MOT17-' number '-FRCNN'];
    outPath3 = ['data2\MOT17Labels\test\MOT17-' number '-SDP'];
    
    index = 1;
    scale = 1;
    
    if exist(outPath, 'dir') == false
        [status, msg, msgID] = mkdir(outPath);
    end
    
    if exist(outPath2, 'dir') == false
        [status, msg, msgID] = mkdir(outPath2);
    end
    
    if exist(outPath3, 'dir') == false
        [status, msg, msgID] = mkdir(outPath3);
    end
     
    if exist([outPath '\det'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath '\det']);
    end
    
    if exist([outPath2 '\det'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath2 '\det']);
    end
    
    if exist([outPath3 '\det'], 'dir') == false
        [status, msg, msgID] = mkdir([outPath3 '\det']);
    end
    
    r1 = r1 * scale;
    c1 = c1 * scale;
    
    [row1,~] = size(d1);
    
    frames = row1;%max(max(max(row1,row2),row3),row4);
    
    fileID = fopen([outPath '\seqinfo.ini'],'at');
	fprintf(fileID,'%s\n',"[Sequence]");
    fprintf(fileID,'%s\n',['name=MOT17-' number '-DPM']);
    fprintf(fileID,'%s\n',"imDir=img1");
    fprintf(fileID,'%s\n',['frameRate=' num2str(1)]);
    fprintf(fileID,'%s\n',['seqLength=' num2str(frames)]);
    fprintf(fileID,'%s\n',['imWidth=' num2str(r1)]);
    fprintf(fileID,'%s\n',['imHeight=' num2str(c1)]);
    fprintf(fileID,'%s\n',"imExt=.jpg");
    fclose(fileID);
    
    fileID = fopen([outPath2 '\seqinfo.ini'],'at');
	fprintf(fileID,'%s\n',"[Sequence]");
    fprintf(fileID,'%s\n',['name=MOT17-' number '-FRCNN']);
    fprintf(fileID,'%s\n',"imDir=img1");
    fprintf(fileID,'%s\n',['frameRate=' num2str(1)]);
    fprintf(fileID,'%s\n',['seqLength=' num2str(frames)]);
    fprintf(fileID,'%s\n',['imWidth=' num2str(r1)]);
    fprintf(fileID,'%s\n',['imHeight=' num2str(c1)]);
    fprintf(fileID,'%s\n',"imExt=.jpg");
    fclose(fileID);
    
    fileID = fopen([outPath3 '\seqinfo.ini'],'at');
	fprintf(fileID,'%s\n',"[Sequence]");
    fprintf(fileID,'%s\n',['name=MOT17-' number '-SDP']);
    fprintf(fileID,'%s\n',"imDir=img1");
    fprintf(fileID,'%s\n',['frameRate=' num2str(1)]);
    fprintf(fileID,'%s\n',['seqLength=' num2str(frames)]);
    fprintf(fileID,'%s\n',['imWidth=' num2str(r1)]);
    fprintf(fileID,'%s\n',['imHeight=' num2str(c1)]);
    fprintf(fileID,'%s\n',"imExt=.jpg");
    fclose(fileID);
    
    fileID2 = fopen([outPath '\det\tracktor_prepr_det.txt'],'at');%
    fclose(fileID2);
    
    fileID3 = fopen([outPath2 '\det\tracktor_prepr_det.txt'],'at');
    fclose(fileID3);
    
    fileID4 = fopen([outPath3 '\det\tracktor_prepr_det.txt'],'at');
    fclose(fileID4);
    
    fileID5 = fopen([outPath '\det\frcnn_prepr_det.txt'],'at');%
    fclose(fileID5);
    
    fileID6 = fopen([outPath2 '\det\frcnn_prepr_det.txt'],'at');
    fclose(fileID6);
    
    fileID7 = fopen([outPath3 '\det\frcnn_prepr_det.txt'],'at');
    fclose(fileID7);
    
    fileID8 = fopen([outPath '\det\det.txt'],'at');%
    fclose(fileID8);
    
    fileID9 = fopen([outPath2 '\det\det.txt'],'at');
    fclose(fileID9);
    
    fileID10 = fopen([outPath3 '\det\det.txt'],'at');
    fclose(fileID10);
    
end
