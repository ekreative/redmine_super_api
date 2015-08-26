class TprojectsController < ProjectsController
  unloadable
  accept_api_auth :index

  def index

    respond_to do |format|

      format.api  {
        @offset, @limit = api_offset_and_limit

          if @offset and @limit
            @limit_q = "LIMIT #{@limit}"
            @offset_q = "OFFSET #{@offset}"
          end


          if params['ordering']
            @ordering = "ORDER BY p.name " + params['ordering']
          end

          if params['name']
            @filter_name = " WHERE p.name LIKE '%" + params['name'] + "%'"
          end

        @projects = Project.find_by_sql("
            SELECT * FROM projects AS p
            LEFT JOIN (SELECT cv.value AS ios,cv.customized_id FROM custom_fields as cf LEFT JOIN custom_values AS cv ON cv.custom_field_id = cf.id WHERE cf.name = 'IOS') AS ios ON ios.customized_id = p.id
            LEFT JOIN (SELECT cv.value AS Android,cv.customized_id FROM custom_fields as cf LEFT JOIN custom_values AS cv ON cv.custom_field_id = cf.id WHERE cf.name = 'Android') AS android ON android.customized_id = p.id
            #{@filter_name} GROUP BY p.id #{@ordering} #{@limit_q} #{@offset_q}
          ")

        @project_count = @projects.count

      }

    end
  end

end
