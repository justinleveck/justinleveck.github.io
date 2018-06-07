module Jekyll

  class TagGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag'
        site.tags.each_key do |tag|
          paginate(site, tag)
        end
      end
    end

    def paginate(site, tag)
      tag_posts = site.data['posts'] = site.collections["posts"].docs.select { |p| p['tags'].include? tag }.sort_by {|post| -post.date.to_f}
      # tag_posts = site.posts.find_all {|post| post.tags.include?(tag)}.sort_by {|post| -post.date.to_f}
      num_pages = TagPager.calculate_pages(tag_posts, site.config['paginate'].to_i)

      (1..num_pages).each do |page|
        pager = TagPager.new(site, page, tag_posts, tag, num_pages)
        dir = File.join('tags', Tag.format(tag))
        page = TagPage.new(site, site.source, dir, tag)
        page.pager = pager
        site.pages << page
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      formatted_tag = tag.gsub(',', '')

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = formatted_tag
      self.data['paginator_path'] = "#{site.config["baseurl"]}/tags/#{self.data['tag']}/"
      self.data['tag_title'] = "#{formatted_tag.gsub("-", " ").titlecase} Articles"
      #self.data['title'] = "Posts Tagged &ldquo;"+tag+"&rdquo;"
    end
  end

  class TagPager < Jekyll::Paginate::Pager
    attr_reader :tag

    def initialize(site, page, all_posts, tag, num_pages = nil)
      @tag = tag
      super site, page, all_posts, num_pages
    end

    alias_method :original_to_liquid, :to_liquid

    def to_liquid
      liquid = original_to_liquid
      liquid['tag'] = @tag
      liquid
    end
  end

end
