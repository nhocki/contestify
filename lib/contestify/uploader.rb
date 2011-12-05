module Contestify
  class Uploader
    def self.upload!(server_url, admin_pwd, base_dir)
      puts green "\n\n=> Uploading problems to the server"

      Dir.chdir base_dir # Ensure you're on the `root` dir
      Dir.glob("*").select { |f| File.directory?(f) }.each do |dir|
        Dir.chdir File.join(base_dir, dir)

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