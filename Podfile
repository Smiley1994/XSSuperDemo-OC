# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
inhibit_all_warnings!

post_install do |installer|
  # 消除版本警告
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 11.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
  end
end

target 'XSSuperDemo-OC' do 
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  use_frameworks!
  pod 'YYKit', :inhibit_warnings => true
  pod 'MJRefresh'
  pod 'Masonry'	
  pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '7.3.0'
  pod 'FMDB'
  pod 'ReactiveCocoa', '=2.3'
  pod 'CocoaLumberjack', '=3.6.2' # 日志框架
  pod "BeeHive"
  
  #
  pod 'XSIntent', :path => 'Module/XSIntent/'
  pod 'HFCategoryView', :path => 'Module/HFCategoryView/'
  
  # 自动检测内存泄漏
#  pod 'MLeaksFinder', :configurations => ['Debug']
  
  # Pods for XSSuperDemo-OC

end

