module ApplicationHelper
  def javascript_exists?(file)
    extensions = [".js", ".coffee", ".erb", ".js.coffee", ".js.erb", ".coffee.erb", ".js.coffee.erb"]
    path = "#{Rails.root}/app/assets/javascripts/#{file}"
    file_exists?(path, extensions)
  end

  def stylesheet_exists?(file)
    extensions = [".css", ".scss", ".sass", ".less", ".styl", ".stylus", ".css.scss", ".css.sass", ".css.less", ".css.styl", ".css.stylus"]
    path = "#{Rails.root}/app/assets/stylesheets/#{file}"
    file_exists?(path, extensions)
  end

  def file_exists?(path, extensions = ['.js', '.css'])
    exists = false
    extensions.each do |ext|
      exists = File.exists?("#{path}#{ext}")
      if exists
        break
      end
    end
    exists
  end




end
