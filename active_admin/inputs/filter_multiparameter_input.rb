module ActiveAdmin
  module Inputs
    class FilterMultiparameterInput < ::Formtastic::Inputs::TextInput
      include ::ActiveAdmin::Inputs::FilterBase

      def to_html
        input_wrapping do
          label_html + input_html
        end
      end

      def input_html
        raise ArgumentError, "No multiparameter fields specified" if options[:fields].blank?
        html = ''
        options[:fields].each_with_index do |field_config, i|
          field_type = field_config.delete(:field_type) || :text_field
          type_cast = field_config.delete(:type_cast) || ''
          html << builder.send(field_type, field_name(i + 1, type_cast), field_config)
        end
        html.html_safe
      end

      def field_name(index, type_cast)
        "#{method}(#{index}#{type_cast})"
      end

    end
  end
end

