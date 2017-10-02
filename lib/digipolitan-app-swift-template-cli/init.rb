require 'open-uri'
require 'digipolitan-apps-tools'
require 'zip'

module Digipolitan

  class AppSwiftTemplate

    def self.init(target_path = nil)

      zip_path = ".template.zip"
      unzip_destination_path = ".template"

      Digipolitan::UI.success "*** DIGIPOLITAN TEMPLATE APP WIZARD ***";

      absolute_target_path = Dir.pwd
      if target_path != nil && target_path != "."
        absolute_target_path = File.join(absolute_target_path, target_path)
      end
      if Digipolitan::UI.confirm "Are you sure to install the Digipolitan template in the directory '#{absolute_target_path}'"
        Digipolitan::UI.message "Preparing...";
        Digipolitan::FileUtils.mkdir_p(absolute_target_path)
        pattern = File.join(absolute_target_path, "*.xcodeproj")
        projects = Dir[pattern]
        if projects.length > 0
          Digipolitan::UI.crash "The target directory contains an xcodeproj, please select another one or clear the directory."
        end

        Digipolitan::UI.message "Downloading Digipolitan app...";
        buffer = open('https://github.com/Digipolitan/app-swift-template/archive/master.zip').read
        Digipolitan::FileUtils.write_to_file(zip_path, buffer)
        Digipolitan::UI.message "Unziping Digipolitan app...";

        template_path = nil
        Digipolitan::FileUtils.remove_dir(unzip_destination_path)
        Zip::InputStream.open(zip_path) { |zip_file|
          while (entry = zip_file.get_next_entry)
            f_path = File.join(unzip_destination_path, entry.name)
            if template_path == nil
              template_path = f_path
            end
            if entry.name_is_directory?
              Digipolitan::FileUtils.mkdir_p(f_path)
            else
              Digipolitan::FileUtils.mkdir_p(File.dirname(f_path))
              entry.extract(f_path)
            end
          end
        }
        Digipolitan::UI.message "Moving..."

        entries = Dir.entries(template_path)
        entries.each do |entry|
          if entry != "." && entry != ".."
            File.rename(File.join(template_path, entry), File.join(absolute_target_path, entry))
          end
        end

        Digipolitan::FileUtils.remove_dir(zip_path)
        Digipolitan::FileUtils.remove_dir(unzip_destination_path)

        Digipolitan::UI.success "Successfully download Digipolitan app template"

        if Digipolitan::UI.confirm "Would you like to install the template ?"
          gemfile = File.join(absolute_target_path, "Gemfile")
          Dir.chdir(absolute_target_path) {
            system("bundle install --gemfile '#{gemfile}'")
            system("BUNDLE_GEMFILE='#{gemfile}' bundle exec ruby install.rb")
          }
          end
        end
      end
  end
end
