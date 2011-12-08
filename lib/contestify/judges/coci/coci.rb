require 'contestify/judges/coci/configuration'

module Contestify
  module Judge
    class Coci
      attr_accessor :problems_url, :working_root_path, :problems_paths

      def initialize(problems_url)
        @problems_url = problems_url
        get_problems
        unzip_problems
        @working_root_path = Dir.pwd
        @problems_paths = Contestify::Coci::Configuration.configure!(@working_root_path)
      end

      private ################################################ PRIVATE

      def get_problems
        working_path = File.join(Dir.pwd, "contestify")
        FileUtils.mkdir_p working_path
        Dir.chdir working_path
        puts green "=> Fetching problems from #{@problems_url}"
        curl_output = `curl #{@problems_url} > #{File.join(Dir.pwd, "problems.zip")}`
        raise Exception.new(red Contestify::CURL_PROBLEM) unless $?.success?
      end

      def unzip_problems
        puts green "=> Unzipping problems"
        unzip_output = `unzip #{File.join(Dir.pwd, "problems.zip")}`
        raise Exception.new(red Contestify::UNZIP_PROBLEM) unless $?.success?
      end

    end
  end
end