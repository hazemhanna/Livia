# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Livia' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Livia
  
  use_frameworks!
  pod 'SideMenu', '~> 5.0.3'
  pod 'SwiftMessages'
  pod 'DLRadioButton', '~> 1.4.12'
  pod 'Parchment'
  pod 'Alamofire', '~> 4.8.2'
  pod 'SwiftyJSON', '~> 5.0.0'
  pod 'Kingfisher', '~> 5.4.0'
  pod 'IQKeyboardManagerSwift', '~> 6.3.0'
  pod 'SVProgressHUD'
  pod 'DropDown', '~> 2.3.13'
  pod 'Cosmos', '~> 19.0'
  pod 'ImageSlideshow/Kingfisher' , '~> 1.9.0'
  pod 'Firebase'
  pod 'Firebase/Analytics'
  pod 'FirebaseMessaging', '3.4.0'
  pod 'FirebaseInstanceID', '3.8.0'
  pod 'MOLH'
  pod 'FSCalendar'

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
    # some older pods don't support some architectures, anything over iOS 11 resolves that
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
