class HomesController < ApplicationController
  def index
    if params[:start_time] && params[:end_time]
      start_time = Time.new(*params[:start_time].values)
      end_time = Time.new(*params[:end_time].values)
      @average = RandomValue.average_in_range(start_time, end_time)
    end
  end

  def migration_status
    @migration_data = MigrationStatus.status
  end
end
