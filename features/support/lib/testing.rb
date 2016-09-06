module Testing

  extend self
  attr_accessor :browser, :timeout

  def clean_report_repository
    FileUtils.rm_r 'report', :force => true
    FileUtils.mkdir 'report'
  end

  # def timeout
  #   rand
  # end

end
