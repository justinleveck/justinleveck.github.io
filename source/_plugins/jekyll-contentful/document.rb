require 'jekyll'
require 'active_support/inflector'

module Jekyll
	module Contentful
		class Document

			attr_accessor :data, :options, :filename, :dir

			def initialize(obj, options={})
				@data = obj
				@options = options
				@dir = FileUtils.pwd
				@filename = parse_filename
			end

			def write!
				FileUtils.mkdir_p File.dirname(path)
				File.open(path, 'w') do |file|
					body = "#{frontmatter.to_yaml}---\n\n"
					unless @options.dig('body').nil?
						if @data.respond_to?(@options.dig('body').to_sym)
							content = @data.send(@options.dig('body').to_sym)
							body = "#{body}#{content}"
						end
					end
					file.write body
				end
				Jekyll.logger.info "#{filename} imported"
			end

			private

				def frontmatter
					matter = {}
					matter.merge!(frontmatter_extras)

					frontmatter_entry_mappings.each do |k, v|
						if @data.fields.keys.include?(v.to_sym)
							matter[k] = @data.send(v.to_sym)
							next
						end
						if v.split('/').size > 1 && @data.fields.keys.include?(v.split('/').first.to_sym)
							matter[k] = @data
							v.split('/').each do |attr|
								if matter[k].is_a?(Array)
									matter[k] = matter[k].map { |x| x.send(attr) }
								else
									matter[k] = matter[k].respond_to?(attr) ? matter[k].send(attr) : nil
								end
							end
						end
					end
					matter
				end

				def frontmatter_extras
					@options.dig('frontmatter','other') || {}
				end

				def frontmatter_entry_mappings
					@options.dig('frontmatter', 'entry_mappings') || {}
				end

				def parse_filename
					_f = slug
					if @options.keys.include?("filename")
						@template = Liquid::Template.parse(@options['filename']) # Parses and compiles the template
						tpl_vars = @template.root.nodelist.select{|obj| obj.class.name == 'Liquid::Variable' }
						mapped = tpl_vars.collect{|obj| Hash[*obj.name.name, @data.send(obj.name.name.to_sym)] }.reduce({}, :merge)
						_f = @template.render(mapped)
					end
					['collections', "_#{collection_name}", "#{_f}.md"].join('/')
				end

				def slug
					@data.slug
				rescue
					@data.title.parameterize
				end

				def path
					File.join(@dir, @filename)
				end

				def collection_name
					@options.dig('collection_name').to_s
				end

		end
	end
end
