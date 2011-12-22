require 'contestify/judges/local/configuration'

module Contestify
  module Judge
    class Local
      attr_accessor :problems_path, :working_root_path, :problems_paths

      def initialize(problems_path)
        @problems_path = problems_path
        @working_root_path = File.join(Dir.pwd, "contestify")
        FileUtils.mkdir_p @working_root_path
        copy_problems
        @problems_paths = Contestify::Local::Configuration.configure!(@working_root_path)
      end

      private ################################################ PRIVATE

      def copy_problems
        puts green "=> Copying problems from #{@problems_path}"
        if not File.directory?(@problems_path)
          raise Exception.new(red "#{@problems_path} is not a valid directory. Did you mistype something?")
        end
        Dir.chdir @problems_path
        FileUtils.cp_r Dir.glob("*"), @working_root_path
      end
      
    end
  end
end