window.onload = ->

  sp = getSpotifyApi(1);
  models = sp.require('sp://import/scripts/api/models');
  views = sp.require('sp://import/scripts/api/views');
  player = models.player;

  blankDatabase = {
    'spotify:album:7sNObDxv8FhBXdkIn1oii6': {
      'url': 'spotify:album:7sNObDxv8FhBXdkIn1oii6'
      'date': new Date()
    }
  }

  if sp? and models? and views? and player?
    console.log 'API ready'

  #models.application.observe(models.EVENT.ACTIVATE, ->
  #  console.log("Application activated!")
  #)

  getLocalStorage = (db = 'albums') ->
    if localStorage.getItem(db)?
      return JSON.parse(localStorage.getItem(db))
    else
      setBlankDatabase(db)
      return getLocalStorage()

  setBlankDatabase = (db = 'albums') ->
    console.log 'setting a blank database'
    localStorage.setItem( db, JSON.stringify(blankDatabase))

  addAlbumToDatabase = (album, db='albums') ->

    console.log 'adding album '+album

    albums = getLocalStorage()

    if albums[album]?
      console.log 'This album is already in the database'

      return false
    else
      albums[album] = {
        'url': album
        'date': new Date()
      }

      console.log 'checking object '

      console.log albums[album].url

      localStorage.setItem(db, JSON.stringify(albums))

      return true

  renderAlbums = ->
    albums = getLocalStorage()

    for album, data of albums
      $("<li data-date='#{ data.date }' data-url='#{ data.url }'></li>").appendTo('ul.albums')

    $('ul.albums li').not('.ready').each ->
      loadAlbumData( $(@).attr('data-url') )

  loadAlbumData = (uri) ->

    console.log 'loadAlbumData'

    models.Album.fromURI(uri, (album) ->
      el = $('ul.albums li[data-url="'+album.uri+'"]')

      albumImage = '"'+album.image+'"'

      cover = $("<span class='cover' style='background: url(#{albumImage})'><div class='play'></div></span>")
      title = $("<a class='title' href='#{album.uri}'>#{album.name}</a>")
      artist = $("<a class='artist' href='#{album.artist}'>#{album.artist}</a>")

      el.append(cover).append(title).append(artist).addClass('ready')
    )


  # Events

  models.application.observe(models.EVENT.LINKSCHANGED,  ->
    
    if addAlbumToDatabase models.application.links[0]

      $("<li data-date='#{ new Date() }' data-url='#{ models.application.links[0] }'></li>").appendTo('ul.albums')
      
      loadAlbumData( models.application.links[0] )
  )

  #getLocalStorage()
  renderAlbums()

  #models.Album.fromURI("spotify:album:7sNObDxv8FhBXdkIn1oii6", (album) ->
  #  console.log 'Album name: '+album.name
  #  console.log 'Album cover: '+album.image
  #  console.log 'Album year: '+album.year
  #)

  #addData = (data)



  #testObject = { 'one': 1, 'two': 2, 'three': 3 };
  #localStorage.setItem('testObject', JSON.stringify(testObject))

  # Retrieve the object from storage
  #retrievedObject = JSON.parse(localStorage.getItem('testObject'))

  #retrievedObject['four'] = 4;



  #retrievedObject['four'] = 4;

  #localStorage.setItem('testObject', JSON.stringify(retrievedObject))


  #console.log('retrievedObject: ', retrievedObject)
