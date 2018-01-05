platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

def testing_pods
    pod 'KeychainAccess', ' ~> 3.1.0'
    pod 'ReactiveCocoa', '7.0.0-alpha.1'
    pod 'ReactiveSwift'
    pod 'Result'
end

target 'Elisa' do
    testing_pods
    pod 'ViewAnimator'
    pod 'ReachabilitySwift'
    pod 'Firebase'
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
    pod 'FBSDKCoreKit'
    pod 'FBSDKLoginKit'
    pod 'Cheers'
    pod 'Fabric'
    pod 'Crashlytics'
    target 'ElisaTests' do
        inherit! :search_paths
        testing_pods
    end

    target 'ElisaUITests' do
        inherit! :search_paths
        testing_pods
    end
end




post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.2'
    end
  end
end