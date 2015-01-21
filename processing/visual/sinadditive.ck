
// OSC sender
OscSend xmit;
"localhost" => string hostname;
6450 => int sendport;
xmit.setHost( hostname, sendport );

10 => int num;

SinOsc sin[num];
Pan2 pan[num];
JCRev rev=>dac;
int i;
for(0=>i;i<num;i++)
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
	
	for(0=>i;i<num;i++)
	{	
		0=>sin[i].gain;
	}

	110=>f0;
	0=>p;
	1=>q;

	for(0=>i;i<num;i++)
	{
		p+q=>r;
		q=>p;
		r=>q;


		r*f0=>sin[i].freq;
		addComponent(1.0/num*0.25*Math.random2f(0.25,4.0),i);
		-1.0+2.0/num*i=>pan[i].pan;
		<<<pan[i].pan()>>>;
		3::second=>now;

	}
	
}


fun void addComponent(float gain,int i)
{
	now=> time mark;

	xmit.startMsg("/add","i");
	i=>xmit.addInt;

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
		for(0=>i;i<num;i++)
		{	
			0=>sin[i].gain;
		}

		for(0=>i;i<num;i++)
		{
			p+q=>r;
			q=>p;
			r=>q;
			r*f0=>sin[i].freq;
			1.0/num*Math.random2f(0.25,4.0)=>sin[i].gain;
			<<<r>>>;
		}
		1::second=>now;	
	}
}
