# fultter facebook audience network for IOS Android
Flutter facebook audience Network IOS Android Advertisement integration


|<img src="https://github.com/yogeshbangar/facebook_audience_IOS_Android/blob/master/ScreanShot/banner.jpg" height="20%" width="20%"><img src="https://github.com/yogeshbangar/facebook_audience_IOS_Android/blob/master/ScreanShot/intertitial.jpg" height="20%" width="20%"><img src="https://github.com/yogeshbangar/facebook_audience_IOS_Android/blob/master/ScreanShot/nativesads.jpg" height="20%" width="20%"><img src="https://github.com/yogeshbangar/facebook_audience_IOS_Android/blob/master/ScreanShot/nativeBannerAd.jpg" height="20%" width="20%">


## Getting Started

### 1. Initialization for IOS
  Add: facebook_audience_IOS_Android/ios/facebook_audience_network.podspec
       s.dependency 'FBAudienceNetwork'
  Add: facebook_audience_network-master/example/ios/Runner/Info.plist
      <key>io.flutter.embedded_views_preview</key>
      <true/>

  goto terminal ..../facebook_audience_network-master/example/ios/
      pod install


### 1. Initialization for Android:

For testing purposes you need to obtain the hashed ID of your testing device. To obtain the hashed ID:

1. Call `FacebookAudienceNetwork.init()` during app initialization.
2. Place the `FacebookBannerAd` widget in your app.
3. Run the app.

The hased id will be in printed to the logcat. Paste that onto the `testingId` parameter.

```dart
FacebookAudienceNetwork.init(
  testingId: "YOUR_PLACEMENT_ID",
);
```
### 2. Show Banner Ad:

```dart
Container(
  alignment: Alignment(0.5, 1),
  child: FacebookBannerAd(
    placementId: "YOUR_PLACEMENT_ID",
    bannerSize: BannerSize.STANDARD,
    listener: (result, value) {
      switch (result) {
        case BannerAdResult.ERROR:
          print("Error: $value");
          break;
        case BannerAdResult.LOADED:
          print("Loaded: $value");
          break;
        case BannerAdResult.CLICKED:
          print("Clicked: $value");
          break;
        case BannerAdResult.LOGGING_IMPRESSION:
          print("Logging Impression: $value");
          break;
      }
    },
  ),
)
```

### 3. Show Interstitial Ad:

```dart
FacebookInterstitialAd.loadInterstitialAd(
  placementId: "YOUR_PLACEMENT_ID",
  listener: (result, value) {
    if (result == InterstitialAdResult.LOADED)
      FacebookInterstitialAd.showInterstitialAd(delay: 5000);
  },
);
```
### 4. Show Rewarded Video Ad:

```dart
FacebookRewardedVideoAd.loadRewardedVideoAd(
  placementId: "YOUR_PLACEMENT_ID",
  listener: (result, value) {
    if(result == RewardedVideoResult.LOADED)
      FacebookRewardedVideoAd.showRewardedVideoAd();
    if(result == RewardedVideoResult.VIDEO_COMPLETE)
      print("Video completed");
  },
);
```

### 5. Show In-Stream Video Ad:
Make sure the width and height is 300 at minimum.

```dart
FacebookInStreamVideoAd(
  placementId: "YOUR_PLACEMENT_ID",
  height: 300,
  listener: (result, value) {
    if (result == InStreamVideoAdResult.VIDEO_COMPLETE) {
      setState(() {
        _videoComplete = true;
      });
    }
  },
)
```

### 6. Show Native Ad:

```dart
FacebookNativeAd(
  placementId: "YOUR_PLACEMENT_ID",
  adType: NativeAdType.NATIVE_AD,
  width: double.infinity,
  height: 300,
  backgroundColor: Colors.blue,
  titleColor: Colors.white,
  descriptionColor: Colors.white,
  buttonColor: Colors.deepPurple,
  buttonTitleColor: Colors.white,
  buttonBorderColor: Colors.white,
  listener: (result, value) {
    print("Native Ad: $result --> $value");
  },
),
```

### 7. Show Native Banner Ad:
Use `NativeBannerAdSize` to choose the height for Native banner ads. `height` property is ignored for native banner ads.

```dart
FacebookNativeAd(
  placementId: "YOUR_PLACEMENT_ID",
  adType: NativeAdType.NATIVE_BANNER_AD,
  bannerAdSize: NativeBannerAdSize.HEIGHT_100,
  width: double.infinity,
  backgroundColor: Colors.blue,
  titleColor: Colors.white,
  descriptionColor: Colors.white,
  buttonColor: Colors.deepPurple,
  buttonTitleColor: Colors.white,
  buttonBorderColor: Colors.white,
  listener: (result, value) {
    print("Native Ad: $result --> $value");
  },
),
```
