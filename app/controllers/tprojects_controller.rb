class TprojectsController < ApplicationController
  unloadable


  def getprojects

    if params['limit'] and params['offset']
      @limit = "LIMIT " + params['limit']
      @offset = "OFFSET " + params['offset']
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

    render json: Tprojects.new(@t_projects_list,  params['offset'], params['limit'], 2)
  end


  class Tprojects

    def initialize(projects, offset, limit, total_count)
      @projects     = projects
      @offset   = offset.to_i
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
