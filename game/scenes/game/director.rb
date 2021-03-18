# マップエディタモジュール
module Game
  class Weapon
    def initialize(x,y)
      @x_1 = x
      @y_1 = y
      @dx_1 = 0
      @dy_1 = 0
      @image1 = Image.new(20, 20).circle_fill(10, 10, 10, C_RED)

    end

    def move
      @dx_1 = 3
      @x_1 += @dx_1
    end

    def draw
      Window.draw(@x_1, @y_1, @image1,1)
    end

  end
  # シーン管理用ディレクタークラス
  class Director < DirectorBase
    DEBUG_MODE = true
    @dx = 0

    # 初期化
    def initialize
      player_img =  Image.load("images/player.png")
      @map = Map.new(50, 50, 2, 5, 15)
      @map.set_scroll_direction(1,1)
      @player = Player.new(10, 10, player_img, @map)
      @font = Font.new(28)
      @debug_box = RenderTarget.new(32, 32, C_YELLOW)
      @weapons = []
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

      if Input.key_push?(K_RETURN)
        @weapons << Weapon.new(@player.x,@player.y)
        p @player.y
      end
      
      @weapons.each do |weapon|
        weapon.move
        weapon.draw
      end

      @map.update
      @map.draw
      @debug_boxes += @player.update(Input.x)
      @player.draw
      title_draw

      if DEBUG_MODE
        @debug_boxes.each do |pos|
          Window.draw(pos[0], pos[1], @debug_box)
        end
      end
        @dy = @player.scroll_y
        if @player.scroll_x(Input.x) > 0
          @map.set_scroll_direction(1,@player.scroll_y)
        else
          @map.set_scroll_direction(1,@player.scroll_y)
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
