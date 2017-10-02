Gem::Specification.new do |s|
  s.name                  = 'digipolitan-app-swift-template-cli'
  s.version               = '0.1.0'
  s.date                  = '2017-10-02'
  s.summary               = 'Digipolitan Ruby tools to use swift app template'
  s.homepage              = 'https://github.com/Digipolitan/app-swift-template-cli'
  s.email                 = 'contact@digipolitan.com'
  s.authors               = ['bbriatte', 'LinharesDavid']
  s.license               = 'BSD-3-Clause'
  s.files                 = %w( README.md LICENSE CHANGELOG.md )
  s.files                 += Dir.glob("lib/**/*.rb")
  s.executables           = %w{ dg-ast }
  s.required_ruby_version = '>= 1.9.3'
  s.description           = <<desc
This module help you to install / use swift app template
desc
s.add_runtime_dependency 'digipolitan-apps-tools', '~> 0.2'
s.add_runtime_dependency 'rubyzip', '~> 1.2'
end
