module Myapp::Encacher
  def cache! attribute, &block
    define_method attribute do
      unless instance_variable_defined? "@#{attribute}".intern
        instance_variable_set "@#{attribute}".intern, instance_eval(&block)
      end
      instance_variable_get "@#{attribute}".intern
    end
  end
end
