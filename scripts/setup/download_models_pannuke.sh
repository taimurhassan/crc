#!/usr/bin/env bash

OUTPUT_PATH=$(python -c "from mot_neural_solver.path_cfg import OUTPUT_PATH; print(OUTPUT_PATH)")
wget -P $OUTPUT_PATH/trained_models/reid https://drive.google.com/file/d/1-XmBHJSaTnP205ZZNoVDAsuX-VklZJ0M/view?usp=sharing
wget -P $OUTPUT_PATH/trained_models/frcnn https://drive.google.com/file/d/1afNm36iEALmC_-s4TCLYPx4gIp474nHW/view?usp=sharing
wget -P $OUTPUT_PATH/trained_models/graph_nets https://drive.google.com/file/d/1qPTNX200RWv2dXM1q76dqt2J88FMKm8z/view?usp=sharing

