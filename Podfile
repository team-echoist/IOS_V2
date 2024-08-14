# Uncomment the next line to define a global platform for your project
post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
            end
        end
    end
end
platform :ios, '14.0'

target 'LinkedOut' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  #Architecture
  pod 'ReactorKit'
  
  #Image
  pod 'Kingfisher'

  #Etc
  pod 'Gifu'
  pod 'Then'
  pod 'Localize-Swift'
  pod 'DeviceKit'
  pod "Device"
  
  #Logging
  pod 'CocoaLumberjack/Swift'
  
  #Networking
  pod 'Alamofire'
  pod 'Moya'
  pod 'Moya/RxSwift'
  pod 'MoyaSugar',
  :git => 'https://github.com/devxoul/MoyaSugar.git',
  :branch => 'master'
  pod 'MoyaSugar/RxSwift',
  :git => 'https://github.com/devxoul/MoyaSugar.git',
  :branch => 'master'

  #Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxOptional'
  pod 'RxDataSources'
  pod 'RxViewController'
  pod 'RxKeyboard'
  pod 'RxGesture'
  
  #UI
  pod 'SnapKit'
  pod 'ManualLayout'
  
  #Persistence
  pod 'SwiftyUserDefaults'
  pod 'SwiftKeychainWrapper'

end
