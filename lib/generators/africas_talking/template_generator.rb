module AfricasTalking
	module Generators
		class TemplateGenerator < Rails::Generators::Base
			
			desc	"Create local africas_talking.yml template file for customizations"
			source_root File.expand_path('../templates', __FILE__)
			arguement :templates_path, type: :string,
				default: "config/",
				banner: "path to templates"

			def copy_templates
				copy_file "africas_talking_config.yml.erb", "#{templates_path}/africas_talking.yml"
			end
			
		end
	end
end