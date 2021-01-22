Pod::Spec.new do |s|
  s.name             = "VuzixConnectivity"
  s.version          = "1.1"
  s.summary          = "Share BLE connection to your Vuzix Smart Glasses.  Bi-directional communication via BLE with your iPhone app and Vuzix smart glasses app."
  s.homepage         = "https://github.com/Vuzix/VuzixConnectivity"
  s.license          = { :type => 'Vuzix Corporation', :file => 'LICENSE' }
  s.author           = { "Vuzix" => "developer@vuzix.com" }
  s.source           = { :http => "https://github.com/Vuzix/VuzixConnectivity/raw/master/#{s.version.to_s}/VuzixConnectivity.zip"}
  
  s.vendored_frameworks = "VuzixConnectivity.framework"

  s.platform     = :ios, "11.0"
  s.requires_arc = true

  s.frameworks = "UIKit"

  s.swift_version = '4.2'
  s.ios.deployment_target  = '11.0'
end
