# マップエディタモジュール
module Game
  class Weapon
    def initialize(x,y)
      @x_1 = x + 50
      @y_1 = y + 60
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
      #p "weapon.y :#{@y_1}"
    end

  end
  # シーン管理用ディレクタークラス
  class Director < DirectorBase
    DEBUG_MODE = true
    @dx = 0
    @@check_flag = 0
    @@check_count = 0

    # 初期化
    def initialize
      player_img =  Image.load("images/player.png")
      @map = Map.new(50, 50, 2, 5, 15)
      @mapbase = MapBase.new(50, 50, 2, 5, 15)
      @map.set_scroll_direction(1,1)
      @player = Player.new(10, 10, player_img, @map)
      @font = Font.new(28)
      @debug_box = RenderTarget.new(32, 32, C_YELLOW)
      @weapons = []
      @enemys = []
      @goalcharactor_img = Image.new(64,64,C_RED)
      @goalcharactor = Game::Goalcharactor.new(100,100,@goalcharactor_img,@map)
      Game::Goalcharactor.add(100, 100, @goalcharactor_img,@map)
    end

    # Scene遷移時に自動呼出しされる規約メソッド
    def reload
      @map.reload_map_array
    end

    # 1フレーム描画
    def play
      @debug_boxes = []

      if Input.key_push?(K_A)
        @enemys << Enemy.new(@player.x, @player.y)
      end

      @enemys.each do |enemy|
        enemy.update
        enemy.draw
      end

      if Input.key_push?(K_SPACE)
        @player.start_jump
      end

      if Input.key_push?(K_RETURN)
        @weapons << Weapon.new(@player.x,@player.y)
        #p "player.y: #{@player.y}"
      end
      
      @weapons.each do |weapon|
        weapon.move
        weapon.draw
      end

      @@check_count += 1
      puts @@check_count
      puts @@check_flag

      @map.update
      @map.draw
      @debug_boxes += @player.update(Input.x)
      @player.draw
      title_draw


      Goalcharactor.collection.each do |goalcharactor|
        goalcharactor.update
        goalcharactor.draw
      end
      Sprite.check(@py,@pg)


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

        if @@check_count > 1200 && @@check_flag == 0
          @@check_flag = 1
        end

        if @check_flaf == 1
        #  @goalcharactor.update
        #  @goalcharactor.draw
        #  Sprite.check(@player, @goalcharactor)
        end
    end


    def gameover?
      @enemys.each do |enemy|
        return true if enemy === @player 
      end
      return @player.gameover? 
    end

  

    private

    # タイトル文字列描画
    def title_draw
      Window.draw_font(50, 5, "Sample Game", @font)
    end
  end
end
