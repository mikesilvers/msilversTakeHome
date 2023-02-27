# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

target 'msilversTakeHome' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for msilversTakeHome
  pod 'Alamofire', '~> 5.6'

  target 'msilversTakeHomeTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Alamofire', '~> 5.6'
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
        end
    end
end
