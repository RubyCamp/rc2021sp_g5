module Title
    class Director  < DirectorBase

            # 初期化
        def initialize
            @title_img =  Image.load("images/title.png")
            @font = Font.new(54)
        end
        
         # Sceneクラスから、move_toによるシーン切り替え時に自動的に呼び出されるメソッド
        def reload
        end

        # 1フレーム分の描画処理
        def play
            Window.draw(0,0,@title_img)

        end


        private
    
        # タイトル文字列描画
        def title_draw
            Window.draw_font(1024/2-12 ,768/2 , "TITLE\n press G" ,@font)
        end
    end
end