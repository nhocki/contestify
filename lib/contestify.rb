require 'fileutils'
require 'thor'
require "contestify/version"
require "contestify/messages"
require "contestify/colorize"
require "contestify/util"
require "contestify/contest"
require "contestify/uploader"
require "contestify/judges"

include Contestify::Colorize
