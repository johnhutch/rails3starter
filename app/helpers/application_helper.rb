module ApplicationHelper
 
  def markdown(text)
      rc = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true, :filter_html => true, :hard_wrap => true)
      #options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
      rc.render(text).html_safe unless text.nil?
  end

  def parent_url_string
    parent = controller.controller_name.singularize
    comments_path(:parent_type => parent, :parent_id => controller.instance_variable_get("@#{parent}").id)
  end
end
