module Contestify
  class Contest
    include Contestify::Util

    attr_accessor :problems_url, :judge_url, :judge_password, :base_dir

    def initialize(problems_url, judge_url, judge_password)
      @problems_url, @judge_url, @judge_password = problems_url, judge_url, judge_password

      if [@problems_url, @judge_url, @judge_password].any? {|attribute| attribute.nil? or attribute.empty?}
        raise Exception.new(Contestify::HELP_MESSAGE)
      end
    end

    def setup!
      check_dependencies
      get_problems
      unzip_problems
      @base_dir = Dir.pwd
      problems_path = Contestify::Configuration.configure!(@base_dir)
      Contestify::Uploader.upload!(@judge_url, @judge_password, problems_path)
      clean_dir!
    end

    private ######################################################################## PRIVATE

    def clean_dir!
      puts red "Deleting created files & folders (#{@base_dir})"
      FileUtils.rm_rf @base_dir
    end

    def check_dependencies
      system?(:zip)       and
      system?(:curl)      and
      system?(:unzip)     and
      system?(:dos2unix)
    end

    def get_problems
      FileUtils.mkdir_p File.join(Dir.pwd, "contestify")
      Dir.chdir File.join(Dir.pwd, "contestify")
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