module Contestify
  class Util
    def system?(command)
      `which #{command.to_s}`
      $?.success?
    end

    def wget?
      system?(:wget)
    end
  end
end