Character = require './character.coffee'

console.log 'Character:', Character

#
#	Main game class
#
class Game
	
	options:
		width: 1200
		height: 600		
	characters_names: ['tri_w', 'tri_b', 'squ_w', 'squ_b', 'squ_w', 'rou_w', 'rou_b']

	#	Initialise kiwi.js and all objects
	constructor: ->
		console.log 'New game'		
		@game = new Kiwi.Game 'gamecanvas', 'Triangle Round Square', null, @options

		@ingame = new (Kiwi.State)('ingame')

		thisgame = @

		thisgame.characters = []

		@ingame.preload = ->
			Kiwi.State::preload.call this
			@addImage 'map_top', 'img/map_top.png'
			@addImage 'map_bottom', 'img/map_bottom.png'
			(@addImage character, "img/#{character}.png") for character in thisgame.characters_names
			console.log @textures
			return

		@ingame.create = ->
			Kiwi.State::create.call this
			@map_bottom = new (Kiwi.GameObjects.StaticImage)(this, @textures['map_bottom'])
			@addChild @map_bottom
			
			Character::spawn thisgame
			
			@map_top = new (Kiwi.GameObjects.StaticImage)(this, @textures['map_top'])
			@addChild @map_top
			
			@leftKey = @game.input.keyboard.addKey Kiwi.Input.Keycodes.LEFT
			@rightKey = @game.input.keyboard.addKey Kiwi.Input.Keycodes.RIGHT
			@upKey = @game.input.keyboard.addKey Kiwi.Input.Keycodes.UP
			@downKey = @game.input.keyboard.addKey Kiwi.Input.Keycodes.DOWN

		@ingame.update = ->
			Kiwi.State::update.call this
			
	
	#	Start the game		
	start: ->
		@game.states.addState @ingame, true
		
game = new Game()
game.start()
