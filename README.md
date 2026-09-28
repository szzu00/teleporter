# Teleporter

Client-only teleport between an entrance and exit marker. Press **E** (`INPUT_CONTEXT`) near a marker to travel to the other point with a black screen fade.

**Author:** szzu00  
**Contact:** Discord `szzu00`

---

## Framework support

| ESX | QBCore | Other frameworks |
|-----|--------|------------------|
| Not required | Not required | Works standalone |

No framework dependency. Works on any FiveM server.

---

## Requirements

- [FiveM](https://fivem.net/)

---

## Installation

1. Put the `teleporter` folder into your server resources.
2. Add to `server.cfg`:
   ```cfg
   ensure teleporter
   ```
3. Set your coordinates in `backend/config.lua`.
4. Restart the resource / server.

---

## How it works

1. Two points are defined: `Config.Entrance` and `Config.Exit`.
2. Markers draw within `10.0` units.
3. Within `Config.InteractDistance`, a help prompt is shown.
4. On press:
   - `DoScreenFadeOut(500)`
   - teleport with `SetEntityCoords`
   - short wait (`300` ms)
   - `DoScreenFadeIn(500)`

Works both ways: Entrance → Exit and Exit → Entrance.

---

## Configuration (`backend/config.lua`)

```lua
Config.Entrance = vector3(221.3350, -789.3663, 30.7589)
Config.Exit = vector3(234.0559, -752.2104, 30.8256)

Config.MarkerType = 1
Config.MarkerColor = {r = 0, g = 150, b = 255, a = 150}
Config.MarkerScale = vector3(1.5, 1.5, 1.0)

Config.InteractDistance = 2.0
```

| Option | Description |
|--------|-------------|
| `Config.Entrance` / `Config.Exit` | World coordinates of both teleport points |
| `Config.MarkerType` | GTA marker type ID |
| `Config.MarkerColor` | RGBA color |
| `Config.MarkerScale` | Marker size |
| `Config.InteractDistance` | Distance required to show prompt / use |

---

## File structure

```
teleporter/
├── fxmanifest.lua
├── README.md
└── backend/
    ├── config.lua
    └── cl_main.lua
```

---

## Notes

- Provided as-is for use on your own FiveM server.
- Questions / support: Discord **szzu00**
