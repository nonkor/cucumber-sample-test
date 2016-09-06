module Container

  #TODO: refactor result from array to specific Container class with additional methods
  #TODO: add :reload method (repeat to search elements in container if page is changed)

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def container_for(elements)
      container = elements.to_s.sub(/_[^_]+$/, '')
      define_method :"#{container}" do
        return instance_variable_get("@#{container}") if instance_variable_get("@#{container}")
        instance_variable_set("@#{container}",
          send(elements).map do |i|
            yield(i)
          end
        )
      end
    end

  end

end
