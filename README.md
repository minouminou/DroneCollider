# DroneCollider

DroneCollider is a SuperCollider port of Native Instruments Reaktor Space Drone Instrument.
This instrument generates atmospheric pads which range from light rain or howling wind noises to deep and uncanny space sounds.
Technically, the instrument is based on parallel voices spread across the frequency spectrum.
Each voice consists of a noise generator; the signal's amplitude is shaped by an envelope, its frequency content gets modified by a bandpass filter, and finally it gets positioned in the stereo field.
Original NI Reaktor SpaceDrone Instrument: Martijn Zwartjes

## Controls

| Control | Description |
| ------- | ----------- |
| Attack | Sets the time that passes until the amplitude envelope reaches its peak after triggering. The [Density] knob controls speed at which the envelope is re-triggered. |
| Res | Sets the bandpass filter's resonance.|
| Density | Sets the speed at which each voice's amplitude envelope is re-triggered.|
| Pan | Sets the rate at which each voice is rotated within the stereo field.|
| Damp | Sets the amount of damping applied to high frequencies.|
| Decay | Sets the time that passes until the amplitude envelope completely fades out after it has reached its peak. The [Density] knob controls speed at which the envelope is re-triggered. |
| Fundamental | Adjusts the fundamental frequency, i. e. the pitch of the lowest voice. |
| Offset | Sets the offset of the filter harmonics: All voices are harmonics of the fundamental frequency (see [Fundamental]); all harmonics below the one adjusted here are skipped. |
| Pitch | Sets the amount by which the amplitude envelope modulates the voice's pitch, i. e. the bandpass filter's center frequency. Turn to the left for inverse modulation - the higher the envelope signal, the lower the pitch. Turn to the right for the opposite effect. |
| Speed | Controls the rate at which a LFO modulates each voice's frequency randomly. |
| Amt | Sets the amount by which the voice's frequency is changed by the random LFO. |
| Rnd | Sets the randomness of the re-triggering events. Turn to the left for completely regular re-triggering; turn to the right to give each voice a slightly varied re-triggering speed. |
| Rnd2 | Sets the randomness of the panning speed. At high values each voice has a slightly different pan rate. |
| Dynamic | Sets the dynamic range of the amplitude envelope. Turn to the left to bind every voice to a constant maximum level; turn to the right to allow some (randomly picked) voices to be quieter. |
| Gain | Sets the amount of amplification applied to each voice independently. |
