##
# Copied directly from ActiveSupport
# <https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/array/wrap.rb>
#
class Array
  def self.wrap(object)
    if object.nil?
      []
    elsif object.respond_to?(:to_ary)
      object.to_ary || [object]
    else
      [object]
    end
  end
end
