---
title: "Human Detection with a Raspberry Pi Camera, ROS 2, and MATLAB/Simulink"
date: 2025-09-12
lastmod: 2025-09-13
tags: ["MATLAB", "RaspberryPi", "ROS2", "Simulink"]
draft: false
showSummary: true
---

## Introduction
After participating in the ROSConJP2025 workshop (Practical Introduction to ROS 2 and Model-Based Design (MBD)), I was able to enjoy ROS development with Simulink! So, this time I will try object recognition.

## Caution
In this article, detailed operations related to collaboration between MATLAB/Simulink and ROS are omitted.

### Configuration
* MacbookAir M3 (16GB)
    * start matlab/simulink
    * Camera data subscription and object recognition
* RaspberryPi4B (8GB)
    * Publish camera data

### Raspberry Pi side
#### Required package installation
```shell-session
sudo apt update
sudo apt install raspi-config v4l-util
```
#### Change settings
```shell-session
sudo raspi-config
```
Select [3 Interface Options], enable [I1 Legacy Camera] and restart.
#### Starting camera node
```shell-session
sudo apt install ros-jazzy-v4l2-camera
ros2 run v4l2_camera v4l2_camera_node --ros-args -p video_device:=/dev/video0
```

### MATLAB/Simulink side
![read_camera.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/0d30c883-413d-4f46-9ce7-bcf8f022c27f.jpeg)
The Simulink model now looks like the image above.
I subscribe to the published camera image on the Raspberry Pi side and recognize objects using ObjectDetector.
The model used for recognition was created and loaded using the following command.
```matlab
detector=yolov4ObjectDetector("tiny-yolov4-coco");
save('detector.mat', 'detector');
```

The function that filters only human detection is defined as below.
```matlab
function [bboxes_person, isDetected] = filter_detections(boundingBoxes, labels)

    % 検出された物体の数を取得
    numDetections = size(labels, 1);

    % personかどうかを格納するための論理配列を初期化
    isPerson = false(numDetections, 1);

    % forループを使って、ラベルを一つずつチェックする
    for i = 1:numDetections
        % ラベルを一つだけ取り出して文字列に変換し、"person"と比較
        if string(labels(i)) == "person_label"
            isPerson(i) = true;
        end
    end

    % 1つでもpersonが検出されたかチェック
    if any(isPerson)
        % personのバウンディングボックスのみを抽出
        bboxes_person = boundingBoxes(isPerson, :);
        isDetected = true;
    else
        % personが検出されなかった場合、空行列を返す
        bboxes_person = zeros(0, 4, 'single');
        isDetected = false;
    end
end
```

---

[Read the original article on Qiita](https://qiita.com/daigo-suhara/items/38fe1154f49c1414099b)
