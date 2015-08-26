class TprojectsController < ApplicationController
  unloadable
  accept_api_auth :index

  def index

    @offset, @limit = api_offset_and_limit

    if @offset and @limit
      @limit = "LIMIT #{@limit}"
      @offset = "OFFSET #{@offset}"
    end


    if params['ordering']
      @ordering = "ORDER BY p.name " + params['ordering']
    end

    if params['name']
      @filter_name = " WHERE p.name LIKE '%" + params['name'] + "%'"
    end

    @t_projects_list = Project.find_by_sql("
      SELECT * FROM projects AS p
      LEFT JOIN (SELECT cv.value AS IOS,cv.customized_id FROM custom_fields as cf LEFT JOIN custom_values AS cv ON cv.custom_field_id = cf.id WHERE cf.name = 'IOS') AS ios ON ios.customized_id = p.id
      LEFT JOIN (SELECT cv.value AS Android,cv.customized_id FROM custom_fields as cf LEFT JOIN custom_values AS cv ON cv.custom_field_id = cf.id WHERE cf.name = 'Android') AS android ON android.customized_id = p.id
      #{@filter_name} GROUP BY p.id #{@ordering} #{@limit} #{@offset}
                                           ")
    @total_count = @t_projects_list.count

    respond_to do |format|
      format.api  {
        @offset, @limit = api_offset_and_limit
        @project_count = @total_count
        @projects = @t_projects_list
      }
    end

    # render json: Tprojects.new(@t_projects_list, @offset, @limit, @total_count)
  end


  class Tprojects

    def initialize(projects, offset, limit, total_count)
      @projects = projects
      @offset = offset.to_i
      @limit = !limit ? 25 : limit.to_i
      @total_count = total_count
    end

    def projects
      @projects
    end

    def offset
      @offset
    end

    def limit
      @limit
    end

    def total_count
      @total_count
    end

  end

end
