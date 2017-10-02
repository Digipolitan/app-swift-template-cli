require 'digipolitan-apps-tools'

module Digipolitan

  class AppSwiftTemplate

    def self.help()
      Digipolitan::UI.message "Digipolitan App Swift Template CLI"
      Digipolitan::UI.message "Available options :"
      Digipolitan::UI.message "--init : Download and install the template"
      Digipolitan::UI.message "--help : Print this help"
    end
  end
end
