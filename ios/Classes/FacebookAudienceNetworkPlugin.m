#import "FacebookAudienceNetworkPlugin.h"
#import "FacebookInterstitialAdPlugin.h"
#import "FacebookBannerAdPlugin.h"
#import "FacebookNativeAdPlugin.h"
@implementation FacebookAudienceNetworkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"fb.audience.network.io" binaryMessenger:[registrar messenger]];
  FacebookAudienceNetworkPlugin* instance = [[FacebookAudienceNetworkPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];


   // Interstitial Ad channel
  FlutterMethodChannel* interstitialAdChannel = [FlutterMethodChannel methodChannelWithName:@"fb.audience.network.io/interstitialAd" binaryMessenger:[registrar messenger]];
  FacebookInterstitialAdPlugin* instance1 = [[FacebookInterstitialAdPlugin alloc] initWithChannel:interstitialAdChannel];
  [registrar addMethodCallDelegate:instance1 channel:interstitialAdChannel];

  FacebookBannerAdPlugin* baninstance = [[FacebookBannerAdPlugin alloc] initWithMessenger:registrar.messenger];
  [registrar registerViewFactory:baninstance withId:@"fb.audience.network.io/bannerAd"];

  FacebookNativeAdPlugin* nativeinstance = [[FacebookNativeAdPlugin alloc] initWithMessenger:registrar.messenger];
  [registrar registerViewFactory:nativeinstance withId:@"fb.audience.network.io/nativeAd"];

}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSLog(@"!!!!!!!! %@",call.method);
  if ([@"init" isEqualToString:call.method]) {
    result(@(YES));
    //result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
