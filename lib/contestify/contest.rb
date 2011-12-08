module Contestify
  class Contest < Thor
    include Contestify::Util

    desc "coci PROBLEMS_URL JUDGE_UPLOAD_URL JUDGE_PASSWORD", "Setups a contest based on a COCI problemset"
    def coci(problems_url, judge_url, judge_password)
      contest = Contestify::Judge::Coci.new problems_url
      Contestify::Uploader.upload!(judge_url, judge_password, contest.problems_paths)
      clean_dir! contest.working_root_path
    end

    desc "check", "Checks that the user has the required OS software installed"
    def check
      check_dependencies
      puts green "Everything looks ok. You may now use Contestify."
    end
  end
end