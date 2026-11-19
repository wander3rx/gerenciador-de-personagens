mob/player
	icon = 'player.dmi'


mob/login/proc/CreateCharacter()

	var/charname = input(src,"Escolha o nome do personagem") as text|null
	if(!charname)
		charname = "SemNome"

	var/clan = input(src,"Escolha seu clã") in list(
		"Senju",
		"Uchiha",
		"Hyuuga",
		"Nara"
	)

	var/vila = input(src,"Escolha sua vila") in list(
		"Folha",
		"Areia",
		"Pedra",
		"Nuvem",
		"Névoa"
	)

	var/mob/player/P = new()

	P.verbs -= /mob/hyuuga/verb/Byakugan
	P.verbs -= /mob/uchiha/verb/Sharingan
	P.sharingan = 0
	P.name = charname
	P.clan = clan
	P.vila = vila
	var/turf/T

	switch(P.vila)
		if("Folha") T = locate(250,250,1)
		if("Areia") T = locate(20,20,1)
		if("Pedra") T = locate(30,30,1)
		if("Nuvem") T = locate(40,40,1)
		if("Névoa") T = locate(50,50,1)

	if(T)
		P.loc = T
	else
		P.loc = locate(1,1,1)

	client.mob = P
	P.IniciarRecuperacaoEstamina()
	P.Save()
	del(src)


// =========================
// LOAD
// =========================
mob/login/proc/LoadCharacter()

	var/savefile/F = new("saves/[ckey(key)].sav")

	var/mob/player/P = new()

	//identificação
	F["name"] >> P.name
	F["clan"] >> P.clan
	F["vila"] >> P.vila

	//localização
	F["x"] >> P.x
	F["y"] >> P.y
	F["z"] >> P.z

	var/turf/T = locate(P.x, P.y, P.z)

	if(T)
		P.loc = T
	else
		P.loc = locate(1,1,1)

	// Progressão
	F["sharingan_tempo_1"] >> P.sharingan_tempo_1
	F["sharingan_tempo_2"] >>P.sharingan_tempo_2
	F["nivel"] >> P.nivel
	F["selos"] >> P.selos
	F["anger_chance"] >> P.anger_chance
	F["anger_reasons"] >> P.anger_reasons
	if(!islist(P.anger_reasons))
		P.anger_reasons = list()

	//var de sistema importante
	F["em_combate"] >> P.em_combate

	//atributos
	F["Estamina"] >> P.Estamina
	F["health"] >> P.health
	F["MaxHP"] >> P.MaxHP
	F["hpxp"] >> P.hpxp
	F["hpup"] >> P.hpup

	F["chakra"] >> P.chakra
	F["Mchakra"] >> P.Mchakra
	F["chakraxp"] >> P.chakraxp
	F["chakraup"] >> P.chakraup

	F["forca"] >> P.forca
	F["forcaexp"] >> P.forcaexp
	F["forcaup"] >> P.forcaup

	F["critico"] >> P.critico

	F["resist"] >> P.resist
	F["resistexp"] >> P.resistexp
	F["resistup"] >> P.resistup

	F["spirit"] >> P.spirit
	F["spiritexp"] >> P.spiritexp
	F["spiritup"] >> P.spiritup

	F["cc"] >> P.cc
	F["ccexp"] >> P.ccexp
	F["ccup"] >> P.ccup

	F["men"]  >> P.men
	F["menexp"] >> P.menexp
	F["menup"] >> P.menup

	F["int"] >> P.int
	F["intexp"] >> P.intexp
	F["intup"] >> P.intup

	//patente
	F["rank"] >> P.rank

	//aparência
	F["manto_minato"] >> P.manto_minato
	F["hair_style"] >> P.hair_style
	F["HairColor"] >> P.HairColor

	//Habilidades
	F["aprendeusuijinheki"] >> P.aprendeusuijinheki
	if(P.aprendeusuijinheki ==1)
		P.verbs += /mob/suiton/verb/SuitonSuijinheki
	F["aprendeumizurappa"] >> P.aprendeumizurappa
	if(P.aprendeumizurappa == 1)
		P.verbs += /mob/suiton/verb/SuitonMizurappa
	F["aprendeusuiryuudan"] >> P.aprendeusuiryuudan
	if(P.aprendeusuiryuudan == 1)
		P.verbs += /mob/suiton/verb/SuitonSuiryuudan
	F["aprendeukawa"] >> P.aprendeukawa
	if(P.aprendeukawa == 1)
		P.verbs += /mob/jutsu/verb/Kawariminojutsu
	F["aprendeukai"] >> P.aprendeukai
	if(P.aprendeukai == 1)
		P.verbs += /mob/jutsu/verb/Kai
	F["mangekyou_unlocked"] >> P.mangekyou_unlocked
	if(P.mangekyou_unlocked == 1)
		P.verbs += /mob/uchiha/verb/MangekyouSharingan
	F["aprendeurasengan"] >> P.aprendeurasengan
	if(P.aprendeurasengan == 1)
		P.verbs += /mob/jutsu/verb/Rasengan
	F["aprendeuchidori"] >> P.aprendeuchidori
	if(P.aprendeuchidori == 1)
		P.verbs += /mob/jutsu/verb/Chidori
	F["aprendeuhousenka"] >> P.aprendeuhousenka
	if(P.aprendeuhousenka == 1)
		P.verbs += /mob/katon/verb/KatonHousenka
	F["Katon1N"] >> P.Katon1N
	F["aprendeukatongoukakyuu"] >> P.aprendeukatongoukakyuu
	if(P.aprendeukatongoukakyuu == 1)
		P.verbs += /mob/katon/verb/KatonGoukakyuu
	F["aprendeusuimen"] >> P.aprendeusuimen
	if(P.aprendeusuimen == 1)
		P.verbs += /mob/suiton/verb/Suimen_no_Jutsu
	F["aprendeukbunshin"] >> P.aprendeukbunshin
	if(P.aprendeukbunshin == 1)
		P.verbs += /mob/bunshin/verb/kBunshinNoJutsu
		P.verbs += /mob/bunshin/verb/DesfazerBunshin
	F["aprendeutajuu"] >> P.aprendeutajuu
	if(P.aprendeutajuu == 1)
		P.verbs += /mob/bunshin/verb/TajuuKageBunshinNoJutsu
		P.verbs += /mob/bunshin/verb/DesfazerBunshin

	//Uchiha
	F["sharingan"] >> P.sharingan
	if(P.sharingan >= 1)
		P.verbs += /mob/uchiha/verb/Sharingan
	else
		P.verbs -= /mob/uchiha/verb/Sharingan

	//Hyuuga
	F["byakugan"] >> P.byakugan
	if(P.byakugan == 1)
		P.verbs += /mob/hyuuga/verb/Byakugan
	else
		P.verbs -= /mob/hyuuga/verb/Byakugan
	F["aprendeujyuuken"] >> P.aprendeujyuuken
	if(P.aprendeujyuuken == 1)
		P.verbs += /mob/hyuuga/verb/Jyuuken_Ryu
	F["aprendeukuushou"] >> P.aprendeukuushou
	if(P.aprendeukuushou == 1)
		P.verbs += /mob/hyuuga/verb/Hakke_Kuushou
	F["aprendeuhakke64"] >> P.aprendeuhakke64
	if(P.aprendeuhakke64 == 1)
		P.verbs += /mob/hyuuga/verb/Hakke_Rokujuuyon_Shou
	F["aprendeukaiten"] >> P.aprendeukaiten
	if(P.aprendeukaiten == 1)
		P.verbs += /mob/hyuuga/verb/Hakkeshou_Kaiten
	F["aprendeuhasangeki"] >> P.aprendeuhasangeki
	if(P.aprendeuhasangeki == 1)
		P.verbs += /mob/hyuuga/verb/Hakke_Hasangeki

	//Senju
	F["aprendeuseimeiryoku"] >> P.aprendeuseimeiryoku
	if(P.aprendeuseimeiryoku == 1)
		P.verbs += /mob/senju/verb/Seimeiryoku

	//Hiraishin - Marcações
	F["hiraishin_nome_1"] >> P.hiraishin_nome_1
	F["hiraishin_x_1"] >> P.hiraishin_x_1
	F["hiraishin_y_1"] >> P.hiraishin_y_1
	F["hiraishin_z_1"] >> P.hiraishin_z_1

	F["hiraishin_nome_2"] >> P.hiraishin_nome_2
	F["hiraishin_x_2"] >> P.hiraishin_x_2
	F["hiraishin_y_2"] >> P.hiraishin_y_2
	F["hiraishin_z_2"] >> P.hiraishin_z_2

	F["hiraishin_nome_3"] >> P.hiraishin_nome_3
	F["hiraishin_x_3"] >> P.hiraishin_x_3
	F["hiraishin_y_3"] >> P.hiraishin_y_3
	F["hiraishin_z_3"] >> P.hiraishin_z_3

	F["aprendeuhiraishin"] >> P.aprendeuhiraishin
	if(P.aprendeuhiraishin == 1)
		P.verbs += /mob/senju/verb/Hiraishin
		P.verbs += /mob/senju/verb/Hiraishin_Marcar
		P.verbs += /mob/senju/verb/Hiraishin_Desmarcar
	F["aprendeukanchi"] >> P.aprendeukanchi
	if(P.aprendeukanchi == 1)
		P.verbs += /mob/senju/verb/Kanchi

	//Clã Nara
	F["aprendeukagemane"] >> P.aprendeukagemane
	if(P.aprendeukagemane == 1)
		P.verbs += /mob/nara/verb/KageMane


	//usando pesos
	F["pesos_lee"] >> P.pesos_lee
	// Inventário
	var/list/itens_salvos = list()

	F["itens"] >> itens_salvos

	for(var/list/item_data in itens_salvos)
		var/item_id = item_data["id"]

		var/quantidade = item_data["quantidade"]

		var/obj/item/I

		switch(item_id)
			if("kunai")
				I = new /obj/item/kunai(P)
			if("shuriken")
				I = new /obj/item/shuriken(P)
			if("pergaminho_katon_goukakyuu")
				I = new /obj/item/PergaminhoKatonGoukakyuu(P)
			if("manto_do_minato")
				I = new /obj/item/mantominato(P)
			if("pesos_de_treinamento")
				I = new /obj/item/Pesos(P)

		if(I)
			I.quantidade = quantidade
			if(item_id == "manto_do_minato")
				I.worn = P.manto_minato
				if(I.worn)
					I.suffix = "Equipado"

			if(item_id == "pesos_de_treinamento")
				I.worn = item_data["worn"]
				if(I.worn)
					I.suffix = "Equipado"
					P.usando_pesos = 1
					P.pesos_lee = 1
					P.pesos_equipados = 1
				else
					I.suffix = ""

	// Transferência para o jogador
	client.mob = P
	P.IniciarRecuperacaoEstamina()
	P.AtualizarVelocidade()
	P.AtualizarAparencia()
	P.AtualizarCabelo()
	del(src)


// =========================
// SAVE
// =========================
mob/player/proc/Save()

	var/savefile/F = new("saves/[ckey(key)].sav")

	//identidade
	F["name"] << name
	F["clan"] << clan
	F["vila"] << vila

	//localização
	F["x"] << x
	F["y"] << y
	F["z"] << z

	//progressão
	F["anger_chance"] << anger_chance
	F["nivel"] << nivel
	F["anger_reasons"] << anger_reasons
	F["sharingan_tempo_1"] << sharingan_tempo_1
	F["sharingan_tempo_2"] << sharingan_tempo_2

	//var de sistema importante
	F["em_combate"] << em_combate

	//atributos
	F["Estamina"] << Estamina
	F["health"] << health
	F["MaxHP"] << MaxHP
	F["hpxp"] << hpxp
	F["hpup"] << hpup

	F["chakra"] << chakra
	F["Mchakra"] << Mchakra
	F["chakraxp"] << chakraxp
	F["chakraup"] << chakraup

	F["forca"] << forca
	F["forcaexp"] << forcaexp
	F["forcaup"] << forcaup

	F["critico"] << critico

	F["resist"] << resist
	F["resistexp"] << resistexp
	F["resistup"] << resistup

	F["spirit"] << spirit
	F["spiritexp"] << spiritexp
	F["spiritup"] << spiritup

	F["cc"] << cc
	F["ccexp"] << ccexp
	F["ccup"] << ccup

	F["men"]  << men
	F["menexp"] << menexp
	F["menup"] << menup

	F["int"] << int
	F["intexp"] << intexp
	F["intup"] << intup

	//patente
	F["rank"] << rank

	//selos
	F["selos"] << selos

	//aparência
	F["manto_minato"] << manto_minato
	F["hair_style"] << hair_style
	F["HairColor"] << HairColor

	//habilidades
	F["aprendeusuijinheki"] << aprendeusuijinheki
	F["aprendeumizurappa"] << aprendeumizurappa
	F["aprendeusuiryuudan"] << aprendeusuiryuudan
	F["aprendeukawa"] << aprendeukawa
	F["aprendeukai"] << aprendeukai
	F["mangekyou_unlocked"] << mangekyou_unlocked
	F["aprendeurasengan"] << aprendeurasengan
	F["aprendeuchidori"] << aprendeuchidori
	F["aprendeuhousenka"] << aprendeuhousenka
	F["aprendeutajuu"] << aprendeutajuu
	F["aprendeukatongoukakyuu"] << aprendeukatongoukakyuu
	F["Katon1N"] << Katon1N
	F["sharingan"] << sharingan
	F["aprendeusuimen"] << aprendeusuimen
	F["aprendeukbunshin"] << aprendeukbunshin

	//Hyuuga
	F["byakugan"] << byakugan
	F["aprendeujyuuken"] << aprendeujyuuken
	F["aprendeukuushou"] << aprendeukuushou
	F["aprendeuhakke64"] << aprendeuhakke64
	F["aprendeukaiten"] << aprendeukaiten
	F["aprendeuhasangeki"] << aprendeuhasangeki

	//Senju
	F["aprendeuseimeiryoku"] << aprendeuseimeiryoku
	//Hiraishin - Marcações
	F["hiraishin_nome_1"] << hiraishin_nome_1
	F["hiraishin_x_1"] << hiraishin_x_1
	F["hiraishin_y_1"] << hiraishin_y_1
	F["hiraishin_z_1"] << hiraishin_z_1

	F["hiraishin_nome_2"] << hiraishin_nome_2
	F["hiraishin_x_2"] << hiraishin_x_2
	F["hiraishin_y_2"] << hiraishin_y_2
	F["hiraishin_z_2"] << hiraishin_z_2

	F["hiraishin_nome_3"] << hiraishin_nome_3
	F["hiraishin_x_3"] << hiraishin_x_3
	F["hiraishin_y_3"] << hiraishin_y_3
	F["hiraishin_z_3"] << hiraishin_z_3

	F["aprendeuhiraishin"] << aprendeuhiraishin
	F["aprendeukanchi"] << aprendeukanchi

	//Clã Nara
	F["aprendeukagemane"] << aprendeukagemane

	//Usando Pesos
	F["pesos_lee"] << pesos_lee
    // Inventário
	var/list/itens_salvos = list()

	for(var/obj/item/I in contents)
		var/list/item_data = list()

		item_data["id"] = I.item_id
		item_data["quantidade"] = I.quantidade
		item_data["worn"] = I.worn

		itens_salvos += list(item_data)

	F["itens"] << itens_salvos



// =========================
// AUTO SAVE
// =========================
mob/player
	Logout()
		world << "[name] está desconectando..."
		// Salva o personagem
		Save()

		// Remove todos os Kage Bunshins deste jogador
		for(var/mob/Bunshin/B in world)
			if(B.dono == src)
				del(B)
 		..()
		world << "Dados de [name] salvos."
		del(src)