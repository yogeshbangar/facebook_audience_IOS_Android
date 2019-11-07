
#import "FacebookInterstitialAdPlugin.h"

@implementation FacebookInterstitialAdPlugin
/*- (instancetype)init {

    if (self = [super init]) {
        // Initialize self
        NSLog(@"FacebookInterstitialAdPlugin~~~");
        self.interstitialAd = [[FBInterstitialAd alloc] initWithPlacementID:@"448732635698200_544198979484898"];
        self.interstitialAd.delegate = self;
    }
    return self;
}*/

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel {
  self = [super init];
  if (self) {
      self.channel = channel;
      self.interstitialAd = [[FBInterstitialAd alloc] initWithPlacementID:@"448732635698200_544198979484898"];
      self.interstitialAd.delegate = self;
  }
  return self;
}

/*-(instancetype)initWithChannel:(FlutterMethodChannel *)channel
{
     self = [super init];
     if (self) {
         self.channel =  channel;
          NSLog(@"FacebookInterstitialAdPlugin~~initWithName~");
         self.interstitialAd = [[FBInterstitialAd alloc] initWithPlacementID:@"448732635698200_544198979484898"];
         self.interstitialAd.delegate = self;
     }
     return self;
}
*/
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSLog(@"!!!!handleMethodCall!!!! %@",call.method);
    if ([@"loadInterstitialAd" isEqualToString:call.method]) {
        NSLog(@"!!!!handleMethodCall~~~~ %@",call.method);
        [self.interstitialAd loadAd];
        result(@(YES));
    //result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"showInterstitialAd" isEqualToString:call.method]) {
       NSLog(@"!!!!showInterstitialAd~~~~ %@",call.method);
      //[self.interstitialAd loadAd];
      UIViewController *objViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
      [self.interstitialAd showAdFromRootViewController:objViewController];
       result(@(YES));
    //result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)interstitialAdDidLoad:(FBInterstitialAd *)interstitialAd
{
  NSLog(@"Ad is loaded and ready to be displayed");

  if (interstitialAd && interstitialAd.isAdValid) {
    // You can now display the full screen ad using this code:
    //UIViewController *objViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    //[interstitialAd showAdFromRootViewController:objViewController];

    NSDictionary *dictionary = @{@"placement_id" : interstitialAd.placementID, @"invalidated" : [NSNumber numberWithBool:TRUE]};
    [self.channel invokeMethod:@"loaded" arguments:dictionary];
  }
}
- (void)interstitialAdWillLogImpression:(FBInterstitialAd *)interstitialAd
{
  NSLog(@"The user sees the add");
  NSDictionary *dictionary = @{@"placement_id" : interstitialAd.placementID, @"invalidated" : [NSNumber numberWithBool:TRUE]};
  [self.channel invokeMethod:@"logging_impression" arguments:dictionary];
  //channel.invokeMethod(FacebookConstants.LOGGING_IMPRESSION_METHOD, args);
}

- (void)interstitialAdDidClick:(FBInterstitialAd *)interstitialAd
{
  NSLog(@"The user clicked on the ad and will be taken to its destination");
  // Use this function as indication for a user's click on the ad.
  //channel.invokeMethod(FacebookConstants.CLICKED_METHOD, args);
  NSDictionary *dictionary = @{@"placement_id" : interstitialAd.placementID, @"invalidated" : [NSNumber numberWithBool:TRUE]};
  [self.channel invokeMethod:@"clicked" arguments:dictionary];
}

- (void)interstitialAdWillClose:(FBInterstitialAd *)interstitialAd
{
  NSLog(@"The user clicked on the close button, the ad is just about to close");
  // Consider to add code here to resume your app's flow
   NSDictionary *dictionary = @{@"placement_id" : interstitialAd.placementID, @"invalidated" : [NSNumber numberWithBool:TRUE]};
   [self.channel invokeMethod:@"dismissed" arguments:dictionary];
   //channel.invokeMethod(FacebookConstants.DISMISSED_METHOD, args);
}

- (void)interstitialAdDidClose:(FBInterstitialAd *)interstitialAd
{
  NSLog(@"Interstitial had been closed");
  // Consider to add code here to resume your app's flow
    NSDictionary *dictionary = @{@"placement_id" : interstitialAd.placementID, @"invalidated" : [NSNumber numberWithBool:TRUE]};
   [self.channel invokeMethod:@"dismissed" arguments:dictionary];

}
- (void)interstitialAd:(FBInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
  NSLog(@"Ad failed to load");
}
@end
