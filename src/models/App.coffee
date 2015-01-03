# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'Busted', => @.trigger 'Busted'
    @get('dealerHand').on 'Busted', => @.trigger 'Busted'

    @get('dealerHand').on 'dealerWin', => console.log 'Dealer Win'
    @get('dealerHand').on 'dealerLose', => console.log 'Dealer Lose'
    @get('dealerHand').on 'push', => console.log 'Push'

