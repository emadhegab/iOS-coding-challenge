 platform :ios, '10.0'


def shared_pods
   pod 'MHNetwork'
end

target 'GALWeather' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GALWeather
  shared_pods

end

target 'GALWeatherTests' do
    inherit! :search_paths
    # Pods for testing
   shared_pods
end

target 'GALWeatherWatchOS Extension' do
    platform :watchos, '2.0'
    shared_pods
end
