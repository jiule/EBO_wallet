

#import <UIKit/UIKit.h>

@interface MHView : UIView
//保存这个页面 有没有被划过
@property(nonatomic,assign)BOOL is_load;
//画页面
-(void)createView;
//刷新页面
-(void)mh_loadView;
- (void)mh_subViewsScrollStop:(BOOL)stop;
@end
