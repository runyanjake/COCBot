sleep 1000

if A_Args.Length() <> 1 {
	campSize := 100
} else {
	for n, campSiz in A_Args {
		campSize := campSiz 
	}
}

startLHSx := 850
startLHSy := 100
endLHSx := 150
endLHSy := 680
startRHSx := 850
startRHSy := 100
endRHSx := 1700
endRHSy := 680

halfCampSize := campSize / 2

rangeLHSx := endLHSx - startLHSx
rangeLHSy := endLHSy - startLHSy
rangeRHSx := endRHSx - startRHSx
rangeRHSy := endRHSy - startRHSy

clickCount := 0

itor := 0
cap := (campSize / 4) + 10
while itor < cap {
	if (Mod(itor, 2) == 1) {
		MouseClick, left, 300, 1000
	}else{
		MouseClick, left, 430, 1000
	}
	Random, rand, 0, 80
	xLHS := startLHSx + (rangeLHSx * (rand / 100))
	yLHS := startLHSy + (rangeLHSy * (rand / 100))
	xRHS := startRHSx + (rangeRHSx * (rand / 100))
	yRHS := startRHSy + (rangeRHSy * (rand / 100))
	xLHSdelt := (rangeLHSx * 0.05)
	yLHSdelt := (rangeLHSy * 0.05)
	xRHSdelt := (rangeRHSx * 0.05)
	yRHSdelt := (rangeRHSy * 0.05)
	itor2 := 0
	while itor2 < 4 {
		MouseClick, left, xLHS, yLHS
		MouseClick, left, xRHS, yRHS
		xLHS := xLHS + xLHSdelt
		yLHS := yLHS + yLHSdelt
		xRHS := xRHS + xRHSdelt
		yRHS := yRHS + yRHSdelt
		itor2 := itor2 + 1
	}
	itor := itor + 1
}
