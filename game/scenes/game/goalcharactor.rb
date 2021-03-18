module Game 
    class Goalcharactor < Sprite
        @@collection = []

        def initialize(x, y, img , map)
            self.x = x
            self.y = y
            self.image = img
            super(self.x,self.y,self.image)
            @x = x
            @y = y
            @map = map
            @image = img
            @image.set_color_key(C_WHITE) # 指定された画像のC_WHITE（白色）部分を透明化
        end

        def self.collection
            @@collection 
        end

        def self.add(x, y, image ,map)
            @@collection << self.new(x, y, image,map)
          end

        def update
        end

        def draw
            Window.draw(@x, @y, @image)
            #Window.draw(@x, @y, @image)
        end

        def hit(obj)
            puts 11111
            Scene.move_to(:congrats)
        end
    end
end