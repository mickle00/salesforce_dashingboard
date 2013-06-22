require "#{File.dirname(__FILE__)}/../lib/salesforce_core"

totalCases = []
allOpenCases = get_report_summary(execute_report('All_Open_Cases'))

(1..9).each do |i|
  totalCases << { x: i * 10, y: 0}
end
last_x = totalCases.last[:x]
totalCases << { x: last_x, y: allOpenCases['rowCount']}

SCHEDULER.every '60s', :first_in => 0 do
  allOpenCases = get_report_summary(execute_report('All_Open_Cases'))
  openCases = get_report_summary(execute_report('Support_Req_Open'))
  closedCases = get_report_summary(execute_report('Support_Req_Closed_Today'))
  send_event('cases-by-team', 
                          { items: [
                                    {label: 'HSTS', value: '15'},
                                    {label: 'PAC/SAM', value: '15'},
                                    {label: 'Content', value: '15'},
                                    {label: 'Media', value: '15'}
                                   ],
                            title: 'WHAT UP DOGG'
                          })
  send_event('cases-opened-today',   { value: openCases['rowCount'], title: openCases['title'] })
  send_event('cases-closed-today',   { value: closedCases['rowCount'], title: closedCases['title'] })

  totalCases.shift
  last_x += 10
  totalCases << { x: last_x, y: allOpenCases['rowCount']}

  send_event('allOpenCases', points: totalCases)
end
