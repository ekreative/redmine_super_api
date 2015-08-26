# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'testbuildrocks/projects', :to => 'tprojects#getprojects'
get 'testbuildrocks/projects.json', :to => 'tprojects#getprojects'
