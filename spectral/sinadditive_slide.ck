


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
	1.0=>float ds;
	for(1=>i;i<26;i++)
	{
		p+q=>r;
		q=>p;
		r=>q;

		ds*1.1=>ds;
		r*f0*ds=>sin[i].freq;
		addComponent(1.0/26.0,i);
		-1.0+2.0/26.0*i=>pan[i].pan;
		<<<pan[i].pan()>>>;
		0.1::second=>now;

	}
	now=>time last;
	while(now<last+130::second)
	{
		Math.random2(0,25)=>int j;
		Math.random2(0,4)=> int k;
		if(k==0)
		{
			rmComponent(j);
			<<<"remove">>>;
		}
		else if(k==1)
		{
		//	addComponent(1.0/13.0/j,j);
		//	<<<"add1">>>;
			//Math.random2f(-1.0,1.0)=>pan[j].pan;
		}
		else if(k==2)
		{
			//addComponent(1.0/13.0/j/j,j);
		//	Math.random2f(-1.0,1.0)=>pan[j].pan;
			//<<<"add2">>>;
		}
		else if(k==3)
		{
			
			<<<"slide">>>;
			Math.random2(0,25)=>int l;
			float freqj,freql;
			sin[j].freq()=>freqj;
			sin[l].freq()=>freqj;
			Math.random2f(0.5,1)=>float dj;
			Math.random2f(0.5,1)=>float dl;
			spork ~slide(j,freql,dj);
			spork ~slide(l,freqj,dl);
		}

		else
		{
			Math.random2(0,25)=>int l;
			pan[j].pan()=>float temp;
			pan[l].pan()=>pan[j].pan;
			temp=>pan[l].pan;
			<<<"swap">>>;
		}
		Math.random2f(0.1,.3)::second=>now;
	}
	for(0=>i;i<26;i++)
		rmComponent(i);
	<<<"over!">>>;
	/*
	for(0=>i;i<26;i++)
	{

		rmComponent(25-i);
			
		1::second=>now;
	}

	for(0=>i;i<26;i++)
	{
	

		addComponent(1.0/13.0/i,i);
		0.01::second=>now;

	}

	for(0=>i;i<26;i++)
	{

		rmComponent(25-i);
			
		1::second=>now;
	}
	
	for(0=>i;i<26;i++)
	{
	

		addComponent(1.0/13.0,i);
		0.01::second=>now;

	}

	for(0=>i;i<26;i++)
	{

		rmComponent(25-i);
			
		1::second=>now;
	}
	*/
	
		
}


fun void slide(int i,float freqj,float d)
{
	now => time mark;
	sin[i].freq()=>float freqi;
	while(now < mark+d::second)
	{
		sin[i].freq()+(freqj-freqi)/100.0=>sin[i].freq;	
		d::second/100=>now;
	}

}

fun void rmComponent(int i)
{
	now => time mark;
	
	//0=>sin[i].gain;
	sin[i].gain()=>float gain;
	while(now < mark+0.1::second)
	{
		sin[i].gain()-gain/100.0=>sin[i].gain;	
		0.1::second/100=>now;
	}
}

fun void addComponent(float gain,int i)
{
	now=> time mark;

	while(now<mark+0.01::second)
	{
		sin[i].gain()+gain/1000.0 => sin[i].gain;
		0.01::second/1000=>now;
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
