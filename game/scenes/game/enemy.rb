module Game
  class Enemy < Sprite
    @@collection = []

    def self.collection
      @@collection
    end

    def self.add(x, y, enemy_img)
      @@collection << self.new(x, y, enemy_img)
    end

    def initialize(x, y)
      #font = Font.new(24)
      @enemy_img = Image.load("images/pose.png")
      #enemy_img.draw_font(16, 16, "敵", font, C_WHITE)
      self.x, self.y = x + 300, y
    end

    def draw
      Window.draw(self.x, self.y, @enemy_img, 1)
    end

    def update
      self.x += rand(5) - 3
      #self.y += rand(5) - 3
    end

    def hit(obj)
      self.class.collection.delete(self)
    end
  end
end