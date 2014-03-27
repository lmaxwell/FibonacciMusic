public class Scale{
	
    int note[];
	
	fun void set(int p,string type)
	{
		if(type=="dorian")
			[p-2,p,p+2,p+3,p+5,p+7,p+9,p+10]@=>note;

          
	}	
}
