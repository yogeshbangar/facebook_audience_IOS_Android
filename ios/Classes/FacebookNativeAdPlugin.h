#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>


@interface NativeView : NSObject <FlutterPlatformView ,FBNativeBannerAdDelegate , FBNativeAdDelegate>
- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id )args binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
- (UIView*)view;
@end

@interface FacebookNativeAdPlugin : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end
