# マップエディタモジュール
module Game
  class Weapon < Sprite
    @@collection = []
    @weapon_checks = 0

    def initialize(x,y,img)
      @x_1 = x + 50
      @y_1 = y + 60
      @dx_1 = 0
      @dy_1 = 0
      @image1 = img
      self.x = @x_1 
      self.y = @y_1
      self.image = @image1 
      super(self.x,self.y,self.image)

    end

    def self.collection
      @@collection 
   end
   
   def self.add(x, y, image )
    @@collection << self.new(x, y, image)
    end

    def move
      @dx_1 = 3
      @x_1 += @dx_1
    end

    def draw
      Window.draw(@x_1, @y_1, @image1,1)
      #Window.draw(@map.root_x + @x, @map.root_y + @y, @image1,1)
      #p "weapon.y :#{@y_1}"
    end

    def update
      self.x = @x_1
      self.y = @y_1
    end

    
    def hit(obj)
      self.class.collection.delete(self)
      Enemy.weapon_re_check
    end

    def self.hits
      @@collection.delete(self.collection)
      Enemy.weapon_re_check
      puts 1
    end

  end
  # シーン管理用ディレクタークラス
  class Director < DirectorBase
    DEBUG_MODE = true
    @dx = 0
    @@check_flag = 0
    @@check_count = 0
    @@check_goal = 1

    # 初期化
    def initialize
      player_img =  Image.load("images/player1.png")
      @map = Map.new(50, 50, 2, 5, 15)
      @mapbase = MapBase.new(50, 50, 2, 5, 15)
      @map.set_scroll_direction(1,1)
      @player = Player.new(10, 10, player_img, @map)
      @font = Font.new(28)
      @debug_box = RenderTarget.new(32, 32, C_YELLOW)
      @weapons = []
      @enemys = []
      @enemy_img = Image.load("images/pose.png")
      @boss_enemy_img = Image.load("images/BOSS.png")
      #@enemy = Enemy.new(600,50,@enemy_img,@map)
      @goalcharactor_img = Image.load("images/princes.png")
      @goalcharactor = Game::Goalcharactor.new(750,289,@goalcharactor_img,@map)
      #Game::Goalcharactor.add(600, 90, @goalcharactor_img,@map)
      @sound1=Sound.new("ショット.wav")
    end

    # Scene遷移時に自動呼出しされる規約メソッド
    def reload
      @map.reload_map_array
    end

    # 1フレーム描画
    def play
      @debug_boxes = []

      if @@check_count % 80 == 0
        #@enemys << Enemy.new(480,70 ,@enemy_img,@map)
        if @@check_count < 200  && @@check_count > 50
          Enemy.add(600 , 365 ,@enemy_img)
        end
        if @@check_count > 225 && @@check_count < 400
          Enemy.add(800, 175 ,@enemy_img)
        end
      end

      
      Enemy.collection.each do |enemy|
        enemy.update
        enemy.draw

      #@enemy.update
      #@enemy.draw

      end

      if @@check_count ==  1200 
        Boss_enemy.add(700,340,@boss_enemy_img)
      end


      Boss_enemy.collection.each do |boss_enemy|
        boss_enemy.update
        boss_enemy.draw
        puts 2
      end

      if Input.key_push?(K_SPACE)
        @player.start_jump
      end

      if Input.key_push?(K_RETURN)
        Weapon.add(@player.x,@player.y, Image.new(20, 20).circle_fill(10, 10, 10, C_RED))
        #@weapons << Weapon.new(@player.x,@player.y, Image.new(20, 20).circle_fill(10, 10, 10, C_RED))
        @sound1.setVolume(230,time=0) 
        @sound1.play
        #p "player.y: #{@player.y}"
      end
      
      Weapon.collection.each do |weapon|
        weapon.update
        weapon.move
        weapon.draw
      end
      #@weapons.each do |weapon|
      #  weapon.move
      #  weapon.update
      #  Sprite.check( @enemys , @weapons)
      #  weapon.draw
      #end

      #p Sprite.check( @enemys , @weapons)

      @@check_count += 1
      puts @@check_count
      #puts @@check_flag

      @map.update
      @map.draw
      @debug_boxes += @player.update(Input.x)
      @player.draw
      #title_draw


      @goalcharactor.update
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

        if @@check_count > 1200 && @@check_flag == 0
          @@check_flag = 1
          @@check_goal = 0
        end

        if @@check_flag == 1
            @goalcharactor.draw
           Sprite.check(@player, @goalcharactor)
        end
        Sprite.check( Weapon.collection, Enemy.collection)
        Sprite.check(Weapon.collection, Boss_enemy.collection)
        if Enemy.weapon_check == 1
          Weapon.hits
        end
        gameover?
    end


    def gameover?
      #@enemys.each do |enemy|
      #  return true if enemy === @player 
      #end
      #if Sprite.check(@weapons,@enemys) == true
      #if Sprite.check(@player,@enemys) == true
      if Sprite.check(@player,Enemy.collection) == true ||  Sprite.check(@player,Boss_enemy.collection) == true
        Scene.move_to(:gameover)
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
