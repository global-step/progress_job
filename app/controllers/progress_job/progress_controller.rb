module ProgressJob
  class ProgressController < ActionController::Base

    def show
      @delayed_job = Delayed::Job.find_by_id(params[:job_id])
      if @delayed_job.present? && @delayed_job.progress_max.present?
        percentage = !@delayed_job.progress_max.zero? ? @delayed_job.progress_current / @delayed_job.progress_max.to_f * 100 : 0
        render json: @delayed_job.attributes.merge!(percentage: percentage).to_json
      else
        render json: {error: '404'}, status: 404
      end
    end

  end
end
