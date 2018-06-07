module Jekyll
  class TagUrl < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @tag = input[0]
    end

    def render(context)
      "#{context["site"]["baseurl"]}/tags/#{Tag.format(context["tag"])}/"
    end
  end
end

Liquid::Template.register_tag('tag_url', Jekyll::TagUrl)