Pod::Spec.new do |s|

  s.name         = "IamLoader"
  s.version      = "1.0"
  s.summary      = "A Swift lightweight library for loading images and handle network request"
  s.description  = <<-DESC
                   IamLoader using native UIImage and handle cache for images and using native urlsession and decodeable protocol under the hood to fetch JSON data
                   DESC

  s.homepage     = "https://github.com/hjwlpjr/IamLoader"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "hjwlpjr" => "huang.zinwei@gmail.com" }

  s.source       = { :git => "https://github.com/hjwlpjr/IamLoader.git", :tag => s.version }

  s.source_files = "IamLoader/**/*.swift"
  s.requires_arc = true
  s.ios.deployment_target = '10.0'
end