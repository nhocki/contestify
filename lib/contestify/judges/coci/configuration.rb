module Contestify
  module Coci
    # <tt>Coci::Configuration</tt> holds all the logic to configure a COCI based
    # contest. This class **must** implement the `self.configure!` method.
    class Configuration

      # <tt>Contestify::Configuration.configure!</tt> is *the only* method you
      # should call from the contest interface. All the other methods should be
      # called from here. This is the only method needed for future strategies
      # for other judges.
      #
      # This should be called in a directory structure such that you have a
      # `base_folder` with one folder for each problem you want to upload to the
      # server. Each of these problems folders should have all the input/output
      # files you want to use as test cases.
      #
      # This method **must** return the absolute paths of the problem folders in
      # an array. This return value will be used in Contestify::Uploader.upload!
      #
      # ==== Parameters
      # base_folder<String>:: The base folder where all the problems folders are
      #                       stored.
      #
      def self.configure!(base_folder)
        puts green "=> Configuring problems (#{base_folder})"
        problem_index = 0
        Dir.glob("*").select { |f| File.directory?(f) }.map do |dir|
          Dir.chdir File.join(base_folder, dir)
          dirid = Dir.pwd.split('/').last[0...8]
          puts green "==> #{dirid.upcase}"
          rename_data_files
          add_problem_config(dirid, problem_index)
          problem_index += 1
          puts green "==> All the work for #{dirid.upcase} is done"
          # Return the absolute path for this problem
          Dir.pwd
        end
      end

      #########################################################################
      private #################################################################

      # <tt>Coci::Configuration.rename_data_files</tt> is in charge of
      # giving each input/output file a standard name that DOMJudge understands.
      #
      # This method should be overriden in future strategies.
      #
      # After this method is called, every different input/output file **must**
      # have the following structure:
      #
      #   `problemid`.`number`.in
      #   `problemid`.`number`.out
      #
      # where:
      #
      # `problemid` is at most 8 letters long and it's the id for the judge and
      # `number` is the test case number. The .in and .out will determine the
      # input and compare file the judge will run/diff.
      def self.rename_data_files
        puts blue "===> Renaming input/output files"
        Dir.glob("*").select { |f| f =~ /\.in.[0-9]+/ }.each do |f|
          parts     = f.split(".")
          new_name  = [parts[0], parts[2], parts[1]].join(".")
          File.rename f, new_name

          f.gsub!(".in", ".out")
          parts = f.split(".")
          new_name = [parts[0], parts[2], parts[1]].join(".")
          File.rename f, new_name
        end
      end


      # <tt>Coci::Configuration.add_problem_config</tt> will add the
      # configuration file needed for DOMJudge to understand the problem.
      #
      # ==== Parameters
      # probid<String>:: The problem id for DOMJudge. This **must** be at most
      #                  8 letters long.
      #
      # problem_index<Integer>:: This is the problem number. This is only used 
      #                          to choose the problem ballon color.
      #
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
end