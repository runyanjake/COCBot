sleep 1000

if A_Args.Length() <> 1 {
	campSize := 100
} else {
	for n, campSiz in A_Args {
		campSize := campSiz 
	}
}

missClickThresh := 10

MouseClick, left, 90, 750

sleep 500

MouseClick, left, 600, 90

itor := 0
cap := campSize + missClickThresh
while itor < cap {
	if(Mod(itor, 2) == 1){
		MouseClick, left, 200, 700
	}else{
		MouseClick, left, 200, 900
	}
	itor := itor + 1
}

MouseClick, left, 1800, 80

sleep 100