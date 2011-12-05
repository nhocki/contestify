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
      puts green "=> Fetching problems from #{@problems_url}"
      curl_output = `curl #{@problems_url} > #{File.join(Dir.pwd, "problems.zip")}`
      raise Exception.new(red Contestify::CURL_PROBLEM) unless $?.success?
    end

    def unzip_problems
      puts green "=> Unzipping problems"
      unzip_output = `unzip #{File.join(Dir.pwd, "problems.zip")}`
      raise Exception.new(red Contestify::UNZIP_PROBLEM) unless $?.success?
    end

    def configure_problems
      base_folder = Dir.pwd
      puts green "=> Configuring problems"
      Dir.glob("*").select { |f| File.directory?(f) }.each do |dir|
        Dir.chdir File.join(base_folder, dir)
        dirid = Dir.pwd.split('/').last[0...8]
        puts green "==> #{dirid.upcase}"
        rename_data_files
        add_problem_config(dirid)
        puts green "==> All the work for #{dirid.upcase} is done"
      end
    end

    def rename_data_files
      puts blue "===> Renaming input/output files"
      Dir.glob("*").select { |f| f =~ /\.in.[0-9]+/ }.each do |f|
        # puts red "    Renaming #{f}..."
        parts     = f.split(".")
        new_name  = [parts[0], parts[2], parts[1]].join(".")
        # puts blue "    " + new_name
        File.rename f, new_name

        f.gsub!(".in", ".out")
        # puts red "    Renaming #{f}..."
        parts = f.split(".")
        new_name = [parts[0], parts[2], parts[1]].join(".")
        # puts blue "    " + new_name
        File.rename f, new_name
      end
    end

    def add_problem_config(probid)
      puts blue "===> Adding DOM Judge configuration"
      file_content = <<-TEXT
      probid = #{probid}
      name = #{probid}
      allow_submit = true
      color = #{Contestify::PROBLEM_COLORS[@problem_index]}
      timelimit = 1
      TEXT
      @problem_index += 1
      File.open(File.join(Dir.pwd, "domjudge-problem.ini"), 'w') {|f| f.write(file_content) }
    end
  end
end