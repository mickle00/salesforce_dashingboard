SCHEDULER.every '2s' do
  send_event('cases', { items: [
                                {label: 'HSTS', value: '15'},
                                {label: 'PAC/SAM', value: '15'},
                                {label: 'Content', value: '15'},
                                {label: 'Media', value: '15'}
                               ] 
                      })
end
