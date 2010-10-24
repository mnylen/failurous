
module ApplicationHelper
  
  def render_instructions(project, name)
    file = File.join(RAILS_ROOT, 'doc', 'clients', "#{name}.md")
    content = File.read(file)
    content.gsub!("<FAILUROUS-INSTALLATION>", root_url)
    content.gsub!("<API-KEY-FOR-PROJECT>", project.api_key)
    RDiscount.new(content, :smart).to_html.html_safe
  end

  def positive_button(title, path, options = {})
    link_to(title, path, options.merge({:class => 'button positive'}))
  end

  def resolve_button(fail)
    positive_button('Resolve',
      ack_project_fail_path(fail.project, fail,
        :return_to => project_path(
          @project.id, :show_resolved => params[:show_resolved]
        )
      ), :method => :post)
  end
end
