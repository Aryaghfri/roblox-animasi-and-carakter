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

- Set animasi dipilih dari `Humanoid.RigType` (R6 atau R15), karena game pakai avatar Player Choice.
- idle / walk / run dipilih dari kecepatan karakter, dengan threshold di `AnimationConfig`.
- Kecepatan putar walk/run/climb di-scale sesuai kecepatan gerak biar kaki nggak "ngepel".
- Animasi run baru kepake kalau `WalkSpeed` di atas `RunThreshold` (default 20), misalnya dari fitur sprint.

Ganti animasi: ubah asset ID di `AnimationConfig.Rigs.R6` / `AnimationConfig.Rigs.R15` (`src/shared/AnimationConfig.luau`). Animasi custom harus di-upload oleh akun/grup yang sama dengan pemilik game.

## Animasi NPC display

NPC (misalnya karakter yang dipajang di shop) dianimasikan oleh `src/server/init.server.luau`:

1. Pilih Model NPC di Studio, tambahkan tag `AnimatedNPC` (Properties > Tags).
2. Tambah attribute `AnimationId` bertipe **string**, isi dengan ID animasinya.
3. Play. Animasi diputar looping di server.

Model NPC-nya ada di file place, bukan di repo ini, jadi tag dan attribute di-set langsung di Studio.

Animasi harus dibuat untuk rig yang sama dengan NPC-nya (R6 atau R15), dan dimiliki oleh akun/grup pemilik game.

## Lint & format

```
stylua src
selene src
```
