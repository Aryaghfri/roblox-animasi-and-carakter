--!strict
-- Data animasi karakter per rig type. Ganti asset ID di sini kalau mau pakai animasi custom.
-- Default-nya pakai animasi bawaan Roblox.

export type RigConfig = {
	ids: { [string]: string },
	-- Kecepatan (stud/detik) saat animasi diputar dengan speed 1.
	baseSpeed: { walk: number, run: number, climb: number },
}

local AnimationConfig = {}

AnimationConfig.Rigs = {
	R15 = {
		ids = {
			idle = "rbxassetid://507766666",
			walk = "rbxassetid://507777826",
			run = "rbxassetid://507767714",
			jump = "rbxassetid://507765000",
			fall = "rbxassetid://507767968",
			climb = "rbxassetid://507765644",
		},
		baseSpeed = { walk = 16, run = 24, climb = 8 },
	},
	-- R6 bawaan nggak punya animasi run terpisah, jadi run pakai animasi walk yang dipercepat.
	R6 = {
		ids = {
			idle = "rbxassetid://180435571",
			walk = "rbxassetid://180426354",
			run = "rbxassetid://180426354",
			jump = "rbxassetid://125750702",
			fall = "rbxassetid://180436148",
			climb = "rbxassetid://180436334",
		},
		baseSpeed = { walk = 16, run = 16, climb = 8 },
	},
} :: { [string]: RigConfig }

-- Di bawah IdleThreshold dianggap diam, di atas RunThreshold pindah ke animasi run.
AnimationConfig.IdleThreshold = 0.5
AnimationConfig.RunThreshold = 20

AnimationConfig.FadeTime = 0.2

return AnimationConfig
