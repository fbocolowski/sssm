class Api::ErrorLogsController < Api::ApplicationController
  def create
    log_watcher = LogWatcher.where(token: request.headers['SSSM-Token']).first rescue nil
    unless log_watcher.nil?
      if params[:file].present?
        filename = params[:file].original_filename

        File.read(params[:file].tempfile).each_line.with_index do |text, line|
          if (text[/erro|Erro|exception|Exception/])
            if log_watcher.error_logs.where(filename: filename, error: text, line: line).empty?
              log_watcher.error_logs.create(filename: filename, error: text, line: line)
              NotificationSender.send_error(log_watcher, text)
            end
          end
        end
      end
    end

    render json: ""
  end
end
