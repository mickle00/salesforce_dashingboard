SCHEDULER.every '10m', :first_in => 0 do |job|
    tweets = [{ name: 'Marc Benioff', body: 'Imagine if this was a Chatter feed!', avatar: 'https://si0.twimg.com/profile_images/3127862205/7a97787536e5b859a5a737db7bef20f4_bigger.jpeg' },
            { name: 'The Developer', body: 'Ugh. More work, I\'ll just hardcode this for now.', avatar: 'https://si0.twimg.com/profile_images/395743755/LazyDeveloper_73x73_TwitterAvatar_bigger.jpg'},
            { name: 'Abe Lincoln', body: 'This is going to be huge.', avatar: 'https://si0.twimg.com/profile_images/679430814/alincoln_bigger.jpg'},
            { name: 'Michael Scott', body: 'That\'s what she said', avatar: 'https://si0.twimg.com/profile_images/105247240/michael_scott_bigger.png'}]
    send_event('chatter', comments: tweets)
end
