module Gameover
    class Director  < DirectorBase

            # 初期化
        def initialize
            @gameover_img =  Image.load("images/gameover2.png")
            @font = Font.new(54)
        end
        
         # Sceneクラスから、move_toによるシーン切り替え時に自動的に呼び出されるメソッド
        def reload
        end
        

        # 1フレーム分の描画処理
        def play
            Window.draw(0,0,@gameover_img)

        end


        private
    
        # タイトル文字列描画
        def gameover_draw
            Window.draw_font(1024/2-12 ,768/2 , "Gameover\n press Z" ,@font)
        end
    end
end