require "#{File.dirname(__FILE__)}/../lib/salesforce_core"

totalCases = []
allOpenCases = get_report_summary(execute_report('All_Open_Cases'))

(1..9).each do |i|
  totalCases << { x: i * 10, y: 0}
end
last_x = totalCases.last[:x]
totalCases << { x: last_x, y: allOpenCases['rowCount']}

SCHEDULER.every '20s', :first_in => 0 do
  allOpenCases = get_report_summary(execute_report('All_Open_Cases'))
  openCases = get_report_summary(execute_report('Support_Req_Open'))
  closedCases = get_report_summary(execute_report('Support_Req_Closed_Today'))
  casesByTeam = get_top_level_summary('Support_Req')
  send_event('cases-by-team',{ items: casesByTeam['values'], title: casesByTeam['summary']['title']})
  send_event('cases-opened-today',   { value: openCases['rowCount'][0]['value'], title: openCases['title'] })
  send_event('cases-closed-today',   { value: closedCases['rowCount'][0]['value'], title: closedCases['title'] })

  totalCases.shift
  last_x += 10
  totalCases << { x: last_x, y: allOpenCases['rowCount'][0]['value']}

  send_event('allOpenCases', {title: allOpenCases['title'], points: totalCases})
end
