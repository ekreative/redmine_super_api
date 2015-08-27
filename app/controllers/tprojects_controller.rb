class TprojectsController < ApplicationController
  unloadable
  accept_api_auth :index

  helper :custom_fields
  helper :projects

  def index

    respond_to do |format|

      format.api  {
        @offset, @limit = api_offset_and_limit
        @filter = " WHERE " + Project.visible_condition(User.current)

          if params['name']
            @filter += " AND ( projects.name LIKE '%" + params['name'] + "%' )"
          end

        @ordering = params['ordering'] == 'desc' ? 'DESC' : 'ASC'
        @projects = Project.find_by_sql ["SELECT * FROM projects #{@filter} GROUP BY projects.id ORDER BY projects.name #{@ordering}  LIMIT :limit  OFFSET :offset", {:limit => @limit, :offset => @offset}]
        @project_count = @projects.count
      }

    end
  end

end
