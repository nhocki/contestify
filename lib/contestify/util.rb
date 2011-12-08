module Contestify
  module Util
    def system?(command)
      `which #{command.to_s}`
      raise Exception.new(red "`#{command}` is not installed. Please install it first") unless $?.success?
    end

    def clean_dir!(directory)
      puts red "Deleting created files & folders (#{directory})"
      # FileUtils.rm_rf directory
    end

    def check_dependencies
      system?(:zip)       and
      system?(:curl)      and
      system?(:unzip)     and
      system?(:dos2unix)
    end
  end
end