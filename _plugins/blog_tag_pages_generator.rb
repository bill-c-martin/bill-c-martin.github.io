module Jekyll
    class TagPageGenerator < Generator
      safe true
  
      def generate(site)
        tags = site.posts.docs.flat_map { |post| post.data['tags'] || [] }.to_set
        tags.each do |tag|
          site.pages << TagPage.new(site, site.source, tag)
        end
      end
    end

    class TagPage < Page
      def initialize(site, base, tag)
        @site = site
        @base = base
        @dir  = File.join('blog/tag', Utils.slugify(tag))
        @name = 'index.html'
  
        self.process(@name)
        self.read_yaml(File.join(base, '_layouts'), 'blog_tag_list.html')
        self.data['tag'] = tag
        self.data['title'] = "Tag: #{tag}"

        # Add meta robot tags with noindex,follow on tag list pages
        # Prevents issues like Google not indexing actual content pages due to duplicate content on tag list pages
        self.data['noindex'] = true
      end
    end
  end