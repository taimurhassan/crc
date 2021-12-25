import sacred
from sacred import Experiment

import os.path as osp

import pandas as pd
import scipy.io as sio
import numpy as np

from sacred import SETTINGS
SETTINGS.CONFIG.READ_ONLY_CONFIG=False

def pair_nuclei_and_generate_output(out_files_dir, datasetName, detector = "tracktor_prepr_det"):
    startFrame = 159
    endFrame = 238

    if datasetName == "crchisto":
        startFrame = 71
        endFrame = 100
    elif datasetName == "consep":
        startFrame = 1
        endFrame = 14
    elif datasetName == "pannuke":
        startFrame = 1
        endFrame = 2359
    elif datasetName == "lizard":
        startFrame = 159
        endFrame = 238

    print("Start Frame: ",startFrame, ", End Frame: ", endFrame, ", Dataset: ", datasetName)

    print("\n\nBackbone: ",detector,"\n\n")

    for i in range(startFrame, endFrame + 1):
        pred2 = []
        gt2 = []

        gt1 = []
        pred1 = []

        print(out_files_dir.replace(':','_'))

        initial = "/MOT17-0"
        if i > 9:
            initial = "/MOT17-"

        pn1 = out_files_dir.replace(':','_') + initial + str(i) + "-FRCNN.txt"
        pn2 = "data/MOT17Det/test" + initial + str(i) + "/gt/gt.txt"
        if detector == "tracktor_prepr_det":
            pn3 = "data/MOT17Labels/test" + initial + str(i) + "-FRCNN/det/tracktor_prepr_det.txt"
        else:
            pn3 = "data/MOT17Labels/test" + initial + str(i) + "-FRCNN/det/frcnn_prepr_det.txt"

        print(pn1)
        print(pn2)
        print(pn3)

        f1 = open(pn3, "r")

        for x in f1:
            minDist = 1000000000
            pairNodeCentroid = [] #Centroid Point
            xs = x.split(',')
            #print(xs) # tokenized line

            type = int(xs[1])
            pred2.append(type)
            x1 = float(xs[2]) + float(xs[4])/2
            y1 = float(xs[3]) + float(xs[5])/2

            f2 = open(pn1, "r")

            for y in f2:
                ys = y.split(',')
                #print(ys)
                #input()

                x2 = float(ys[2]) + float(ys[4])/2
                y2 = float(ys[3]) + float(ys[5])/2

                distance = np.sqrt(((x1-x2) * (x1-x2)) + ((y1-y2) * (y1-y2)))

                if distance < minDist:
                    minDist = distance
                    pairNodeCentroid = [x2, y2]
                    #print(int(type))

            f2.close()
            #input()

            if len(pairNodeCentroid) > 0:
                pred1.append([round(pairNodeCentroid[0],2),round(pairNodeCentroid[1],2)])
            else:
                pred1.append([round(x1,2),round(y1,2)])

        f1.close()


        print(len(pred2))
        f1 = open(pn2, "r")
        #print(len(pred1))

        for x in f1:
            minDist = 1000000000
            pairNodeCentroid = [] #Centroid Point
            xs = x.split(',')
            #print(xs) # tokenized line
            type = int(xs[1])
            x1 = float(xs[2]) + float(xs[4])/2
            y1 = float(xs[3]) + float(xs[5])/2

            gt2.append(type)
            gt1.append([round(x1,2),round(y1,2)])

                #print(gt1)

        f1.close()

        print(len(gt2))
        #print(len(pred2))
        #input()

        inst_type_pred = np.transpose(np.array(pred2))
        inst_type_gt = np.transpose(np.array(gt2))
        inst_centroid_pred = np.array(pred1)
        inst_centroid_gt = np.array(gt1)

        index = 0
        index2 = 0

        pn4 = "mot_neural_solver/output/"+ datasetName +"/true/detections_"+ str(i) + "_" + str(index2) + ".mat"
        pn5 = "mot_neural_solver/output/"+ datasetName +"/pred/detections_"+ str(i) + "_" + str(index2) + ".mat"

        pred1 = []
        pred2 = []
        gt1 = []
        gt2 = []

        if datasetName == "pannuke":
            pn4 = "mot_neural_solver/output/"+ datasetName +"/true/detections_"+ str(i) + ".mat"
            pn5 = "mot_neural_solver/output/"+ datasetName +"/pred/detections_"+ str(i) + ".mat"

            mdic = {"inst_centroid": inst_centroid_gt, "inst_type": inst_type_gt}

            sio.savemat(pn4, mdic)


            mdic = {"inst_centroid": inst_centroid_pred, "inst_type": inst_type_pred}

            sio.savemat(pn5, mdic)
        else:
            for ii in range(min(len(inst_type_gt),len(inst_type_pred))):
                if index > 99:
                    pn4 = "mot_neural_solver/output/"+ datasetName +"/true/detections_"+ str(i) + "_" + str(index2) + ".mat"
                    pn5 = "mot_neural_solver/output/"+ datasetName +"/pred/detections_"+ str(i) + "_" + str(index2) + ".mat"

                    index = 0

                    #print(len(pred2))

                    mdic = {"inst_centroid": gt1, "inst_type": gt2}

                    sio.savemat(pn4, mdic)


                    mdic = {"inst_centroid": pred1, "inst_type": pred2}

                    sio.savemat(pn5, mdic)

                    pred1 = []
                    pred2 = []
                    gt1 = []
                    gt2 = []
                else:
                    index = index + 1
                    index2 = index2 + 1

                pred1.append(inst_centroid_pred[ii])
                pred2.append(inst_type_pred[ii])

                if inst_centroid_gt[ii] != '':
                    gt1.append(inst_centroid_gt[ii])
                    gt2.append(inst_type_gt[ii])

                    if inst_type_gt[ii] == 4:
                        print(inst_type_gt[ii], " type is coming in gt")

                    if inst_type_gt[ii] == 5:
                        print(inst_type_gt[ii], " type is coming in gt")
