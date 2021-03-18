module Game
 class Boss_weapon < Sprite
    @@collection = []

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
       Window.draw(self.x, self.y + 20, @enemy_img,1)
     end
 
     def update
       self.x += rand(5) - 3
       #self.x = @x
       self.y = @y -20  #rand(5) - 3
     end
 
     def self.weapon_check
       return @@weapon_check
     end
 
     def self.weapon_re_check
       @@weapon_check = 0
     end
 
     def hit(obj)
       self.class.collection.delete(self)
       @@weapon_check = 1
     end
   end
 end