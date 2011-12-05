module Contestify
  HELP_MESSAGE = <<-TEXT
  You need to specify the three arguments. Here's an example:
  
    contestify coci_problems_url judge_upload_url judge_password 
  TEXT

  MESSAGE_PROBLEM = <<-TEXT
    We could not get the problems from that URL. Maybe you mispelled it? Please try again.
  TEXT

end