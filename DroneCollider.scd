(
s.waitForBoot({
  var voicesnum = 24; // number of voices

  // Knob controls (Polar Wind)
  var kAttack = 80;
  var kRes = 0.85;
  var kDensity = -72;
  var kPan = -96;
  var kDamp = 1.35;
  var kDecay = 80;
  var kFundamental = 36;
  var kOffset = 0;
  var kPitch = 0;
  var kSpeed = 2.5;
  var kAmt = 0.12;
  var kRnd = 24;
  var kRnd2 = -72;
  var kDynamic = 0.5;
  var kGain = 0.98;

  SynthDef(\DroneCollider,
    { |out, voiceid = 1|

      // Functions
      var p_to_f = {arg p; 2**(p/12+3.03135); };
      var f_to_p = {arg f; 12 * (log2(f)-3.03135); };

      // Output variables
      var sout1;
      var sout2;
      var sout3;
      var sout4;
      var sout;

      // Module variables
      var cntFreq;
      var geiger;
      var attackT;
      var decayT;
      var slowRandom;
      var filterP;
      var filterRes;
      var filterIn;
      var voiceConst;
      var slowRandom2;
      var panLFO;
      var soutStereo;

      // Init
      RandID.ir(id: voiceid);
      RandSeed.ir(1, voiceid);

      // Module 1
      sout1 = f_to_p.value((voiceid + kOffset) * p_to_f.value(kFundamental));

      // Module 2
      cntFreq = p_to_f.value(LocalIn.ar(1) + IRand(0-kRnd, kRnd) + kDensity);
      geiger = LFPulse.ar(freq: cntFreq, width: 0.5);
      LocalOut.ar(geiger);
      attackT = (10 ** (kAttack / 20)) / 1000 + 0.001; // [0..80] -> 0=1ms, 20=10ms, 40=100ms
      decayT = (10 ** (kDecay / 20)) / 1000 + 0.001; // [0..80] -> 0=1ms, 20=10ms, 40=100ms
      geiger = EnvGen.ar(Env.adsr(attackTime: attackT, decayTime: decayT, sustainLevel: 0, releaseTime: decayT, curve: \lin), gate: geiger);
      geiger = geiger ** 2;
      sout2 = geiger;

      // Module 3
      slowRandom = TRand.kr(0-kAmt, kAmt, Dust.kr(kSpeed));

      filterP = sout1 + (sout2 * kPitch) + slowRandom;
      filterP = p_to_f.value(filterP);
      filterRes = kRes ** 0.03125;
      filterIn = WhiteNoise.ar(mul: 1);
      sout3 = SVF.ar(filterIn, cutoff: filterP, res: filterRes, lowpass: 0, bandpass: 1, highpass: 0);

      // Module 4
      voiceConst = 0;
      for (1, voicesnum, { arg i; voiceConst = voiceConst + ((1 / (i + kOffset)) ** kDamp) });
      sout4 = (((1 / (voiceid + kOffset)) ** kDamp) / ( voiceConst )) * (kGain**3);

      // Module 5
      sout = sout3 * sout2 * sout4;

      // Module 6
      slowRandom2 = TRand.kr(0-p_to_f.value(kRnd2), p_to_f.value(kRnd2), Dust.kr(p_to_f.value(kRnd2)));
      panLFO = LFTri.ar(freq: p_to_f.value(kPan) + slowRandom2);
      soutStereo = Pan2.ar(sout, panLFO);

      Out.ar(out, soutStereo);
  }).add;

  (
    fork {
      (1..voicesnum).do { |voiceid|
        Synth(\DroneCollider, [\voiceid, voiceid]);
      }
    }
  );

});
)