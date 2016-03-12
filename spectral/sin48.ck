
SinOsc sin[14];
Pan2 pan[14];
JCRev rev=>dac;
int i;
for(0=>i;i<14;i++)
{	
	sin[i]=>pan[i]=>rev;
}

0.3=>rev.mix;
int p,q,r;

110=> float f0;





section2();


fun void section2()
{
	
	for(0=>i;i<14;i++)
	{	
		0=>sin[i].gain;
	}

	440.=>f0;
	f0/48.=>float step;
	0=>p;
	1=>q;

	for(0=>i;i<14;i++)
	{
		p+q=>r;
		q=>p;
		r=>q;


		f0+r*step=>sin[i].freq;
		addComponent(1.0/14.0,i);
		-1.0+2.0/14.0*i=>pan[i].pan;
		<<<"component",i,pan[i].pan()>>>;
		0.1::second=>now;

	}
	now=>time last;
	while(now<last+130::second)
	{
		Math.random2(0,13)=>int j;
		Math.random2(0,3)=> int k;
		if(k==0)
		{
			rmComponent(j);
			<<<"remove">>>;
		}
		else if(k==1)
		{
			addComponent(1.0/13.0/j,j);
			<<<"add">>>;
			//Math.random2f(-1.0,1.0)=>pan[j].pan;
		}
		else if(k==2)
		{
			addComponent(1.0/13.0/j/j,j);
		//	Math.random2f(-1.0,1.0)=>pan[j].pan;
			<<<"add">>>;
		}
		else
		{
			Math.random2(0,13)=>int l;
			pan[j].pan()=>float temp;
			pan[l].pan()=>pan[j].pan;
			temp=>pan[l].pan;
			<<<"swap">>>;
		}
		Math.random2f(0.01,0.03)::second=>now;
	}
	for(0=>i;i<14;i++)
		rmComponent(i);
	<<<"over!">>>;
	/*
	for(0=>i;i<14;i++)
	{

		rmComponent(7-i);
			
		1::second=>now;
	}

	for(0=>i;i<14;i++)
	{
	

		addComponent(1.0/13.0/i,i);
		0.01::second=>now;

	}

	for(0=>i;i<14;i++)
	{

		rmComponent(7-i);
			
		1::second=>now;
	}
	
	for(0=>i;i<14;i++)
	{
	

		addComponent(1.0/13.0,i);
		0.01::second=>now;

	}

	for(0=>i;i<14;i++)
	{

		rmComponent(7-i);
			
		1::second=>now;
	}
	*/
	
		
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

