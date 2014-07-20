HevyMetl pad => Gain gain1 => Gain gainPad =>JCRev reverb => Pan2 pan => dac;


0.2=>gain1.gain;
1.0=>gainPad.gain;

0.04=>reverb.mix;
0.1::second=>dur pulse;
gainPad => Gain feedback => Delay eightdot => gainPad;
eightdot=> Gain gain2 => eightdot;
0.1=>gain2.gain;
0.7=>feedback.gain;
pulse*4=>eightdot.max;
pulse*4.0*3.0/4.0=>eightdot.delay;
Fibonacci fibonacci;
Scale scale;
fibonacci.init();
scale.set(48,"lydian");

spork ~ tunepan();
while(1)
{
	scale.note[fibonacci.genNext(scale.note.cap())]+Math.random2(2,3)*12=>Std.mtof=>pad.freq;
	1.0=>pad.noteOn;

	pulse=>now;
	pulse => now;
	1.0=>pad.noteOff;
	pulse*2=>now;
	
}

fun void tunepan()
{
	while(1)
	{
		Math.random2f(-1,1)=>pan.pan;
		pulse*4=>now;
	}
}
