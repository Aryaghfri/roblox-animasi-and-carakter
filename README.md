# roblox-animasi-and-carakter

Sistem animasi karakter Roblox yang dikelola pakai [Rojo](https://rojo.space), jadi source code-nya bisa di-version control dan diedit di luar Studio.

## Struktur

```
src/
  shared/      -> ReplicatedStorage.Shared
    AnimationConfig.luau      asset ID animasi + threshold kecepatan
    AnimationController.luau  load track, crossfade, adjust speed
  character/   -> StarterPlayer.StarterCharacterScripts
    Animate.client.luau       pengganti script Animate bawaan Roblox
  client/      -> StarterPlayer.StarterPlayerScripts.Client
  server/      -> ServerScriptService.Server
```

## Setup

1. Install [Rokit](https://github.com/rojo-rbx/rokit), lalu jalankan `rokit install` di root repo.
2. Install plugin Rojo di Roblox Studio.
3. Jalankan `rojo serve`, lalu klik **Connect** di plugin Rojo.

Build file place tanpa Studio: `rojo build -o game.rbxl`

## Cara kerja animasi

`Animate.client.luau` ditaruh di StarterCharacterScripts dengan nama `Animate`, sehingga otomatis menggantikan script animasi default Roblox. Script ini dengerin event `Humanoid` (`Running`, `Jumping`, `FreeFalling`, `Climbing`, `Died`) lalu manggil `AnimationController:play()`.

- idle / walk / run dipilih dari kecepatan karakter, dengan threshold di `AnimationConfig`.
- Kecepatan putar walk/run/climb di-scale sesuai kecepatan gerak biar kaki nggak "ngepel".
- Animasi run baru kepake kalau `WalkSpeed` di atas `RunThreshold` (default 20), misalnya dari fitur sprint.

Ganti animasi: ubah asset ID di `src/shared/AnimationConfig.luau`. Animasi custom harus di-upload oleh akun/grup yang sama dengan pemilik game.

## Lint & format

```
stylua src
selene src
```
