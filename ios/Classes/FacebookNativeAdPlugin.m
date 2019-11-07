#import "FacebookNativeAdPlugin.h"
#import <objc/runtime.h>

@implementation FacebookNativeAdPlugin{ NSObject<FlutterBinaryMessenger>* _messenger;}
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) { _messenger = messenger;
   NSLog(@"FacebookNativeAdPlugin~~~~~~~~~%@ ",_messenger);
  }
  return self;
}
- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    NSLog(@"FacebookNativeAdPlugin createArgsCodec~~~~~~~~~");
    return [FlutterStandardMessageCodec sharedInstance];
}
- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    NSDictionary *dic = args;
    NSLog(@"FacebookNativeAdPlugin createWithFrame~~~~~~~~~%@",dic[@"bg_color"]);
    NativeView* nativeView = [[NativeView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return nativeView;//[[FluffView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args];
}
@end

@implementation NativeView{UIView *_nativebannerView;FBNativeBannerAd *_nativeBannerAd;FBNativeAdViewAttributes *_atr;NSInteger fbNativeBannerAdViewTypeGenericHeight;}


static UIColor * UIColorWithHexString(NSString *hex) {
    unsigned int rgb = 0;
    [[NSScanner scannerWithString:
      [[hex uppercaseString] stringByTrimmingCharactersInSet:
       [[NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEF"] invertedSet]]]
     scanHexInt:&rgb];
    return [UIColor colorWithRed:((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0 green:((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0 blue:((CGFloat)(rgb & 0xFF)) / 255.0 alpha:1.0];
}


- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id )args binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    if ([super init]) {
        NSDictionary *dict = args;
        NSLog(@"FacebookNativeAdPlugin initWithWithFrame~~~~~~~~~%@",dict);
        NSString *IDs = @"Placement_ID";
        fbNativeBannerAdViewTypeGenericHeight = 100;
        _atr = [[FBNativeAdViewAttributes alloc] init];
        if ([dict objectForKey:@"bg_color"])
            _atr.backgroundColor = UIColorWithHexString(dict[@"bg_color"]);//[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        if ([dict objectForKey:@"title_color"])
            _atr.titleColor = UIColorWithHexString(dict[@"title_color"]);//[UIColor colorWithRed:0.1 green:0.9 blue:0.9 alpha:1];
        if ([dict objectForKey:@"desc_color"])
            _atr.descriptionColor = UIColorWithHexString(dict[@"desc_color"]);//[UIColor colorWithRed:0.1 green:0.5 blue:0.45 alpha:1];
        if ([dict objectForKey:@"button_border_color"])
            _atr.buttonBorderColor = UIColorWithHexString(dict[@"button_border_color"]);//[UIColor colorWithRed:0.1 green:0.9 blue:0.9 alpha:1];
        if ([dict objectForKey:@"button_color"])
            _atr.buttonColor = UIColorWithHexString(dict[@"button_color"]);//[UIColor colorWithRed:66/255.0 green:108/255.0 blue:173/255.0 alpha:1];
        if ([dict objectForKey:@"button_title_color"])
            _atr.buttonTitleColor = UIColorWithHexString(dict[@"button_title_color"]);//[UIColor whiteColor];
        if ([dict objectForKey:@"height"])
            fbNativeBannerAdViewTypeGenericHeight = [dict[@"height"] intValue];//dict[@"height"];
        if ([dict objectForKey:@"id"])
             IDs = dict[@"id"];

        NSInteger type = 1;
        if ([dict objectForKey:@"banner_ad"])
             type = [dict[@"banner_ad"] intValue];//dict[@"banner_ad"];

    NSLog(@"FacebookNativeAdPlugin initWithWithFrame~~~~~~~~~%@ ,  %i,  %i",IDs,fbNativeBannerAdViewTypeGenericHeight,type);

        if(type == 1){
            FBNativeBannerAd *nativeBannerAd = [[FBNativeBannerAd alloc] initWithPlacementID:IDs];
            nativeBannerAd.delegate = self;
            [nativeBannerAd loadAd];
        }else{
            FBNativeAd *nativeAd = [[FBNativeAd alloc] initWithPlacementID:@"448732635698200_544899966081466"];
            nativeAd.delegate = self;
            [nativeAd loadAd];
        }
        _nativebannerView = [[UIView alloc] init];
    }
    return self;
}
- (UIView*)view {
  return _nativebannerView;
}

- (void)nativeBannerAdDidLoad :(FBNativeBannerAd *)nativeBannerAd
{
  _nativeBannerAd = nativeBannerAd;

  [self showNativeBannerAd];
}
- (void)nativeAdDidLoad:(FBNativeAd *)nativeAd
{
  FBNativeAdView *adView = [FBNativeAdView nativeAdViewWithNativeAd:nativeAd withType:FBNativeAdViewTypeGenericHeight300 withAttributes:_atr];
  adView.frame = CGRectMake(0,0, 320, 300);
  _nativebannerView.frame = adView.frame;
  [_nativebannerView addSubview:adView];
  NSLog(@"F nativeAdDidLoad~~~~~~~~");
}
- (void)showNativeBannerAd
{
    NSLog(@"FacebookNativeAdPlugin showNativeBannerAd~~~~~~~~");
  if (_nativeBannerAd && _nativeBannerAd.isAdValid) {
        FBNativeBannerAdView   *adView;
      if(fbNativeBannerAdViewTypeGenericHeight == 120){
            adView = [FBNativeBannerAdView nativeBannerAdViewWithNativeBannerAd:_nativeBannerAd withType:FBNativeBannerAdViewTypeGenericHeight120 withAttributes:_atr];
            adView.frame = CGRectMake(0, 0, 320, 120);
      }else{
        adView = [FBNativeBannerAdView nativeBannerAdViewWithNativeBannerAd:_nativeBannerAd withType:FBNativeBannerAdViewTypeGenericHeight100 withAttributes:_atr];
        adView.frame = CGRectMake(0, 0, 320, 100);
      }

      _nativebannerView.frame = adView.frame;
    [_nativebannerView addSubview:adView];


  }
}


@end