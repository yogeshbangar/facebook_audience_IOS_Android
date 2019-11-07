#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>


@interface FluffView : NSObject <FlutterPlatformView ,FBAdViewDelegate>
//@property int64_t viewId;
//@property CGRect frame;
//- (instancetype)initWithFrame:(CGRect)frame  viewIdentifier:(int64_t)viewId arguments:(id )args;
- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id )args binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
- (UIView*)view;
@end

@interface FacebookBannerAdPlugin : NSObject <FlutterPlatformViewFactory>
   // @property (nonatomic, strong) FBAdView *fbAdView;
    //@property (nonatomic, strong) FlutterMethodChannel* channel;
//- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args;
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end
