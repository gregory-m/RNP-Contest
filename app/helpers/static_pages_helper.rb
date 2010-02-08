module StaticPagesHelper
  def page_path id
    id != 'home' ? "/#{id}" : '/'
  end
end
