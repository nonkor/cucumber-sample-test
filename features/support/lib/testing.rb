module Testing
  class << self
    attr_accessor :browser, :timeout
  end

  def clean_report_repository
    FileUtils.rm_r 'report', force: true
    FileUtils.mkdir 'report'
  end

  module_function :clean_report_repository
end
