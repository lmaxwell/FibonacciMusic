SinOsc sin => dac;


Fibonacci fibonacci;
fibonacci.init();

Scale scale;

["ionian","dorian","phrygian","lydian","mixolydian","aeolian","locrian"] @=> string modes[];

0=>int i;
while(1)
{
	scale.set(48,modes[i]);

	section();
	(i+1)%7=>i;
}




fun void section()
{

	0 => int beat;
	while(beat<5)
	{
        fibonacci.genNext(scale.note.cap())=>int k;
		scale.note[k]+Math.random2(0,0)*12 => Std.mtof => sin.freq;	
		0.25::second=>now;
		beat++;
	}
}
