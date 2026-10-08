--!strict
-- Load AnimationTrack sekali di awal, lalu crossfade antar animasi berdasarkan nama.
-- Bisa dipakai di client (karakter player) maupun server (NPC).

local AnimationController = {}
AnimationController.__index = AnimationController

type Fields = {
	_tracks: { [string]: AnimationTrack },
	_current: string?,
}

export type AnimationController = typeof(setmetatable({} :: Fields, AnimationController))

function AnimationController.new(animator: Animator, ids: { [string]: string }): AnimationController
	local tracks = {}
	for name, id in ids do
		local animation = Instance.new("Animation")
		animation.Name = name
		animation.AnimationId = id
		tracks[name] = animator:LoadAnimation(animation)
	end

	return setmetatable({
		_tracks = tracks,
		_current = nil,
	}, AnimationController)
end

-- Kalau animasi yang sama lagi jalan, cuma speed-nya yang di-update biar nggak restart.
function AnimationController.play(
	self: AnimationController,
	name: string,
	fadeTime: number?,
	speed: number?
)
	local track = self._tracks[name]
	if not track then
		warn(`[AnimationController] animasi "{name}" tidak ada di config`)
		return
	end

	if self._current == name and track.IsPlaying then
		track:AdjustSpeed(speed or 1)
		return
	end

	if self._current then
		self._tracks[self._current]:Stop(fadeTime)
	end
	track:Play(fadeTime, 1, speed or 1)
	self._current = name
end

function AnimationController.current(self: AnimationController): string?
	return self._current
end

function AnimationController.stopAll(self: AnimationController, fadeTime: number?)
	for _, track in self._tracks do
		track:Stop(fadeTime)
	end
	self._current = nil
end

function AnimationController.destroy(self: AnimationController)
	self:stopAll(0)
	for _, track in self._tracks do
		track:Destroy()
	end
	table.clear(self._tracks)
end

return AnimationController
