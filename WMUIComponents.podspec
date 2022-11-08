Pod::Spec.new do |s|
  s.name             = 'WMUIComponents'
  s.version          = '1.1.1'
  s.summary          = 'Common UI Components'

  s.description      = <<-DESC
This can be reused for apps to make it reusable.
                       DESC

  s.homepage         = 'https://github.com/malekwasim/WMUIComponents'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wasim' => 'Wasim.malek.009@gmail.com' }
  s.source           = { :git => 'https://github.com/malekwasim/WMUIComponents.git', :tag => s.version.to_s }
  s.swift_version = '5.0'
  s.ios.deployment_target = '12.0'
  s.source_files = 'WMUIComponents/Source/**/*'
  s.resource_bundles = {
    'WMUIComponents' => ['WMUIComponents/Resources/**']
  }

end
