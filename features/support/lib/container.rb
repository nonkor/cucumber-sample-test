# module for wrapping group of elements into container namespace
# TODO: refactor result from array to specific Container class with additional methods
# TODO: add :reload method (repeat to search elements in container if page is changed)
module Container
  def self.included(base)
    base.extend(ClassMethods)
  end

  # class methods
  module ClassMethods
    def container_for(elements)
      container = elements.to_s.sub(/_[^_]+$/, '')
      define_method :"#{container}" do
        return instance_variable_get("@#{container}") if instance_variable_get("@#{container}")
        instance_variable_set("@#{container}", send(elements).map { |i| yield(i) })
      end
    end
  end
end
