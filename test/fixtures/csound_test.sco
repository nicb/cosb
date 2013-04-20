;
; $Id: csound_test.sco 16 2013-04-19 20:43:38Z nicb $
;
f1 0 4096 10 1
;
; test score: this score exercises each channel separately
;
i1  1.0    0.2   -12
;i2  1.2    0.2   -12
;i3  1.4    0.2   -12
;i4  1.6    0.2   -12
;i5  1.8    0.2   -12
;i6  2.0    0.2   -12
;i7  2.2    0.2   -12
;i8  2.4    0.2   -12
;i9  2.6    0.2   -12

;
; point-source rooms 
;
i1301  0    3    0   -90
; i1302  0    3    0   -90
; i1303  0    3    0   -90
; i1304  0    3    0   -90
; i1305  0    3    0   -90
; i1306  0    3    0   -90
; i1307  0    3    0   -90
; i1308  0    3    0   -90
; i1309  0    3    0   -90

;
; reverberation (should not be present)
;
i5000 0    3

;
; space location (coinciding with speaker positions)
;
i301  0    0.300   0  -10.0   0    20.5
i302  0    0.300   0   10.0   0    20.5
i303  0    0.300   0  -11.5   0     8.5
i304  0    0.300   0   11.5   0     8.5
i305  0    0.300   0  -11.5   0    -8.5
i306  0    0.300   0   11.5   0    -8.5
i307  0    0.300   0  -10.0   0   -18.5
i308  0    0.300   0   10.0   0   -18.5
i309  0    0.300   0    0     0    20.5
