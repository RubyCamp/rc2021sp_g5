# マップエディタモジュール
module Game
  # シーン管理用ディレクタークラス
  class Director < DirectorBase
    DEBUG_MODE = true
    @dx = 0
    @@check_flag = 0
    @@check_count = 0
    @@check_goal = 1

    # 初期化
    def initialize
      player_img =  Image.load("images/player.png")
      @map = Map.new(50, 50, 2, 5, 15)
      @mapbase = MapBase.new(50, 50, 2, 5, 15)
      @map.set_scroll_direction(1,1)
      @player = Player.new(10, 10, player_img, @map)
      @font = Font.new(28)
      @debug_box = RenderTarget.new(32, 32, C_YELLOW)
      @goalcharactor_img = Image.load("images/princes.png")
      @goalcharactor = Game::Goalcharactor.new(600,90,@goalcharactor_img,@map)
      Game::Goalcharactor.add(600, 90, @goalcharactor_img,@map)
    end

    # Scene遷移時に自動呼出しされる規約メソッド
    def reload
      @map.reload_map_array
    end

    # 1フレーム描画
    def play
      @debug_boxes = []

      if Input.key_push?(K_SPACE)
        #if @collision_bottom
          @player.start_jump
          #@dy += @jump_power
          #@player.update(Input.x)
        #end
      end

      @@check_count += 1
      puts @@check_count
      puts @@check_flag

      @map.update
      @map.draw
      @debug_boxes += @player.update(Input.x)
      @player.draw
      title_draw


      #@goalcharactor.update
      #@goalcharactor.draw
      #Sprite.check(@player,@goalcharactor)

      if DEBUG_MODE
        @debug_boxes.each do |pos|
          Window.draw(pos[0], pos[1], @debug_box)
        end
      end
        @dy = @player.scroll_y
        if @@check_flag == 0
          @map.set_scroll_direction(1,@player.scroll_y)
        else
          @map.set_scroll_direction(0,0)
        end

        if @@check_count > 1400 && @@check_flag == 0
          @@check_flag = 1
          @@check_goal = 0
        end

        if @@check_flag == 1
            @goalcharactor.draw
           Sprite.check(@player, @goalcharactor)
        end
    end

    def gameover?
      return @player.validate_player_pos_limit
    end

    private

    # タイトル文字列描画
    def title_draw
      Window.draw_font(50, 5, "Sample Game", @font)
    end
  end
end
