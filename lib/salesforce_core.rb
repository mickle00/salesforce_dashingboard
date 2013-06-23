require 'databasedotcom'
require 'yaml'

def execute_report(devName)
    login if @client.nil?
    report_id = find_report_id_by_name(devName)
    url = "/services/data/v27.0/analytics/reports/#{report_id}"
    res = @client.http_get(url)
    JSON.load(res.body)
end

def get_top_level_summary(devName)
    rep = execute_report(devName)
    values = []
    rep['groupingsDown']['groupings'].each do |r|
        lookupKey = r['key'] + '!T'
        values << {'label' => r['label'], 'value' => rep['factMap'][lookupKey]['aggregates'][0]['value']}
    end
    returnVal = {'summary' => get_report_summary(rep), 'values'=> values}
end

private 

    def login
        @client = Databasedotcom::Client.new()
        @client.host = ENV['DATABASEDOTCOM_HOST']
        @client.version = ENV['DATABASEDOTCOM_VERSION']
        @client.username = ENV['DATABASEDOTCOM_USERNAME']
        @client.password = ENV['DATABASEDOTCOM_PASSWORD']
        @client.authenticate
        @client.materialize('Report')
        @client
    end

    def find_report_id_by_name (devName)
        Report.find_by_DeveloperName(devName).Id
    end

    def get_report_summary(report)
        sum = {}
        sum['title'] = report['attributes']['reportName']
        sum['rowCount'] = get_row_count(report)
        sum
    end

    def get_row_count(report)
        totals = report['factMap']['T!T']['aggregates']
        totals.each do |total|
            if total['name'] == 'RowCount' 
                return total['value']
            end
        end
    end
