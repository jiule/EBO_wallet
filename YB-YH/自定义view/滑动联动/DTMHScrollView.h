

#import <UIKit/UIKit.h>


@class MHView;
@class DTMHScrollView;

@protocol DTMHScrollViewDelegate<NSObject>

@optional

- (void)scrollViewDidScroll:(DTMHScrollView  *)scrollView  btn:(UIButton *)btn MHView:(MHView *)mhView;
@end

@interface DTMHScrollView : UIView

-(instancetype)initWithFrame:(CGRect)frame MHBtns:(NSArray *)btnArrays MHViews:(NSArray *)mhViews;

@property(nonatomic,weak)id <DTMHScrollViewDelegate>delegate;

-(void)MH_ScollViewWithStop:(BOOL)stop;

@end
