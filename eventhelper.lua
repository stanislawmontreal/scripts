local imgui = require 'imgui'
local sw, sh = getScreenResolution()
local fa = require 'fAwesome5'
local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
local fontsize = nil
local encoding = require 'encoding'
encoding.default = "CP1251"
u8 = encoding.UTF8


local dlstatus = require('moonloader').download_status
update_state = false

local script_vers = 2
local script_vers_text = "1.05"

local update_url = "https://raw.githubusercontent.com/makvinov/scripts/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://github.com/makvinov/scripts/raw/main/eventhelper.lua"
local script_path = thisScript().path 


local main_window_state = imgui.ImBool(false)
local menu = {true, 
    false,
    false,
    false,
    false,
    
}

nickList = {"zxcmarvel", "zxc_marvel", "Denzel_Richardson"}

local inicfg = require 'inicfg'
local mainini = inicfg.load({
    config =
    {
    mpname = 'n/a',
    mpreward = 'n/a',
    mpwinner = 'n/a',
    mpallgun = 'n/a',
    mpkolvohp = 'n/a',
    rvidachihp = 'n/a',
    mprfix = 'n/a',
    mpchelid = 'n/a',
    mpgunchel = 'n/a',
    mparmchel = 'n/a',
    }
}, "eventhelper")

--��������� ��
local mpname = imgui.ImBuffer(256)
local mpreward = imgui.ImBuffer(256)
local mpwinner = imgui.ImBuffer(256)
--������ ����-����
local mpallgun = imgui.ImBuffer(256)
local mpkolvohp = imgui.ImBuffer(256)
local rvidachihp = imgui.ImBuffer(256)
local mprfix = imgui.ImBuffer(256)
local mpchelid = imgui.ImBuffer(256)
local mpgunchel = imgui.ImBuffer(256)
local mparmchel = imgui.ImBuffer(256)



if not doesFileExist('moonloader/config/eventhelper.ini') then inicfg.save(mainini, 'eventhelper.ini') end

function main()
    sampRegisterChatCommand('ehelp', function() main_window_state.v = not main_window_state.v end)

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("���� ����������. ������: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)

    while true do wait(0)

        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("������ ������� �������!", -1)
                    thisScript():reload()
                end
            end)
            break
        end

        local myNick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
        for k, v in pairs(nickList) do
            if v == myNick then
                myNick = 123
                break
            end
        end
        if myNick ~= 123 then
            sampAddChatMessage('')
            sampAddChatMessage('')
            sampAddChatMessage('���� ��� �� ZXC������ ������� ����� ����� � eventHELPr �� �������', -1)
            sampAddChatMessage('')
            sampAddChatMessage('')
            thisScript():unload()
        end
        imgui.Process = main_window_state.v 
    end
end

function imgui.OnDrawFrame()
    if main_window_state.v then 
        imgui.SetNextWindowSize(imgui.ImVec2(700, 370), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(fa.ICON_USERS..u8' Event Helper', main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild("child", imgui.ImVec2(123, 335), true)
            --if imgui.Button(fa.ICON_COG..u8' ��������� ��', imgui.ImVec2(110, 18)) then uu() menu[1] = true end
            --if imgui.Button(fa.ICON_USER..u8' �������', imgui.ImVec2(110, 18)) then uu() menu[2] = true end
            --if imgui.Button(fa.ICON_STICKY_NOTE..u8' ID ���������', imgui.ImVec2(110, 18)) then uu() menu[3] = true end 
            --if imgui.Button(fa.ICON_MAP_MARKER_ALT..u8' ���������', imgui.ImVec2(110, 18)) then uu() menu[4] = true end --�������� ������ ��� 135, 20
            imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"�������").x) / 2)
            imgui.Text(u8'����')
            imgui.Separator()
            if imgui.Selectable(fa.ICON_BARS..u8 ' �������') then uu() menu [1] = true end --5
            if imgui.Selectable(fa.ICON_COG..u8' ��������� ��') then uu() menu[2] = true end --1
            if imgui.Selectable(fa.ICON_USER..u8' �������') then uu() menu[3] = true end --2 
            if imgui.Selectable(fa.ICON_STICKY_NOTE..u8' ID ���������') then uu() menu[4] = true end --3
            if imgui.Selectable(fa.ICON_MAP_MARKER_ALT..u8' ���������') then uu() menu[5] = true end --4
        imgui.EndChild()
        imgui.SameLine()
        if menu[1] then --5
            imgui.BeginChild('child5', imgui.ImVec2(557, 335), true)
            imgui.PushFont(fontsize)
            imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"ya daun").x) / 2)
            result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
                imgui.Text(u8'������,')
                imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(sampGetPlayerNickname(id)).x) / 2)
                imgui.Text(sampGetPlayerNickname(id))
            imgui.PopFont()
            imgui.EndChild()
        end

        if menu[2] then --1
            imgui.BeginChild('child1', imgui.ImVec2(557, 335), true)
            imgui.PushItemWidth(200.00)
            if imgui.InputText(u8'�������� ��. ������: ������', mpname) then
                mainini.config.mpname = u8:decode(mpname.v)
                inicfg.save(mainini, 'eventhelper.ini')
            end
            
            imgui.PushItemWidth(200.00)
            if imgui.InputText(u8'���� ��. ������: 10000$', mpreward) then
                mainini.config.mpreward = u8:decode(mpreward.v)
                inicfg.save(mainini, 'eventhelper.ini')
            end

            imgui.PushItemWidth(200.00)
            if imgui.InputText(u8'���������� ��. ������: Vasya Pupkin', mpwinner) then
                mainini.config.mpwinner = u8:decode(mpwinner.v)
                inicfg.save(mainini, 'eventhelper.ini')
            end
            
            imgui.Separator()
            imgui.Text(u8'�������� ��')
            imgui.Text(u8'����� ������� �� - ������� �� ��� ������ � ��������� 1-3 �������.')
            imgui.Text(u8'������ �������� �� ������������ � /esay:')
            imgui.Text(u8('1 ������: ��������� ������, ������ ����� ����������� ����������� "'..mainini.config.mpname..'".'))
            imgui.Text(u8('2 ������: ��� ������������ �� ����������� ����������� � /tp & /warp. ����: '..mainini.config.mpreward..'.'))
            imgui.Separator()
            imgui.Text(u8'�������� ��')
            imgui.Text(u8'������ �������� �� ������������ � /esay:')
            imgui.Text(u8('����������� ����������� "'..mainini.config.mpname..'" ���� - '..mainini.config.mpwinner.. ', �����������!'))
            imgui.Separator()

            --if imgui.Button(u8'��������� ���������', imgui.ImVec2(-0.1, 20)) then
                --mainini.config.mpname = u8:decode(mpname.v)
                --mainini.config.mpreward = u8:decode(mpreward.v)
                --mainini.config.mpwinner = u8:decode(mpwinner.v) 
                --inicfg.save(mainini, 'eventhelper.ini')
                --printStringNow('save!', 1500)
            --end

            if imgui.Button(u8'��������� ����', imgui.ImVec2(-0.1, 20)) then
                sampSendChat('/warpcp')
            end
            if imgui.Button(u8'��������� ������ ������ �������� �� � /esay', imgui.ImVec2(-0.1, 20)) then
                sampSendChat('��������� ������, ������ ����� ����������� ����������� "'..mainini.config.mpname..'".')
            end
            if imgui.Button(u8'��������� ������ ������ �������� �� � /esay', imgui.ImVec2(-0.1, 20)) then 
                sampSendChat('��� ������������ �� ����������� ����������� � /tp & /warp. ����: '..mainini.config.mpreward..'.')
            end
            if imgui.Button(u8'��������� ������ �������� �� � /esay', imgui.ImVec2(-0.1, 20)) then
                sampSendChat('����������� ����������� "'..mainini.config.mpname..'" ���� - '..mainini.config.mpwinner.. ', �����������!')
            end

            imgui.EndChild()
        end

        if menu[3] then --2
            imgui.BeginChild('child2', imgui.ImVec2(557, 335), true)

                if imgui.Button(u8'������ ��', imgui.ImVec2(120, 20)) then
                    sampSendChat('/hpall '..mainini.config.rvidachihp.. ' ' ..mainini.config.mpkolvohp) 
                end

                imgui.SameLine()
                imgui.Text(u8'� �������')
                imgui.SameLine()

                imgui.PushItemWidth(25.00)
                if imgui.InputText(u8'�', rvidachihp) then
                    mainini.config.rvidachihp = u8:decode(rvidachihp.v)
                    inicfg.save(mainini, 'eventhelper.ini')
                end

                imgui.SameLine()
                imgui.Text(u8'��')
                imgui.SameLine()
                imgui.PushItemWidth(25.00)
                if imgui.InputText(u8'�', mpkolvohp) then
                    mainini.config.mpkolvohp = u8:decode(mpkolvohp.v)
                    inicfg.save(mainini, 'eventhelper.ini')
                end

                if imgui.Button(u8'������ �����', imgui.ImVec2(120, 20)) then
                    sampSendChat('/fixr '..mainini.config.mprfix)
                end

                imgui.SameLine()
                imgui.Text(u8'� �������')
                imgui.SameLine()

                imgui.PushItemWidth(25.00)
                if imgui.InputText(u8'��', mprfix) then
                    mainini.config.mprfix = u8:decode(mprfix.v)
                    inicfg.save(mainini, 'eventhelper.ini')
                end
            
                if imgui.Button(u8'������ ���', imgui.ImVec2(120, 20)) then
                    sampSendChat('/allgun '..mainini.config.mpallgun) 
                end

                imgui.SameLine()
                imgui.Text(u8'���� � �����-���� � ID')
                imgui.SameLine()

                imgui.PushItemWidth(25.00)
                if imgui.InputText(u8'�', mpallgun) then
                    mainini.config.mpallgun = u8:decode(mpallgun.v)
                    inicfg.save(mainini, 'eventhelper.ini')
                end

                if imgui.Button(u8'������ ������', imgui.ImVec2(120, 20)) then
                    sampSendChat('/ggun '..mainini.config.mpchelid..' '..mainini.config.mpgunchel)
                end

                imgui.SameLine()
                imgui.Text(u8'������ �')
                imgui.SameLine()

                imgui.PushItemWidth(25.00)
                if imgui.InputText(u8'id', mpchelid) then
                    mainini.config.mpchelid = u8:decode(mpchelid.v)
                    inicfg.save(mainini, 'eventhelper.ini')
                end

                imgui.SameLine()
                imgui.Text(u8'������ � ID')
                imgui.SameLine()

                imgui.PushItemWidth(25.00)
                if imgui.InputText(u8'���', mpgunchel) then
                    mainini.config.mpgunchel = u8:decode(mpgunchel.v)
                    inicfg.save(mainini, 'eventhelper.ini')
                end

                if imgui.Button(u8'������ �����', imgui.ImVec2(120, 20)) then
                    sampSendChat('/armall')
                end
                imgui.SameLine()
                imgui.Text(u8'���� � �����-����')

                if imgui.Button(u8'������ ��������', imgui.ImVec2(120, 20)) then
                    sampSendChat('/garm '..mainini.config.mparmchel)
                end

                imgui.SameLine()
                imgui.Text(u8'������ �')
                imgui.SameLine()

                imgui.PushItemWidth(25.00)
                if imgui.InputText(u8'���', mparmchel) then
                    mainini.config.mparmchel = u8:decode(mparmchel.v)
                    inicfg.save(mainini, 'eventhelper.ini')
                end

                if imgui.Button(u8'��������� ���� � ������� 100', imgui.ImVec2(-0.1, 20)) then
                    sampSendChat('/frall 100')
                end

                if imgui.Button(u8'���������� ���� � ������� 100', imgui.ImVec2(-0.1, 20)) then
                    sampSendChat('/unfrall 100')
                end

                if imgui.Button(u8'������� ���� �� �����-����(/aworld)', imgui.ImVec2(-0.1, 20)) then
                    sampSendChat('/clearworld')
                end

            imgui.EndChild()
        end
        if menu[4] then --3
            imgui.BeginChild('child3', imgui.ImVec2(557, 335), true)
                imgui.Text(u8'������ - 1')
                imgui.SameLine()
                imgui.Text(u8'������ - 2')
                imgui.Text(u8'������� - 3')
                imgui.SameLine()
                imgui.Text(u8'��� - 4')
                imgui.Text(u8'���� - 5')
                imgui.SameLine()
                imgui.Text(u8'������ - 6')
                imgui.Text(u8'��� - 7')
                imgui.SameLine()
                imgui.Text(u8'������ - 8')
                imgui.Text(u8'��������� - 9')
                imgui.SameLine()
                imgui.Text(u8'����� - 10-13')
                imgui.Text(u8'����� ������ - 14')
                imgui.SameLine()
                imgui.Text(u8'������ - 15')
                imgui.Text(u8'������� - 16')
                imgui.SameLine()
                imgui.Text(u8'������� ������� - 17')
                imgui.Text(u8'�������� �������� - 18')
                imgui.SameLine()
                imgui.Text(u8'����� - 22')
                imgui.Text(u8'����� � ���������� - 23')
                imgui.SameLine()
                imgui.Text(u8'���� - 24')
                imgui.Text(u8'������ - 25')
                imgui.SameLine()
                imgui.Text(u8'����� - 26')
                imgui.Text(u8'������ ������ - 27')
                imgui.SameLine()
                imgui.Text(u8'��� - 28')
                imgui.Text(u8'��5 - 29')
                imgui.SameLine()
                imgui.Text(u8'����� - 30')
                imgui.Text(u8'�4 - 31')
                imgui.SameLine()
                imgui.Text(u8'���9 - 32')
                imgui.Text(u8'����� - 33')
                imgui.SameLine()
                imgui.Text(u8'������� ����� - 34')
                imgui.Text(u8'��� - 35')
                imgui.SameLine()
                imgui.Text(u8'��������������� ��� - 36')
                imgui.Text(u8'������ - 37')
                imgui.SameLine()
                imgui.Text(u8'������� - 38')
                imgui.Text(u8'����� � ������ - 39')
                imgui.SameLine()
                imgui.Text(u8'��������� ��� ����� - 40')
                imgui.Text(u8'�������� - 41')
                imgui.SameLine()
                imgui.Text(u8'������������ - 42')
                imgui.Text(u8'����������� - 43')
                imgui.SameLine()
                imgui.Text(u8'��� - 44')
                imgui.Text(u8'���������� - 45')
                imgui.SameLine()
                imgui.Text(u8'������� - 46')
            imgui.EndChild()
        end

        if menu[5] then --4
            imgui.BeginChild('child4', imgui.ImVec2(557, 335), true)

                if imgui.Button(u8'������', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 16')
                end
                imgui.SameLine()
                if imgui.Button(u8'�������� ���', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 42')
                end
                imgui.SameLine()
                if imgui.Button(u8'��������', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 36')
                end
                imgui.SameLine()
                if imgui.Button(u8'���� ����', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 17')
                end
                imgui.SameLine()
                if imgui.Button(u8'������', imgui.ImVec2(105, 20)) then
                    sampSendChat('/spliff')
                end
                if imgui.Button(u8'������ �����', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 42')
                end
                imgui.SameLine()
                if imgui.Button(u8'��� � ������.', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 22')
                end
                imgui.SameLine()
                if imgui.Button(u8'�����', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 41')
                end
                imgui.SameLine()
                if imgui.Button(u8'�������', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 5')
                end
                imgui.SameLine()
                if imgui.Button(u8'����� �� �����.', imgui.ImVec2(105, 20)) then
                    sampSendChat('/iwarp 99')
                end
                if imgui.Button(u8'�����', imgui.ImVec2(105, 20)) then
                    sampSendChat('/iwarp 108')
                end
                imgui.SameLine()
                if imgui.Button(u8'������� ���', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 19')
                end
                imgui.SameLine()
                if imgui.Button(u8'�����', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 14')
                end
                imgui.SameLine()
                if imgui.Button(u8'�����', imgui.ImVec2(105, 20)) then
                    sampSendChat('/awarp 18')
                end
                imgui.SameLine()
                if imgui.Button(u8'������', imgui.ImVec2(105, 20)) then
                    sampSendChat('/iwarp 3')
                end
                if imgui.Button(u8'�� �������', imgui.ImVec2(105,20)) then
                    sampSendChat('/iwarp 2')
                end
                imgui.SameLine()
                if imgui.Button(u8'�����. �����.', imgui.ImVec2(105,20)) then
                    sampSendChat('/iwarp 2')
                end
                imgui.SameLine()
                if imgui.Button(u8'�����. �������.', imgui.ImVec2(105,20)) then
                    sampSendChat('/iwarp 108')
                end
                imgui.SameLine()
                if imgui.Button(u8'��������� ���', imgui.ImVec2(105,20)) then
                    sampSendChat('ne rabotaet poka 4to')
                end
                imgui.SameLine()
                if imgui.Button(u8'�����', imgui.ImVec2(105,20)) then
                    sampSendChat('/island')
                end
            
            imgui.EndChild()
        end

        imgui.End()
    end
end

function uu()
    for i = 0,5 do
        menu[i] = false
    end
end

function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end

    if fontsize == nil then
        fontsize = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 30.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) -- ������ 30 ����� ������ ������
    end
end

function theme()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00); --(0.00, 0.88, 0.42, 0.89)
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end
theme()