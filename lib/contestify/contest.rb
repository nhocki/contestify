module Contestify
  class Contest
    attr_accessor :problems_url, :judge_url, :judge_password

    def initialize(problems_url, judge_url, judge_password)
      @problems_url, @judge_url, @judge_password = problems_url, judge_url, judge_password

      if [@problems_url, @judge_url, @judge_password].any? {|attribute| attribute.nil? or attribute.empty?}
        raise Exception.new(Contestify::HELP_MESSAGE)
      end
    end

    def get_problems
      puts green "Fetching problems from #{@problems_url}"
      curl_output = `curl #{@problems_url} > #{File.join(Dir.pwd, "problems.zip")}`
      raise Exception.new(red Contestify::CURL_PROBLEM) unless $?.success?
    end

    def unzip_problems
      puts green "Unzipping problems"
      unzip_output = `unzip #{File.join(Dir.pwd, "problems.zip")}`
      raise Exception.new(red Contestify::UNZIP_PROBLEM) unless $?.success?
    end
  end
end