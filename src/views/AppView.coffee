class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="double-button">Double</button>
    <button class="split-button" disabled="true">Split</button>
    <button class="new-button" disabled="true">New Game</button>
    <input class="wager" type="number" disabled="true"> 
    <h2>Chips: $<%= chips %></h2>
    <h2 id="wager">Wagers: $<%= wager %></h2>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .double-button': -> 
      @model.set 'wager', @model.get('wager')*2
      @initialize()
      @model.get('playerHand').hit()
      @$el.find('.stand-button').trigger('click')
      @model.set 'wager', @model.get('wager')/2
    'click .stand-button': -> 
      @model.get('dealerHand').stand(@model.get('playerHand').scores()[0])
      @$el.find('.stand-button').attr('disabled','true');
      @$el.find('.hit-button').attr('disabled','true');
      #@$el.find('.new-button').removeAttr('disabled');
    'click .new-button': -> 
      @model.reDeal()
      @initialize()
    'click .split-button': -> 
      @model.split()
      @initialize()
    'blur .wager': -> 
      @model.set 'wager', $('.wager').val() or 5
      console.log @model.get 'wager'


  initialize: ->
    `
    this.model.on('Busted dealerWin dealerLose push',function(){
      this.$el.find('.stand-button').attr('disabled','true');
      this.$el.find('.hit-button').attr('disabled','true');
      this.$el.find('.new-button').removeAttr('disabled');
      this.$el.find('.wager').removeAttr('disabled');
    }, this)

    this.model.on('split',function(card){
      this.$el.find('.split-button').removeAttr('disabled');
    }, this)
    `

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template(@model.attributes)
    playerView = new HandView(collection: @model.get 'playerHand')
    dealerView = new HandView(collection: @model.get 'dealerHand')

    @$('.player-hand-container').html playerView.el
    @$('.dealer-hand-container').html dealerView.el

