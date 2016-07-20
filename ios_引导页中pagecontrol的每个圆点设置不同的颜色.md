#iOS 引导页中pageControl的每个圆点设置不同的颜色

今天公司项目需求要求引导页中给pageControl的每个圆点设置不同的颜色，很少见到有APP这样的。不过还好，我想到了用一个颜色数组来做，首先我们是知道当前页的索引，我们就让颜色按顺序排列，取对应索引的颜色赋给currentPageIndicatorTintColor，这样我就用两行代码实现了不同的颜色，是不是很有趣！

	NSArray *colorArry = @[currentPageFirst,currentPageSeconed,currentPageThird,currentPageFourth,currentPageFifth,currentPageSixth];

    pageControl.currentPageIndicatorTintColor = colorArry[pageControl.currentPage];

![icon1](http://huanghaiyan.96.lt/wp-content/uploads/2016/07/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7-2016-07-20-%E4%B8%8A%E5%8D%8811.18.39.png)

![icon2](http://huanghaiyan.96.lt/wp-content/uploads/2016/07/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7-2016-07-20-%E4%B8%8A%E5%8D%8811.18.52.png)

![icon3](http://huanghaiyan.96.lt/wp-content/uploads/2016/07/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7-2016-07-20-%E4%B8%8A%E5%8D%8811.19.02.png)

图片太大，传三张，哈哈,这两天要上3.0版啦。
