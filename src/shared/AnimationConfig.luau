--!strict
-- Data animasi karakter. Ganti asset ID di sini kalau mau pakai animasi custom.
-- Default-nya pakai animasi R15 bawaan Roblox.

local AnimationConfig = {}

AnimationConfig.Locomotion = {
	idle = "rbxassetid://507766666",
	walk = "rbxassetid://507777826",
	run = "rbxassetid://507767714",
	jump = "rbxassetid://507765000",
	fall = "rbxassetid://507767968",
	climb = "rbxassetid://507765644",
}

-- Kecepatan (stud/detik) saat animasi diputar dengan speed 1.
AnimationConfig.BaseSpeed = {
	walk = 16,
	run = 24,
	climb = 8,
}

-- Di bawah IdleThreshold dianggap diam, di atas RunThreshold pindah ke animasi run.
AnimationConfig.IdleThreshold = 0.5
AnimationConfig.RunThreshold = 20

AnimationConfig.FadeTime = 0.2

return AnimationConfig
