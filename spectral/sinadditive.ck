SinOsc sin[26];
Pan2 pan[26];
JCRev rev=>dac;
int i;
for(0=>i;i<26;i++)
{	
	sin[i]=>pan[i]=>rev;
}

0.3=>rev.mix;
int p,q,r;

110=> float f0;

[48,50,51,53,55,56,58]@=> int scale[];




section2();


fun void section2()
{
	
	for(0=>i;i<26;i++)
	{	
		0=>sin[i].gain;
	}

	110=>f0;
	0=>p;
	1=>q;

	for(0=>i;i<26;i++)
	{
		p+q=>r;
		q=>p;
		r=>q;


		r*f0=>sin[i].freq;
		addComponent(1.0/26.0*0.25*Math.random2f(0.25,4.0),i);
		-1.0+2.0/26.0*i=>pan[i].pan;
		<<<pan[i].pan()>>>;
		1::second=>now;

	}
	
}


fun void addComponent(float gain,int i)
{
	now=> time mark;

	while(now<mark+1::second)
	{
		sin[i].gain()+gain/1000.0 => sin[i].gain;
		1::ms=>now;
	}
	
}

fun void section1(){
	while(true)
	{
		scale[Math.random2(0,6)]=>Std.mtof=> f0;
		0=>p;
		1=>q;
		for(0=>i;i<26;i++)
		{	
			0=>sin[i].gain;
		}

		for(0=>i;i<26;i++)
		{
			p+q=>r;
			q=>p;
			r=>q;
			r*f0=>sin[i].freq;
			1.0/26.0*Math.random2f(0.25,4.0)=>sin[i].gain;
			<<<r>>>;
		}
		1::second=>now;	
	}
}
