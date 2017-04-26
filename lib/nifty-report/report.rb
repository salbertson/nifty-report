require 'nifty-report/model'

module Nifty
  class Report
    def initialize(sql, name, connection_string = nil)
      @sql = sql
      @name = name
      @connection_string = connection_string
    end

    def filename
      @name.downcase.gsub(' ', '.') + ".#{Time.now.strftime('%F')}.csv"
    end

    def csv
      Model.establish_connection(@connection_string)
      Model.connection.execute("COPY (#{@sql}) TO STDOUT WITH DELIMITER ',' CSV HEADER")

      csv = ''

      while line = Model.connection.raw_connection.get_copy_data do
        csv << line
      end

      csv
    end

    def email_to(email_address)
      AWS::S3::Base.establish_connection!(
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      )

      AWS::S3::S3Object.store(filename, csv, ENV['AWS_S3_BUCKET'])
      remote_file = AWS::S3::S3Object.find(filename, ENV['AWS_S3_BUCKET'])

      ReportMailer.report_email(email_address, remote_file.url(expires_in: 30 * 60)).deliver

      wat = "aaaaaaaaaahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
    end
  end
end
