# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'testbuildrocks/projects(.:format)', :to => 'tprojects#index', :format => true
# get 'testbuildrocks/projects.json', :to => 'tprojects#getprojects'
