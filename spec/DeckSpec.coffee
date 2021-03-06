assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49

    it 'should bust when over 21', ->
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      console.log hand.scores()
