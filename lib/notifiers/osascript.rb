# frozen_string_literal: true

module Notifiers
  class Osascript < Notifiers::Base
    def self.installed?
      platform?(/darwin/) and command?('osascript')
    end

    def subtitle(text)
      @subtitle = text
      self
    end

    def sound(name)
      @sound = name
      self
    end

    def to_s
      script = 'display notification'.dup
      script << " \"#{@message}\"" if @message
      script << " with title \"#{@title}\"" if @title
      script << " subtitle \"#{@subtitle}\"" if @subtitle
      script << " sound name \"#{@sound}\"" if @sound

      "osascript -e '#{script}'"
    end

    def install_instructions
      ''
    end
  end
end
