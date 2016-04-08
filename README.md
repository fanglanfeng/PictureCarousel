# PictureCarousel
PictureCarousel

说明：
主要功能：
1.实现轮播图的无限滚动效果
    
#warning - 这个是在你需要导入的项目的设置 --->> 必须按照相应的顺序,否则会造成其他BUG

    PictureCarousel *pictureView = [[PictureCarousel alloc] init];
    //1.先将你需要设置的图片赋值
    pictureView.arrayImage = arrayM;
    //2.设置要添加的图片的数量 == arrayM.count
    pictureView.imageCount = 3;
    //3.设置位置
    pictureView.frame = CGRectMake(0, 0, 350, 500);
    //4.加入到view上
    [self.view addSubview:pictureView];
    self.picture = pictureView;
