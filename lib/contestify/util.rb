module Contestify
  module Util
    def system?(command)
      `which #{command.to_s}`
      raise Exception.new(red "`#{command}` is not installed. Please install it first") unless $?.success?
    end
  end
end