FUNCTION_BLOCK FB_Debounce

(*
	This function block filters unstable digital input transitions using a debounce logic.
	If the input changes, a timer is activated, and the output updates only if the input remains stable for the debounce period.
	
	Bu fonksiyon bloğu, kararsız dijital giriş geçişlerini bir debounce mantığı ile filtreler.
	Giriş değiştiğinde bir zamanlayıcı başlatılır ve giriş belirlenen süre boyunca kararlı kalırsa çıkış güncellenir.
*)

VAR_INPUT
    i_InputToDebounce	: BOOL;	  					// Input Before Debounce - Filtreleme Öncesi Giriş
    i_DebounceTime		: INT;						// Debounce Time In Milliseconds - Filtreleme Süresi (Milisaniye)
    i_FB_Enable			: BOOL;						// Function Block Enable - Fonksiyon Bloğu Etkinleştirme
END_VAR

VAR_OUTPUT
    o_DebouncedInput	: BOOL;						// Debounced Input - Filtrelenmiş Giriş
END_VAR

VAR
    l_DebounceTimer		: TON;	  					// Timer for Debouncing - Filtreleme için Zamanlayıcı
    l_LastState			: BOOL;						// Last Stable State - Son Kararlı Durum
    l_IsInputChanged	: BOOL;						// Flag for Change in Input - Giriş Değişim Bayrağı
END_VAR



// Last Stable State - Son Kararlı Durum
l_LastState := i_InputToDebounce;

// Start Debouncing If Enable is Active - Enable Girişi Aktifse Filtreleme İşlemine Başla

IF (i_FB_Enable) THEN
	
	// Check If Input Changed - Giriş Değişti Mi Kontrol Et
    l_IsInputChanged := (i_InputToDebounce <> l_LastState);
	
	// Timer Initialization	- Zamanlayıcının Başlatılması
    l_DebounceTimer(IN := l_IsInputChanged, PT := INT_TO_TIME(i_DebounceTime));
	
    // Update the Output If Input is Stable - Giriş Kararlıysa Çıkışı Güncelle
    IF l_DebounceTimer.Q THEN
        o_DebouncedInput := i_InputToDebounce;
        l_LastState := i_InputToDebounce;
		
	// Do Not Update the Output If Input is Unstable - Giriş Kararsızsa Çıkışı Güncelleme
    ELSE
        o_DebouncedInput := l_LastState;
    END_IF
	
// Do Nothing If Enable is Inactive - Enable Girişi Aktif Değilse Hiçbir Şey Yapma
ELSE
    // No Operation - Hiçbir İşlem Yapma
END_IF