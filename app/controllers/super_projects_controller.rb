class SuperProjectsController < ProjectsController
  def index
    respond_to do |format|
      format.api  {
        scope = Project.visible.sorted
    
        if params['name']
          scope = scope.like(params['name'])
        end
        
        @offset, @limit = api_offset_and_limit
        @project_count = scope.count
        @projects = scope.offset(@offset).limit(@limit).to_a
      }
      format.all {
        super
      }
    end
  end
end
