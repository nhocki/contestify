module Contestify
  HELP_MESSAGE = <<-TEXT
  You need to specify the three arguments. Here's an example:

    contestify coci_problems_url judge_upload_url judge_password
  TEXT

  CURL_PROBLEM = <<-TEXT
  We could not get the problems from that URL. Maybe you mispelled it? Please try again.
  TEXT

  UNZIP_MISSING = <<-TEXT
  Please install `unzip` first or add it to your PATH if needed.
  TEXT

  UNZIP_PROBLEM = <<-TEXT
  We couldn't unzip your files. Please verify that the download was succesful.
  TEXT

end