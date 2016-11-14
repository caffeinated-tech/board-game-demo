Api = 
  request: (method, args) ->
    new Promise (resolve, reject) ->
      xhr = new XMLHttpRequest()
      xhr.open(method, args.url)
      # setup promise callbacks
      xhr.onload = ->
        if 200 <= xhr.status < 300
          resolve(JSON.parse(xhr.response))
        else
          reject(JSON.parse(xhr.response))
      xhr.onerror = ->
        reject(JSON.parse(xhr.response))
      # set headers
      xhr.setRequestHeader(
        "Content-Type",
        "application/json;charset=UTF-8")
      xhr.setRequestHeader(
        'X-CSRF-Token',
        App.Helpers.Cookies.read('CSRF-TOKEN'))

      for header, value of args.headers 
        xhr.setRequestHeader(header, value)

      # make request
      if method is 'POST' or method is 'PUT'
        xhr.send JSON.stringify(args.data)
      else
        xhr.send()

  POST: (args) ->
    console.log 'post'
    @request('POST', args)

  GET: (args) ->
    @request('GET', args)

  DELETE: (args) ->
    @request('DELETE', args)

  PUT: (args) ->
    @request('PUT', args)
    
module.exports = Api