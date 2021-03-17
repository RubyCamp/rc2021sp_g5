module Congrats
    class Director  < DirectorBase

            # 初期化
        def initialize
           @congrats_img =  Image.load("images/congrats.png")
           @font = Font.new(54)
        end
        
         # Sceneクラスから、move_toによるシーン切り替え時に自動的に呼び出されるメソッド
        def reload
        end

        # 1フレーム分の描画処理
        def play
            Window.draw(0,0,@congrats_img)

        end


    end
end