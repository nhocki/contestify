module Contestify
  class Configuration

    def self.configure!(base_folder)
      puts green "=> Configuring problems"
      problem_index = 0
      Dir.glob("*").select { |f| File.directory?(f) }.each do |dir|
        Dir.chdir File.join(base_folder, dir)
        dirid = Dir.pwd.split('/').last[0...8]
        puts green "==> #{dirid.upcase}"
        rename_data_files
        add_problem_config(dirid, problem_index)
        problem_index += 1
        puts green "==> All the work for #{dirid.upcase} is done"
      end
    end

    def self.rename_data_files
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

    def self.add_problem_config(probid, problem_index)
      puts blue "===> Adding DOM Judge configuration #{probid}"
      file_content = <<-TEXT
      probid = #{probid}
      name = #{probid}
      allow_submit = true
      color = #{Contestify::PROBLEM_COLORS[problem_index]}
      timelimit = 1
      TEXT
      File.open(File.join(Dir.pwd, "domjudge-problem.ini"), 'w') {|f| f.write(file_content) }
    end
  end
end