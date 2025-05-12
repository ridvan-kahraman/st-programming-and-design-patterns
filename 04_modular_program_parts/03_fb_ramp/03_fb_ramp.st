FUNCTION_BLOCK FB_Ramp

(*
	Smoothly limits changes between current and target using min/max ramp.
	Rampa fonksiyon bloğu mevcut ile hedef arasındaki değişimi min/max rampa ile yumuşatır.
*)

VAR_INPUT
	i_Target	: REAL;		// Target Value – Hedef Değer
	i_RampUp	: REAL;		// Increase Ramp – Artış Rampası
	i_RampDown	: REAL;		// Decrease Ramp – Azalış Rampası
END_VAR

VAR_OUTPUT
	o_Value		: REAL;		// Ramp Output – Rampa Çıktısı
END_VAR

VAR
	l_Diff      : REAL;		// Difference – Fark
	l_Step      : REAL;		// Step to Apply – Uygulanacak Adım
END_VAR



// Directional Ramp Calculation – Yönlü Rampa Hesaplaması
IF i_Target > o_Value THEN
	
	l_Diff := i_Target - o_Value;
	
    // Limits the RampUp Value - RampUp Değerini Sınırlar
	IF i_RampUp < l_Diff THEN
		l_Step := i_RampUp;
	ELSE
		l_Step := l_Diff;
	END_IF
	
    // Converges the Target Value - İstenen Değere Yaklaşır
	o_Value := o_Value + l_Step;
	
ELSIF o_Value > i_Target THEN
	
	l_Diff := o_Value - i_Target;
	

    // Limits the RampDown Value - RampDown Değerini Sınırlar
	IF i_RampDown < l_Diff THEN
		l_Step := i_RampDown;
	ELSE
		l_Step := l_Diff;
	END_IF

	// Converges the Target Value - İstenen Değere Yaklaşır
	o_Value := o_Value - l_Step;
	
ELSE
	// Reached the Target Value - İstene Değere Ulaşıldı
	o_Value := i_Target;
END_IF