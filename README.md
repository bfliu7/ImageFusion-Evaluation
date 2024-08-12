\# Image Fusion Evaluation For IVIF


\## 📰 News
\* [2024-08-12] **Open-sourcing evaluation code with 21 metrics for infrared and visible image fusion!** 

\## 🗼 Platform
\* Matlab

\## 🚩 Structure of Folder
\```
Dataset Folder
    ├─21_pairs_tno
    │  ├─ccfuse
    │  │    Fuse1.png
    │  │    Fuse10.png
    │  │    ......
    │  │
    │  ├─ir
    │  │    IR1.png
    │  │    IR10.png
    │  │    ......
    │  │
    │  └─vis
    │       VIS1.png
    │       VIS10.png
    │       ......     
    │
    ├─40_vot_tno
    │  ├─ir
    │  │    IR1.png
    │  │    IR11.png
    │  │    ......
    │  │
    │  └─vis
    │       VIS1.png
    │       VIS11.png
    │       ......
    │       
    └─output
        └─21_pairs_tno
            └─ccfuse
                ├─evaluation_metrics
                │      all_results.txt
                │
                └─evaluation_metrics_single
                        Fuse1.txt
                        Fuse10.txt
                        ......
                        output_single.xlsx
\```
\* As shown above, **21_pairs_tno** and **40_vot_tno** are the folders of the dataset, and **output** is the result after running evaluation.
\* Take the dataset **21_pairs_tno** as an example. Folder **ir** holds the infrared images, referring to **the format of "IR1.png"**. Folder **vis** holds the infrared images, referring to the format of **"VIS1.png"**. Folder **ccfuse** holds the fused results, which name of refers to **"Fuse1.png"**. 
\* **".png"**, **".jpg"** and **'.bmp'** are all allowed to use.
\* Folder output classifies the data first by dataset and then by algorithm. **Evaluation_metrics** holds the average of all fused images, and **evaluation_metrics_single** holds fused images separately.


\## 💁 Get Started
\* Git clone the repository.
\* Prepare the data as the structure of folder.
\* Get to the project of top folder. 
\* Change the default path in amain.m
\```
vifb_path = "datasetexample\"; % better to use an absolute path
bench = "21_pairs_tno";
method = "ccfuse";
\```
    
*##* *🖼️* *Metrics
** Entropy(EN)
\* Cross Entropy(CE)
\* Mutual Information(MI)
\* FMI_pixel
\* FMI_dct
\* FMI_w
\* Peak signal to noise ratio(PSNR)
\* MS structural similarity(MS-SSIM)
\* Root mean square error(RMSE)
\* Spaial Frequency(SF)
\* Standard deviation(SD)
\* Variance
\* Edge Intensity(EI)
\* Average gradient(AG)
\* VIF
\* Qcb
\* Gradient based similarity measurement(Qabf)
\* Correlation coefficient(CC)
\* Sum of correlation differences(SCD)
\* Nabf
\* Qcv






\## 📈 Star Rising
<picture>
  <source
    media="(prefers-color-scheme: dark)"[README (1).md](README%20%281%29.md)
    srcset="
      https://api.star-history.com/svg?repos=l1uuuuu/ImageFusion-for-IVIF-Evaluation&type=Date&theme=dark
    "
  />
  <source
    media="(prefers-color-scheme: light)"
    srcset="
      https://api.star-history.com/svg?repos=l1uuuuu/ImageFusion-for-IVIF-Evaluation&type=Date
    "
  />
  <img
    alt="Star History Chart"
    src="https://api.star-history.com/svg?repos=l1uuuuu/ImageFusion-for-IVIF-Evaluation&type=Date"
  />
</picture>



\## 📋 Citation
Thanks to [Linfeng Tang](*https://github.com/Linfeng-Tang/Image-Fusion/tree/main*) and [Chenzhang Xing](*https://github.com/xingchenzhang/VIFB*) for the open source code, please cite these papers if you are using this code.

\```*bibtex
*@article{Tang2022Survey,
  title={Deep learning-based image fusion: A survey},
  author={Tang, Linfeng and Zhang, Hao and Xu, Han and Ma, Jiayi},  
  journal={Journal of Image and Graphics}
  volume={28},
  number={1},
  pages={3--36},
  year={2023}
}


@article{Tang2022SuperFusion,
  title={SuperFusion: A versatile image registration and fusion network with semantic awareness},
  author={Tang, Linfeng and Deng, Yuxin and Ma, Yong and Huang, Jun and Ma, Jiayi},
  journal={IEEE/CAA Journal of Automatica Sinica},
  volume={9},
  number={12},
  pages={2121--2137},
  year={2022},
  publisher={IEEE}
}


@article{Ma2022SwinFusion,
  title={SwinFusion: Cross-domain Long-range Learning for General Image Fusion via Swin Transformer},
  author={Ma, Jiayi and Tang, Linfeng and Fan, Fan and Huang, Jun and Mei, Xiaoguang and Ma, Yong},
  journal={IEEE/CAA Journal of Automatica Sinica},
  volume={9},
  number={7},
  pages={1200--1217},
  year={2022},
  publisher={IEEE}
}


@article{TangSeAFusion,
title = {Image fusion in the loop of high-level vision tasks: A semantic-aware real-time infrared and visible image fusion network},
author = {Linfeng Tang and Jiteng Yuan and Jiayi Ma},
journal = {Information Fusion},
volume = {82},
pages = {28-42},
year = {2022},
issn = {1566-2535},
publisher={Elsevier}
}


@article{Tang2022DIVFusion,
  title={DIVFusion: Darkness-free infrared and visible image fusion},
  author={Tang, Linfeng and Xiang, Xinyu and Zhang, Hao and Gong, Meiqi and Ma, Jiayi},
  journal={Information Fusion},
  volume = {91},
  pages = {477-493},
  year = {2023},
  publisher={Elsevier}
}


@article{Tang2022PIAFusion,
  title={PIAFusion: A progressive infrared and visible image fusion network based on illumination aware},
  author={Tang, Linfeng and Yuan, Jiteng and Zhang, Hao and Jiang, Xingyu and Ma, Jiayi},
  journal={Information Fusion},
  volume = {83-84},
  pages = {79-92},
  year = {2022},
  issn = {1566-2535},
  publisher={Elsevier}
}


@article{Ma2021STDFusionNet,
  title={STDFusionNet: An Infrared and Visible Image Fusion Network Based on Salient Target Detection},
  author={Jiayi Ma, Linfeng Tang, Meilong Xu, Hao Zhang, and Guobao Xiao},
  journal={IEEE Transactions on Instrumentation and Measurement},
  year={2021},
  volume={70},
  number={},
  pages={1-13},
  doi={10.1109/TIM.2021.3075747}，
  publisher={IEEE}
}



@inproceedings{zhang2020vifb,
title={VIFB: A Visible and Infrared Image Fusion Benchmark},
author={Zhang, Xingchen and Ye, Ping and Xiao, Gang},
booktitle={Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition Workshops},
year={2020}}  


@article{zhang2023visible,
title={Visible and Infrared Image Fusion Using Deep Learning},
author={Zhang, Xingchen and Demiris, Yiannis},
journal={IEEE Transactions on Pattern Analysis and Machine Intelligence},
year={2023},
publisher={IEEE}}
\```