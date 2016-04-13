文件层次结构：
  
  DevelopmentIOS:
  
    常用的工具类和分类Common(Category,Utils) ,
    
    Manager包含封装好的定位和网络请求,
    
    UI系统自定义的经典UITabBarController和UINavigationController的搭建,(后期混更新自定义的UITabBarController和UINavigationColtroller的搭建方式和抽屉界面等)
    
    ThirdPart是用到的大三方API，这里只做简单介绍
    
  详细介绍：
  
    Common目录
    
      Category目录下：
      
        NSArray,NSMutableArray,NSData,NSDate,NSDictionary,NSKeyedUnarchiver,NSNumber,NSObject,NSString,NSString
        
        UIApplication,UIBarButtonItem,UIBezierPath,UIColor,UIControl,UIDevice,UIFont,UIGestureRecognizer,UIImage,UIScrollView,UITextField,UIView,UIViewController
        
        CALayer
        
      Utils目录下:
        
        Album:打开相册或相机工具类的封装
        
        AlertView:封装的一个包含图片和文字的弹出框UI
        
        Base64_MD5_AES:数据加密解密的工具类
        
        BigImageView:点击图片看大图
        
        Foundation:有序的字典（OrderedDictionary）,LSProjectsUtils(工程的工具类包含常用的工具类方法)，SafeArray,SafeDictionary(线程安全)
        
        NetWorkReachability:(网络监测)
        
        Other:(单例的模型，计算文字大小的工具类，YY的钥匙串存取,弱路由的运用)
        
        QRScannerCodeView: (二维码扫描的工具类)
        
        Skin:(皮肤工具类)
        
        SoundAndMusic:(播放本地音效音乐)
        
        UIBarButtonItem:(封装的BarButtonItem结合CommonViewController才可以使用)
        
        ViewController:(常用的获取Controller和UITabBarcontroller和UINavigationController才可以使用否则会闪退)
      
      
      
        
        
