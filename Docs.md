# Modal UI Library

A modern, customizable Roblox UI library with theming, notifications, and a full set of reusable components.

**Repository:** https://github.com/BloxCrypto/Modal/  
**Author:** Leviform

---

## Table of Contents

- [Installation](#installation)
- [Getting Started](#getting-started)
- [Window](#window)
- [Tabs](#tabs)
- [Components](#components)
  - [Title](#title)
  - [Button](#button)
  - [Input](#input)
  - [Toggle](#toggle)
  - [Slider](#slider)
  - [Keybind](#keybind)
  - [Dropdown](#dropdown)
  - [MultiDropdown](#multidropdown)
  - [ColorPicker](#colorpicker)
- [Notifications](#notifications)
- [Themes](#themes)
  - [Built-in Themes](#built-in-themes)
  - [Custom Themes](#custom-themes)
- [Utility Functions](#utility-functions)
- [Window Methods](#window-methods)
- [Example](#example)
- [License](#license)

---

## Installation

Load Modal directly from the latest GitHub release:

```lua
local Modal = loadstring(game:HttpGet("https://github.com/lxte/Modal/releases/latest/download/main.lua"))()
```

## Creating a Window

```lua
local Window = Modal:CreateWindow({
    Title = "Modal",
    SubTitle = "github.com/lxte/Modal",
    Size = UDim2.fromOffset(400, 400),
    MinimumSize = Vector2.new(250, 200),
    Transparency = 0,
    Icon = "rbxassetid://68073547",
})
```

| Option       | Type    | Description           |
| ------------ | ------- | --------------------- |
| Title        | string  | Window title          |
| SubTitle     | string  | Subtitle text         |
| Size         | UDim2   | Default window size   |
| MinimumSize  | Vector2 | Minimum resize size   |
| Transparency | number  | UI transparency (0–1) |
| Icon         | string  | Image asset id        |

## Tabs

```lua
local Tab = Window:AddTab("Components")
```

## Set Active Tab

```lua
Window:SetTab("Components")
```

## Components

Components are created using:

```lua
Tab:New("ComponentType")(Options)
```

## Title

```lua
Tab:New("Title")({
    Title = "Section Title"
})
```

## Button

```lua
Tab:New("Button")({
    Title = "Button",
    Description = "Click me",
    Callback = function()
        print("Clicked")
    end,
})
```

## Input

```lua
Tab:New("Input")({
    Title = "Input",
    Description = "Text input",
    DefaultText = "Hello",
    Placeholder = "Type here",
    Callback = function(Value)
        print(Value)
    end,
})
```

## Toggle

```lua
local Toggle
Toggle = Tab:New("Toggle")({
    Title = "Toggle",
    Description = "Enable feature",
    DefaultValue = true,
    Callback = function(Value)
        print(Value)
    end,
})
```
## Set Toggles

```lua
Toggle:SetTitle("Value Changed");
Toggle:SetDescription("New value is"));
```

## Keybind

```lua
Tab:New("Keybind")({
    Title = "Keybind",
    Description = "Bind a key",
    DefaultKeybind = "LeftControl",
    Callback = function(Key)
        print(Key)
    end,
})
```
Returns

* `Enum.KeyCode` for keyboard

* `Enum.UserInputType` for mouse

## Dropdown (Single)

```lua
Tab:New("Dropdown")({
    Title = "Dropdown",
    Options = { "Option 1", "Option 2" },
    Default = "Option 1",
    Callback = function(Value)
        print(Value)
    end,
})
```

## MultiDropdown

```lua
Tab:New("MultiDropdown")({
    Title = "Multi Dropdown",
    Options = { "A", "B", "C" },
    Default = { "B", "C" },
    Callback = function(Values)
        print(table.concat(Values, ", "))
    end,
})
```

## ColorPicker

```lua
Tab:New("ColorPicker")({
    Title = "Color Picker",
    Default = Color3.fromRGB(255, 114, 43),
    Callback = function(Color)
        print(Color)
    end,
})
```

## Notifications

```lua
Window:Notify({
    Title = "Notification",
    Description = "Hello world",
    Duration = 5,
    Type = "Info" -- Info, Success, Warning, Error
})
```

Themes

* Built-in Themes

```lua
Window:SetTheme("Light")
Window:SetTheme("Dark")
Window:SetTheme("Midnight")
Window:SetTheme("Rose")
Window:SetTheme("Emerald")
```

## Custom Theme

```lua
Window:SetTheme({
    Mode = "Dark",
    Accent = Color3.fromRGB(255, 170, 70),

    Background = {
        Rotation = 120,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(22,18,14)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10,8,6))
        })
    },

    Text = {
        Title = { Color = Color3.fromRGB(255,245,230) },
        Description = { Color = Color3.fromRGB(205,190,170) }
    }
})
```

> Sections with `Rotation` support `ColorSequence`
> Others only support `Color3`

## Window Methods

```lua
Window:SetTitle("Title")
Window:SetSubTitle("Subtitle")
Window:SetIcon("rbxassetid://0")
Window:SetTransparency(0.5)
Window:Destroy()
```

## Input Helper

```lua
if Modal:IsCorrectInput(Input, Keybind) then
    print("Triggered")
end
```
