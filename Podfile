inhibit_all_warnings!
use_frameworks!

#platform :ios, '13.0'

target 'WW-Exercise-01' do
  pod 'SwiftLint'
  pod 'SDWebImage'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
