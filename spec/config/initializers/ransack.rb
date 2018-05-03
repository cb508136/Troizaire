module Ransack
  module Helpers
    class FormBuilder

      Rint = ['eq', 'not_eq', 'lt', 'lteq', 'gt', 'gteq']
      Rint2 = ['in', 'not_in']
      Rbool = ['true', 'not_true', 'false', 'not_false']
      Rstring = ['cont', 'start', 'end']
      Rdate = ['eq', 'not_eq', 'lt', 'lteq', 'gt', 'gteq']

      def values_select(*args, &block)
        values_select_fields(:v, args, block)
      end

      def values_select_fields(name, args, block)
        args << {} unless args.last.is_a?(Hash)
        args.last[:builder] ||= options[:builder]
        args.last[:parent_builder] = self
        options = args.extract_options!
        objects = args.shift
        objects ||= @object.send(name)
        objects = [objects] unless Array === objects
        name = "#{options[:object_name] || object_name}[#{name}][]"
        collection = block.call(object)
        #template_collection_select(name, collection, {}, {:class=>"form-control", :multiple => true})
        #@template.select(name, collection, {}, {:class=>"form-control", :multiple => true})
        output = ""#ActiveSupport::SafeBuffer.new
        output += "<select name='#{name}' class='form-control custom-select2-multiple' multiple style='width:100%'>"
        collection.each do |c|
           selected = objects.map(&:value).map(&:to_i).include?(c.last) ? 'selected=true' : ''
           output += "<option value='#{c.last}' #{selected}>#{c.first}</option>"
        end
        output += "</select>"
        output.html_safe
      end

      def attribute_select(options = nil, html_options = nil, action = nil)
        options = options || {}
        html_options = html_options || {}
        action = action || Constants::SEARCH
        default = options.delete(:default)
        raise ArgumentError, formbuilder_error_message(
          "#{action}_select") unless object.respond_to?(:context)
        options[:include_blank] = true unless options.has_key?(:include_blank)
        bases = [''.freeze].freeze + association_array(options[:associations])
        if bases.size > 1
	  	if !object.blank? || !object.name.blank?
                        collection = attribute_collection_for_bases(action, bases.first).delete_if {|v| v.first != object.name}
                else
                        collection = collection_for_base(action, bases.first)
                end
          object.name ||= default if can_use_default?(
            default, :name, mapped_values(collection.flatten(2))
            )
          template_grouped_collection_select(collection, options, html_options)
        else
		if !object.blank? || !object.name.blank?
			collection = collection_for_base(action, bases.first).delete_if {|v| v.first != object.name}
		else
          		collection = collection_for_base(action, bases.first)
		end
          object.name ||= default if can_use_default?(
            default, :name, mapped_values(collection)
            )
          template_collection_select(:name, collection, options, html_options)
        end
      end

      def predicate_select(options = {}, html_options = {})
        options[:compounds] = true if options[:compounds].nil?
        default = options.delete(:default) || Constants::CONT

        keys =
        if options[:compounds]
          Predicate.names
        else
          Predicate.names.reject { |k| k.match(/_(any|all)$/) }
        end
	begin
		keys = eval(object.attributes.first.name.split("_").last)
	rescue
	  if only = options[:only]
            if only.respond_to? :call
              keys = keys.select { |k| only.call(k) }
            else
              only = Array.wrap(only).map(&:to_s)
              keys = keys.select {
                |k| only.include? k.sub(/_(any|all)$/, ''.freeze)
              }
            end
          end
	end
        collection = keys.map { |k| [k, Translate.predicate(k)] }
        object.predicate ||= Predicate.named(default) if
          can_use_default?(default, :predicate, keys)
        template_collection_select(:p, collection, options, html_options)
      end

    end
  end

=begin
  module Nodes
    class Value
      def label(model_given)
        model_given.find(value).try(:label) || model_given.find(value).try(:fullname) unless value.blank?
      end
    end
  end
=end
end
