public class Fibonacci{
	
	int i;
	int j;
	int k;
	fun void init()
	{
		0=>i;
		0=>j;
		1=>k;
	}
	fun void reset()
	{
		init();
	}

	fun int genNext(int len)
	{
		j=>i;
		k=>j;
 		(i+j)%len=>k;
		return k;	
	}
}
