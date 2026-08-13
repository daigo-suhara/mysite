---
title: "[ROS2+MATLAB/Simulink]ラズパイカメラから人間の検出"
date: 2025-09-12
lastmod: 2025-09-13
tags: ["MATLAB", "RaspberryPi", "ROS2", "Simulink"]
draft: false
showSummary: true
---

## はじめに
ROSConJP2025のワークショップ（ROS 2とモデルベースデザイン(MBD)の実践入門）に参加したことにより，SimulinkでROS開発楽しいー！となったので，今回は物体認識を試してみます．

## 注意
この記事では，MATLAB/SimulinkとROSの連携に関する詳しい操作などは省いております．

### 構成
* MacbookAir M3 (16GB)
    * matlab/simulink起動
    * カメラデータのSubscribeと物体認識
* RaspberryPi4B (8GB)
    * カメラデータのPublish

### ラズパイ側
#### 必要パッケージインストール
```shell-session
sudo apt update
sudo apt install raspi-config v4l-util
```
#### 設定の変更
```shell-session
sudo raspi-config
```
[3 Interface Options] を選択して [I1 Legacy Camera] を Enableにして再起動します．
#### カメラノードの起動
```shell-session
sudo apt install ros-jazzy-v4l2-camera
ros2 run v4l2_camera v4l2_camera_node --ros-args -p video_device:=/dev/video0
```

### MATLAB/Simulink側
![read_camera.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/0d30c883-413d-4f46-9ce7-bcf8f022c27f.jpeg)
Simulinkモデルは上図のようになりました．
ラズパイ側でパプリッシュしたカメラ画像をサブスクライブして，ObjectDetectorで物体認識しています．
なお認識に使用するモデルは下記コマンドで，モデルファイルを作成して読み込ませました．
```matlab
detector=yolov4ObjectDetector("tiny-yolov4-coco");
save('detector.mat', 'detector');
```

人の検出のみフィルタリングするfunctionは下記のように定義しました．
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

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/38fe1154f49c1414099b)
