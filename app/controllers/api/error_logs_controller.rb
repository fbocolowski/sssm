class Api::ErrorLogsController < Api::ApplicationController
  def create
    token = request.headers['SSSM-Token']
    log_watcher = LogWatcher.where(token: token).first rescue nil
    unless log_watcher.nil?
      begin
        Rails.logger.info 'Receiving: ' + log_watcher.name + ' (' + log_watcher.file + ')'

        if params[:file].present?
          filename = params[:file].original_filename
          result_message = ''
          File.read(params[:file].tempfile).each_line.with_index do |text, line|
            if (text[/erro|Erro|exception|Exception/])
              if log_watcher.error_logs.where(filename: filename, error: text, line: line).empty?
                log_watcher.error_logs.create(filename: filename, error: text, line: line)
                result_message = result_message + text
              end
            end
          end
          result_message.strip!
          if !result_message.nil? && result_message != ''
            NotificationSender.send_error(log_watcher, result_message)
          end
        end
      rescue => e
        Rails.logger.info 'Exception: ' + log_watcher.name + ' (' + log_watcher.file + ')'
        Rails.logger.info e
      end
    else
      Rails.logger.info 'Invalid token: ' + token
    end

    render json: ""
  end
end
