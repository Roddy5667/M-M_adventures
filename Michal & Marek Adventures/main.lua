---multitacz
local widget = require( "widget" )
local composer = require( "composer" )

---zdobycie czasu
time = (os.date("%H"))
local time = tonumber(time)
---graficzki
if (time >= 7 and time <= 18) then
    bg=display.newImageRect("game/res/bg/Day_bg.png", 600, 400)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    bg=display.newImageRect("game/res/bg/Day_city.png", 600, 400)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    bg=display.newImageRect("game/res/bg/Day_title.png", 500, 350)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
else
    bg=display.newImageRect("game/res/bg/bg.png", 600, 400)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    bg=display.newImageRect("game/res/bg/city.png", 600, 400)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    bg=display.newImageRect("game/res/bg/title.png", 500, 300)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
end
local bg=display.newImageRect("game/res/bg/fade.png", 600, 350)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local bg=display.newImageRect("game/res/bg/koledzy.png", 600, 350)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

print(time)

-- Function to handle button events
local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        system.vibrate()
        composer.gotoScene( "game", {effect = "fade", time = 400} )
    end
end
 
local function handleButtonOfStatystyki( event )
    if ( "ended" == event.phase ) then
        dark = display.newImageRect("game/res/bg/dark.png", 600, 400)
        dark.x = display.contentCenterX
        dark.y = display.contentCenterY
        dark.alpha = 0.95
        widget = display.newImageRect("game/res/ui/widget.png", 260, 100)
        widget.x = display.contentCenterX
        widget.y = 140
        widget.alpha = 0.8
        widgettext = display.newText("sorki jeszcze nie zrobiłem",  display.contentCenterX, 120, native.systemFont, 20)
---guzik powrotu
        local function tapBack( event )
            print("kill me")
            display.remove(dark)
            dark = nil
            display.remove(widget)
            display.remove(back)
            display.remove(widgettext)
            system.vibrate()
        end
        back = display.newImageRect("game/res/ui/arrow.png", 25, 25)
        back.x = display.contentCenterX
        back.y = display.contentCenterY
        back:addEventListener( "tap", tapBack )
end
end

local button1 = widget.newButton(
    {
        width = 120,
        height = 60,
        defaultFile = "game/res/ui/menubutton.png",
        overFile = "game/res/ui/menubuttonA.png",
        label = "button",
        onEvent = handleButtonEvent,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } }
    }
)
 
-- pozycja
button1.x = 160
button1.y = 220
 
-- Change the button's label text
button1:setLabel( "Graj!")

local button2 = widget.newButton(
    {
        width = 120,
        height = 60,
        defaultFile = "game/res/ui/menubutton.png",
        overFile = "game/res/ui/menubuttonA.png",
        label = "button",
        onEvent = handleButtonOfStatystyki,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } }
    }
)
 
-- pozycja
button2.x = 320
button2.y = 220
 
-- Change the button's label text
button2:setLabel( "Statystyki")
