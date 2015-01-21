// oscChuck.ck
// a very basic example of communication from/to Processing

// OSC sender
OscSend xmit;
"localhost" => string hostname;
6450 => int sendport;
xmit.setHost( hostname, sendport );

// OSC receiver
OscRecv recv;
6449 => recv.port;

// listening to receiver port
recv.listen();
// expected event "/hello", tag type string
recv.event("/play,s i") @=> OscEvent @ evtPlay;
// concurrent shred
spork ~ listenHello();

0 => int cnt;  // a counter just for fun

// main loop
while( true )
{
    // send counter as float every 1 second
    xmit.startMsg( "/count", "f" );
    cnt++ => xmit.addFloat; 
    1::second => now;
}

// "/hello" listener
fun void listenHello()
{
	SinOsc s=>dac;
	48=>int base;
	[base,base+2,base+4,base+5,base+7,base+9,base+11] @=> int scale[];
    while(true) {
        evtPlay => now;
		<<<"pressed!">>>;
        // get message if any
        if ( evtPlay.nextMsg() != 0 )  
        { 
			evtPlay.getString();
            evtPlay.getInt() => int mesg;
            <<< "Mesg:", mesg >>>;
			if(mesg>0)
			{
				scale[(mesg-1)%7] => Std.mtof => s.freq;
				0.9=>s.gain;
			}
			if(mesg==-2) // key released
			{
				0=>s.gain;	
			}
        }
    }
}

