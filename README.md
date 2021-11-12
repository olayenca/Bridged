# Bridged - IOS

## Initialise project
- Prerequisite Xcode Version 11.3.1

`npx react-native init [Project Name] --version 0.62.`

* Move duplicate Dir components one level up, make sure scripts paths are correct (optional)
* Delete /android

* `npm start` make sure :8081 isn't already in use then
* Run instructions for iOS:
    • Open Bridged/ios/Bridged.xcworkspace in Xcode or run "xed -b ios"
    • Hit the Run button
    
### Xcode: 
- Click on the project - very important! 
- Create a new file: File > new > file > swift file > ok 
- Name the file SplashScreenViewController, click ok 
- it should prompt _"Would you like to configure an Objective-C bridging header?"_ click create bridge header
    - a new [Project Name]-Bridging-Header.h should also be created
- Open ios/AppDelegate.m, and add `#import <[Project Name]-Swift.h>` this is the converted to swift to header file

- Extend the `@implemetation` in ios/AppDelegate.m
    - this allows us to pass the apps root view to swift for further styling
    ```
    {
    ...
        [self.window makeKeyAndVisible];
  
        SplashScreenViewController *launchController = [[SplashScreenViewController alloc] init];
        
        [launchController view];
        
        launchController.viewController = rootViewController;
        [launchController loadVideo];
        
        return YES;
    }
  ```

- Update with SplashScreenViewController created earlier with ios/SplashScreenViewController.swift in this repo

- Also create another swift file give it a name _(Navigator)_ and update with ios/Navigator.swift
    - this is the code handling the navigation between swift and RN

- In [Project Name]-Bridging-Header.h add the modules needed by swift, in this case: 
    ```
  #import <React/RCTBridge.h>
  #import <React/RCTEventDispatcher.h>
  #import <React/RCTRootView.h>
  #import <React/RCTBundleURLProvider.h>
  ```
  
- Create another swift file called Extensions.swift, this is to add additional methods to existing swift classed to be reused with the view contorller 
    - update with ios/Extensions.swift
    
- Make a copy of the video or add you own video but rename the file to splashscreen.mov
    - go to xcode and click File > Add files to [Project Name] and find splashscreen.mov
- Create a new file Obj C .m [Project Name]-swift.m
    - this will emit the methods to RN
 
### React Native 
* Import `NativeModules` from `react-native`
* Destructure `{goBack}` from the emitted modules in Navigator.swift
* Import and add a button and place somewhere on the UI with onPress method `goBack`

### Useful Links
* [xcode Downloads](https://developer.apple.com/download/all/)
* [CocoaPods](https://guides.cocoapods.org/using/getting-started.html)
