---------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "did" ) then
        
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

else
    bg=display.newImageRect("game/res/bg/bg.png", 600, 400)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    bg=display.newImageRect("game/res/bg/city.png", 600, 400)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

end
local bg=display.newImageRect("game/res/bg/fade.png", 600, 350)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local bg=display.newImageRect("game/res/bg/koledzy.png", 600, 350)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

---fukc
-------------------------------------------------help=====
---tekst
local s = 0
local score=display.newText(s, display.contentCenterX, 150, native.systemFont, 30)
local path = system.pathForFile( "data.txt", system.DocumentsDirectory )
local file, errorString = io.open( path, "r" )
    if not file then
        print( "File error: " .. errorString )
    else
        for line in file:lines() do
            print( line )
            s = line
            score.text =(s)
        end
        io.close( file )
    end
local tekst=display.newText("Naciśnij aby zbierać mońki!",  display.contentCenterX, 100, native.systemFont, 30)

---kolor tekstu
if (time >= 7 and time <= 18) then
    tekst:setFillColor( 0, 0, 0 )
    score:setFillColor( 0, 0, 0 )
else
    tekst:setFillColor(265, 265, 265)
    score:setFillColor(265, 265, 265)
end

---wyświetlanie guziczka
local klikaczwhite = display.newImageRect("game/res/ui/whitewidget.png", 275, 110)
klikaczwhite.x = display.contentCenterX
klikaczwhite.y = 230

local function mainButtonListener( event )
    tekst.text = "Ilość mońków:"
    s = s+1
    print(s)
    score.text=(s)
    return true
end

---swap guziczków
local klikacz = widget.newButton(
    {
        width = 265,
        height = 100,
        defaultFile = "game/res/ui/button.png",
        overFile = "game/res/ui/buttonA.png",
        onPress = mainButtonListener,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } }
    }
)
klikacz.x = display.contentCenterX
klikacz.y = 230

------------------------------------------------------------------------------------------------
--ui
---setting funkcja

function settingListener( event )
    print("ustawienia w porzo")
    klikacz:setEnabled(false)
    system.vibrate()
----ściemnienie tła
    dark = display.newImageRect("game/res/bg/dark.png", 600, 400)
    dark.x = display.contentCenterX
    dark.y = display.contentCenterY
    dark.alpha = 0.95
---widget
    widget = display.newImageRect("game/res/ui/widget.png", 220, 120)
    widget.x = display.contentCenterX
    widget.y = 140
    widget.alpha = 0.8
    widgettext = display.newText("Zapis - Powrót - Reset",  display.contentCenterX, 120, native.systemFont, 20)
---guzik powrotu
    function tapBack( event )
        print("kill me")
        display.remove(dark)
        dark = nil
        display.remove(widget)
        display.remove(back)
        display.remove(save)
        display.remove(trash)
        display.remove(widgettext)
        system.vibrate()
--    ----nowy klikacz
        klikacz:setEnabled(true)
        return true
    end
---    guzik zapisu
    function tapSave( event )
        system.vibrate()
        saveData = s
        path = system.pathForFile( "data.txt", system.DocumentsDirectory )
        local file, errorString = io.open( path, "w" )
           if not file then
        --Error occurred; output the cause
                print( "File error: " .. errorString )
           else
        --Write data to file
                widgettext.text = ("Zapis się powiódł!")
                file:write( saveData )
                print("help me")
        --Close the file handle
                io.close( file )
           end
    end
file = nil
---guzik resetu
    function tapTrash( event )
        s = 0
        score.text = (s)
        local saveData = s
        local path = system.pathForFile( "data.txt", system.DocumentsDirectory )
        local file, errorString = io.open( path, "w" )
        if not file then
                print( "File error: " .. errorString )
        else
            file:write( saveData )
            io.close( file )
        end
---powrót do gry
        display.remove(dark)
        display.remove(widget)
        display.remove(back)
        display.remove(save)
        display.remove(trash)
        display.remove(widgettext)
        system.vibrate()
        tekst.text = ("Naciśnij aby zbierać mońki!")
---n    owy klikacz po resecie
        klikacz:setEnabled(true)
    end    
    back = widget.newButton(
        {
            width = 25,
            height = 25,
            defaultFile = "game/res/ui/arrow.png",
            overFile = "game/res/ui/arrow.png",
            onPress = tapBack,
        }
    )
    save = widget.newButton(
        {
            width = 25,
            height = 25,
            defaultFile = "game/res/ui/save.png",
            overFile = "game/res/ui/save.png",
            onPress = tapSave,
        }
    )
    trash = widget.newButton(
        {
            width = 25,
            height = 25,
            defaultFile = "game/res/ui/trash.png",
            overFile = "game/res/ui/trash.png",
            onPress = tapTrash,
        }
    )
---wyświetl strzałkę
    back.x = display.contentCenterX
    back.y = display.contentCenterY
---wyświetl zapis
    save.x = 175
    save.y = display.contentCenterY
---wyświetl kosz
    trash.x = 300
    trash.y = display.contentCenterY

end

setting_button = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "game/res/ui/cog.png",
        overFile = "game/res/ui/cog.png",
        onPress = settingListener,
    }
)


setting_button.x = -15
setting_button.y = 25

---wczytywanie save i inne głupoty
local function onSystemEvent( event )
    local eventType = event.type
---event na start
    if ( eventType == "applicationStart" ) then
        local path = system.pathForFile( "data.txt", system.DocumentsDirectory )
        local file, errorString = io.open( path, "r" )
        if not file then
            print( "File error: " .. errorString )
        else
            for line in file:lines() do
                print( line )
                s = line
                score.text =(s)
            end
            io.close( file )
        end
---event na wyjście
    elseif ( eventType == "applicationExit" ) then
        local saveData = s
        local path = system.pathForFile( "data.txt", system.DocumentsDirectory )
        local file, errorString = io.open( path, "w" )
        if not file then
    -- Error occurred; output the cause
            print( "File error: " .. errorString )
    else
            file:write( saveData )
            io.close( file )
    end
---event na zawieszenie
    elseif ( eventType == "applicationSuspend" ) then
        local saveData = s
        local path = system.pathForFile( "data.txt", system.DocumentsDirectory )
        local file, errorString = io.open( path, "w" )
        if not file then
    -- Error occurred; output the cause
            print( "File error: " .. errorString )
    else
            file:write( saveData )
            io.close( file )
    end
---event na wznowienie
    elseif ( eventType == "applicationResume" ) then
    local eventType = event.type
    if ( eventType == "applicationStart" ) then
        local path = system.pathForFile( "data.txt", system.DocumentsDirectory )
        local file, errorString = io.open( path, "r" )
        if not file then
            print( "File error: " .. errorString )
        else
            for line in file:lines() do
                print( line )
                s = line
                score.text =(s)
            end
            io.close( file )
        end
    end
end
end

Runtime:addEventListener( "system", onSystemEvent )
test_thingy = 0
---tabelka kupującego
local function tapEx( event )
    return true
end


local expand_button = display.newImageRect("game/res/ui/buttonright.png", 30, 100)
expand_button.x = -30
expand_button.y = display.contentCenterY
expand_button:addEventListener( "tap", tapEx )
expand_button.alpha = 0.8


local adventure_button = display.newImageRect("game/res/ui/buttonleft.png", 30, 100)
adventure_button.x = 510
adventure_button.y = display.contentCenterY
adventure_button:addEventListener( "tap", tapEx )
adventure_button.alpha = 0.8

---zega YEIIEWJUdiWJISOSOSDKjuh
tick = 0
--[[
local function bought()
    if test_thingy == 1 and tick % 10 == 0 then
        s = s+1
        score.text = (s)
    elseif test_thingy > 1 and math.floor(tick % (test_thingy/10)) == 0 then
        s = s + 1
        score.text = (s)
    end
end
--]]
local function ticking()
    tick = tick+1
    if tick == 1000 then
        tick = 0
    end
end
timer.performWithDelay(0.001, ticking, 0)
 
end
end

 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "show", scene )
-- -----------------------------------------------------------------------------------
 
return scene


