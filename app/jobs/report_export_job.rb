class ReportExportJob < ApplicationJob
  queue_as :default

  def perform(company_id)
    Rails.logger.info("Financial report export requested for company #{company_id}")
  end
end
