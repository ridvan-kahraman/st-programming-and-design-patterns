FUNCTION FN_ADC : BOOL

(*
	This function converts an analog input value to a digital (BOOL) output based on a threshold level.
	"ActiveSide" allows reversing the output logic.
	
	Bu fonksiyon, analog giriş değerini belirlenen eşik seviyesine göre dijital (BOOL) çıktıya çevirir.
	"ActiveSide" değişkeni, çıkışı tersine çevirmek için kullanılır.
*)

VAR_INPUT
    i_AnalogInput		: WORD;				// Analog Input Value - Analog Giriş Değeri
    i_ActiveSide		: BOOL;				// Reverse Output Logic Control - Çıkışı Tersine Çevirme Kontrolü
	i_Threshold			: WORD;				// Digital Threshold Value - Dijital Eşik Değeri
END_VAR

VAR  
END_VAR



// If Analog Input Exceeds the Threshold TRUE otherwise FALSE - Analog Giriş Eşik Değerini Geçiyorsa TRUE, Geçmiyorsa FALSE
IF (i_AnalogInput > i_Threshold) THEN
    FN_ADC := TRUE;
ELSE
    FN_ADC := FALSE;
END_IF

// Adjust Output Based On ActiveSide Condition - ActiveSide Durumuna Göre Çıkışı Ayarla
IF (i_ActiveSide = FALSE) THEN
	FN_ADC := NOT FN_ADC;
END_IF