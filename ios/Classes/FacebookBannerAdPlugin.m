#import "FacebookBannerAdPlugin.h"
#import <objc/runtime.h>

@implementation FacebookBannerAdPlugin { NSObject<FlutterBinaryMessenger>* _messenger;}
 /*
- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"~~~~~FacebookBannerAdPlugin~~~~~~~~");
    }
    return self;
}*/
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
    NSLog(@"initWithMessenger~~~~~~~~~%@ %i",_messenger);
  }
  return self;
}
- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    NSLog(@"FacebookNativeAdPlugin createArgsCodec~~~~~~~~~");
    return [FlutterStandardMessageCodec sharedInstance];
}
- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {

//- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    //frame = CGRectMake(0, 0, 320, 50);

    NSLog(@"createWithFrame~~~~~~~~~%@",args);
    NSDictionary *dict = args;
    NSLog(@"createWithFrame !!! ~~~~~~~~~%@",dict);
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([args class], &count);
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSLog(@"~~~~~FacebookBannerAdPlugin~~~~~~~~%@ : %@",key,([args valueForKey:key] ? [args valueForKey:key] : @""));
    }



    FluffView* fluffView = [[FluffView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];

    return fluffView;//[[FluffView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args];
}

@end



@implementation FluffView{ CGRect _frame; int64_t _viewId; FlutterMethodChannel* _channel; FBAdView* _fbAdView;}


- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id )args binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    if ([super init]) {
        NSDictionary *dict = args;
        NSString *IDs = @"Placement_ID"; if ([dict objectForKey:@"id"])
        IDs = dict[@"id"];

        NSLog(@"initWithWithFrame initWithWithFrame~~~%@~~~~~~%@",IDs,dict);
        frame.size.width = 320;frame.size.height = 50;
        _frame = frame;
        _viewId = viewId;
        _fbAdView = [[FBAdView alloc] initWithPlacementID:IDs adSize:kFBAdSizeHeight50Banner rootViewController:self];
        _fbAdView.frame = _frame;// CGRectMake(0, 0, 320, 250);
        _fbAdView.delegate = self;
        [_fbAdView loadAd];
        NSLog(@"~~~~~initWithFrame~~~~view~~~~%0.2f,%0.2f,%0.2f,%0.2f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    }
    return self;
}
- (UIView*)view {
    NSLog(@"~~~~~initWithFrame~~~~view~~~~%0.2f,%0.2f,%0.2f,%0.2f",_frame.origin.x,_frame.origin.y,_frame.size.width,_frame.size.height);
    UIView *uiview = [[UIView alloc] initWithFrame:_frame];
        uiview.backgroundColor = UIColor.blueColor;

  return _fbAdView;
}
- (void)adViewDidClick:(FBAdView *)adView
{
    NSLog(@"Banner ad was clicked.");
}

- (void)adViewDidFinishHandlingClick:(FBAdView *)adView
{
    NSLog(@"Banner ad did finish click handling.");
}

- (void)adViewWillLogImpression:(FBAdView *)adView
{
    NSLog(@"Banner ad impression is being captured.");
}
- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error
{
  NSLog(@"Ad failed to load %@",error);
}

- (void)adViewDidLoad:(FBAdView *)adView
{
  NSLog(@"Ad was loaded and ready to be displayed");
  //[self showBanner];
}

@end
