Shareable.configure do |config|
  config.names = %w[ twitter facebook linkedin google_plus reddit ]
  ##############
  #facebook
  ##############
  config.app_id=''
  config.send= 'false'
  config.layout='button_count'
  config.show_faces='true'
  config.width='80'
  config.action='like'
  config.font=''
  config.colorscheme=''
  config.ref=''

  ##############
  #google_plus
  ##############
  config.annotation='bubble'
  config.align=''
  config.expand_to=''
  config.callback=''
  config.onstartinteraction=''
  config.onendinteraction=''
  config.recommendations='false'

  ##############
  #linkedin
  ##############
  config.counter = 'right'
  config.onsuccess = ''
  config.onerror = ''
  config.showzero = 'true'

  ##############
  #pinterest
  ##############
  config.pin_config = 'none'
  config.pin_do = 'buttonPin'
  config.title= "Find your prospect's verified email address - DirectContact" # title for content, also used by reddit button
  config.alt='' # alternate text for image tag
  config.media=''
  config.description='Pin This'

  ##############
  #reddit
  ##############
  config.target=''
  config.color=''
  config.bordercolor=''
  config.styled='off'
  config.newwindow='1'
  config.btnsrc='http://www.reddit.com/buttonlite.js?i=1'
  config.type= '1' # button type, eg: 1 to n
  config.points = '1' # points style, eg: 0 to 5

  ##############
  #twitter
  ##############
  config.via='DirectContactHQ'
  config.text="Find your prospect's verified email address. Sales Prospecting and Lead Generation Tool"
  config.related=''
  config.count='horizontal'
  config.lang='en'
  config.counturl=''
  config.hashtags=''
  config.size='small'
  config.dnt=''
end
