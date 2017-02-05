# frozen_string_literal: true

module Kernel
  # 即所有的class_eval方法只对metaclass有效
  # class_eval on an object acts like singleton_class.class_eval.
  def class_eval(*args, &block)
    singleton_class.class_eval(*args, &block)
  end
end
