
Pod::Spec.new do |spec|

spec.name         = "MitchHolmesSynchronousPosterGetter"
spec.version      = "0.2.0"
spec.summary      = "The creation of MitchHolmesSynchronousPosterGetter for Assignment 2."
spec.description  = "Learning how to create a new pod and use that within another project."
spec.homepage     = "https://github.com/hlmmit001/MitchHolmesSynchronousPosterGetter"
spec.license      = { :type => "MIT", :file => "LICENSE" }
spec.author             = { "Mitch Holmes" => "hlmmit001@myuct.ac.za" }
spec.platform     = :ios, "10.0"
spec.swift_version = "4.2"
spec.source       = { :git => "https://github.com/hlmmit001/MitchHolmesSynchronousPosterGetter.git", :tag => "0.2.0" }
spec.source_files  = "MitchHolmesSynchronousPosterGetter/**/*.{h,m,swift,mm}"
spec.resources = "MitchHolmesSynchronousPosterGetter/Resources/*.{strings}"
spec.dependency "SBJson", "~> 5.0.0"
spec.dependency "AFNetworking", "~> 2.7.0"
spec.dependency "SwiftLint","~> 0.30.1"
spec.dependency "Result","~> 4.1.0"

end
