ActionView::Base.field_error_proc = Proc.new do |html, instance|
  %{<span class='fieldWithErrors'>#{html}</span>}.html_safe
end

module ActionView
  module Helpers
    def link_to(name, options = {}, html_options = nil)
      method = (html_options and html_options[:method] == :delete) ? "delete" : "read"
      if current_user and options.is_a?(String)
        # remove query string
        params = Rails.application.routes.recognize_path(options.sub(/\?.*/, ''), :method => :get) rescue {}
        Rails::Engine.subclasses.find_all{|e| e.name.start_with?("Nemo")}.each do |engine_class|
          if params.blank?
            params = engine_class.routes.recognize_path(options.sub(/\?.*/, '')) rescue {}
          end
        end
        if params[:controller]
	
          unless params[:controller] =~ /admin_data/
            action          = params[:action]
            controller_path = params[:controller]
            # Manage namespace, bo/users become Bo::UsersController
            controller_name = controller_path.split('/').map { |c| c.camelcase }.join("::") + "Controller"
            controller = controller_name.constantize rescue nil
            if controller.try(:const_defined?, "RESOURCES")
              resources = controller.const_get("RESOURCES")
              resource  = resources[action.to_sym]

              if resource
                can_access = nil
                Array(resource).each do |sym|
                  model = sym.to_s.classify.constantize rescue nil
                  can_access = current_user.send("#{method}?", model)
                  break unless can_access
                end
                # if can_access has not been set, use default permissions
                unless can_access.nil?
                  if can_access
                    return super(name, options, html_options)
                  else
                    return ""
                  end
                end
              end
            end
            # Try to determine resource automaticaly
            # transform controller like 'bo/foo' into 'foo'
            resource = controller_path.split('/').last
            model = resource.classify.constantize rescue nil
            # return an empty string instead of nil to permit "" + object
            return "" if model and [model.superclass, model.superclass.superclass].include?(ActiveRecord::Base) and not current_user.send("#{method}?", model)
          end
        end
      end

      super(name, options, html_options)
    end

    def label(object_name, method, text = nil, options = {})
      # Labels are filtered by institution
      if current_institution
        key   = Label.key(object_name, method, current_institution.id)
        label = Label.find_by_key(key)
        text  ||= label.try(:value) || t(Label.base_key(object_name, method)) || 'Default'

        # Ensure to cache the value for the next load.
        Label.create(:key => key, :value => text, :institution_id => current_institution.id) unless label

        # Place a special class to be able to dynamicaly update the name of the field.
        options[:class] = "#{(options[:class] || '')} key.#{key}"
      end
      #InstanceTag.new(object_name, method, self, options.delete(:object)).to_label_tag(text, options)
      Tags::Label.new(object_name, text.blank? ? "" : text, self, options.merge({ :text => text })).render {text} rescue nil
    end

    module FormTagHelper
      def select_tag(name, option_tags = nil, options = {})
        html_name = (options[:multiple] == true && !name.to_s.ends_with?("[]")) ? "#{name}[]" : name
        if blank = options.delete(:include_blank)
          if blank.kind_of?(String)
            option_tags = "<option value=\"\">#{blank}</option>" + option_tags
          else
            option_tags = "<option value=\"\"></option>" + option_tags
          end
        end
        content_tag :select, option_tags.gsub("&lt;","<").gsub("&gt;",">").html_safe, { "name" => html_name, "id" => sanitize_to_id(name) }.update(options.stringify_keys)
      end
    end

    module FormHelper
      def date_field(object_name, method, options = {})
        format ||= I18n.t("date.formats.default")
        object = options[:object]
        v = object.try(method)
        value = v.respond_to?(:to_date) ? I18n.l(v.to_date, :format => format) : v
        #InstanceTag.new(object_name, method, self, options.delete(:object)).to_input_field_tag("text", options.merge({ :value => value }))
        Tags::TextField.new(object_name, method, self, options.merge({ :value => value })).render
      end
    end

    module UrlHelper
    end

    class FormBuilder
      def date_field(method, options = {})
        @template.send(
          "date_field",
          @object_name,
          method,
          objectify_options(options))
      end
    end
  end
end
