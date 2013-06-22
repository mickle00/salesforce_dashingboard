SCHEDULER.every '2s' do
  send_event('cases-by-team', 
                          { items: [
                                    {label: 'HSTS', value: '15'},
                                    {label: 'PAC/SAM', value: '15'},
                                    {label: 'Content', value: '15'},
                                    {label: 'Media', value: '15'}
                                   ],
                            title: 'WHAT UP DOGG'
                          })
  send_event('cases-opened-today',   { value: rand(100) })
  send_event('cases-closed-today',   { value: rand(100) })
end
