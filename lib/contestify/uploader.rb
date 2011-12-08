module Contestify
  # <tt>Contestify::Uploader</tt> is a simple class that will habdle the
  # uploading part to the server.
  class Uploader
    # <tt>Contestify::Uploader.upload!</tt> is *the only* method you should call
    # to upload the problems to the server. It will receive 3 params.
    #
    # ==== Parameters
    # server_url<String>:: The **upload** URL in the server. E.g http://your-dom-judge.com/jury/problem.php
    #
    # admin_pwd<String>:: This is the `admin` password needed to authenticate in the server
    #
    # problems_path<Array>:: An array having all the paths where the problems input/output are.
    #                        This *should* be the return array from a <tt>Contestify::Configuration</tt> call.
    #                        The paths here **must** be absolute paths.
    #
    def self.upload!(server_url, admin_pwd, problems_path)
      puts green "\n\n=> Uploading problems to the server"
      
      for dir in problems_path do
        Dir.chdir dir

        unless File.exists?("domjudge-problem.ini")
          puts cyan "domjudge-problem.ini not found. Skipping #{dir}."
          next
        end

        puts blue "==> Building #{dir}"
        FileUtils.rm_f "bundle.zip"
        zip_output = system("zip bundle.zip *")
        raise Exception.new(red Contestify::ZIP_PROBLEM) unless $?.success?

        puts blue "===> Uploading #{dir}/bundle.zip..."
        curl_output = system("curl -vv -F upload=Upload -F problem_archive=@bundle.zip --user admin:#{admin_pwd} #{server_url}")
        puts blue "===> Upload done\n"
      end

      puts green "\n\n=> All problems have been uploaded"
    end
  end
end