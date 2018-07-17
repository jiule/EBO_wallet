

#import "DTMHScrollView.h"
#import "MHView.h"

@interface DTMHScrollView()  <UIScrollViewDelegate>
{
    UIScrollView * _upScollView;
    UIScrollView * _downScollView;
    
    NSArray * _mhBtns ;
    NSArray * _mhViews ;
    
    UIButton * _selBtn;
    BOOL _stop;
}

@end


@implementation DTMHScrollView

-(instancetype)initWithFrame:(CGRect)frame MHBtns:(NSArray *)btnArrays MHViews:(NSArray *)mhViews
{
    if (btnArrays.count != mhViews.count) {
        return nil;
    }
    _mhBtns = btnArrays;
    _mhViews = mhViews;
    _stop = YES;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createView];
        return self;
    }
    return nil;
}


-(void)createView
{
    self.userInteractionEnabled = YES;
    self.clipsToBounds = YES ;
    
    _upScollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _upScollView.bounces = NO;
    [self addSubview:_upScollView];
    _downScollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _downScollView.delegate = self ;
    _downScollView.pagingEnabled = YES ;
    
    [self addSubview:_downScollView];
    
    float btn_x = 0;  //这是上面按钮的初始化位子
    float btn_h = 0;  //这是记录第一个按钮的高度
    float view_w = self.width;  //这是下面scillview 的宽度
    
    for (int i = 0 ; i < _mhBtns.count; i++)
    {
        UIButton * btnView =_mhBtns[i];
        btnView.tag = 10000 +i;
        [btnView addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_upScollView addSubview:btnView];
        
        [btnView setX:btn_x]; //重新设置 按钮的x值
        btn_x += btnView.width ;
        if (i == 0) {
            btn_h = btnView.height + 10;
            _selBtn = btnView;
            _selBtn.selected = YES;
        }
        [btnView setHeight:btn_h];
    }
    
    for (int i = 0 ; i < _mhViews.count; i++) {
        MHView * view = _mhViews[i];
        [view setX:view_w * i];
        [view setWidth:view_w];
        [view setHeight:self.height - btn_h];
        [view setY:0];
        if ( i == 0) {
            [view createView];
        }
        [_downScollView addSubview:view];
    }
    
    _upScollView.contentSize = CGSizeMake(btn_x, 0);
    [_downScollView setY:btn_h];
    [ _downScollView setHeight:self.height - btn_h];
    _downScollView.contentSize = CGSizeMake(view_w * _mhViews.count, self.height - btn_h);
  //  _downScollView.backgroundColor = [UIColor greenColor];
  //  NSLog(@"%@",NSStringFromCGSize(_downScollView.contentSize));
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, btn_h - 1, self.width, 1)];
    lineView.backgroundColor = COLOR_B5;
    [self addSubview:lineView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / self.width;  //计算这是第几页
   
    //获取第几个按钮
    UIButton * btn = _mhBtns[index];

    if (btn == _selBtn) {
        return ;
    }
    _selBtn.selected = NO;
    _selBtn = btn;
    _selBtn.selected = YES;
    
    MHView * downView = _mhViews[index];
    if (!downView.is_load) {  //判断这个view 有没有被创建  没有创建 就创建
        [downView createView];  //创建view
    }    else {
        [downView mh_loadView];
    }
   [downView setHeight:self.height - 30];
    if (index == _mhBtns.count - 1) {
         _upScollView.contentOffset = CGPointMake((_upScollView.contentSize.width - self.width) / _mhBtns.count * (index+1), 0);
    }else{
        _upScollView.contentOffset = CGPointMake((_upScollView.contentSize.width - self.width) / _mhBtns.count * index, 0);
    }
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:btn:MHView:)]) {
        [self.delegate scrollViewDidScroll:self btn:btn MHView:downView];
    }
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / self.width;  //计算这是第几页
    
    MHView * downView = _mhViews[index];
    UIButton * btn = _mhBtns[index];
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:btn:MHView:)]) {
        [self.delegate scrollViewDidScroll:self btn:btn MHView:downView];
    }
}

-(void)BtnClick:(UIButton *)btn
{
    if (_selBtn == btn) {
        return ;
    }
    _selBtn.selected = NO;
    _selBtn = btn;
    _selBtn.selected = YES;
    
    int index = (int)btn.tag - 10000;
    //让下面一个view 滑动到指定位子
    _downScollView.contentOffset = CGPointMake(self.width * index, 0);
    
    MHView * downView = _mhViews[index];
    if (!downView.is_load) {  //判断这个view 有没有被创建  没有创建 就创建
        [downView createView];  //创建view
    }else {
        [downView mh_loadView];
    }
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:btn:MHView:)]) {
        [self.delegate scrollViewDidScroll:self btn:btn MHView:downView];
    }
    
}
-(void)MH_ScollViewWithStop:(BOOL)stop
{
    _stop = stop;
    if (stop) {
        _downScollView.contentSize = CGSizeZero;
        for (int i = 0 ; i < _mhViews.count; i++) {
            MHView * mhView = _mhViews[i];
            [mhView mh_subViewsScrollStop:stop];
        }
    }else {
        _downScollView.contentSize = CGSizeMake(_downScollView.width * _mhBtns.count, _downScollView.height);
        for (int i = 0 ; i < _mhViews.count; i++) {
            MHView * mhView = _mhViews[i];
            [mhView mh_subViewsScrollStop:stop];
        }
  }
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [ _downScollView setHeight:self.height- _selBtn.height];
    if (_stop == NO) {
        _downScollView.contentSize = CGSizeMake(_downScollView.width * _mhBtns.count, _downScollView.height);
    }
    for (int i = 0 ; i < _mhViews.count; i++) {
       MHView * mhView = _mhViews[i];
       [mhView setHeight:frame.size.height - _selBtn.height ];
    }
}

@end
