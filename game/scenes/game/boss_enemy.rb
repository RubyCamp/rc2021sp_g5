module Game
    class Boss_enemy < Sprite
      @@collection = []
      @@weapon_check = 0
  
      def self.collection
        @@collection
      end
  
      def self.add(x, y, enemy_img)
        @@collection << self.new(x, y, enemy_img)
      end
  
      def initialize(x, y, img)
        self.x = x
        self.y = y
        self.image = img
        @enemy_img = img
        @enemy_img.set_color_key(C_WHITE) # 指定された画像のC_WHITE（白色）部分を透明化
        super(self.x,self.y,self.image)
        @x = x
        @y = y
      end
  
      def draw
        #Window.draw(@map.root_x + @x, @map.rooty +@y, @enemy_img, 1)
        Window.draw(self.x, self.y, @enemy_img,1)
      end
  
      def update
        #self.x += rand(5) - 3
        self.x = @x
        self.y = @y - 20  #rand(5) - 3
      end
  
      def hit(obj)

        @@weapon_check += 1
        if @@weapon_check == 100
            self.class.collection.delete(self)
        end
      end
    end
  end