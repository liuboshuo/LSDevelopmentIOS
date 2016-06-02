文件层次结构：
  
  DevelopmentIOS:
  
    常用的工具类和分类Common(Category,Utils) ,
    
    Manager包含封装好的定位和网络请求,通讯录的访问，大文件的下载（面向对象的封装）
    
    UI系统自定义的经典UITabBarController和UINavigationController的搭建,
    
    抽屉效果的搭建
    
    (后期混更新自定义的UITabBarController和UINavigationColtroller的搭建方式等)
    
    ThirdPart是用到的第三方API，这里只做简单介绍
    
  详细介绍：
  
    Common目录
    
      Category目录下：
      
        NSArray,NSMutableArray,NSData,NSDate,NSDictionary,NSKeyedUnarchiver,NSNumber,NSObject,NSString,NSString
        
        UIApplication,UIBarButtonItem,UIBezierPath,UIColor,UIControl,UIDevice,UIFont,UIGestureRecognizer,UIImage,UIScrollView,UITextField,UIView,UIViewController
        
        CALayer
        
      Utils目录下:
      
        NotificationHubCount:消息数字提醒的封装
        
        WebViewController:带进度条的UIWebView的封装
        
        popMenuView:弹出式的菜单
        
        ProgressView:弧形进度条
        
        InfiniteScrollView:轮播图
        
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
      
    Resources:
      
      SkinFile的switch_night一定要创建引用才可以不然的话皮肤无效
      
    Manager:
      
      HttpRquest:(网络请求的封装（AFNetworking）)
      
      Location:(定位基于系统)
      
      DownloadManager:大文件的下载和视频的下载边下载边播放的实现方式
      
    UI:
      
      NormalTabBarUI: (利用系统的UITabBar,和UINavigation搭建的界面)只需要在UIPropertyCOnfig.plist 配置TabBarUi即可
      
      CustomTabUI: 自定义UITabBarController和导航的效果，无特殊需求建议使用系统的UITabBar即可
      
      NormalDrawerUI: 抽屉效果
      
Demo:
  
  测试Demo不是很完善
  
  
  谢谢大家！欢迎修改Bug,不要记得给赞啊
      
        
        
