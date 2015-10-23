Redmine::Plugin.register :redmine_super_api do
  name 'Super API plugin'
  author 'Yuriy Paliy and Fred Cox'
  description 'Plugin for Redmine adds extra parameters to the projects list'
  version '1.0.0'
  url 'http://github.com/ekreative/redmine_super_api'
end

# Putting this in init allows to override the default routes
RedmineApp::Application.routes.prepend do
  get 'projects(.:format)', :to => 'super_projects#index', :format => true
end
