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
require_relative 'scenes/game/enemy'
require_relative 'scenes/game/boss_enemy'
require_relative 'scenes/game/goalcharactor'
require_relative 'scenes/game/boss_weapon'

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


sound1=Sound.new("戦闘曲.wav")
sound1.loop_count=-1
sound1.setVolume(22,time=0) #第一引数はvolumeの大きさ。ふつうは230。

sound2=Sound.new("gameover.wav")
#sound2.loop_count=0
sound2.setVolume(22,time=0) #第一引数はvolumeの大きさ。ふつうは230。

start=0
starting=0

Window.loop do
  break if Input.key_push?(K_ESCAPE)
  if Input.key_push?(K_G)
    if start==0
      sound1.play
      start=1
    end
    if Input.keyPush?(K_Z)
      sound1.stop
    end
    Scene.move_to(:game) 
  end
  Scene.move_to(:map_editor) if Input.key_push?(K_M)
  Scene.move_to(:title) if Input.key_push?(K_T)

  if game_director.gameover?
    sound1.stop
    if starting==0
      sound2.play
      starting=1
    end
    Scene.move_to(:gameover) 
  end
  #Scene.move_to(:gameover) if @player===@enemy  #@つけるかわからない。@enemyは暫定的に
  Scene.play

end

sound1.dispose
sound2.dispose
