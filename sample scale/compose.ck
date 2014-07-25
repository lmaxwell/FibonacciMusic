SinOsc sin => Envelope env  => JCRev reverb=> Pan2 pan => dac;


0.8=>env.gain;

0.04=>reverb.mix;
Fibonacci fibonacci;
fibonacci.init();

Scale scale;

["ionian","dorian","phrygian","lydian","mixolydian","aeolian","locrian"] @=> string modes[];

0.1::second=>dur pulse;

scale.set(48,modes[3]);


Euclid pattern;
pattern.compute(16,13);

section1();
section1();

0=>int i;
while(1)
{
	scale.set(48,modes[3]);

	section();
	(i+1)%7=>i;
}




fun void section1()
{

	0 => int beat;
	while(beat<15)
	{		
		pattern.bitmap[beat] => sin.gain;
        fibonacci.genNext(scale.note.cap())=>int k;
		scale.note[k]+Math.random2(0,0)*12 => Std.mtof => sin.freq;
		env.value(1);
		env.target(0);
		pulse=>env.duration;
		pulse=>now;
		beat++;
	}
}

fun void section()
{

	0 => int beat;
	while(beat<15)
	{

		pattern.bitmap[beat] => sin.gain;
        fibonacci.genNext(scale.note.cap())=>int k;
		scale.note[k]+Math.random2(0,1)*12 => Std.mtof => sin.freq;	
		Math.random2f(-0.7,0.7)=>pan.pan;
		env.value(1);
		env.target(0);
		pulse=>env.duration;

		pulse=>now;
		beat++;
	}
}
