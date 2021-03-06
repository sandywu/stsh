((plunker) ->

  class plunker.EditorController extends Backbone.Router
    initialize: ->
      @route /^edit\/from\:([^\?]+)(\?.+)?/, "importPlunk"
      @route /^edit\/([a-zA-Z0-9]{6})(\?.+)?/, "loadPlunk"
      
      @parseQuery()
      
      # Model defining the editing session that is taking place on Plunker
      plunker.models.session = @session = new plunker.Session
  
      
      # View for the toolbar at the top of the page
      plunker.views.toolbar = new plunker.Toolbar
        el: document.getElementById("toolbar")
        model: plunker.models.session

      # View for the sidebar
      plunker.views.sidebar = @sidebar = new plunker.Sidebar
        el: document.getElementById("sidebar")
        model: plunker.models.session
      
      # View for the text editor component
      plunker.views.textarea = @textarea = new plunker.Textarea
        id: "textarea"
        model: plunker.models.session

      # View for the live previewer component
      plunker.views.previewer = new plunker.Previewer
       el: document.getElementById("live")
       model: plunker.models.session
      
      
      if @query.live == "compile" then plunker.mediator.trigger "intent:live-compile"
      else if @query.live == "preview" then plunker.mediator.trigger "intent:live-preview"

    parseQuery: ->
      @query = {};
      
      a = /\+/g
      r = /([^&=]+)=?([^&]*)/g
      d = (s) -> decodeURIComponent(s.replace(a, " "))
      q = window.location.search.substring(1)
      
      @query[d(e[1])] = d(e[2]) while e = r.exec(q)


    
    loadPlunk: (id) -> @session.load(id)
    
    importPlunk: (source) -> @session.import(source)
      
)(@plunker ||= {})