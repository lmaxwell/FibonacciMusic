public class Scale{
	
  static int note[];
	  
	fun void set(int p,string type)
	{
    if(type=="ionian")
      [p-1,p,p+2,p+4,p+5,p+7,p+9]@=>note;
		else if(type=="dorian")
			[p-2,p,p+2,p+3,p+5,p+7,p+8]@=>note;
    else if(type=="phrygian")
      [p-2,p,p+1,p+3,p+5,p+7,p+8]@=>note;
    else if(type=="lydian")
      [p-1,p,p+2,p+4,p+6,p+7,p+9]@=>note;
    else if(type=="mixolydian")
      [p-2,p,p+2,p+4,p+5,p+7,p+9]@=>note;
    else if(type=="aeolian")
      [p-2,p,p+2,p+3,p+5,p+7,p+8]@=>note;
    else if(type=="locrian")
      [p-2,p,p+1,p+3,p+5,p+7,p+8]@=>note;
    else
      [p-1,p,p+2,p+4,p+5,p+7,p+9]@=>note;
	}	
}
