# frozen_string_literal: true

require_relative "concern"
require_relative "core_ext/module/attribute_accessors"
require "concurrent"

module LoggerSilence
  # 提供silence方法用于在代码块中设置日志类型
  extend ActiveSupport::Concern

  included do
    cattr_accessor :silencer, default: true
  end

  # Silences the logger for the duration of the block.
  def silence(temporary_level = Logger::ERROR)
    if silencer
      begin
        old_local_level            = local_level
        self.local_level           = temporary_level

        yield self
      ensure
        self.local_level = old_local_level
      end
    else
      yield self
    end
  end
end
