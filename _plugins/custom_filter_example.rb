# module Jekyll
#   module FormatTagFilter
#     class TagUrl < Liquid::Tag
#       def format_tag(tag)
#         tag.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
#       end
#     end
#   end
# end

# Liquid::Template.register_filter(Jekyll::FormatTagFilter)