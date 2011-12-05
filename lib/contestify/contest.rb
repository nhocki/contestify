module Contestify
  class Contest
    include Contestify::Util

    attr_accessor :problems_url, :judge_url, :judge_password, :problem_index

    def initialize(problems_url, judge_url, judge_password)
      @problems_url, @judge_url, @judge_password = problems_url, judge_url, judge_password
      @problem_index = 0

      if [@problems_url, @judge_url, @judge_password].any? {|attribute| attribute.nil? or attribute.empty?}
        raise Exception.new(Contestify::HELP_MESSAGE)
      end
    end

    def setup!
      check_dependencies
      get_problems
      unzip_problems
      configure_problems
    end

    private ######################################################################## PRIVATE

    def check_dependencies
      system?(:curl)      and
      system?(:unzip)     and
      system?(:dos2unix)
    end

    def get_problems
      FileUtils.mkdir_p File.join(Dir.pwd, "contestify")
      Dir.chdir File.join(Dir.pwd, "contestify")
      puts green "Fetching problems from #{@problems_url}"
      curl_output = `curl #{@problems_url} > #{File.join(Dir.pwd, "problems.zip")}`
      raise Exception.new(red Contestify::CURL_PROBLEM) unless $?.success?
    end

    def unzip_problems
      puts green "Unzipping problems"
      unzip_output = `unzip #{File.join(Dir.pwd, "problems.zip")}`
      raise Exception.new(red Contestify::UNZIP_PROBLEM) unless $?.success?
    end

    def configure_problems
      Dir.glob("*").select { |f| File.directory?(f) }.each do |dir|
        puts dir
        Dir.chdir File.join(base, dir)
        dirid = Dir.pwd.split('/').last[0...8]
      end
    end
  end
end