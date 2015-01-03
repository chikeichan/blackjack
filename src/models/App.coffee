# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'Busted', => @.trigger 'Busted'
    @get('dealerHand').on 'Busted', => @.trigger 'Busted'
    @get('dealerHand').on 'dealerWin', => @trigger 'dealerWin'
    @get('dealerHand').on 'dealerLose', => @trigger 'dealerLose'
    @get('dealerHand').on 'push', => @trigger 'push'

  reDeal:
  	`
  	function(){
  		this.set('playerHand', this.get('deck').dealPlayer());
  		this.set('dealerHand', this.get('deck').dealDealer());
  	}
  	`