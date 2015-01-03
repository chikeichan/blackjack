# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'chips', 5000
    @set 'wager', 5

    @get('playerHand').on 'Busted', => 
    	@.trigger 'Busted'
    	@lose()

    @get('dealerHand').on 'Busted', =>
    	@.trigger 'Busted'
    	@win()

    @get('dealerHand').on 'dealerWin', =>
    	@trigger 'dealerWin'
    	@lose()

    @get('dealerHand').on 'dealerLose', =>
    	@trigger 'dealerLose'
    	@win()

    @get('dealerHand').on 'push', => @trigger 'push'

  lose: ->
  	@set 'chips', @get('chips')-@get('wager')

  win: ->
  	@set 'chips', @get('chips')+@get('wager')

  reDeal:
  	`
  	function(){
  		if(this.get('deck').length > 30){
	  		this.get('playerHand').redeal();
	  		this.get('dealerHand').redeal();
  		} else {
  			this.get('deck').shuffle();
  			this.get('playerHand').redeal();
	  		this.get('dealerHand').redeal();
  		}
  	}
  	`
