Cookies = 
  read: (name) ->
    document.cookie.split("#{name}=")[1].split(';')[0]
  
  write: (name, value) ->
    document.cookie = "#{name}:#{value}"

module.exports = Cookies