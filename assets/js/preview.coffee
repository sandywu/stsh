updateTitle = ->
  document.title = $('#plunk').contents().find("title").text()  
$ ->
  setInterval(updateTitle, 1000)