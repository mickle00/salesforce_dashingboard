SCHEDULER.every '10m', :first_in => 0 do |job|
    tweets = [{ name: 'First', body: '1111', avatar: '' },
            { name: 'Second', body: '2', avatar: ''},
            { name: 'Third', body: '2', avatar: ''},
            { name: 'Fourth', body: '2', avatar: ''}]
    send_event('chatter', comments: tweets)
end
