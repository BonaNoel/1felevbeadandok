(deffacts init
    (konyv nap hetfo cim unknown1 szerkeszto unknown2 ar unknown3)
    (konyv nap kedd cim unknown4 szerkeszto unknown5 ar unknown6)
    (konyv nap szerda cim unknown7 szerkeszto unknown8 ar unknown9)
    (konyv nap csutortok cim unknown10 szerkeszto unknown11 ar unknown12)
    (konyv nap pentek cim unknown13 szerkeszto unknown14 ar unknown15)

	(cimek csengo dobostorta maranyfejek tulmindenen zenebona)
	(szerkesztok abafibea dalosrezso gemesimre joszkinede paloskata)
	(arak 1500 1700 2000 2200 2350)
)

(defrule solve
	?k1 <- (konyv nap hetfo cim ?c1 szerkeszto ?s1 ar ?a1)
	?k2 <- (konyv nap kedd cim ?c2 szerkeszto ?s2 ar ?a2)
	?k3 <- (konyv nap szerda cim ?c3 szerkeszto ?s3 ar ?a3)
	?k4 <- (konyv nap csutortok cim ?c4 szerkeszto ?s4 ar ?a4)
	?k5 <- (konyv nap pentek cim ?c5 szerkeszto ?s5 ar ?a5)
    
    ;1. Sem a hétfőn boltokba került könyvet, sem a Csengő című önéletrajzot nem női szerkesztő dolgozta át. DONE
    ; hetfoi konyv -> nem abafibea es nem paloskata
    (test (and (neq ?s1 abafibea) (neq ?s1 paloskata)))

    ; csengo konyv -> nem abafibea es nem paloskata (c4 biztos nem csengo 4.)
    (test (or 
        (and (eq ?c1 csengo) (neq ?s1 abafibea) (neq ?s1 paloskata))
        (and (eq ?c2 csengo) (neq ?s2 abafibea) (neq ?s2 paloskata))
        (and (eq ?c3 csengo) (neq ?s3 abafibea) (neq ?s3 paloskata))
        (and (eq ?c5 csengo) (neq ?s5 abafibea) (neq ?s5 paloskata))
    ))    

    ;2. Mind a két előbb említett mű kevesebbe kerül, mint az Abafi Bea által átszerkesztett könyv, ami egy nappal a Joszkin Ede keze munkáját dícsérő kiadvány előtt jelent meg. DONE
    ; hetfoi konyv -> ar < abafibea konyv
    (test (or 
        (and (eq ?s2 abafibea) (< ?a1 ?a2))
        (and (eq ?s3 abafibea) (< ?a1 ?a3))
        (and (eq ?s4 abafibea) (< ?a1 ?a4))
        (and (eq ?s5 abafibea) (< ?a1 ?a5))
    ))

    ; csengo konyv -> ar < abafibea konyv
    (test (or 
        (and (eq ?c1 csengo) (eq ?s2 abafibea) (< ?a1 ?a2))
        (and (eq ?c1 csengo) (eq ?s3 abafibea) (< ?a1 ?a3))
        (and (eq ?c1 csengo) (eq ?s4 abafibea) (< ?a1 ?a4))
        (and (eq ?c1 csengo) (eq ?s5 abafibea) (< ?a1 ?a5))

        (and (eq ?c2 csengo) (eq ?s1 abafibea) (< ?a2 ?a1))
        (and (eq ?c2 csengo) (eq ?s3 abafibea) (< ?a2 ?a3))
        (and (eq ?c2 csengo) (eq ?s4 abafibea) (< ?a2 ?a4))
        (and (eq ?c2 csengo) (eq ?s5 abafibea) (< ?a2 ?a5))

        (and (eq ?c3 csengo) (eq ?s1 abafibea) (< ?a3 ?a1))
        (and (eq ?c3 csengo) (eq ?s2 abafibea) (< ?a3 ?a2))
        (and (eq ?c3 csengo) (eq ?s4 abafibea) (< ?a3 ?a4))
        (and (eq ?c3 csengo) (eq ?s5 abafibea) (< ?a3 ?a5))

        (and (eq ?c5 csengo) (eq ?s1 abafibea) (< ?a5 ?a1))
        (and (eq ?c5 csengo) (eq ?s2 abafibea) (< ?a5 ?a2))
        (and (eq ?c5 csengo) (eq ?s3 abafibea) (< ?a5 ?a3))
        (and (eq ?c5 csengo) (eq ?s4 abafibea) (< ?a5 ?a4))
    ))

    ;abafi bea konyv -> nap = 1 - joszkinede konyv
    (test (or 
        (and (eq ?s1 abafibea) (eq ?s2 joszkinede))
        (and (eq ?s2 abafibea) (eq ?s3 joszkinede))
        (and (eq ?s3 abafibea) (eq ?s4 joszkinede))
        (and (eq ?s4 abafibea) (eq ?s5 joszkinede))  
    ))

    ;3. A Túl Mindenen drágább, mint a Dalos Rezső szerkesztése. DONE
    ; tulmindenen konyv ara > dalosrezso konyv ara (osszes parositasba, esetleg valahogy szebben?)
    (test (or
        (and (eq ?c1 tulmindenen) (eq ?s2 dalosrezso) (> ?a1 ?a2))
        (and (eq ?c1 tulmindenen) (eq ?s3 dalosrezso) (> ?a1 ?a3))
        (and (eq ?c1 tulmindenen) (eq ?s4 dalosrezso) (> ?a1 ?a4))
        (and (eq ?c1 tulmindenen) (eq ?s5 dalosrezso) (> ?a1 ?a5))

        (and (eq ?c2 tulmindenen) (eq ?s1 dalosrezso) (> ?a2 ?a1))
        (and (eq ?c2 tulmindenen) (eq ?s3 dalosrezso) (> ?a2 ?a3))
        (and (eq ?c2 tulmindenen) (eq ?s4 dalosrezso) (> ?a2 ?a4))
        (and (eq ?c2 tulmindenen) (eq ?s5 dalosrezso) (> ?a2 ?a5))

        (and (eq ?c3 tulmindenen) (eq ?s1 dalosrezso) (> ?a3 ?a1))
        (and (eq ?c3 tulmindenen) (eq ?s2 dalosrezso) (> ?a3 ?a2))
        (and (eq ?c3 tulmindenen) (eq ?s4 dalosrezso) (> ?a3 ?a4))
        (and (eq ?c3 tulmindenen) (eq ?s5 dalosrezso) (> ?a3 ?a5))

        (and (eq ?c5 tulmindenen) (eq ?s1 dalosrezso) (> ?a5 ?a1))
        (and (eq ?c5 tulmindenen) (eq ?s2 dalosrezso) (> ?a5 ?a2))
        (and (eq ?c5 tulmindenen) (eq ?s3 dalosrezso) (> ?a5 ?a3))
        (and (eq ?c5 tulmindenen) (eq ?s4 dalosrezso) (> ?a5 ?a4))
    ))

    ;4. A Márányfejek-et csütörtök óta lehet kapni. DONE
    ; csutortok konyv -> maranyfejek konyv
    (test (eq ?c4 maranyfejek))

    ;5. Az 1700 forintos önéletrajzot Pálos Kata öntötte vésgő formába; ez a mű a már a Márányfejek előtt a boltokban volt. DONE
    ; 1700 forintos konyv -> paloskata konyv es hetfon vagy kedden jelent meg (szerda nem lehet mert az 1500 ft 6.)
    (test (or
        (and (eq ?a1 1700) (eq ?s1 paloskata))
        (and (eq ?a2 1700) (eq ?s2 paloskata))
    ))

    ;6. A szerdai megjelenésű könyv volt az öt közül a legolcsóbb. DONE
    ; szerdai konyv -> ar 1500
    (test (eq ?a3 1500))

    ;7. A Dobos Torta ára 2350 forint. DONE
    ; dobostorta konyv (tudjuk nem csutortoki 4. | tudjuk nem szerdai 6.) -> ar 2350
    (test (or
        (and (eq ?c1 dobostorta) (eq ?a1 2350))
        (and (eq ?c2 dobostorta) (eq ?a2 2350))
        (and (eq ?c5 dobostorta) (eq ?a5 2350))
    ))

    ;8. Gémes Imre a rock-sztár kéziratát szerkesztette át. DONE
    ; zenebona konyv (tudjuk nem csutortoki 4.)-> szerkesztok gemesimre
    (test (or
        (and (eq ?c1 zenebona) (eq ?s1 gemesimre))
        (and (eq ?c2 zenebona) (eq ?s2 gemesimre))
        (and (eq ?c3 zenebona) (eq ?s3 gemesimre))
        (and (eq ?c5 zenebona) (eq ?s5 gemesimre))
    ))

=>
    (printout t "A hétfői könyv címe: " ?c1 ", szerkesztője: " ?s1 ", ára: " ?a1 crlf)
    (printout t "A keddi könyv címe: " ?c2 ", szerkesztője: " ?s2 ", ára: " ?a2 crlf)
    (printout t "A szerdai könyv címe: " ?c3 ", szerkesztője: " ?s3 ", ára: " ?a3 crlf)
    (printout t "A csütörtöki könyv címe: " ?c4 ", szerkesztője: " ?s4 ", ára: " ?a4 crlf)
    (printout t "A pénteki könyv címe: " ?c5 ", szerkesztője: " ?s5 ", ára: " ?a5 crlf)
)