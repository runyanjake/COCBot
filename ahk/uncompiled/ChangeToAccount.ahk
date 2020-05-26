sleep 3000

if A_Args.Length() <> 1 {
	acctNum := 1
} else {
	for n, acctNr in A_Args {
		acctNum := acctNr 
	}
}

MouseClick, left, 1815, 750

sleep 1500

MouseClick, left, 1245, 200

sleep 3000

baseX := 1440
baseY := 560
deltY := 115

actualX := baseX
actualY := baseY + (deltY * (acctNum - 1)) 

MouseClick, left, actualX, actualY

sleep 10000

MouseClick, left, 960, 990

sleep 1000