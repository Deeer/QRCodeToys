#基本分类
1.PermissionHelper -- 权限和状态获取 
2.Scanview -- 扫描视图功能部分： 包含二维码扫描 和 亮度检测并自动开启🔦
3.Generator -- 根据文本或URL生成二维码
4.Detector -- 检测图片内容分类 

##可进行二维码界面的二次开发
##TODO：接下来就是把这些玩具拼在一起


#UPDATA


##⌨️代码结构

····
.
├── Detector //图片二维码检测器
│   ├── UIImage+detect.h
│   └── UIImage+detect.m
├── Generator //二维码生成器
│   ├── DeeQRcodeGenerator.h
│   ├── DeeQRcodeGenerator.m
│   ├── UIImage+generator.h
│   └── UIImage+generator.m
├── InterFaceLayer //顶层 —— 扫描效果展示界面
│   ├── DeeQRCodeDemoLayer.h
│   └── DeeQRCodeDemoLayer.m
├── PermissionHelper //权限检测管理器
│   ├── DeeScannerPermissionManager.h
│   └── DeeScannerPermissionManager.m
└── ScannerLayer //二维码扫描器
    ├── DeeScannerLayer.h
    └── DeeScannerLayer.m 	
····

#🚧施工图
|
| ——— 扫描效果展示界面
| 
| ——— 二维码扫描器 
|
| ——— view自带的Layer





