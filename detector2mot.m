clc
clear all
close all
warning off
format longG

detector = 0; % change it to 1 for generating FRCNN detections

for i = 71:100
    path = ['CRCHistoPhenotypes_2016_04_28\Classification\img' num2str(i) '\img' num2str(i)];
    
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
    
    img = imread([path '.bmp']);
    
    [r1,c1,~] = size(img);
    
    r1 = r1 * scale;
    c1 = c1 * scale;
      
    if detector == 0
        fileID2 = fopen([outPath '\det\tracktor_prepr_det.txt'],'at');%
        fileID3 = fopen([outPath2 '\det\tracktor_prepr_det.txt'],'at');
        fileID4 = fopen([outPath3 '\det\tracktor_prepr_det.txt'],'at');
    else
        fileID2 = fopen([outPath '\det\frcnn_prepr_det.txt'],'at');%
        fileID3 = fopen([outPath2 '\det\frcnn_prepr_det.txt'],'at');
        fileID4 = fopen([outPath3 '\det\frcnn_prepr_det.txt'],'at');
    end

    fileName = ['detections' '\img' num2str(i) '.json']; 
    fid = fopen(fileName); 
    raw = fread(fid,inf); 
    str = char(raw'); 
    fclose(fid); 
    value = jsondecode(str); 

    fnames = fieldnames(value.nuc);
    
    if detector == 1
        for j=1:numel(fnames)
            cent = value.nuc.(fnames{j}).centroid;
            x = cent(1,1);
            y = cent(2,1);

            threshold = 17*scale;

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

            fprintf(fileID2,'%s,',num2str(j));
            fprintf(fileID2,'%s,',num2str(-1));
            fprintf(fileID2,'%s,',num2str(round(x1))); % left
            fprintf(fileID2,'%s,',num2str(round(y1))); % top
            fprintf(fileID2,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID2,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID2,'%d\n',1);

            fprintf(fileID3,'%s,',num2str(j));
            fprintf(fileID3,'%s,',num2str(-1));
            fprintf(fileID3,'%s,',num2str(round(x1))); % left
            fprintf(fileID3,'%s,',num2str(round(y1))); % top
            fprintf(fileID3,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID3,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID3,'%d\n',1);

            fprintf(fileID4,'%s,',num2str(j));
            fprintf(fileID4,'%s,',num2str(-1));
            fprintf(fileID4,'%s,',num2str(round(x1))); % left
            fprintf(fileID4,'%s,',num2str(round(y1))); % top
            fprintf(fileID4,'%s,',num2str(round(length(x1:x2)))); % width
            fprintf(fileID4,'%s,',num2str(round(length(y1:y2)))); % height
            fprintf(fileID4,'%d\n',1);
        end
    else
        for k = 1:4
            i1 = 1;
            for j=1:numel(fnames)
                if value.nuc.(fnames{j}).type == k
                    cent = value.nuc.(fnames{j}).centroid;
                    x = cent(1,1);
                    y = cent(2,1);
                    
                    minC = min(value.nuc.(fnames{j}).contour);
                    maxC = max(value.nuc.(fnames{j}).contour);
                    
                    width = maxC(1,1) - minC(1,1);
                    height = maxC(1,2) - minC(1,2);
                    
                    threshold = 17*scale;

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
                    
                    img = insertShape(img,'Rectangle',[x1, y1, length(x1:x2), length(y1:y2)]);
            
                    fprintf(fileID2,'%s,',num2str(i1));
                    fprintf(fileID2,'%s,',num2str(value.nuc.(fnames{j}).type));
                    fprintf(fileID2,'%s,',num2str(round(x1))); % left
                    fprintf(fileID2,'%s,',num2str(round(y1))); % top
                    fprintf(fileID2,'%s,',num2str(round(width))); % width
                    fprintf(fileID2,'%s,',num2str(round(height))); % height
                    fprintf(fileID2,'%d,',-1);
                    fprintf(fileID2,'%d,',-1);
                    fprintf(fileID2,'%d,',-1);
                    fprintf(fileID2,'%d\n',-1);

                    fprintf(fileID3,'%s,',num2str(i1));
                    fprintf(fileID3,'%s,',num2str(value.nuc.(fnames{j}).type));
                    fprintf(fileID3,'%s,',num2str(round(x1))); % left
                    fprintf(fileID3,'%s,',num2str(round(y1))); % top
                    fprintf(fileID3,'%s,',num2str(round(width))); % width
                    fprintf(fileID3,'%s,',num2str(round(height))); % height
                    fprintf(fileID3,'%d,',-1);
                    fprintf(fileID3,'%d,',-1);
                    fprintf(fileID3,'%d,',-1);
                    fprintf(fileID3,'%d\n',-1);

                    fprintf(fileID4,'%s,',num2str(i1));
                    fprintf(fileID4,'%s,',num2str(value.nuc.(fnames{j}).type));
                    fprintf(fileID4,'%s,',num2str(round(x1))); % left
                    fprintf(fileID4,'%s,',num2str(round(y1))); % top
                    fprintf(fileID4,'%s,',num2str(round(width))); % width
                    fprintf(fileID4,'%s,',num2str(round(height))); % height
                    fprintf(fileID4,'%d,',-1);
                    fprintf(fileID4,'%d,',-1);
                    fprintf(fileID4,'%d,',-1);
                    fprintf(fileID4,'%d\n',-1);
                    
                    i1 = i1 + 1;
                    
                end
            end
        end
    end
    
    
    fclose(fileID2);
    fclose(fileID3);
    fclose(fileID4);
    
    imshow(img);
end
