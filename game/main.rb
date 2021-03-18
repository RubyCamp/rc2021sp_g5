require 'dxruby'
require 'singleton'

require_relative 'scene'

require_relative 'modules/map_chip'
require_relative 'modules/math_helper'

require_relative 'lib/component'
require_relative 'lib/director_base'
require_relative 'lib/popup_message'
require_relative 'lib/map_base'

require_relative 'scenes/game/director'
require_relative 'scenes/game/map'
require_relative 'scenes/game/player'
require_relative 'scenes/game/goalcharactor'

require_relative 'scenes/map_editor/director'
require_relative 'scenes/map_editor/map'
require_relative 'scenes/map_editor/chip_pallet'
require_relative 'scenes/map_editor/button'

require_relative 'scenes/title/director'
require_relative 'scenes/gameover/g_director'

require_relative 'scenes/Congrats/director'



Window.width = 1024
Window.height = 768
Window.caption = "RubyCamp 2021SP Sample1"

game_director=Game::Director.new

Scene.add(game_director, :game)
Scene.add(MapEditor::Director.new, :map_editor)
Scene.add(Title::Director.new, :title)
Scene.add(Gameover::Director.new,:gameover)
Scene.add(Congrats::Director.new, :congrats)
Scene.move_to(:title)



Window.loop do
  break if Input.key_push?(K_ESCAPE)
  Scene.move_to(:game) if Input.key_push?(K_G)
  Scene.move_to(:map_editor) if Input.key_push?(K_M)
  Scene.move_to(:title) if Input.key_push?(K_T)
  Scene.move_to(:gameover) if game_director.gameover?
　#Scene.move_to(:gameover) if @player===@enemy  #@つけるかわからない。@enemyは暫定的に
  Scene.play

end