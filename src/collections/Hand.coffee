class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->


  redeal: ->
    if @isDealer
      @reset()
      @push(@deck.pop().flip())
      @push(@deck.pop())
    else
      @reset()
      @push(@deck.pop())
      @push(@deck.pop())

  hit: ->
    if @scores()[0] < 21
      card = @deck.pop()
      @add(card)
      if @scores()[0] is 21
        @trigger('21')
      else if @scores()[0] > 21
        @trigger('Busted')
      card

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    # [@minScore(), @minScore() + 10 * @hasAce()]
    if @minScore() + 10 * @hasAce() <= 21 then [@minScore() + 10 * @hasAce()]
    else [@minScore()]

  stand: (playerScore) ->
    @models[0].flip()
    @finish(playerScore)

  finish:(playerScore) ->
    if @scores()[0] < 17 or @scores()[0] < playerScore
      @hit()
      @finish(playerScore)
    else if @scores()[0] > 21
      @trigger "dealerLose"
    else if @scores()[0] is playerScore
      @trigger "push"
    else 
      @trigger "dealerWin"
