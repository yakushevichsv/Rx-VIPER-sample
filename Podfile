# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

# Hack to fix testability until cocoapods gets an update
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name == 'Debug'
                config.build_settings['ENABLE_TESTABILITY'] = 'YES'
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
end

def libraries
    pod 'RxCocoa',    '~> 3.0.0'

    pod 'Moya-ModelMapper/RxSwift', '~> 4.0.0-beta.3'
    pod 'RxOptional', '~> 3.1.2'
    pod 'RxDataSources', '~> 1.0'
    pod 'Moya'
    pod 'Moya/RxSwift'
    pod 'RxAlamofire'
    pod 'RxSwift'
    
end

target 'Herbs' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for Herbs
  libraries

  target 'HerbsTests' do
    inherit! :search_paths
    # Pods for testing
    libraries
  end

  target 'HerbsUITests' do
    inherit! :search_paths
    # Pods for testing
    libraries
  end

end

