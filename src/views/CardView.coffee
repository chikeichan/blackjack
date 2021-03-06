class window.CardView extends Backbone.View
  className: 'card'

  #template: _.template '<img class="card" src="./img/cards/<%= rankName %>-<%= suitName %>.png"></img>'
  template: _.template '<img class="card" src="./img/cards/<% if(revealed) %><%=rankName%>-<%=suitName%>.png"></img>'


  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

