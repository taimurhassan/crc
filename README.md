# Learning to Recognize Cellular Communities in Histopathological Landscape

This the official implementation of our paper, titled, *Learning to Recognize Cellular Communities in Histopathological Landscape*. In this codebase, we couple neural message solver with the nuclei graph decomposition network in order to effectively recognize cellular communities within the CRC whole slide images. The block diagram of the complete framework is illusrated below: 

![Block_Diagram](images/bd.png)

## Requirements
This codebase is developed and fully tested on Anaconda using Ubuntu v20.04. Hence, we recommend the utilization of the same platform in order to avoid setup issues. Also, please note that we do not support Windows OS. 

The execution of the code is currently dependent on two virtual environments, i.e., `cellGraph.yaml` and `metrics.yaml`. `cellGraph.yaml` is to be used for training and testing the proposed framework. Moreover, in order to fairly compare our work with state-of-the-art, `metrics.yaml` environment has to be used, as it computes the crc metrics originally developed by the [HoVerNet](https://github.com/vqdang/hover_net) devs. In future, we will merge both of these two environments but, for now, we recommend their independent usage just to avoid libs incompatibility.   

## Setup

1. Import the 'cellGraph.yaml' and install the related code dependencies as:
    1. `conda env create -f cellGraph.yaml`
    2. `conda activate cellGraph`
    3. `pip install -e tracking_wo_bnw`
    4. `pip install -e .`

2. Import the 'metrics.yaml' and infer the related libraries from the requirement.txt file:
   1. `conda env create -f metrics.yaml`
    
3. Download the datasets from the following URLs. In order to use these datasets, they need to be tailored in the MOT format. For this purpose, we provide the conversion scripts as discussed in detail within the `preprocessing` section. Moreover, the desired converted datasets must be placed within the `data` folder within the project's root directory.

4. Create two more folders (`output`, `mot_neural_solver/output`) in the project's root directory to save proposed framework's output. Their hierarchy are:

```
├── output
│   ├── experiments
│   │   └── time_date_train_w_default_config
│   │   └── time_date_evaluation
│   ├── trained_models
│   |   └── frcnn
│   |   └── graph_nets
│   |   └── reid

```

```
├── mot_neural_solver
│   ├── output
│   |   ├── crchisto
│   |   │   └── true
│   |   │   └── pred
│   |   ├── consep
│   |   │   └── true
│   |   │   └── pred
│   |   ├── pannuke
│   |   │   └── true
│   |   │   └── pred
│   |   ├── lizard
│   |   │   └── true
│   |   │   └── pred
│   |   ├── graphs
│   |   │   └── MOT17-01-FRCNN.npy

```

## Preprocessing
To use each CRC dataset with this codebase, it has to be converted in the MOT-17 format. The MOT-17 format requires two sub-directories (`MOT17Dets` and `MOT17Labels`) in which each WSI (within the candidate dataset) has to be replicated into multiple frames (depending on the total number of nuclei classes). Moreover, each nuclei is connected to its adjacent pair in the breadth first search manner to yield the time-aware sequence graph representation. For this purpose, we first provide the `generateDataset.m` script, which converts the desired dataset to MOT-17 format. Please note that this script has to be tuned as per each dataset structure accordingly. Then, we provide `detector2mot.m` script which changes each detection (recorded in the JSON format) from each preprocessing backbone to mot structure. Currently, we provide support for the two detectors, i.e., [Faster R-CNN](https://github.com/facebookresearch/detectron2) and [HoVer-Net](https://github.com/vqdang/hover_net).  

For convenience, we also provide mirrors for the converted datasets. These mirrors can directly take you to the training and testing phase. The mirrors for the CRCHisto and CONSEP are given below. However, if you need mirrors for PanNuke and Lizard, then please contact us. We can give you temporary links to download these mirrors as their size is over 150GB.
   1. [CRCHisto]()
   2. [CONSEP]()

## Training
1. After converting and placing the desired dataset in the `data` folder. Please make sure that the following dataset configurations are updated:
   1. 'dataset' parameter in `tracking_cfg.yaml`
   2. 'MOV_CAM_DICT' in `MOTCha_loader.py`
   3. 'sequence_numbers' in `seq_processor.py`
   4. 'frame_numbers' in `splits.py`

2. Train the proposed framework by running:
```
python scripts/train.py 
```
By default, HoVer-Net is chosen as a backbone detector. If you want to use Faster R-CNN, then please run:
```
python scripts/train.py with prepr_w_tracktor=False
```

The trained models (for each dataset) can also be downloaded through:
```
bash scripts/setup/download_models_crchisto.sh
bash scripts/setup/download_models_consep.sh
bash scripts/setup/download_models_pannuke.sh
bash scripts/setup/download_models_lizard.sh
```

## Inference
1. In order to evaluate the proposed framework on the test dataset, please run:
```
python scripts/evaluate.py 
```
or
```
python scripts/evaluate.py with prepr_w_tracktor=False
```
2. To compute performance metrics, please activate `metrics.yaml` in a seperate shell, and run:
```
python compute_stats.py --mode=type --pred_dir='pred_dir' --true_dir='true_dir'
```
## Acknowledgement
We would like to thank Guillem Brasó and his team for their excellent contribution towards developing [time-aware neural solver for multi-object tracking](https://github.com/dvl-tum/mot_neural_solver). Apart from this, we would like to thanks Simon Graham and his team for their excellent work in releasing [HoVer-Net](https://github.com/vqdang/hover_net) and the original implementation of their performance metrics related to CRC nucleus segmentation and classification. Our codebase is extensively derived from these repositories/ projects, and as a token of our appreciation, we have acknowledged and cited their works in our manuscript.

## Citation
If you use this codebase (or any part of it) in your research, then you **MUST** cite the following paper:
```
@article{Hassan2021Cancer,
  title   = {A Dilated Residual Hierarchically Fashioned Segmentation Framework for Extracting Gleason Tissues and Grading Prostate Cancer from Whole Slide Images},
  author  = {Taimur Hassan and Bilal Hassan and Ayman El-Baz and Naoufel Werghi},
  note = {16th IEEE Sensors Applications Symposium (SAS), 2021}
}
```
## Contact
In case of any query, please feel free to contact us at taimur.hassan@ku.ac.ae



