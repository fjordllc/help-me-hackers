module RailsExt
  module Helper
    # h + n2br
    def hbr(str)
      html_escape(str).gsub(/\r\n|\r|\n/, "<br />\n")
    end

    # h + quote
    def hsq(str)
      html_escape(str).gsub(/'/, '&apos;')
    end

    def focus(element)
      content_tag(:script, "document.getElementById('#{element}').focus()", :type => "text/javascript")
    end

    def title(page_title)
      content_for(:title) { page_title }
    end

    def description(page_description)
      content_for(:description) { page_description }
    end

    def keywords(page_keywords)
      content_for(:keywords) { page_keywords }
    end

    # Making bread crumb tag
    #
    # == Options
    # * <tt>:yield</tt> - Using content_for.
    # * <tt>:name</tt> - Setting target name when use :yield option.
    # == Example
    #   <%= bread_crumbs([
    #     {:name => "Home", :url => root_path},
    #     {:name => "Listing entries"}]) %>
    #
    #   <% bread_crumbs([
    #     {:name => "Home", :url => root_path},
    #     {:name => "Listing entries"}], :yield => true) %>
    def bread_crumbs(bread_crumbs, options = {:yield => false, :name => :bread_crumbs})
      html = bread_crumbs.map do |bread_crumb|
        if bread_crumb[:url].blank?
          content_tag :li, bread_crumb[:name], :class => 'bread_crumb'
        else
          content_tag :li, link_to(bread_crumb[:name], bread_crumb[:url]),
            :class => 'bread_crumb', :title => bread_crumb[:name]
        end
      end.join
      out = content_tag :ol, html, :class => 'bread_crumbs'
      if options[:yield]
        content_for(:bread_crumbs) { out }
      else
        out
      end
    end

    def free_dial?(str)
      /^(0120|0800)/ =~ str
    end
  end
end
