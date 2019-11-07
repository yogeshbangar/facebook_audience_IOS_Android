#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>

@interface FacebookInterstitialAdPlugin : NSObject <FBInterstitialAdDelegate>
    @property (nonatomic, strong) FBInterstitialAd *interstitialAd;
    @property (nonatomic, strong) FlutterMethodChannel* channel;
- (instancetype)initWithChannel:(FlutterMethodChannel *)channel;
@end
