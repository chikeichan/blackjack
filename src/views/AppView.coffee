class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="new-button" disabled="true">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      @model.get('dealerHand').stand(@model.get('playerHand').scores()[0])
      @$el.find('.stand-button').attr('disabled','true');
      @$el.find('.hit-button').attr('disabled','true');
      @$el.find('.new-button').removeAttr('disabled');

  initialize: ->
    @model.on 'Busted', ->
      $('.new-button').removeAttr('disabled'),


    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

